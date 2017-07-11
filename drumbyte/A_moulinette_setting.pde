/**
preset
v 0.0.2
*/
iVec2 entry;
iVec2 where;
boolean variables_is_set;

void preset_moulinette() {
	if(!variables_is_set) {
		int entry_x = floor(get_pioche_image().width *0);
    int entry_y = floor(get_pioche_image().height *.5);
    entry = iVec2(entry_x, entry_y);

    float ratio_length = random(1) ;


    int where_x = floor(get_canvas().width *0);
    int where_y = floor(random(get_canvas().height));
    where = iVec2(where_x, where_y) ;

    variables_is_set = true ;
	}
}

/**
Pioche setup
v 0.0.1
*/
// String current_path_pioche = "";

void pioche_setup() {
  build_pioche("data/01-berurier");
    build_pioche("data/02-berurier");
      build_pioche("data/03-berurier");
        build_pioche("data/04-berurier");



  int which_pioche = 0;
  select_pioche_moulinette(which_pioche);
  int which_img = floor(random(pioche_image_size()));
  select_image_pioche(which_img);
}





int current_id_pioche_moulinette;
void select_pioche_moulinette(int which_one) {
  select_pioche(which_one);
  current_id_pioche_moulinette = which_one;
  // current_path_pioche = get_pioche().get_path();
}

int get_current_id_pioche_moulinette() {
  return current_id_pioche_moulinette;
}



/**
drumbyte moulinette
v 1.0.2.1
*/
void moulinette_drumbyte() {
  
  // setting_DrumByte_test() ;
  //setting_simple_moulinette();
  // setting_basic_moulinette();
  // setting_moulinette_mode_d_emploi();
  // setting_moulinette_3();
 // setting_image_suivante();

  rendering_moulinette_horizontal(); 
  // rendering_moulinette_vertical(); 

}




/**
setting example
v 0.0.4
*/
/**
setting simple step by step
*/
float norm_entry = 0 ;
int pioche_img = 0;
float norm_destination = 0 ;
void setting_simple_moulinette() {
  // select the canvas on which one you want copy your pixel work
  select_canvas(1);
  //select_image_pioche(0);
  
  // entry in image pioche
  // norm_entry += .001 ;
  float norm_entry = map(mouseX, 0, width, 0, 1) ;
  if(norm_entry > 1) {
    norm_entry = 0 ;
  }
  set_entry_moulinette(norm_entry);

  // if the entrey copy return to zero select a new image for the round
  if(norm_entry <= 0) {
    pioche_img ++;
    if(pioche_img >= pioche_image_size()) { 
      pioche_img = 0 ;
    }
    select_image_pioche(pioche_img);
  }

  // length norm of what must be copy
  float norm_length_copy = map(mouseY, 0, height, 0, 1) ;
  if(norm_length_copy <= 0) norm_length_copy = .001 ;
  set_length_moulinette(norm_length_copy);
  

  // where the image of part of it must be copied
  norm_destination += .01 ;
  if(norm_destination > 1) norm_destination = 0;
  set_destination_moulinette(norm_destination);

  // set_moulinette(norm_entry, norm_length_copy, norm_destination);

}



/**
setting basic
*/
float norm_length = 1;
boolean change_pioche_is = true  ;
void setting_basic_moulinette() {
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


/**
setting moulinette 2
*/
int which_pioche_img = 0 ;

void setting_moulinette_mode_d_emploi() {
  select_canvas(0);

  entry.x = 0 ;
  entry.y += 1 ;
  float ratio_length = 1. ;

  where.x += 1;
  where.y += 5;

  if(where.x > get_canvas().width) where.x =0 ;
  if(where.y > get_canvas().height) where.y =0 ;

  set_moulinette(entry, ratio_length, where);  
  
  if(beat_is()) {
    if( which_pioche_img > pioche_image_size()) {
      which_pioche_img = 0 ;
    }
    which_pioche_img ++ ;
    select_image_pioche(which_pioche_img);
  }
}


/**
setting moulinette 3
*/
boolean new_pioche_is ;
String current_pioche ;

void setting_moulinette_3() {
  select_canvas(0);

  //select new pioche
  if(get_time_track() == 0 && new_pioche_is) {
    int new_pioche = floor(random(pioche_size()));
    if(!current_pioche.equals(pioche_list.get(new_pioche).get_name())) {
      select_pioche_moulinette(new_pioche);
      new_pioche_is = false ;
    }
  }
  if(get_time_track() > 0) {
    current_pioche = pioche.get_name() ;
    new_pioche_is = true ;
  }


  if(beat_is(1)) { 
    float ratio_length = random(1) *.1;
   // where_y = floor(random(get_moulinette().height));
    where.y = floor(random(get_canvas().height));
    set_moulinette(entry, ratio_length, where);  
  }

  if(beat_is(2)) {
    int which_pioche_img = floor(random(pioche_image_size()));
    select_image_pioche(which_pioche_img);
  }

}


/**
setting moulinette 4
*/
int nouvelle_image ;
void setting_image_suivante() {
  // select a canvas to draw your work
  select_canvas(0);
  // set pioch
  if(beat_is(1)) {
    int taille_pioche = pioche_image_size() ;
    // nouvelle_image = nouvelle_image + 1 ;
    nouvelle_image++ ;
    if(nouvelle_image > taille_pioche) {
      nouvelle_image = 0 ;
    }
    select_image_pioche(nouvelle_image);  
  }


  // select pioche
  if(beat_is(0) && new_pioche_is) {
    int new_pioche = floor(random(pioche_size()));
    if(!current_pioche.equals(pioche_list.get(new_pioche).get_name())) {
      select_pioche_moulinette(new_pioche);
      new_pioche_is = false ;
    }
  }

  if(!beat_is(0)) {
    current_pioche = pioche.get_name() ;
    new_pioche_is = true ;
  }
}





/**
rendering
v 0.0.1
*/
/**
rendering 1
*/
void rendering_moulinette_horizontal() {
	if(entry_in_moulinette > get_canvas().pixels.length) {
    entry_in_moulinette = entry_in_moulinette -get_canvas().pixels.length; 
  }
  moulinette_horizontale_is(true) ;
  int which_canvas = get_canvas_id() ; 
  PImage img_temp = moulinette_verticale(entry_in_moulinette, get_pioche_image(), where_entry_pioche, pix_length_copy, which_canvas);
  update_canvas(img_temp, which_canvas);
}


/**
rendering 2
*/
float value_vert ;
float threshold_inverse = .2 ;
void rendering_moulinette_vertical() {
	if(entry_in_moulinette > get_canvas().pixels.length) {
    entry_in_moulinette = entry_in_moulinette -get_canvas().pixels.length; 
  }
  if(beat_is(2)) {
  	value_vert = 1 ;
  } else if(!beat_is(3) && value_vert > 0 ) {
  	value_vert -= .05 ;
  }

  moulinette_horizontale_is(false) ;

  int which_canvas = get_canvas_id() ;
  PImage img_temp = moulinette_verticale(entry_in_moulinette, get_pioche_image(), where_entry_pioche, pix_length_copy, which_canvas);
  update_canvas(img_temp, which_canvas);
}