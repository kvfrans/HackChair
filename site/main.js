var myFirebaseRef = new Firebase("https://hackchair.firebaseio.com/");

myFirebaseRef.child("lean").on("value", function(snapshot) {
  $("#chair").rotate(snapshot.val());
});