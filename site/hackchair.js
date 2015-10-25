var forwarded = false;

var myFirebaseRef = new Firebase("https://hackchair.firebaseio.com/");

myFirebaseRef.child("lean").on("value", function(snapshot) {
if(snapshot.val() != null)
{
  console.log("sd");
  if(snapshot.val() < 0)
  {
    forwarded = true;
    keyFaster = true;
  }
  else
  {
    forwarded = false;
    keyFaster = false;
  }
}});
