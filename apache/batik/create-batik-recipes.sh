#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -DbundleSymbolicName=$4
}

# Edit these as needed
GID='org.apache.xmlgraphics'
VERSION='1.9.1'
ARTIDS=(
batik-css
batik-util
batik-i18n
batik-xml
batik-awt-util
batik-gui-util
batik-dom
batik-svg-dom
batik-parser
batik-extension
batik-svggen
batik-swing
batik-transcoder
batik-anim
batik-codec
batik-gvt
batik-bridge
batik-constants
batik-script
xmlgraphics-commons
)
BSNS=(
org.apache.batik.css
org.apache.batik.util
org.apache.batik.i18n
org.apache.batik.xml
org.apache.batik.ext.awt
org.apache.batik.util.gui
org.apache.batik.dom
org.apache.batik.dom.svg
org.apache.batik.parser
org.apache.batik.extension
org.apache.batik.svggen
org.apache.batik.swing
org.apache.batik.transcoder
org.apache.batik.anim
org.apache.batik.codec
org.apache.batik.gvt
org.apache.batik.bridge
org.apache.batik.constants
org.apache.batik.script
org.apache.xmlgraphics
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GID} ${ARTIDS[${i}]} ${VERSION} ${BSNS[${i}]}
done
