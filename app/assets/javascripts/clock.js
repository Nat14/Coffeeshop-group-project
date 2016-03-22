$(document).ready(function updateClock () {


var currentTime = new Date();
var currentHours = currentTime.getHours();
var currentMinutes = currentTime.getMinutes();
var currentSeconds = currentTime.getSeconds();

//add zeros to minutes and seconds, when below 10.
currentMinutes = ( currentMinutes < 10 ? "0" : "" ) + currentMinutes
currentSeconds = ( currentSeconds < 10 ? "0" : "" ) + currentSeconds

//add "AM" or "PM"
var timeOfDay = ( currentHours < 12 ) ? "AM" : "PM";

//convert to 12 hr clock
currentHours = ( currentHours > 12 ) ? currentHours - 12 : currentHours;

//convert hour of "0" to "12"
currentHours = ( currentHours == 0 ) ? 12 : currentHours;

//full time string
var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds + " " + timeOfDay;

//update time display
document.getElementById("clock").firstChild.nodeValue = currentTimeString;
})
