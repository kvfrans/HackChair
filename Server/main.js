// var angle = 0, img = document.getElementById('container');
// window.onload = function()
// {
// 	// $("#chair").rotate(45);
// }

var myFirebaseRef = new Firebase("https://hackchair.firebaseio.com/");

myFirebaseRef.child("lean").on("value", function(snapshot) {
  $("#chair").rotate(snapshot.val());
});