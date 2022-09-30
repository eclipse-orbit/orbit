#!/bin/bash

# Surprisingly this also gets us Hudson stuff
ECLIPSE_JIPP_ROOT='https://ci.eclipse.org'

PAT_LATEST='latest-[A-Z]'
PAT_DROP='[A-Z][0-9]+'
PAT_HIDDEN='[A-Z]-builds/[A-Z][0-9]+'
REPO_PAT="download.eclipse.org/tools/orbit/[a-z/]*(${PAT_LATEST}|${PAT_DROP}|${PAT_HIDDEN})"
declare -A repoToTS

function get_project_instance_locations () {
curl -s ${ECLIPSE_JIPP_ROOT} | xmllint --html --xpath '//tr/td/a/@href' - 2>/dev/null | tr ' ' '\n' | cut -d\" -f2
}

function get_instance_jobs () {
res=`curl -s ${ECLIPSE_JIPP_ROOT}${1}api/xml | xmllint --xpath '/hudson/job/url' - | sed 's/></>\n</g' | sed 's/<url>//' | sed 's/<\/url>//'`

echo "${res}"

for job in ${res}; do
 curl -s ${job}api/xml | grep -q 'matrixProject'
 if [ $? -eq 0 ]; then
   group=`curl -s ${job}api/xml | xmllint --xpath '/matrixProject/activeConfiguration/url' - | sed 's/></>\n</g' | sed 's/<url>//' | sed 's/<\/url>//'`
   echo "${group}"
 fi
done
}

function get_build_log () {
url=${1}lastSuccessfulBuild/consoleText
if [ `exists "${url}"` -eq 0 ]; then
  curl -s ${url}
fi
}

function orbit_query () {
grep -aoE "${REPO_PAT}" | sort -u
}

function exists () {
res=`curl -s -o /dev/null -w "%{http_code}" "${1}"`
if [ ${res} -ge 400 ]; then
  echo 1
else
  echo 0
fi
}

function get_build_time () {
url=${1}lastSuccessfulBuild/api/xml
if [ `exists "${url}"` -eq 0 ]; then
  res=`curl -s ${url} | xmllint --xpath '/freeStyleBuild/timestamp | /mavenModuleSetBuild/timestamp | /workflowRun/timestamp | /matrixRun/timestamp | /matrixBuild/timestamp' - | grep -o "[0-9]*"`
  if [ -n "${res}" ]; then
    echo "$((${res} / 1000))"
  else
    echo "0"
  fi
else
  echo "0"
fi

}

function generate_orbit_report () {

JOB_PAT='(jenkins|hudson|ci).eclipse.org'
firstRun=1

while read line; do
  echo ${line} | grep -qE '^[0-9]{10}'
  if [ $? -eq 0 ]; then
    ts=${line}
  fi
  echo ${line} | grep -qE ${REPO_PAT}
  if [ $? -eq 0 ]; then
    repo=${line}
    if [ -z ${repoToTS["${repo}"]} ] || [ ${ts} -gt ${repoToTS["${repo}"]} ]; then
      repoToTS["${repo}"]="${ts}"
    fi
  fi
done < "${1}"

cat << EOF
<html>
<head>
<script src="orbit.js"></script>
</head>
<body onload="pageLoaded()">
<input type="text" id="search_box">
EOF

echo "<table border=\"1\">"
while read line; do
  echo "<tr>"
  echo "<td>" `echo "${line}" | awk '{ print $1 }'` "</td>"
  url=`echo "${line}" | awk '{ print $2 }'`
  if [ `exists "${url}"` -eq 0 ]; then
    echo "<td>" ${url} "</td>"
  else
    echo "<td><font color=\"red\">${url}</font></td>"
  fi
  echo "<td>" `date -d "@${repoToTS[${url}]}"` "</td>"
  echo "</tr>"
done < <(cat $1 | orbit_distribution)
echo "</table>"

echo "<table border=\"1\">"
while read line; do
  echo ${line} | grep -qE ${JOB_PAT}
  if [ $? -eq 0 ]; then
    if [ ${firstRun} -eq 0 ]; then
      echo "</td>"
      echo "</tr>"
    fi
    echo "<tr>"
    job=`echo ${line} | cut -d/ -f4-`
    echo "<td>" "<a href=\"${line}\">${job}</a>" "</td>"
  fi

  echo ${line} | grep -qE '^[0-9]{1,10}'
  if [ $? -eq 0 ]; then
    echo "<td>" `date -d "@${line}"` "</td>"
    echo "<td>"
    firstRun=0
  fi

  echo ${line} | grep -qE ${REPO_PAT}
  if [ $? -eq 0 ]; then
    if [ `exists "${line}"` -eq 0 ]; then
      echo "${line} <br/>"
    else
      echo "<font color=\"red\">${line}</font><br/>"
    fi
  fi
done < "${1}"
cat << EOF
</table>
</body>
</html>
EOF
}


function generate_orbit_data () {
for p in `get_project_instance_locations` ; do
  for j in `get_instance_jobs ${p}` ; do
    res=`get_build_log ${j} | orbit_query`
    ts=`get_build_time ${j}`
    if [ -n "${res}" ]; then
      echo "${j}"
      echo "${ts}"
      echo "${res}"
    fi
  done
done
}

function orbit_distribution () {
grep 'download.eclipse.org' ${1} | sort | uniq -c | sort -n
}

cat << EOF > orbit.js
function keyUp () {
  var key = document.getElementById("search_box").value;
  var elems = document.getElementsByTagName("tr");
  var i;
  for (i = 0; i < elems.length; i++) {
    if (elems[i].innerHTML.match(key)) {
      elems[i].style = "";
    } else {
      elems[i].style = "display:none;";
    }
  }
}

function pageLoaded () {
  var btn = document.getElementById("search_box");
  btn.addEventListener("keyup", keyUp);
}
EOF

generate_orbit_data | tee orbit.txt
generate_orbit_report orbit.txt | tee orbit-use.html
