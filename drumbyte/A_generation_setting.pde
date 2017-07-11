/**

drumbyte generation
v 0.0.1
*/
PixGen [] pg ;

void set_generation() {
  pg = new PixGen[4] ;
  for(int i = 0 ; i < pg.length ; i++) {
    pg[i] = new PixGen(i) ;
  }
}



void drumbyte_generation() {
  generation_is = true ;
  /*
  color array
  */
  // int [] c_grey = array_colour_grey(60, 0, 56);

  int max = int(g.colorModeX);
  // int array_length = max /y ;
  int array_length = max;

  int [] c_grey = array_colour(max, 0, max);
  // int [] c_rgb = array_colour(array_length, iVec3(0,0,0), iVec3(max,0,0));


  int [] c_sound = array_colour_sound(4) ;

  int [] c_ouf =  new int [c_grey.length + c_sound.length] ;
  int count = 0;
  for(int i = 0 ; i < c_ouf.length ; i++) {
    if(count >= c_grey.length) {
      count = 0 ;
    }
    if(i <  c_grey.length) {
      c_ouf[i] = c_grey[count];
    } else {
      c_ouf[i] = c_sound[count];
    }
    count++;

  }

  // int [] c = array_colour_range_sound(4);



 /**
  When you use a same PixGen, you can create something weird :)
 */
/**
bug quand la taille des pixels n'est pas un multiple de la taille de la fenêtre
*/
int x = 2;
int y = 7;
// setting_south_right_gen(pg[0],x,y,c_rgb);
pg[0].security_distribution(false);
pg[1].security_distribution(false);
pg[2].security_distribution(false);
pg[3].security_distribution(false);

/*
classic setting
*/

setting_north_right_gen(pg[0],x,y,c_sound);
// setting_north_left_gen(pg[0],x,y,c_sound);
// setting_north_gen(pg[0],x,y,c_sound);
setting_east_up_gen(pg[1],x,y,c_sound);
// setting_east_left_gen(pg[1],x,y,c_sound);
// setting_east_gen(pg[1],x,y,c_sound);
setting_south_left_gen(pg[2],x,y,c_sound);
// setting_south_right_gen(pg[2],x,y,c_sound);
// setting_south_gen(pg[2],x,y,c_sound);
setting_west_down_gen(pg[3],x,y,c_sound);
// setting_west_up_gen(pg[3],x,y,c_sound);
// setting_west_gen(pg[3],x,y,c_sound);







/*
special setting
*/
// setting_nowhere_gen(pg[3], x, y, c_sound) ;

/*
int colour = color(255,0,0) ;
setting_draw_and_clear(pg[3], x, y, colour, c_sound) ;
*/
/*
float norm_entry = random(1);
float norm_exit = random(1);
int c = color(random(g.colorModeX),random(g.colorModeY),random(g.colorModeZ),random(g.colorModeA));
setting_entry_exit(pg[3], norm_entry, norm_exit, c);
*/




}











/**
setting colour array
*/

int [] array_colour(int num, int min, int max) {
  int [] c = new int[num] ;
  for(int i = 0 ; i < c.length ; i++) {
    int value = int(map(i, 0, num, min, max));
    c[i] = color(value) ;
  }
  return c ;
}

int [] array_colour(int num, iVec2 min, iVec2 max) {
  int [] c = new int[num] ;
  for(int i = 0 ; i < c.length ; i++) {
    int grey = int(map(i, 0, num, min.x, max.x));
    int alpha = int(map(i, 0, num, min.y, max.y));
    c[i] = color(grey, alpha);
  }
  return c ;
}

int [] array_colour(int num, iVec3 min, iVec3 max) {
  int [] c = new int[num] ;
  for(int i = 0 ; i < c.length ; i++) {
    int r = int(map(i, 0, num, min.x, max.x));
    int g = int(map(i, 0, num, min.y, max.y));
    int b = int(map(i, 0, num, min.z, max.z));
    c[i] = color(r,g,b) ;
  }
  return c ;
}

int [] array_colour(int num, iVec4 min, iVec4 max) {
  int [] c = new int[num] ;
  for(int i = 0 ; i < c.length ; i++) {
    int r = int(map(i, 0, num, min.x, max.x));
    int g = int(map(i, 0, num, min.y, max.y));
    int b = int(map(i, 0, num, min.z, max.z));
    int a = int(map(i, 0, num, min.w, max.w));
    c[i] = color(r,g,b,a) ;
  }
  return c ;
}


int [] array_colour_sound(int num_component) {
  // int sort = SORT_BLOCK_ARGB;
  int sort = SORT_BLOCK_RGBA;
  // int sort = SORT_HASH;
  return color_spectrum(num_component, sort);
}

int [] array_colour_range_sound(int num_component) {
  int sort = SORT_BLOCK_ARGB;
  Vec2 range_red = Vec2(0,1) ;
  Vec2 range_green = Vec2(0, 1) ;
  Vec2 range_blue = Vec2(0, 1) ;
  float max = random(1) ;
  Vec2 range_alpha = Vec2(0, max) ;
  return color_spectrum(num_component, sort, range_red, range_green, range_blue, range_alpha);
}



/**
setting generation

problem with the selection of canvas where the pixel is writing...we don't wich one must be updated,

must be resolved..
may be give the ID of canvas on the class PixGen ???????
*/
/**

*/

/**
NORTH writing LEFT or RIGHT start
*/


/**
left
*/
void setting_north_left_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y);

  // used to display info
  if(collect_pix_work) add_pix_work(c) ;

  pix_gen.colour_line(c) ;

  boolean left = true ;
  pix_gen.draw(get_canvas(), NORTH, pix, left);
}
/**
right
*/
void setting_north_right_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y);

  // used to display info
  if(collect_pix_work) add_pix_work(c) ;

  pix_gen.colour_line(c) ;

  boolean right = false ;
  pix_gen.draw(get_canvas(), NORTH, pix, right);
}


/**
SOUTH writing LEFT or RIGHT start
*/
/**
left
*/
void setting_south_left_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y);

  // used to display info
  if(collect_pix_work) add_pix_work(c) ;

  pix_gen.colour_line(c) ;

  boolean left = true ;
  pix_gen.draw(get_canvas(), SOUTH, pix, left);
}
/**
right
*/
void setting_south_right_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y);

  // used to display info
  if(collect_pix_work) add_pix_work(c) ;

  pix_gen.colour_line(c) ;

  boolean right = false ;
  pix_gen.draw(get_canvas(), SOUTH, pix, right);
}





/**
WEST writting TOP or DOWN start
*/
/**
from botton
*/
void setting_west_down_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y);

  // used to display info
  if(collect_pix_work) add_pix_work(c) ;

  pix_gen.colour_line(c) ;
  pix_gen.draw(get_canvas(), WEST, pix, false);
}

/**
from top
*/
void setting_west_up_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y);

  // used to display info
  if(collect_pix_work) add_pix_work(c) ;

  pix_gen.colour_line(c) ;
  pix_gen.draw(get_canvas(), WEST, pix, true);
}




/**
EAST writting TOP or DOWN start
*/
/**
from botton
*/
void setting_east_down_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y);

  // used to display info
  if(collect_pix_work) add_pix_work(c) ;

  pix_gen.colour_line(c) ;
  pix_gen.draw(get_canvas(), EAST, pix, false);
}

/**
from top
*/
void setting_east_up_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y);
  // used to display info
  if(collect_pix_work) add_pix_work(c) ;

  pix_gen.colour_line(c) ;
  pix_gen.draw(get_canvas(), EAST, pix, true);
}










/**
CLASSIC
*/
void setting_north_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y) ;
  // used to display info
  if(collect_pix_work) add_pix_work(c) ;
  pix_gen.colour_line(c) ;
  pix_gen.draw(get_canvas(), NORTH, pix);
}

void setting_east_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y);
  // used to display info
  if(collect_pix_work) add_pix_work(c) ;
  pix_gen.colour_line(c) ;
  pix_gen.draw(get_canvas(), EAST, pix);
}

void setting_south_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y);
  // used to display info
  if(collect_pix_work) add_pix_work(c) ;
  pix_gen.colour_line(c) ;
  pix_gen.draw(get_canvas(), SOUTH, pix);
}

void setting_west_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y);
  // used to display info
  if(collect_pix_work) add_pix_work(c) ;
  pix_gen.colour_line(c) ;
  pix_gen.draw(get_canvas(), WEST, pix);
}



/**
CHAOS, DIAGONAL, NOWHERE
*/
void setting_nowhere_gen(PixGen pix_gen, int x, int y, int... c) {
  iVec2 pix = iVec2(x,y);
  // used to display info
  if(collect_pix_work) add_pix_work(c) ;
  
  pix_gen.colour_line(c) ;
  // pix_gen.draw(get_canvas(which_canvas), NOWHERE_A, pix);
  /**
  why I must created a special void for this case ????
  */
  
  update_canvas(pix_gen.get(get_canvas(), NOWHERE_A, pix, false)) ;
}





/**
clear
v 0.0.2
*/

void setting_clear(PixGen pix_gen, int c) {
  pix_gen.colour(get_canvas(), c) ;

}

/*
void setting_draw_and_clear(PixGen pix_gen, int x, int y, int c, int... array_colour) {
  iVec2 pix = iVec2(x,y);
  // used to display info
  if(collect_pix_work) add_pix_work(array_colour) ;
  
  pix_gen.colour_line(array_colour) ;
  if(beat_is(2)) {
    // c is a colour to clean the board :)
    pix_gen.colour(get_canvas(), c) ;
  }
  pix_gen.draw(get_canvas(), EAST, pix);
}
*/


/**

*/
void setting_entry_exit(PixGen pix_gen, float entry, float exit, int c) {
  
  // used to display info
  if(collect_pix_work) add_pix_work(c) ;

  if(entry > 1) entry = 1;
  if(entry < 0) entry = 0 ;
  if(exit > 1) exit = 1;
  if(exit < 0) exit = 0 ;
  entry = map(entry, 0, 1, 0, exit);

  pix_gen.colour(get_canvas(), c, entry, exit) ;

}







