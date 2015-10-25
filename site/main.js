var time = new Date().getTime()
var data2 = '{"client_id":"u5vHzE9yBqw", "client_secret":"s8aOW4vlM4Q" ,"grant_type":"http://www.moxtra.com/auth_uniqueid" ,"uniqueid" :"kev4",  "timestamp":"'+ time +'"}';
console.log(data2);
var data1 = JSON.parse(data2);
console.log(time);
$.ajax({
    type: 'POST',
    url:  "https://apisandbox.moxtra.com/oauth/token",
    data: data1,
    contentType: "application/x-www-form-urlencoded",
    success: function(json) {
        console.log(json);


        var options = {
                mode: "sandbox", //for production environment change to "production"
                client_id: "u5vHzE9yBqw",
                access_token: json.access_token, //valid access token from user authentication
                invalid_token: function(event) {
                    alert("Access Token expired for session id: " + event.session_id);
                }
            };

            Moxtra.init(options);

            console.log()



    var options = {
        iframe: true,
        extension: { "show_dialogs": { "meet_invite": true } },
        tagid4iframe: "container",
        iframewidth: (window.innerWidth/2)+"px",
        iframeheight: (window.innerHeight - 81)+"px",
        video: true,
        start_meet: function(event) {
            alert("session key: " + event.session_key + " session id: " + event.session_id + " binder id: " + event.binder_id);
        },
        error: function(event) {
            alert("error code: " + event.error_code + " message: " + event.error_message);
        },
        resume_meet: function(event) {
            alert("session key: " + event.session_key + " session id: " + event.session_id + " binder id: " + event.binder_id);
        },
        end_meet: function(event) {
            alert("Meet end event");
        }
    };
    Moxtra.meet(options);

    $('iframe', parent.document).css("margin-top","81px");



    },
    error: function(e) {
        console.log(e)
        // alert("Failure"+ JSON.stringify(e));

    }
});








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
			  		var rand = Math.random();
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