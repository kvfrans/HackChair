var myFirebaseRef = new Firebase("https://hackchair.firebaseio.com/");

myFirebaseRef.child("lean").on("value", function(snapshot) {
  $("#image").rotate(snapshot.val());
});

console.print("asd")