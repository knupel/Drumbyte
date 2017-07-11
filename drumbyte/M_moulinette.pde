/**
Moulinette
v 0.0.7
*/
/**
global variable
*/
int where_entry_pioche;
int pix_length_copy;
int entry_in_moulinette;
/**
set moulinette
v 0.0.5
*/
void set_moulinette(iVec2 entry, float norm_length, iVec2 where) {
  set_entry_moulinette(entry);
  set_length_moulinette(norm_length);
  set_destination_moulinette(where);
}

void set_moulinette(float norm_entry, float norm_length, float norm_where) {
  set_entry_moulinette(norm_entry);
  set_length_moulinette(norm_length);
  set_destination_moulinette(norm_where);
}

void set_moulinette(int entry, int length_copy_pix, int where) {
  set_entry_moulinette(entry);
  set_length_moulinette(length_copy_pix);
  set_destination_moulinette(where);
}

/**
entry
v 0.0.1
*/
void set_entry_moulinette(iVec2 entry_pioche_img_coord) {
  int entry_pix = int(entry_pioche_img_coord.y *get_pioche_image().width +entry_pioche_img_coord.x);
  set_entry_moulinette(entry_pix);
}

void set_entry_moulinette(int entry_in_img_pioche) {
  if(entry_in_img_pioche > get_pioche_image().pixels.length) { 
    entry_in_img_pioche = get_pioche_image().pixels.length -1; 
  } else if (entry_in_img_pioche < 0 ) {
    entry_in_img_pioche = 0;
  }
  where_entry_pioche = entry_in_img_pioche;
}

void set_entry_moulinette(float entry_norm) {
  if(entry_norm < 0) entry_norm = 0;
  if(entry_norm > 1) entry_norm = 1;
  where_entry_pioche = floor((get_pioche_image().pixels.length -1) *entry_norm);
}

/**
length must be copy
v 0.0.2
*/
void set_length_moulinette(float norm_length_pix_must_be_copy) {
  if(norm_length_pix_must_be_copy < 0) norm_length_pix_must_be_copy = 0;
  if(norm_length_pix_must_be_copy >1) norm_length_pix_must_be_copy = 1;
  int length_copy_pix = int(get_pioche_image().pixels.length *norm_length_pix_must_be_copy);
  set_length_moulinette(length_copy_pix);
}

void set_length_moulinette(int num_pix_must_be_copy) {
  int max = get_pioche_image().pixels.length -where_entry_pioche ;
  if(num_pix_must_be_copy <= 0) {
    num_pix_must_be_copy = 1;
  } else if(num_pix_must_be_copy > max) {
    num_pix_must_be_copy = max ;
  }
  pix_length_copy = num_pix_must_be_copy;
}
/**
copy destination
v 0.0.1
*/
void set_destination_moulinette(iVec2 where_start_in_canvas_coord) {
  set_destination_moulinette(int(where_start_in_canvas_coord.y *get_canvas().width +where_start_in_canvas_coord.y));
}

void set_destination_moulinette(float where_norm_in_canvas) {
  if(where_norm_in_canvas < 0) where_norm_in_canvas = 0;
  if(where_norm_in_canvas > 1) where_norm_in_canvas = 1;
  entry_in_moulinette = floor((get_canvas().pixels.length -1) *where_norm_in_canvas);
}

void set_destination_moulinette(int where_start_in_canvas) {
  if(where_start_in_canvas > get_canvas().pixels.length) {
    where_start_in_canvas = get_canvas().pixels.length - 1;
  } else if(where_start_in_canvas <= 0) {
    where_start_in_canvas = 0;
  }
  entry_in_moulinette = where_start_in_canvas;
}




/**
info
v 0.0.1
*/

void print_info_moulinette(int which_pioche, int which_line_of_pioche, int num_line_of_pioche_must_be_copy, int pix_length_copy) {
  println("--") ;
  println("pioche", get_pioche_image_name(which_pioche)) ;
  println("Quelle ligne de la pioche", which_line_of_pioche) ;
  println("nombre de ligne copiées", num_line_of_pioche_must_be_copy) ;
  println("nombre de pixel copiées",pix_length_copy);
  println("pixel d'entrée dans la pioche", where_entry_pioche) ;
}












/**
Rendering
v 0.1.1.5
Direction artistique Antoine Thibaudeau
code Stan le Punk

*/
boolean moulinette_vertical_is = true ;

void moulinette_horizontale_is(boolean verticale_is) {
  moulinette_vertical_is = verticale_is ;
}

PImage moulinette_horizontale(int paste_entry, PImage origin, int origin_entry, int length_pixels_duplicate, int which_canvas) {
  int [] array_pix = new int[length_pixels_duplicate];
  int entry_copy = floor(origin.pixels.length -length_pixels_duplicate) ;
  for(int i = 0 ; i < length_pixels_duplicate ; i++) {
    int where = origin_entry +i ;
    if(where >= origin.pixels.length) {
      int ratio = floor(where / origin.pixels.length) ;
      where -= (origin.pixels.length *ratio);
    }
    array_pix[i] = origin.pixels[where] ;
  }
  // add to hex
  if(collect_pix_work) add_pix_work(array_pix) ;

  return paste(get_canvas(which_canvas), paste_entry, array_pix, moulinette_vertical_is);
}


PImage moulinette_verticale(int paste_entry, PImage origin, int origin_entry, int length_pixels_duplicate, int which_canvas) {
  int [] array_pix = new int[length_pixels_duplicate];
  int entry_copy = floor(origin.pixels.length -length_pixels_duplicate);
  int w = origin.width;
  int line = 0 ;
  for(int i = 0 ; i < length_pixels_duplicate ; i++) {
    int mod = i%w ;
    int where =  origin_entry +(w *(w -(w -mod))) +line;
    if(mod >= w -1) {
      line++;
    }

    if(where >= origin.pixels.length) {
      int ratio = floor(where / origin.pixels.length) ;
      where -= (origin.pixels.length *ratio);
    }
    array_pix[i] = origin.pixels[where] ; 
  }
  // collect data to hex
  if(collect_pix_work) add_pix_work(array_pix) ;

  return paste(get_canvas(which_canvas), paste_entry, array_pix, moulinette_vertical_is);
}