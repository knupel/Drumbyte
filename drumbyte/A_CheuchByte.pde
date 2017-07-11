void pioche_setup_Cheuch() {
  build_pioche("data/01-Texte_1");
  /*
    build_pioche("data/02-Texte_2");
    
      build_pioche("data/03-Texte_3");
        build_pioche("data/04-Texte_4");
          build_pioche("data/05-Texte_R");
            build_pioche("data/06-Texte_V");
              build_pioche("data/07-Texte_B");
                build_pioche("data/08-Texte_N");
        */       
  int which_pioche = 0;
  select_pioche_moulinette(which_pioche);
  //int which_img = floor(random(pioche_image_size()));
}


void DrumByte_Cheuch() {

  // build
 setting_accelero_x() ;
  // setting_accelero_y() ;

  // setting_ride();

  // rendering
 //  boolean bool_test = beat_is();
  boolean bool_test = true ;
 //  if(mouseX > width/2) bool_test = true ; else bool_test = false ;

  setting_hihat(bool_test);
  // rendering_moulinette_vertical(); 
}
/**
accelero X
*/
int entry_x ;
void setting_accelero_x() {
  select_canvas(1);
  
  int result = (int)map(mouseX, 0, width, -5, 5) ;
  entry_x += result ;
  if(entry_x < 0) entry_x = get_pioche_image().width ;
  if(entry_x > get_pioche_image().width) entry_x = 0 ;
  int lenght_pix = get_pioche_image().pixels.length ;
  int destination = 0 ;

  set_moulinette(entry_x, lenght_pix, destination);
}

/**
accelero Y
*/
void setting_accelero_y() {
  select_canvas(1);

  float entry = 0 ;
  float position = decalage_pixels() ;
  float lenght_pix = map(position, 0, 1, -3, 3) ;
  lenght_pix = abs(lenght_pix *lenght_pix) ;
  lenght_pix = map(lenght_pix, 0, 9, 0, 1) ;

  set_moulinette(entry, lenght_pix, position);
}



/**
//-----------------------------------HI-HAT / HORIZONTAL-VERTICAL-----------------------------------//
*/
void setting_hihat(boolean choice) {
  if(choice) {
    rendering_moulinette_cheuch_hor(); 
  } else {
    rendering_moulinette_cheuch_vert(); 
  }
}
/**
setting_ride
*/
int destination_ride = 0;
void setting_ride() {
  select_canvas(1);
//   println(get_pioche_image_id());
   int entry_img_source = 0 ;
  // int entry_img_source = floor(random(get_pioche_image().pixels.length)) ;
  int nombre_pixel_copies = 23565 ;
  // int nombre_pixel_copies = int(map(mouseX, 0, width, 3000, get_pioche_image().pixels.length)) ;
  destination_ride += nombre_pixel_copies ;
  if(destination_ride > get_canvas().pixels.length) destination_ride = 0 ;
  
  set_ride_decalage(entry_img_source, nombre_pixel_copies, destination_ride);
}
/**

*/



//-----------------------------------GROSSE CAISSE / ON-OFF-----------------------------------//
//-----------------change pioche selon le nombre de coups//

int which_pioche = 0 ;

void new_pioche() {
  if (which_pioche >= (4)) {
    which_pioche = 0 ;

   } 
   select_pioche (which_pioche) ;
   select_image_pioche(19);
   which_pioche ++ ;  
}


//-----------------------------------CAISSE CLAIRE / INTENSITÉ-----------------------------------//
//-----------------change image selon l'intensité min (0) ou max (39)//

void change_image() {
  int min = 0 ;
  int max = 39;
    int which_image = floor(map(mouseX, 0, width, min, max));
    if (which_image >= max) { 
      which_image = max ;
    }
    if (which_image <= min) { 
    which_image = min ;
    }
        
   select_image_pioche (which_image) ;
  // println(which_pioche, get_pioche_name(), get_pioche_image_id());
   
}

//-----------------------------------CAISSE CLAIRE / ACCÉLÉROMÈTRE-----------------------------------//
//-----------------décalage pixels selon mouvement haut-bas //

float decalage_pixels() {
  int min = 0 ;
  int max = height;
   float decalage = map(mouseY, min,max, 0, 1);
      if (decalage >= 1) { 
      decalage = 1 ;
    }
    if (decalage <= 0) { 
    decalage = 0 ;
    }
    return decalage ;
    

}


//-----------------------------------CRASH / HORIZONTAL-VERTICAL-----------------------------------//
//-----------------change canvas when hit //



void change_pioche_crash_rvb() {
  if (which_pioche <= 4) {
    int new_pioche = ((which_pioche)+3) ;
    select_pioche (new_pioche);
    
   }else{
    if (which_pioche >= 4) {
     select_pioche (which_pioche);
      
    } 
   }
   
   
}

   



//-----------------version cymbale pixel generator //





//-----------------------------------RIDE / HORIZONTAL-VERTICAL-----------------------------------//

  
int entry_ride;
int length_copy_ride;
int where_ride;


void set_ride_decalage(int entry, int length, int destination) {
  set_entry_ride(entry) ;
  set_length_ride(length) ;
  set_destination_ride(destination) ;

}


void set_entry_ride(int entry_in_img_pioche) {
  // ma cuisine

  // verification des problemes
  if(entry_in_img_pioche > get_pioche_image().pixels.length) { 
    entry_in_img_pioche = get_pioche_image().pixels.length -1; 
  } else if (entry_in_img_pioche < 0 ) {
    entry_in_img_pioche = 0;
  }

  // travail obligatoire ne pas déranger
  set_entry_moulinette(entry_in_img_pioche);
}

void set_length_ride(int num_pix_must_be_copy) {
  // ma cuisine

  // compare le nombre de pixel a copier avec le nombre de pixel qui l'est possible de copier à partir de mon point d'entrée
  int max = get_pioche_image().pixels.length -where_entry_pioche ;
  if(num_pix_must_be_copy <= 0) {
    num_pix_must_be_copy = 1;
  } else if(num_pix_must_be_copy > max) {
    num_pix_must_be_copy = max ;
  }
  // travail obligatoire ne pas déranger
  set_length_moulinette(num_pix_must_be_copy);
}


void set_destination_ride(int where_start_in_canvas) {
   // ma cuisine

  // verification des problemes
  if(where_start_in_canvas > get_canvas().pixels.length) {
    where_start_in_canvas = get_canvas().pixels.length - 1;
  } else if(where_start_in_canvas <= 0) {
    where_start_in_canvas = 0;
  }
  
  // travail obligatoire ne pas déranger
  set_destination_moulinette(where_start_in_canvas);
    
}




/*
float decalage_ride() {
  int min = 0 ;
  int max = height;
   float decalage = map(mouseY, min,max, 0, 1);
      if (decalage >= 1) { 
      decalage = 1 ;
    }
    if (decalage <= 0) { 
    decalage = 0 ;
    }
    return decalage ;
    

}


boolean ride_decalage ;



void set_ride_decalage() {
  if (ride_decalage == false) {
    
   int entry = 0 ;
   int where = 1 ;
   int lenght_pix = 300 ;    
  }
  
  ride_decalage = true ;
  
}

void ride_decalage () {
  if (mousePressed){
    set_moulinette(0, 300, 0.5) ;

    }
  }
      
    
    
  */  

/*

    if(where < height) {
      where ++ ; 

    set_moulinette() ;
    entry_in_moulinette += entry_in_moulinette ;
    if(entry_in_moulinette > get_moulinette_img().pixels.length) {
      entry_in_moulinette = entry_in_moulinette -get_moulinette_img().pixels.length ; 
    }
    moulinette(entry_in_moulinette, which_pioche, where_entry_pioche, pix_length_copy) ;
  } else {
    moulinette_is = false ;
    set_moulinette() ;
  }
  image(get_moulinette_img() , 0, 0);
}


nt which_line_of_pioche = 0 ;
    where_entry_pioche = 0 ;
    int num_line_of_pioche_must_be_copy = get_height_pioche(which_pioche) ;

    if(num_line_of_pioche_must_be_copy + which_line_of_pioche > get_pioche_img(which_pioche).height) {
      num_line_of_pioche_must_be_copy = abs(which_line_of_pioche -num_line_of_pioche_must_be_copy) ;
    }


    pix_length_copy = num_line_of_pioche_must_be_copy *(int)get_pioche_img(which_pioche).width ;
    // entry_in_moulinette = floor(random(get_moulinette_img().pixels.length)) ;
    // int offset = int(get_pioche_img(which_pioche).height)/4) + 1 ;
    int offset = int(get_pioche_img(which_pioche).height)/3 ;
    entry_in_moulinette += offset ;
    println("décalage", entry_in_moulinette) ;

    // print_info(which_pioche, which_line_of_pioche, num_line_of_pioche_must_be_copy, pix_length_copy) ;

  }
  moulinette_is = true ;


*/






/*
float norm_entry = 0 ;
int pioche_img = 0;
float norm_destination = 0 ;


float norm_length = 1;
boolean change_pioche_is = true  ;
void setting_ride() {
  // select the canvas on which one you want copy your pixel work
  select_canvas(0);

  if(beat_is(0)) {
    //choice an image in random from the pioche
    int num_of_image_in_current_pioche = pioche_image_size();
    int which_pioche_img = floor(random(num_of_image_in_current_pioche));
    select_image_pioche(which_pioche_img);
  }

  if(beat_is(1)) { 
    where.x += random(20) ;
    if(where.x > get_canvas().width) {
      where.x = 0;
    }
    where.y = floor(random(get_canvas().height));
  }

  if(beat_is(2)) {
    norm_length = random(1);
  }
  

  // change pioche when there is no sound
  if(get_time_track() == 0 && change_pioche_is) {

    change_pioche_is = false;
    int other_pioche = get_current_id_pioche_moulinette() +1; 
    if(other_pioche >= pioche_size()) {
      other_pioche = 0 ;
    }
    select_pioche_moulinette(other_pioche);
    println(get_pioche_name());
  }
  if(get_time_track() != 0) {
    change_pioche_is = true;
  }

  set_moulinette(entry, norm_length, where);
}
  


*/


//-----------------version cymbale pixel generator //






//-----------------version cymbale pixel generator //




//-----------------------------------TOM / CHANGE-CANVAS-----------------------------------//


void setting_tom_bass () {


  int which_canvas = get_canvas_id() ; 
  PImage img_temp = moulinette_horizontale(entry_in_moulinette, get_pioche_image(), where_entry_pioche, pix_length_copy, which_canvas);
  update_canvas(img_temp, which_canvas);

 if (get_canvas_id() > canvas_size()) {
    which_canvas = 0 ;
  
  
  if (get_canvas_id() == 1 ) {
    which_canvas ++ ;
    select_canvas(which_canvas);
    
 //    print(which_canvas);
     }
 
}
}



  
//-----------------------------------RENDERING MOULINETTE CHEUCH-----------------------------------//

// rendering

void rendering_moulinette_cheuch_hor() {
  if(entry_in_moulinette > get_canvas().pixels.length) {
    entry_in_moulinette = entry_in_moulinette -get_canvas().pixels.length; 
  }
  moulinette_horizontale_is(true) ;
  int which_canvas = get_canvas_id() ; 
  PImage img_temp = moulinette_horizontale(entry_in_moulinette, get_pioche_image(), where_entry_pioche, pix_length_copy, which_canvas);
  update_canvas(img_temp, which_canvas);
}



void rendering_moulinette_cheuch_vert() {
  if(entry_in_moulinette > get_canvas().pixels.length) {
    entry_in_moulinette = entry_in_moulinette -get_canvas().pixels.length; 
  }
  moulinette_horizontale_is(false) ;
  int which_canvas = get_canvas_id() ; 
  PImage img_temp = moulinette_verticale(entry_in_moulinette, get_pioche_image(), where_entry_pioche, pix_length_copy, which_canvas);
  update_canvas(img_temp, which_canvas);
}