///////////////////////////////
//main program
//globals declare
/////////////////
PImage lspeakerControl;
int lWidth, lHeight;

Maxim maxim;
 DeckState deckState;
 DrumPadsState drumPadsState;
 ModalState appState;

ModRadio radioTabs;

//================================================================
void setup() {  

  maxim = new Maxim(this);


  size(1024,768);
  background(0);

  deckState = new DeckState(maxim);
  drumPadsState = new DrumPadsState(maxim);
  appState = deckState;


  imageMode(CORNER);
  
  //speakers are inactive at this time.... just an array of images
  lspeakerControl = loadImage("speaker.png");
  lWidth = lspeakerControl.width;
  lHeight = lspeakerControl.height;
  for (int i = 0; i<6 ; i+=5) { // edited to just 2 speakers spaced across top
      image(lspeakerControl, lWidth * i, 0,lWidth,lHeight);
  }

  deckState.init(lHeight);
  drumPadsState.init(lHeight);
  
String[] tabNames =  {"DJ Decks","Drum Pads"};
radioTabs = new ModRadio(0, 2, 200, 40, 180,tabNames);



}//end setup


//========================================================
void draw() {
  background(0);
  imageMode(CORNER);  
  
//-----------------------  
//speakers draw..  
for (int i = 0; i<6 ; i+=5) { // edited to just 2 speakers spaced across top
    image(lspeakerControl, lWidth * i, 0,lWidth,lHeight);
}

// deckState.update();
//drumPadsState.update();
appState.update();
radioTabs.update();
  

}//end draw function


void mousePressed() {
// deckState.mousePressed();
// drumPadsState.mousePressed();
int tab = radioTabs.mousePressed();
if (tab == 0) {
  appState = deckState;
}
else if (tab == 1) {
  appState = drumPadsState;
}

appState.mousePressed();


}//end mouse pressed

void mouseDragged() {
  
// deckState.mouseDragged();
appState.mouseDragged();

}


void mouseReleased() {
  
// deckState.mouseReleased();
appState.mouseReleased();
}
  
