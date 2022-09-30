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
