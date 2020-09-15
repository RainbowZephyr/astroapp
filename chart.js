var canvas = document.getElementById("chart");
var ctx = canvas.getContext("2d");

console.log(canvas.height);

ctx.beginPath();
ctx.arc(canvas.height/2, canvas.width/2, canvas.width/2, 0, 2 * Math.PI);
ctx.lineWidth = 5;
ctx.stroke();

