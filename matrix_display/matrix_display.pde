/**
Matrix display 2017-2017 
v 0.0.1
L'affiche reçoit des info OSC de l'application drumbyte

Build with Processing 3.3.5
Direction artistique Antoine Thibaudeau
Code Stan le Punk
http://stanlepunk.xyz/
*/


void settings() {
  size(100,100) ;
  /*
  fullScreen(1);
  fullscreen_is = true ;
    */
}


void setup() {
  background(0);
  // OSC pour envoyer les info à l'autre sketch afin qu'il reçoive les informations récoltées.
  set_OSC() ;

  // setup drumbyte
  iVec2 canvas = iVec2(600,840);
  boolean alpha = true;
  int num_canvas = 3 ;
  
  set_size_drumbyte(canvas, alpha, num_canvas);
  set_show(); 

  drumbyte_createFont();

}



void draw() {

    
  background_rope(0) ;

  if(display_info_is) {
    drumbyte_text();
  } 

  // clear library
  if(library != null && library.size() > 3) {
    for(int i = 0 ; i <= library.size() -1 ; i++) {
      library.remove(i) ;
    }
  }
}



boolean display_info_is = true  ;

void keyPressed() {  
  if(key == 'i') {
    display_info_is = (display_info_is)? false:true;
  }
    
  final int k = keyCode;
  if (k == 'a') {
    if (looping)  {
      noLoop();
    } else {
      loop();
    }
  }
}







int chapter_reveived = 0 ;
void oscEvent(OscMessage osc_receive) {
  archive_osc_book(osc_receive) ;
}



