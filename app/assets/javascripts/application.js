// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

function Resizer( element ) {

    var inputBox = element;
    var cssRules = window.getComputedStyle(inputBox);
    var maxFontSize = parseInt(cssRules.getPropertyValue("font-size"));
    var minFontSize = 11; // 11 is pretty damn small!
    var currentFontSize = maxFontSize;
    var maxScrollWidth = parseInt(cssRules.getPropertyValue("width"))
    var fontFamily = cssRules.getPropertyValue("font-family");
    var currentText = inputBox.value;

    // Canvas used to check text widths.
    var canvas = document.createElement('canvas');
    var context = canvas.getContext('2d');

    var initialize = function() {

        inputBox.oninput = onUpdate;
    }

    var onUpdate = function(event) {

        var width;
        // Some text has been deleted!
        if (inputBox.value.length < currentText.length) {
            width = checkTextWidth(inputBox.value, currentFontSize + 1);

            while (width < maxScrollWidth && currentFontSize < maxFontSize) {
                currentFontSize += 1;
                inputBox.style.fontSize = currentFontSize + 'px';
                width = checkTextWidth(inputBox.value, currentFontSize + 1);
            }

            currentText = inputBox.value;
            return;

        }

        var width = checkTextWidth(inputBox.value, currentFontSize);

        // Shrink
        while (currentFontSize > minFontSize && width > maxScrollWidth) {
            currentFontSize -= 1;
            inputBox.style.fontSize = currentFontSize + 'px';
            width = checkTextWidth(inputBox.value, currentFontSize);
        }

        currentText = inputBox.value;
    }

    var checkTextWidth = function(text, size) {
        context.font = size + "px " + fontFamily;

        if (context.fillText) {
            return context.measureText(text).width;
        } else if (context.mozDrawText) {
            return context.mozMeasureText(text);
        }
    }

    // Initialize the auto adapt functionality.
    initialize();
}

Resizer( document.getElementById( 'resizer' ) );
