/**
MISC DRUMBYTE
v 0.0.6

*/
/**
OSC send info
v 0.1.0
*/
void set_OSC() {
  set_OSC("127.0.0.1");
}


void set_OSC(String ip_address) {
  int num_chapter = 10 ;
  int first_port = 10_000 ;
  int size_datagram = 9000 ;
  osc_book_builder(num_chapter, first_port, ip_address, size_datagram);
}

/*
void osc_send_info() {
  for(int pix : pix_work) {
    add_osc_data(pix) ;
  }
  send_message("DRUMBYTE");

}
*/



/**
effect
v 0.0.3
*/
boolean reverse_is;
boolean mirror_is;

void drumbyte_effect(int target) {
 //  PImage img = get_canvas(target) ;

  if(reverse_is) {
    image(reverse(get_canvas(target)), 0, 0);
  }

  if(mirror_is) {
    image(mirror(get_canvas(target)), 0, 0);
  }


  // alpha_control(get_canvas(target), -.1);


}



void alpha_control(int target, float change) {
  
  for(int i = 0 ; i < get_canvas(target).pixels.length ; i++) {
    int c = get_canvas(target).pixels[i];
    float rr = red(c);
    float gg = green(c);
    float bb = blue(c);
    float aa = alpha(c);
    aa += change ;
    if(i== 0 && target == 1 && aa < 5) {
      //
    } 
    if(aa < 0 ) {
      aa = 0 ;
    }
    get_canvas(target).pixels[i] = color(rr,gg,bb,aa) ;
  }
  get_canvas(target).updatePixels() ;
}


/**
export
v 0.0.2
*/
void export(String extension) {
  if(extension.contains("bmp")) {
    save_frame_bmp();
  } else if(extension.contains("jpg")) {
    float compression = 1. ;
    save_frame_jpg(compression);
  }
}

/**
save bmp
*/
void save_frame_jpg(float compression) {
  String filename = "image_" +year()+"_"+month()+"_"+day()+"_"+hour() + "_" +minute() + "_" + second() + ".jpg" ; 
 // String path = sketchPath()+"/bmp/";
  String path = sketchPath();
  path += "/jpg" ;
  saveFrame(path, filename, compression, get_canvas());
}



void save_frame_bmp() {
  String filename = "image_" +year()+"_"+month()+"_"+day()+"_"+hour() + "_" +minute() + "_" + second() + ".bmp" ; 
 // String path = sketchPath()+"/bmp/";
  String path = sketchPath();
  path += "/bmp" ;
  saveFrame(path, filename, get_canvas());
}

/**
Must be coded
*/
/*
void save_frame_bmp(int [] array_pix) {
  String filename = "image_" +year()+"_"+month()+"_"+day()+"_"+hour() + "_" +minute() + "_" + second() ; 
 // String path = sketchPath()+"/bmp/";
  String path = sketchPath();
  path += "/bmp" ;
  // save_bmp(path, filename, width, height, array_pix) ;
}
*/