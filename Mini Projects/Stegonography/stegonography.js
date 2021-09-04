var main_image = null;
var hidden_image = null;
var encoded_image = null;

//function to take main file upload and output to primary canvas
function loadMainImage() {
    var file_input = document.getElementById("main_file_input");
    main_image = new SimpleImage(file_input);
    main_image.drawTo(main_canvas);
}

//function to take second file upload and output to secondary canvas
function loadHiddenImage() {
    var file_input = document.getElementById("hidden_file_input");
    hidden_image = new SimpleImage(file_input);
    hidden_image.drawTo(hidden_canvas);
}

//function to output cleared image from main image
//(all binary color values set to xxxx0000 from xxxxyyyy)
function showClearedImage() {
    //if main image has been uploaded
    if (main_image) {
        //create clear main image
        var cleared_image = clearImage();
        //output to encoded_canvas for testing
        main_image.drawTo(encoded_canvas);
    } else {
        console.log("ERROR: Tried clearing image before uploading image to clear");
        alert("You must first upload an image before clearing one!");
    }
}

//function to output masked image from second image
//(all binary color values set to xxxx0000 from yyyyxxxx)
function showMaskedImage() {
    //if second image has been uploaded
    if (hidden_image) {
        //create emptied hidden image
        var masked_image = maskImage();
        //output to encoded_canvas
        masked_image.drawTo(encoded_canvas);
    } else {
        console.log("ERROR: Tried masking image before uploading image to mask");
        alert("You must first upload an image before masking one!");
    }
}

//function to output combined encoded image
function showEncodedImage() {
    //if both images have been uploaded
    if (main_image && hidden_image) {
        //create encoded image
        encoded_image = encodeImage();
        //output to canvas
        encoded_image.drawTo(encoded_canvas);
    } else {
        console.log("ERROR: Tried encoding image before uploading primary and secondary images");
        alert("You must first upload two images to encode them together!");
    }
}

//function to output decoded image from combined image
//should look like output from maskedImage
function showDecodedImage() {
    //if encoded_image has been generated
    if (encoded_image) {
        //decode image from encoded image
        var decoded_image = decodeImage();
        //output to decoded_canvas
        decoded_image.drawTo(decoded_canvas);
    } else {
        console.log("ERROR: Tried decoding image before encoding");
        alert("You must first encode an image before decoding one!");
    } 
}

//function to crop 2nd image, create cleared and masked versions of primary images
//then combine them to create the encoded image using Stegonography
function encodeImage() {
    //verify that the second image has same dimensions of first image
    hidden_image = adjustImageSize(main_image,hidden_image);
    //create cleared main image
    var cleared_image = clearImage();
    //create masked hidden image
    var masked_image = maskImage();
    //combine images into encoded_image
    var combined_image = combineImages(cleared_image,masked_image);
    return combined_image;
}

//add together color values of each corrosponding pixel in both layers
function combineImages(top_layer,bottom_layer) {
    var width = top_layer.getWidth();
    var height = top_layer.getHeight();
    var combined_image = new SimpleImage(width,height);
    for (var xpos = 0; xpos < width; xpos++) {
        for (var ypos = 0; ypos < height; ypos++) {
            var curr_pixel = combined_image.getPixel(xpos,ypos);
            var top_pixel = top_layer.getPixel(xpos,ypos);
            var bottom_pixel = bottom_layer.getPixel(xpos,ypos);
            combinePixels(curr_pixel,top_pixel,bottom_pixel);
        }
    }
    return combined_image;
}

//adds color values for provided pixels and displays them in curr_pixel
function combinePixels(curr_pixel,top_pixel,bottom_pixel){
    curr_pixel.setRed(top_pixel.getRed() + bottom_pixel.getRed());
    curr_pixel.setGreen(top_pixel.getGreen() + bottom_pixel.getGreen());
    curr_pixel.setBlue(top_pixel.getBlue() + bottom_pixel.getBlue());
}

//function to clear all bits of the main image
function clearImage(){
    var width = main_image.getWidth();
    var height = main_image.getHeight();
    var cleared_image = new SimpleImage(width,height);

    for (var xpos = 0; xpos < width; xpos++) {
        for (var ypos = 0; ypos < height; ypos++) {
            var currMainPixel = main_image.getPixel(xpos,ypos);
            var currPixelToClear = cleared_image.getPixel(xpos,ypos);
            currPixelToClear.setAllFrom(currMainPixel);
            clearPixel(currPixelToClear);
        }
    }
    return cleared_image;
}

//function to clear the RGB values of provided pixel
function clearPixel(pixel){
    var redValue = pixel.getRed();
    var greenValue = pixel.getGreen();
    var blueValue = pixel.getBlue();
    pixel.setRed(clearBits(redValue));
    pixel.setGreen(clearBits(greenValue));
    pixel.setBlue(clearBits(blueValue));
}

//function to get 1st half of encoded binary color value (1010xxxx)
//this is the 1st half of the primary pixel's binary color (xxxx1010)
function clearBits(colorValue){
    var clearedColor = Math.floor(colorValue/16)*16;
    return clearedColor;
}

//function to hide all pixels of hidden_image
function maskImage(){
    var width = hidden_image.getWidth();
    var height = hidden_image.getHeight();
    var masked_image = new SimpleImage(width,height);

    for (var xpos = 0; xpos < width; xpos++) {
        for (var ypos = 0; ypos < height; ypos++) {
            var currHiddenPixel = hidden_image.getPixel(xpos,ypos);
            var currPixelToMask = masked_image.getPixel(xpos,ypos);
            currPixelToMask.setAllFrom(currHiddenPixel);
            maskPixel(currPixelToMask);
        }
    }
    return masked_image;
}


//function to hide the RGB values of provided pixel
function maskPixel(pixel) {
    var redValue = pixel.getRed();
    var greenValue = pixel.getGreen();
    var blueValue = pixel.getBlue();
    pixel.setRed(maskBits(redValue));
    pixel.setGreen(maskBits(greenValue));
    pixel.setBlue(maskBits(blueValue));
}

//function to clear 1st half of binary color value (xxxx1010)
//this is the 1st of of the hidden pixel's binary color (xxxx1010)
function maskBits(colorValue){
    var maskedColor = Math.floor(colorValue/16);
    return maskedColor;
}

//function to retrieve decoded image from encoded_image
function decodeImage(){
    var width = encoded_image.getWidth();
    var height = encoded_image.getHeight();
    var decoded_image = new SimpleImage(width, height);

    for (var xpos = 0; xpos < width; xpos++) {
        for (var ypos = 0; ypos < height; ypos++) {
            var curr_encoded_pixel = encoded_image.getPixel(xpos,ypos);
            var curr_decoded_pixel = decoded_image.getPixel(xpos,ypos);
            curr_decoded_pixel.setAllFrom(curr_encoded_pixel);
            decodePixel(curr_decoded_pixel);
        }
    }
    return decoded_image;
}

//function to decode the RGB values of provided pixel
function decodePixel(pixel) {
    var redValue = pixel.getRed();
    var greenValue = pixel.getGreen();
    var blueValue = pixel.getBlue();
    pixel.setRed(decodeBits(redValue));
    pixel.setGreen(decodeBits(greenValue));
    pixel.setBlue(decodeBits(blueValue));
}

//function to restore 1st half of hidden pixel's binary color value
//given 2nd half of the combined binary color (1010xxxx -> xxxx0000)
//X % 16 * 16
function decodeBits(colorValue) {
    var decodedColor = (colorValue % 16) * 16;
    return decodedColor;
}

//function to restore page to original output, resetting file
//inputs and clearing the canvases
function resetPage() {
    clearCanvas("main_canvas");
    clearCanvas("hidden_canvas");
    clearCanvas("encoded_canvas");
    clearCanvas("decoded_canvas");
}

//function to clear provided canvas_id
function clearCanvas(canvas_id) {
    var canvas = document.getElementById(canvas_id);
    var context = canvas.getContext("2d");
    context.clearRect(0,0,canvas.width,canvas.height);
}

//function to resize the second image to match dimensions of 
//first image by either cropping or adding black pixels to image
function adjustImageSize(main_image,second_image) {
    var main_width = main_image.getWidth();
    var main_height = main_image.getHeight();
    var second_width = second_image.getWidth();
    var second_height = second_image.getHeight();

    var resized_image = new SimpleImage(main_width,main_height);

    //loop through pixels of second image and copy to resized image
    //ignore any pixels greater than dimensions of main to crop
    //leave black pixels where dimensions of main_image exceed second
    for (var xpos = 0; xpos < main_width; xpos++) {
        if (xpos < second_width) {
            for (var ypos = 0; ypos < main_height; ypos++) {
                if (ypos < second_height) {
                    var second_pixel = second_image.getPixel(xpos,ypos);
                    var resized_pixel = resized_image.getPixel(xpos,ypos);
                    resized_pixel.setAllFrom(second_pixel);
                }
            }
        }
    }
    return resized_image;
}