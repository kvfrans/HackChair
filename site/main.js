var myFirebaseRef = new Firebase("https://hackchair.firebaseio.com/");

var leaning;
var blinks = 0;
// var blinkCo

myFirebaseRef.child("lean").on("value", function(snapshot) {
	if(snapshot.val() != null)
	{
		$("#image").rotate(snapshot.val()*-1);
		  $("#degree").html( (Math.round(snapshot.val() * 100) / 100) + " deg");
		  if(snapshot.val() > 8)
		  {
		  	swal({
		  		title: "Too much tilt",
		  		text: "You're leaning your chair back a lot! Try out a different chair model?",
		  		type: "warning",
		  		showCancelButton: true,
		  		confirmButtonColor: "#8CD4F5",
		  		confirmButtonText: "Ok sure",
		  		closeOnConfirm: false
			  	}, function(){
			  		var urlthing = "249-05-0250";
			  		var rand = math.random();
			  		if(rand < 0.2)
			  		{
			  			urlthing = "249-08-1152";
			  		}
			  		else if(rand < 0.4)
			  		{
			  			urlthing = "249-14-0381";
			  		}
			  		else if(rand < 0.6)
			  		{

			  		}
			  		$.ajax({
			  		        type: 'GET',
			  		        url: 'http://api.target.com/items/v3/'+urlthing+'?key=1Kfdqvy6wHmvJ4LDyAVOl7saCBoKHcSb&id_type=dpci&fields=descriptions,brand',
			  		        crossDomain: true,
			  		        async: false,
			  		        jsonpCallback: 'jsonpCallback',
			  		        dataType: 'jsonp',
			  		        contentType:'application/json',
			  		        success: function(data) {
			  		        	console.log(data);
			  		        	var item = data.product_composite_response.items[0];
			  		        	swal({   title: "<a href='"+item.data_page_link+"'>"+item.general_description+"</a>",
			  		        		text: "by "+item.online_brand_name,   html: true });
			  		        }
			  		    });
			  	});
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