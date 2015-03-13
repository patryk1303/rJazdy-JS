/**
* Removes Polish letters from string
* @param {String} txt String with Polish letters
* @return {String} String without Polish letters
*/
function removePolishLetters(txt) {
	return txt
	.replace(/ą/g, 'a').replace(/Ą/g, 'A')
	.replace(/ć/g, 'c').replace(/Ć/g, 'C')
	.replace(/ę/g, 'e').replace(/Ę/g, 'E')
	.replace(/ł/g, 'l').replace(/Ł/g, 'L')
	.replace(/ń/g, 'n').replace(/Ń/g, 'N')
	.replace(/ó/g, 'o').replace(/Ó/g, 'O')
	.replace(/ś/g, 's').replace(/Ś/g, 'S')
	.replace(/ż/g, 'z').replace(/Ż/g, 'Z')
	.replace(/ź/g, 'z').replace(/Ź/g, 'Z');
}

/**
* Checks if <b>txt1</b> is inside <b>txt2</b> ingoring Polish letters
* @param {String} txt1 String fragment to compare
* @param {String} txt2 Full string to compate
* @return {Boolean} <b>true</b> if <i>txt1</i> if a part of <i>txt2</i>, <b>false</b> otherwise
*/
function checkPolishStrings(txt1,txt2) {
	txt1 = txt1.toLowerCase();
	txt2 = txt2.toLowerCase();
	txt1 = removePolishLetters(txt1);
	txt2 = removePolishLetters(txt2);
	return txt1.indexOf(txt2)===-1?false:true;
}

/**
* compares times
* @param {String} timeToCompare time to compare in format "HH:MM"
* @param {String} startTime starting time to compare in format "HH:MM"
* @param {String} endTime ending time to compare in format "HH:MM"
* @return {Boolean} <b>true</b> if <i>timeToCompare</i> is between <i>startTime</i> and <i>endTime</i>, <b>false</b> otherwise
*/
function compareTimes(timeToCompare,startTime,endTime) {
	var time = new Date();
	var currentDate = (time.getMonth()+1) + "/" + time.getDate() + "/" + time.getFullYear() + " ";
	var timeToCompare_test = currentDate + timeToCompare;
	var startTime_test = currentDate + startTime;
	var endTime_test = currentDate + endTime;
	var timeToCompare_MS = new Date(timeToCompare_test).getTime();
	var startTime_MS = new Date(startTime_test).getTime();
	var endTime_MS = new Date(endTime_test).getTime();
	return timeToCompare_MS >= startTime_MS && timeToCompare_MS <= endTime_MS;
}

var countDataInDepartures = function(deps) {
  var count = 0;
  deps.forEach(function(e) {
    count +=e.length;
  });
  return count;
}