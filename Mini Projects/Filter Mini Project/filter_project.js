var main_image = null;
var gray_image = null;
var red_image = null;
var mirror_image = null;


var main_canvas;

window.onload = function() {
  initVariables();
}

function initVariables() {
  main_canvas = document.getElementById("main_canvas");
}

function loadImage() {
  var file_input = document.getElementById("file_input");
  main_image = new SimpleImage(file_input);

  main_image.drawTo(main_canvas);
}

//Function for clearing the image and resetting the webpage
function clearCanvas() {
  var main_context = main_canvas.getContext("2d");

  main_context.clearRect(0, 0, main_canvas.width, main_canvas.height);

  main_canvas.width = 350;
  main_canvas.height = 300;
}

//Function for verifying if file has successfully uploaded before applying filters
function checkFileUpload() {
  var uploaded = true;
  if (main_image == null || !main_image.complete()){
    alert("Waiting for image to upload...");
    uploaded = false;
  }
  return uploaded;
}

function grayscaleFilter() {
  if(checkFileUpload){
    var width = main_image.getWidth();
    var height = main_image.getHeight();
    gray_image = new SimpleImage(width,height);
    for (var xpos = 0; xpos < width; xpos++){
      for (var ypos = 0; ypos < height; ypos++){
        var main_pixel = main_image.getPixel(xpos,ypos);
        var avg = (main_pixel.getRed() + main_pixel.getGreen() + main_pixel.getBlue()) / 3;
        var gray_pixel = gray_image.getPixel(xpos,ypos);
        gray_pixel.setRed(avg);
        gray_pixel.setGreen(avg);
        gray_pixel.setBlue(avg);
      }
    }
    gray_image.drawTo(main_canvas);
  }
}

function blurFilter() {
  if(checkFileUpload){
    var width = main_image.getWidth();
    var height = main_image.getHeight();
    blur_image = new SimpleImage(width,height);
    for (var xpos = 0; xpos < width; xpos++){
      for (var ypos = 0; ypos < height; ypos++){
        var main_pixel = main_image.getPixel(xpos,ypos);
        var blur_pixel = blur_image.getPixel(xpos,ypos);
        var random_int = Math.floor(Math.random()*10);
        if (random_int > 4) {
          blur_pixel.setAllFrom(main_pixel);
        } else {
          var new_xpos = xpos;
          var new_ypos = ypos;
          var coin_flip = Math.floor(Math.random()*4);
          if(coin_flip == 0) {
            new_xpos = Math.max(Math.floor(Math.random()*-10)+xpos,0);
          } else if (coin_flip == 1) {
            new_xpos = Math.min(Math.floor(Math.random()*10)+xpos,width-1);
          } else if (coin_flip == 2) {
            new_ypos = Math.max(Math.floor(Math.random()*-10)+ypos,0);
          } else {
            new_ypos = Math.min(Math.floor(Math.random()*10)+ypos,height-1);
          }
          blur_pixel.setAllFrom(main_image.getPixel(new_xpos,new_ypos));
        }
      }
    }
    blur_image.drawTo(main_canvas);
  }
}

function rainbowFilter() {
  if(checkFileUpload){
    var width = main_image.getWidth();
    var height = main_image.getHeight();
    rainbow_image = new SimpleImage(width,height);
    for (var xpos = 0; xpos < width; xpos++){
      for (var ypos = 0; ypos < height; ypos++){
        var main_pixel = main_image.getPixel(xpos,ypos);
        var rainbow_pixel = rainbow_image.getPixel(xpos,ypos);
        rainbow_pixel.setAllFrom(main_pixel);
        var seventh = height / 7;
        if (ypos < seventh) {
          pixelToRed(rainbow_pixel);
        } else if (ypos < seventh*2) {
          pixelToOrange(rainbow_pixel);
        } else if (ypos < seventh*3) {
          pixelToYellow(rainbow_pixel);
        } else if (ypos < seventh*4) {
          pixelToGreen(rainbow_pixel);
        } else if (ypos < seventh*5) {
          pixelToBlue(rainbow_pixel);
        } else if (ypos < seventh*6) {
          pixelToIndigo(rainbow_pixel);
        } else {
          pixelToViolet(rainbow_pixel);
        }
      }
    }
    rainbow_image.drawTo(main_canvas);
  }
}

function pixelToRed(pixel) {
  var avg = (pixel.getRed() + pixel.getGreen() + pixel.getBlue()) / 3;
  if (avg < 128) {
    pixel.setRed(2*avg);
    pixel.setGreen(0);
    pixel.setBlue(0);
  } else {
    pixel.setRed(255);
    pixel.setGreen(2*avg-255);
    pixel.setBlue(2*avg-255);
  }
  return pixel;
}

function pixelToOrange(pixel) {
  var avg = (pixel.getRed() + pixel.getGreen() + pixel.getBlue()) / 3;
  if (avg < 128) {
    pixel.setRed(2*avg);
    pixel.setGreen(0.8*avg);
    pixel.setBlue(0);
  } else {
    pixel.setRed(255);
    pixel.setGreen(1.2*avg-51);
    pixel.setBlue(2*avg-255);
  }
  return pixel;
}

function pixelToYellow(pixel) {
  var avg = (pixel.getRed() + pixel.getGreen() + pixel.getBlue()) / 3;
  if (avg < 128) {
    pixel.setRed(2*avg);
    pixel.setGreen(2*avg);
    pixel.setBlue(0);
  } else {
    pixel.setRed(255);
    pixel.setGreen(255);
    pixel.setBlue(2*avg-255);
  }
  return pixel;
}

function pixelToGreen(pixel) {
  var avg = (pixel.getRed() + pixel.getGreen() + pixel.getBlue()) / 3;
  if (avg < 128) {
    pixel.setRed(0);
    pixel.setGreen(2*avg);
    pixel.setBlue(0);
  } else {
    pixel.setRed(2*avg-255);
    pixel.setGreen(255);
    pixel.setBlue(2*avg-255);
  }
  return pixel;
}

function pixelToBlue(pixel) {
  var avg = (pixel.getRed() + pixel.getGreen() + pixel.getBlue()) / 3;
  if (avg < 128) {
    pixel.setRed(0);
    pixel.setGreen(0);
    pixel.setBlue(2*avg);
  } else {
    pixel.setRed(2*avg-255);
    pixel.setGreen(2*avg-255);
    pixel.setBlue(255);
  }
  return pixel;
}

function pixelToIndigo(pixel) {
  var avg = (pixel.getRed() + pixel.getGreen() + pixel.getBlue()) / 3;
  if (avg < 128) {
    pixel.setRed(0.8*avg);
    pixel.setGreen(0);
    pixel.setBlue(2*avg);
  } else {
    pixel.setRed(1.2*avg-51);
    pixel.setGreen(2*avg-255);
    pixel.setBlue(255);
  }
  return pixel;
}

function pixelToViolet(pixel) {
  var avg = (pixel.getRed() + pixel.getGreen() + pixel.getBlue()) / 3;
  if (avg < 128) {
    pixel.setRed(1.6*avg);
    pixel.setGreen(0);
    pixel.setBlue(1.6*avg);
  } else {
    pixel.setRed(0.4*avg+153);
    pixel.setGreen(2*avg-255);
    pixel.setBlue(0.4*avg+153);
  }
  return pixel;
}

function redFilter(){
  if(checkFileUpload){
    var width = main_image.getWidth();
    var height = main_image.getHeight();
    red_image = new SimpleImage(width,height);
    for (var xpos = 0; xpos < width; xpos++){
      for (var ypos = 0; ypos < height; ypos++){
        var main_pixel = main_image.getPixel(xpos,ypos);
        var red_pixel = red_image.getPixel(xpos,ypos);
        red_pixel.setRed(255);
        red_pixel.setGreen(main_pixel.getGreen());
        red_pixel.setBlue(main_pixel.getBlue());
      }
    }
    red_image.drawTo(main_canvas);
  }
}

function mirrorFilter(){
  if(checkFileUpload){
    var width = main_image.getWidth();
    var height = main_image.getHeight();
    mirror_image = new SimpleImage(width,height);
    for (var xpos = 0; xpos < width; xpos++){
      for (var ypos = 0; ypos < height; ypos++){
        var main_pixel = main_image.getPixel(xpos,ypos);
        var mirror_pixel = mirror_image.getPixel(width - xpos - 1,ypos);
        mirror_pixel.setAllFrom(main_pixel);
      }
    }
    mirror_image.drawTo(main_canvas);
  }
}

function flipFilter(){
  if(checkFileUpload){
    var width = main_image.getWidth();
    var height = main_image.getHeight();
    flipped_image = new SimpleImage(width,height);
    for (var xpos = 0; xpos < width; xpos++){
      for (var ypos = 0; ypos < height; ypos++){
        var main_pixel = main_image.getPixel(xpos,ypos);
        var flipped_pixel = flipped_image.getPixel(xpos,height - 1 - ypos);
        flipped_pixel.setAllFrom(main_pixel);
      }
    }
    flipped_image.drawTo(main_canvas);
  }
}

function resetFilter(){
  clearCanvas();
  main_image.drawTo(main_canvas);
}