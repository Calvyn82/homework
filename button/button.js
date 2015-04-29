var button      = document.getElementById("button")
var image       = document.getElementById("image")
var replacement = 'Splode.jpg'

function swapImage()
{
  image.src = replacement;
}

button.addEventListener("click", function(){
  swapImage();
}, false);
