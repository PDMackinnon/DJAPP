public interface ModalState {
void init(int topEdge);
void update();
void mousePressed();
void mouseDragged();
void mouseReleased();
void enterState();
void changeToState(ModalState nextState);
}

class DeckState implements ModalState {
//////////////////////////
//instance vars declare

//images:
PImage volumeControl;
PImage speedControl;
PImage deckControl;
PImage sliderControl;

//video playing:
PImage [] images;

//UI widgets:
Deck deck1,deck2;
VolumeWidget vWidget1,vWidget2;
SpeedWidget sWidget1,sWidget2;
DJbutton playPause1, playPause2;

//layout in pixels values:
int vWidth,sWidth,dWidth;
int vHeight,sHeight,dHeight,lHeight;
int deck1CentreX, deck1CentreY, deck2CentreX, deck2CentreY;

float currentFrame = 0;

AudioPlayer player1;
AudioPlayer player2;

Maxim maxim;


///////////////////////
//constructor declare
DeckState(Maxim maxim){
this.maxim = maxim;
}

//////////////////
//methods declare

void init(int topEdge) {
this.lHeight = topEdge;

player1 = maxim.loadFile("zion.wav");
player1.setLooping(false);

player2 = maxim.loadFile("sonic2.wav");
player2.setLooping(false);

images = loadImages("videdited/DJ", ".png", 81);

// first load images to know the width and heights for layout...
  volumeControl = loadImage("DJvolume.png");
  vWidth = volumeControl.width;
  vHeight = volumeControl.height;
  
  speedControl = loadImage("speed.png");
  sWidth = speedControl.width;
  sHeight = speedControl.height;

  deckControl = loadImage("vinyl.png");
  dWidth = deckControl.width;
  dHeight = deckControl.height;
  
  sliderControl = loadImage("slider.png");

  //volume widgets -----------------------------  
  vWidget1 = new VolumeWidget(volumeControl, sliderControl, 0, lHeight);
  vWidget2 = new VolumeWidget(volumeControl, sliderControl, vWidth + sWidth*2 + dWidth*2, lHeight);
  
  player1.volume(vWidget1.volume);  //set audio volumes from the widget values
  player2.volume(vWidget2.volume);

  //speed widgets --------------------------
  sWidget1 = new SpeedWidget(speedControl, sliderControl, vWidth, lHeight);
  sWidget2 = new SpeedWidget(speedControl, sliderControl, vWidth + sWidth + dWidth*2, lHeight);

  //decks ---------------------------------
  // initialise decks 1 & 2:
  deck1CentreX = vWidth + sWidth + dWidth/2;
  deck1CentreY = lHeight + dHeight/2;
  deck1 = new Deck(deckControl, deck1CentreX, deck1CentreY );
  
  deck2CentreX = vWidth + sWidth + dWidth + dWidth/2;
  deck2CentreY = lHeight + dHeight/2;
  deck2 = new Deck(deckControl, deck2CentreX, deck2CentreY );
  
  //play/pause buttons
  int playH = 90;
  playPause1 = new DJbutton(vWidth, lHeight + sHeight + playH, playH);
  playPause2 = new DJbutton(vWidth + sWidth + dWidth*2, lHeight + sHeight + playH, playH);


}//end init

void update() {
playPause1.update(player1.isPlaying());
playPause2.update(player2.isPlaying());

//-----------------------
//widgets draw...
  
  deck1.update(sWidget1.adjust, player1.isPlaying());
  deck2.update(sWidget2.adjust, player2.isPlaying());
  
  vWidget1.update();
  vWidget2.update();
  sWidget1.update();
  sWidget2.update();
 
//-----------------------    
//video updates:
    imageMode(CORNER);
    image(images[(int)currentFrame], vWidth + sWidth + dWidth - images[0].width /2 , lHeight + dHeight + 40, images[0].width, images[0].height);

    currentFrame = (currentFrame + 0.4) % images.length;  //movie was just 12fps -> 30fps so slow it back down !

}

void mousePressed() {
deck1.mousePressed();
deck2.mousePressed();
  
sWidget1.mousePressed();
player1.speed(sWidget1.adjust);
sWidget2.mousePressed();
player2.speed(sWidget1.adjust);
  
vWidget1.mousePressed();
player1.volume(vWidget1.volume);
vWidget2.mousePressed();
player2.volume(vWidget2.volume);

if (playPause1.mousePressed()) {//play 1 pressed    
    if (player1.isPlaying()) {
            player1.stop();
            }
    else {
            player1.play();
            }
  }//end if playpaused pressed

if (playPause2.mousePressed()) {//play 2 pressed
    if (player2.isPlaying()) {
            player2.stop();
            }
    else {
            player2.play();
            }
  }//end if play2 test

}

void mouseDragged() {

 deck1.mouseDragged();
 deck2.mouseDragged();
 
 sWidget1.mouseDragged();
 player1.speed(sWidget1.adjust);
 sWidget2.mouseDragged();
 player2.speed(sWidget2.adjust);
 
 vWidget1.mouseDragged();
 player1.volume(vWidget1.volume);
 vWidget2.mouseDragged();
 player2.volume(vWidget2.volume);
}

void mouseReleased() {
deck1.mouseReleased();
deck2.mouseReleased();
vWidget1.mouseReleased();
vWidget2.mouseReleased();
sWidget1.mouseReleased();
sWidget2.mouseReleased();
}

void enterState() {

}

void changeToState(ModalState nextState) {

}

}//end implemtation of DeckState class
///////////////////////////////////

//----------------------------------------------------------------------

class DrumPadsState implements ModalState {
//////////////////////////
//instance vars declare
DrumPad [] pads;
DrumPad testPad;

int topEdge;

AudioPlayer sample1;
AudioPlayer sample2; 
AudioPlayer sample3; 
AudioPlayer sample4;

Maxim maxim;

///////////////////////
//constructor declare
DrumPadsState(Maxim maxim){
this.maxim = maxim;
}


//////////////////
//methods declare
void init(int topEdge) {
  
  sample1 = maxim.loadFile("bd1.wav");
  sample1.volume(0.7);
  sample1.setLooping(false);
  sample2 = maxim.loadFile("sn1.wav");
  sample2.setLooping(false);
  sample2.volume(0.7);
  sample3 = maxim.loadFile("hh1.wav");
  sample3.volume(0.7);
  sample3.setLooping(false);
  sample4 = maxim.loadFile("sn2.wav");
  sample4.volume(0.7);
  sample4.setLooping(false);
  
  this.topEdge = topEdge;

  pads = new DrumPad[4];

  pads[0] = new DrumPad(" Drum1", 200, topEdge + 30, 200 );
  pads[1] = new DrumPad(" Drum2", 500, topEdge + 30, 200 );
  pads[2] = new DrumPad(" Drum3", 200, topEdge + 260, 200 );
  pads[3] = new DrumPad(" Drum4", 500, topEdge + 260, 200 );



}

void update() {
//testPad.update();
pads[0].update();
pads[1].update();
pads[2].update();
pads[3].update();

}

void mousePressed() {
  /*
if (testPad.mousePressed()) {
  
  }//end if
  */
  
  if (pads[0].mousePressed()) {
      sample1.cue(0);
      sample1.play();
  }//end if
  
    if (pads[1].mousePressed()) {
      sample2.cue(0);
      sample2.play();
  }//end if
  
    if (pads[2].mousePressed()) {
      sample3.cue(0);
      sample3.play();
  }//end if
  
    if (pads[3].mousePressed()) {
      sample4.cue(0);
      sample4.play();
  }//end if
  
  
}// end mousepressed


void mouseDragged() {

}

void mouseReleased() {

}

void enterState() {

}

void changeToState(ModalState nextState) {

}

}//end implemtation of DrumPadsState
///////////////////////////////////
