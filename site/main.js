var myFirebaseRef = new Firebase("https://hackchair.firebaseio.com/");

var leaning;
var blinks;

myFirebaseRef.child("lean").on("value", function(snapshot) {
  $("#image").rotate(snapshot.val());
  $("#degree").html(snapshot.val());
  if(snapshot.val() > 15)
  {
  	if(blinks >= 2)
  	{
  		swal({   title: "Sleeping!",   text: "stop sleeping dude its class",   type: "error",   confirmButtonText: "ok fine" });
  	}
  }
});

myFirebaseRef.child("blinks").on("value", function(snapshot) {
	console.log(snapshot.val());
  $("#blinks").html(snapshot.val());
  blinks = snapshot.val();
});

myFirebaseRef.child("sitting").on("value", function(snapshot) {
	console.log(snapshot.val());
	if(snapshot.val())
	{
		$("#sitting").html("Someone is in this chair");
	}
	else
	{
		$("#sitting").html("no one is in the chair :(");
	}

});


// console.print("asd")