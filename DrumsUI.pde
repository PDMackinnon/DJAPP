//=====================================================================
class DrumPad {
//////////////////////////
//instance vars declare
int x,y,padH;
String drumText;
  
///////////////////////
//constructor declare
DrumPad(String drumName, int x,int y, int padH){
this.drumText =  drumName;
this.x = x;
  this.y = y;
  this.padH = padH;
}
  

//////////////////
//methods declare
void update() { //pass in current play state

  fill(200,200,220); //pad colour

  rect(x, y, padH, padH, 5 ); //fixed width, height, rounded corners
  
  fill(30,30,30);  //text colour

  text(drumText,x, y, padH, padH );

//end pads update...  
//-----------------------
}
  
boolean mousePressed() {
return ((mouseX > x) && (mouseX < x + padH) && (mouseY > y) && (mouseY < (y + padH) ));
}//end mouse pressed
  
  
  
}//end class DrumPad
///////////////////////////////////
