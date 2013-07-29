
class Deck {
  //////////////////////////
  //instance vars declare
  PImage deckControl;  //recieved image for deck as PImage
  int w,h; //abbreviated width, height to w,h
  int centreX, centreY;  // these are for convenience

  // need to maintain the rotation of deck as well as deal with user interaction with deck (cue point control)
  float rotate, startRotate, dragStartAngle, dragAngle; // current rotation of deck, rotation when started drag
                                                            // likewise for angle of touch pressed: start and current
                                                            // from this can workout change (delta) in drag angle to apply to deck 
                                                            // i.e. rotate = start + delta
  boolean cueDrag;  //rotational drag is active
  
  ///////////////////////
  //constructor declare
  Deck(PImage deckImg, int cx,int cy) {
    //init object:
    rotate = 0.0;
    cueDrag = false;
    
    deckControl = deckImg;
    centreX = cx;
    centreY = cy;
    w = deckControl.width; 
    h = deckControl.height;
  }
  
  //////////////////
  //methods declare
  void update(float sAdjust, boolean playing) {
   
    //deck rotate
    if (!cueDrag && playing) {
        rotate += radians(9 * sAdjust); // 9 deg per frame at 30fps -> 45RPM (when sAdjust1 = 1.0)
    }
  // draw deck with transforms as required:
  pushMatrix();
  translate(centreX, centreY);
  rotate(rotate);
  imageMode(CENTER);
  image(deckControl, 0, 0, w, h);
  popMatrix();
  }
  
  
  void mousePressed() {
    //test for drag in locus of deck starting..
    int offsetX = mouseX - centreX;
    int offsetY = mouseY - centreY;
  
    if ((offsetX*offsetX + offsetY*offsetY) < w*w/4 ) {//start deck drag as inside locus
      cueDrag = true;
      startRotate = rotate;
      dragStartAngle = atan2((float) offsetY, (float)offsetX );
      }
    
  }//end mouse pressed method
  
  void mouseDragged() {
    if (cueDrag) {//user is controlling deck  
      int offsetX = mouseX - centreX;
      int offsetY = mouseY - centreY;
  
      dragAngle = atan2((float) offsetY, (float)offsetX );
    
      float deltaR =  dragAngle - dragStartAngle;
    
      rotate = startRotate + deltaR;
      }//end if deck cue
      
  }//end mouse draggged method
  
  void mouseReleased() {
    cueDrag = false;
  }//end mouse released method
  
}//end of class Deck
///////////////////////////////////

class VolumeWidget {
  //////////////////////////
  //instance vars declare
  PImage volumeControl;
  PImage sliderControl;
  int w,h; //abbreviated width, height to w,h
  //interactions
  int  startDragX, startDragY;
  boolean volDrag;
  //volume levels
  float volume, maxVolume;
  int sliderX, sliderY;
  int top, bottom, left;
   
  ///////////////////////
  //constructor declare
  VolumeWidget(PImage widgetImg, PImage sliderImg, int left,int top) {
    
    volDrag = false;
    
    maxVolume = 1.0;
    volume = 0.0;
    
    w = widgetImg.width;
    h = widgetImg.height;
    this.left = left;
    this.top = top;
    this.bottom = top + h;

    
    sliderY =  (int) map(volume, 0, maxVolume, (float)bottom, (float)top);
    sliderX = left + w/2;  //centre position of slider

    volumeControl = widgetImg;
    sliderControl = sliderImg;
  }//end constructor


  
  //////////////////
  //methods declare
  void update() {

  imageMode(CORNER);
  image(volumeControl,left,top, w, h);
      
  // slider draw:
    imageMode(CENTER);
    image(sliderControl, sliderX, sliderY, sliderControl.width, sliderControl.height);
  }//end update

  void mousePressed() {
  if ((mouseX > left) && (mouseX < left + w) && (mouseY > top) && (mouseY < (bottom) )) {//widget  pressed
    volume = map(mouseY, top, bottom, maxVolume, 0);
    volume = constrain(volume, 0, maxVolume);
    
    sliderY = mouseY;
    
    volDrag = true;
    }//end if volume widget pressed
  }//end mouse pressed method
  
  void mouseDragged() {
    
     if (volDrag) {//user is controlling volume widget
    
      volume = map(mouseY, top, bottom, maxVolume, 0);
      volume = constrain(volume, 0, maxVolume);
   
      sliderY = constrain(mouseY, top, bottom);
      }//end if volDrag
    
  }//end mouse draggged method
  
  void mouseReleased() {
    volDrag = false;
  }//end mouse released method
  
}//end of class VolumeWidget
///////////////////////////////////


class SpeedWidget {
  //////////////////////////
  //instance vars declare
  PImage speedControl;
  PImage sliderControl;
  int w,h; //abbreviated width, height to w,h
  //interactions
  int  startDragX, startDragY;
  boolean speedDrag;
  //speed levels
  //RPM adjust +- 20% version
  float adjust, minAdjust, maxAdjust;
  int sliderX, sliderY;
  int top, bottom, left;
  
   
  ///////////////////////
  //constructor declare
  SpeedWidget(PImage widgetImg, PImage sliderImg, int left,int top) {

    speedDrag = false;

    minAdjust = 0.8; // - 20%
    maxAdjust = 1.2; //  + 20%
    adjust = 1.0;  // normal speed
    
    w = widgetImg.width;
    h = widgetImg.height;
    
    this.top = top;
    this.left = left;
    this.bottom = top + h;
    
    sliderY =  (int) map(adjust, minAdjust, maxAdjust, (float)bottom, (float)top);
    sliderX = left + w/2;  //centre position of slider

    speedControl = widgetImg;
    sliderControl = sliderImg;

  }//end constructor
  
  //////////////////
  //methods declare
  void update() {

  imageMode(CORNER);
  image(speedControl,left,top, w, h);
      
  // slider draw:
    imageMode(CENTER);
    image(sliderControl, sliderX, sliderY, sliderControl.width, sliderControl.height);
    
  }// end update
  
  

void mousePressed() {
    
 if ((mouseX > left) && (mouseX < (left + w)) && (mouseY > top) && (mouseY < bottom)) {//speed widget pressed
        
    adjust = map(mouseY, top, bottom, maxAdjust, minAdjust);
    adjust = constrain(adjust, minAdjust, maxAdjust);
    
    sliderY = mouseY;
    
    speedDrag = true;
    
    }//end adjust
    
  }//end mouse pressed method
  
  void mouseDragged() {
    if (speedDrag) {//user is controlling speed RPM
    
      adjust = map(mouseY, top, bottom, maxAdjust, minAdjust);
      adjust = constrain(adjust, minAdjust, maxAdjust);
   
      sliderY = constrain(mouseY, top, bottom);
  }//end adj1Drag drag
  
}//end mouse draggged method
  
  void mouseReleased() {
    speedDrag = false;
  }//end mouse released method
  

}//end of class SpeedWidget
///////////////////////////////////


//=====================================================================
class DJbutton {
//////////////////////////
//instance vars declare
int x,y,playH;
  
///////////////////////
//constructor declare
DJbutton(int x,int y, int playH){
  this.x = x;
  this.y = y;
  this.playH = playH;
}
  

//////////////////
//methods declare
void update(boolean on) { //pass in current play state
  //-----------------------
  //temp box for play/pause buttons
  if (on) {            //on state so..
    fill(200,30,30); //red -> press to stop
  }
  else {              //in off state so..
    fill(30,200,30); //green -> press to go
  }
  rect(x, y, playH, playH, 5 ); //fixed width, height, rounded corners
  
  fill(30,30,30);

  text("Play/Stop",x, y, playH, playH );

//end play pause buttons...  
//-----------------------
}
  
boolean mousePressed() {
return ((mouseX > x) && (mouseX < x + playH) && (mouseY > y) && (mouseY < (y + playH) ));
}//end mouse pressed
  
  
  
}//end class DJbutton
///////////////////////////////////