var myFirebaseRef = new Firebase("https://hackchair.firebaseio.com/");

var leaning;
var blinks = 0;
// var blinkCo

myFirebaseRef.child("lean").on("value", function(snapshot) {
	if(snapshot.val() != null)
	{
		$("#image").rotate(snapshot.val()*-1);
		  $("#degree").html( (Math.round(snapshot.val() * 100) / 100) + " deg");
		  if(snapshot.val() > 15)
		  {

		  }
	}

});

myFirebaseRef.child("blinks").on("value", function(snapshot) {
	console.log(snapshot.val());
	$("#blinks").html(snapshot.val() + " blinks");
	blinks = blinks + snapshot.val();
	if(blinks >= 10)
	{
		swal({   title: "Sleeping!",   text: "stop sleeping dude its class",   type: "error",   confirmButtonText: "ok fine" });
	}
});

myFirebaseRef.child("sitting").on("value", function(snapshot) {
	console.log(snapshot.val());
	if(snapshot.val())
	{
		$("#sitting").html("Good Posture");
	}
	else
	{
		$("#sitting").html("Bad Posture");
	}

});


// console.print("asd")