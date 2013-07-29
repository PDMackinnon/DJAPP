class ModRadio {
//////////////////////////
//instance vars declare
int x,y,size,numOfStates; 	//size = width and height of each radio button, 
int state;		//0 = first button, 1 = 2nd button etc 
String [] names;

///////////////////////
//constructor declare
ModRadio(int initState, int numOfStates, int x,int y, int size, String[] names){
  this.x = x;
  this.y = y;
  this.size = size;
  this.state = initState;
  this.numOfStates = numOfStates;
  this.names = names;
}

ModRadio(int initState, int numOfStates, int x,int y, int size) {
  this.x = x;
  this.y = y;
  this.size = size;
  this.state = initState;
  this.numOfStates = numOfStates;

  names = new String[numOfStates];
  for (int i = 0; i < numOfStates; i++ ) {
	names[i] = new String("test:" + i);
	println(names[i]);
	}//end for
}


  

//////////////////
//methods declare
void update() { 

  imageMode(CORNER);
  //-----------------------
for (int i = 0; i < numOfStates; i++ ) {
  stroke(1.0);
  fill(100,30,200); //blue ish ?

  rect(x + i * size, y, size, size, 5 ); //fixed width, height, rounded corners
  fill(30,30,30);

  text(names[i], x + i * size, y, size, size );
  
    if (state == i) {
      noStroke();
      fill(20,200,30); //green ish
      ellipse(x + (size/2) + (i * size), y + size/2, size/2, size/2);
      }
    else {
      noStroke();
      fill(20,100,30); //green ish
      ellipse(x + (size/2) + (i * size), y + size/2, size/2, size/2);
      }
  
  }//end for
  

//end draw buttons...  
//-----------------------
}
  
int mousePressed() {
//return ((mouseX > x) && (mouseX < x + size) && (mouseY > y) && (mouseY < (y + size) ));

for (int i = 0; i < numOfStates; i++ ) {
  
  if ((mouseX > x + i*size) && (mouseX < x + (i+1)*size) && (mouseY > y) && (mouseY < (y + size) )) {
    state = i;
    return i;
  } //end if

}//end for

  return -1; // otherwsie represent no hit by value -1


}//end mouse pressed
  
  
  
}//end class ModRadio
///////////////////////////////////
