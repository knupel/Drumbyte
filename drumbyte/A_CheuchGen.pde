/**

drumbyte generation
v 0.0.1
*/


// int [] couleur_total ;


void set_DrumGen() {
  select_canvas(2);
  
  pg = new PixGen[4] ;
  for(int i = 0 ; i < pg.length ; i++) {
    pg[i] = new PixGen(i) ;
  }
  set_array_colour();
}




void DrumGen_Cheuch() {
  select_canvas(2);
  cymbale_gen() ;
}





void cymbale_gen() {
  // taille la plus petit et homotétique à la taille du canvas
    /*
  int x = 1 ;
  int y = 1 ;
  */
  /*
  int x = 1 ;
  int y = 1 ;
  */
  int x = 5 ;
  int y = 7 ;
  pg[0].set_pix(x,y);
  pg[1].set_pix(x,y);
  pg[2].set_pix(x,y);
  pg[3].set_pix(x,y);
  

  

  // choix de couleur ;
  
  int taille_pixel = x*y ;
  int max_pixels = get_canvas().pixels.length / taille_pixel ;
  int nombre_de_pixel = (int)random(1, 10);
  int quelle_couleur = floor(random(6)) +5000;
  float alpha = g.colorModeA ;

  create_array_colour(max_pixels, nombre_de_pixel, quelle_couleur, alpha) ;

  int [] c = new int[get_array_colour_size()] ;
  for(int i = 0 ; i < c.length ; i++) {
    c[i] = get_colour_pixel(i) ;
  }

  
  // reset fait des truc bizarre, c'est cool
  int couleur_reset = color(0) ;
  reset_pix_gen(pg[0], max_pixels, couleur_reset, c);
  reset_pix_gen(pg[1], max_pixels, couleur_reset, c);
  reset_pix_gen(pg[2], max_pixels, couleur_reset, c);
  reset_pix_gen(pg[3], max_pixels, couleur_reset, c);
  
  


 // choix du vent grosse caisse / KICK
 int vent = floor(random(4)) ; 

/*
  if(vent == 0) setting_north_right_gen(pg[0],x,y,c);
  if(vent == 1) setting_east_up_gen(pg[0],x,y,c);
  if(vent == 2) setting_north_left_gen(pg[0],x,y,c);
  if(vent == 3) setting_east_down_gen(pg[0],x,y,c);
*/

  if(collect_pix_work) add_pix_work(c);

  if(vent == 0) setting_north_right_gen(pg[0],x,y,c);
  if(vent == 1) setting_east_up_gen(pg[1],x,y,c);
  if(vent == 2) setting_south_left_gen(pg[2],x,y,c);
  if(vent == 3) setting_east_down_gen(pg[3],x,y,c);


  // dans le cas ou les pixel sont au dessus de '1'
  pg[0].security_distribution(true);
  pg[1].security_distribution(true);
  pg[2].security_distribution(true);
  pg[3].security_distribution(true);
 

}












/**
annexe
*/
void reset_pix_gen(PixGen pg, int max_pixels, int colour_reset, int... c) {
  int surface_pix = pg.get_pix().x *pg.get_pix().y ;
  if(pg.get_header() / surface_pix >= max_pixels -c.length) {
    pg.set_header(0);
    clear_array_colour();
    setting_clear(pg, colour_reset);
  }
}







/**
Manage pixel colour list
v 0.0.2
*/
ArrayList<Integer> colour_list ;

int get_array_colour_size() {
  return colour_list.size();
}
void set_array_colour() {
  colour_list = new ArrayList<Integer>();
}

void clear_array_colour() {
  colour_list.clear();
}

int get_colour_pixel(int which_one) {
  if(which_one < colour_list.size()) {
    return colour_list.get(which_one) ;
  } else {
    String message = ("target: " + which_one + " is out of list, instead a pixel blank is used");
    printErrTempo((int)frameRate, message);
    return color(0,0);
  }
}

int count_pix = 0 ;
boolean set_pix_list = false ;
void create_array_colour(int max_pixels, int round_length, int which_colour, float alpha) {
  // first part : complete the list until the max, where the max is the surface of the canvas
  if(count_pix <= max_pixels && set_pix_list == false) {
    // println("je commence", frameCount, count_pix, colour_list.size(), max_pixels);
    for(int i = 0 ; i < round_length ; i++) {
      iVec4 temp = component_couleur(which_colour, alpha) ;
      int colour_temp = color(temp.x,temp.y, temp.z, temp.w) ;
      colour_list.add(colour_temp) ;
      count_pix++ ;
    }
    // second step, replace the pixel 
  } else {
    if(count_pix >= max_pixels) {
      count_pix = 0;
      set_pix_list = true;
      colour_list.clear() ;
    }
    for(int i = 0 ; i < round_length ; i++) {
      if(count_pix >= max_pixels) {
        // colour_list.clear() ;
      }
      iVec4 temp = component_couleur(which_colour, alpha) ;
      int colour_temp = color(temp.x,temp.y, temp.z, temp.w) ;

      colour_list.add(colour_temp) ;
      count_pix++ ;
    }
  }
}


static public int ROUGE = 5000 ;
static public int VERT = 5001 ;
static public int BLEU = 5002 ;
static public int JAUNE = 5003 ;
static public int MAGENTA = 5004 ;
static public int CYAN = 5005 ;

iVec4 component_couleur(int which_one, float alpha) {
  iVec4 c = iVec4(0,0,0,(int)alpha) ;

  if(which_one == ROUGE) c.x = (int)g.colorModeX;
  if(which_one == VERT) c.y = (int)g.colorModeY;
  if(which_one == BLEU) c.z = (int)g.colorModeZ;
  if(which_one == CYAN) {
    c.y = (int)g.colorModeY;
    c.z = (int)g.colorModeZ;
  }
  if(which_one == MAGENTA) {
    c.x = (int)g.colorModeX;
    c.z = (int)g.colorModeZ;
  }
  if(which_one == JAUNE) {
    c.x = (int)g.colorModeX;
    c.y = (int)g.colorModeY;
  }
  // alpha
   // c.w = (int)random(255);
  return c ;
}





