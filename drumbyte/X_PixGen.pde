/**
PixGen - Pixel Generator 2017-2017
by Stan le Punk
v 0.1.0
*/


/**
CONSTANTE
*/
int NORTH = 0;
int EAST = 4;
int SOUTH = 8;
int WEST = 12;
int NOWHERE_A = 26 ;

/**
variable global
*/
boolean template_pixelate_is ;
int [] raw_list ;
ArrayList<CanvasPix> canvas_list ;
ID_pixelate [] pix_list ;




/**
class PixGen
v 0.0.3
*/

class PixGen {
	int header ;
	int header_col ;

	int [] color_array;

	int id ;
	int direction = WEST ;
  
  int def_pix ;
	iVec2 pix ;



	public PixGen(int id) {
		this.id = id ;
	}
  /**
  header control
  */
	public int get_header() {
		return header ;
	}

	public void set_header(int header) {
		this.header = header ;
	}

	/**
	set pix
	*/
	public void set_pix(int x, int y) {
		if(this.pix == null) {
			this.pix = iVec2(x,y) ;
		} else {
			this.pix.set(x,y) ;
		}	
	}

	public iVec2 get_pix() {
		return pix ;
	}


	/**
  Public method
  */
  void colour_line(int [] a) {
  	color_array = a ;
  }


  void colour(PImage img, int colour) {
  	for(int i = 0 ; i < img.pixels.length ; i++) {
  		img.pixels[i] = colour ;
  	}
  	img.updatePixels();
  }


  void colour(PImage img, int colour, float entry, float exit) {
  	if(entry < 0) {
  		println("float entry is under '0' change to '0'") ;
  		entry = 0 ;
  	}
  	if(exit > 1){
  		println("float entry is upper '1' change to '1'") ;
  		exit = 1 ;
  	}
  	if(entry > exit) {
  		println("float entry is upper to float exit, entry is change to '0'") ;
  		entry = 0  ;
  	}
  	if(exit < entry) {
  		println("float exit is under float entry, exit is change to '1'") ;
  		exit = 1 ;
  	}
  	int in = int(img.pixels.length *entry) ;
  	int out = int(img.pixels.length *exit) ;
  	for(int i = in ; i < out ; i++) {
  		img.pixels[i] = colour ;
  	}
  	img.updatePixels();
  }

  /**
  draw
  v 0.0.3
  */
  void draw(PImage img, int direction, iVec2 pix, boolean side) {
  	img = get(img, direction, pix, side) ;
	}


  void draw(PImage img, int direction, iVec2 pix) {
  	img = get(img, direction, pix, false);
	}
  
  /**
  enable strage behavior security
  */
  boolean behavior_security = true ;
	void security_distribution(boolean security) {
		behavior_security = security ;
	}


















  /**

  private method

  */

	private PImage get(PImage img, int direction, iVec2 pix, boolean side) {
	  this.pix = pix ;
	  def_pix = pix.x * pix.y;
	  this.direction = direction ;
    img = generation(img, color_array, side) ;
    
    // update header
    if(side) {
    	header -= (color_array.length *def_pix);
    	if(header <= 0) {
    		header = img.pixels.length +header ;
    	}
    } else if(!side || (direction == NORTH || direction == SOUTH)) {
    	header += (color_array.length *def_pix) ;  
    	if(header >= img.pixels.length) {
    		header -= img.pixels.length ;
    	}
    }
	  return img ;
	}


  // generation
  private PImage generation(PImage img, int [] c, boolean side) {
	// private void generation(PImage img, int [] c) {
		// build list canvas
		if(canvas_list == null) {
			canvas_list = new ArrayList<CanvasPix>() ;
		} 
		// check for the existing canvas
		// check the existing template
		int different_template = 0;
		if(canvas_list != null && canvas_list.size() > 0 && def_pix > 1) {
			for(CanvasPix cp : canvas_list) {
				if(cp.pix.x != pix.x || cp.pix.y != pix.y || cp.canvas.x != img.width || cp.canvas.y != img.height) {
					different_template++ ;
				} 
			}
			if(different_template == canvas_list.size()) {
				template_pixelate_is = false ;
			}
	  }

		if(def_pix > 1 && !template_pixelate_is) {
			// Don't clutter the memory, if it's not necessary, with huge data list
			iVec2 full_canvas = iVec2(img.width,img.height) ;
			raw_list = pix_rank_id(full_canvas, pix);
			CanvasPix cp = new CanvasPix(raw_list, full_canvas, pix) ;
			canvas_list.add(cp) ;
			pix_list = cp.get_list() ;
			template_pixelate_is = true ;
		} else if (def_pix == 1) {
			pix_list = new ID_pixelate[1];
			pix_list[0] = new ID_pixelate();
		} else if(template_pixelate_is && def_pix > 1) {
			for(CanvasPix cp : canvas_list) {
				if(cp.pix.x == pix.x && cp.pix.y == pix.y && cp.canvas.x == img.width && cp.canvas.y == img.height) {
					pix_list = cp.get_list() ;
				}
			}
		}

		// PImage img = null;
		if(direction == NORTH) {
			img = generation_north(img, c, pix_list, side) ;
		} else if(direction == SOUTH) {
			img = generation_south(img, c, pix_list, side) ;
		} else if(direction == EAST) {
			img = generation_east(img, c, pix_list) ;
		} else if(direction == WEST) {
			img = generation_west(img, c, pix_list);
		} else if(direction == NOWHERE_A) {
			img = generation_nowhere_a(img, c);
		}
		img.updatePixels();
	  return img;

	}
	/**
	Chaos
	*/
	PImage generation_nowhere_a(PImage img, int [] c) {
		img = paste_vertical(img, header, c);
		return img;
	}

  /**
  NORTH
  the winter is coming
  v 0.1.0
  */
	PImage generation_north(PImage img, int [] c, ID_pixelate [] pix_list, boolean side) {	
		if(def_pix == 1 ) {
			img = gen_north(img, c, side);
		} else {
      img = gen_north_adv(img, c, pix_list, side);
		}
		return img;
	}
  
  /*
  private
  */
  // north classic
  private PImage gen_north(PImage img, int [] c, boolean side) {	
		int count = 0;
	  int where = 0;
	 //  int w = img.width;
	  for(int i = header ; i < header +c.length ; i++) {
	  	iVec2 w_m = where_mod(where, i, img);
	  	where = w_m.x ;
	  	int mod = w_m.y ;

	    // reverse
	    if(side) {
	    	where = img.pixels.length -where -1;
	    }
	  	img.pixels[where] = c[count];
	  	count++ ;
	  } 
		return img;
	}
  // north adv
	private PImage gen_north_adv(PImage img, int [] c, ID_pixelate [] pix_list, boolean side) {	
		int small_header = floor(header /def_pix);
		int count = 0;
		int where = 0;
		int w = int(img.width /pix.x);

		for(int i = small_header ; i < small_header + c.length ; i++) {
			iVec2 w_m = where_mod(where, i, img);
	  	where = w_m.x ;
	  	int mod = w_m.y ;

	  	if(where < pix_list.length) {
	  		for(int k = 0 ; k < pix_list[where].id_list.size() ; k++) {
	  			int id_case = pix_list[where].id_list.get(k) ;
	  			if(side) {
	  				id_case = img.pixels.length -id_case -1;
	  			}
	  			img.pixels[id_case] = c[count] ;
	  		}
	  	}
	    count++ ;
	  }
		return img;
	}


	/**
	SOUTH
	*/
	PImage generation_south(PImage img, int [] c, ID_pixelate [] pix_list, boolean side) {
		if(def_pix == 1 ) {
	    img = gen_south(img, c, side);
		} else {
			img = gen_south_adv(img, c, pix_list, side);
		}
		return img;
	}

  // advance south
	private PImage gen_south_adv(PImage img, int [] c, ID_pixelate [] pix_list, boolean side) {
		int count = 0;
		int where = 0;
		int w = int(img.width /pix.x);

	  for(int i = header ; i < header +c.length ; i++) {
	  	iVec2 w_m = where_mod(where, i, img);
	  	where = w_m.x ;
	  	int mod = w_m.y ;

	  	// pixel distribution
      if(where < pix_list.length) {
	  		for(int k = 0 ; k < pix_list[where].id_list.size() ; k++) {
	  			int id_case = pix_list[where].id_list.get(k) ;
	  			// reverse
	  			if(side) {
	  				id_case = img.pixels.length -id_case -1;
	  			}
	  			img.pixels[id_case] = c[count] ;
	  		}
	  	}

	  	progress_line++ ;  
	  	count++ ;
	  }
		return img;
	}




	// classic south
	private PImage gen_south(PImage img, int [] c, boolean side) {
		int count = 0;
		int where = 0;
		int w = img.width ;
	  for(int i = header ; i < header +c.length ; i++) {
	  	iVec2 w_m = where_mod(where, i, img);
	  	where = w_m.x ;
	  	int mod = w_m.y ;

	  	// reverse
	    if(side) {
	    	where = img.pixels.length -where -1;
	    }
	  	img.pixels[where] = c[count] ;

	  	progress_line++ ;  
	  	count++ ;
	  }
		return img;
	}




	/**
	EAST
	East Block
	*/

	int progress_line ;
	PImage generation_east(PImage img, int [] c, ID_pixelate [] pix_list) {
		if(def_pix == 1 ) {
	    img = gen_east(img, c);
		} else {
			img = gen_east_adv(img, c, pix_list);
		}
		return img;
	}
  // east advanced
  PImage gen_east_adv(PImage img, int [] c, ID_pixelate [] pix_list) {
		int count = 0 ;
		int w = img.width ;
		int small_header = floor(header /def_pix) ;

		for(int i = small_header ; i < small_header + c.length ; i++) {
			int where = 0 ;
			where = where_mod(where, i, img).x;

	  	if(where < pix_list.length && where > 0) {
	  		for(int k = 0 ; k < pix_list[where].id_list.size() ; k++) {
	  			int id_case = pix_list[where].id_list.get(k) ;
	  			img.pixels[id_case] = c[count] ;
	  		}
	  	}
	  	progress_line++ ;  	
	    count++ ;
	  }
		return img;
	}


	// classic westesn
	PImage gen_east(PImage img, int [] c) {
		int count = 0 ;
		int w = img.width ;

	  for(int i = header ; i < header +c.length ; i++) {
	  	int where = 0;
	  	where = where_mod(where, i, img).x;
	  	img.pixels[where] = c[count] ;

	  	progress_line++ ;  
	  	count++ ;
	  }
		return img;
	}


  /**
	WEST
	Western Spaghetti
	*/
	PImage generation_west(PImage img, int [] c, ID_pixelate [] pix_list) {
		if(def_pix == 1 ) {
	    img = gen_west(img, c);
		} else {
			img = gen_west_adv(img, c, pix_list) ;
		}
		return img;
	}
  	// classic westesn
	private PImage gen_west_adv(PImage img, int [] c, ID_pixelate [] pix_list) {
		int small_header = floor(header /def_pix) ;
		int count = 0;
		int w = img.width ;

		for(int i = small_header ; i < small_header + c.length ; i++) {
  		int where = 0;
	  	where = where_mod(where, i, img).x;

	  	if(where < pix_list.length) {
	  		for(int k = 0 ; k < pix_list[where].id_list.size() ; k++) {
	  			int id_case = pix_list[where].id_list.get(k) ;
	  			img.pixels[id_case] = c[count] ;
	  		}
	  	}  	
	    count++ ;
	  }
		return img;
	}

	// classic westesn
	private PImage gen_west(PImage img, int [] c) {
		int count = 0 ;
		int w = img.width ;
	  for(int i = header ; i < header +c.length ; i++) {
	  	int where = 0;
	  	where = where_mod(where, i, img).x;
	  	img.pixels[where] = c[count] ;
	  	count++ ;
	  }
		return img;
	}





	/**
  WHERE_MOD
  v 0.0.3
  */
  /*
  return where is the pixel on the array on component 'x'
  return modulo on a component 'y'
  */
	private iVec2 where_mod(int where, int i, PImage img) {
		int mod = 0 ;
		// make grid on the pixel size basis
		int w = img.width; 
		if(pix.x != 1 ) {
			w = int(w /pix.x);
		}
		int h = img.height;
		if(pix.y != 1 ) {
			h = int(h /pix.y);
		}

    // the main work
		if(pix.x == 1 && pix.y == 1) {
			iVec2 temp = where_mod_pix_classic(where, i, w, h, img);
			where =  temp.x ;
			mod = temp.y ;
		} else {
			// iVec2 temp = where_mod_pix_other(where, i, ref_length_size, img);
			iVec2 temp = where_mod_pix_other(where, i, w, h, img);
			where =  temp.x ;
			mod = temp.y ;
		}

    // security
  	if(where >= img.pixels.length) {
  		where -= header ;
  	} else if(where < 0) {
  		where = img.pixels.length +where;
  	}

  	if(where < 0) {
  		where = img.pixels.length +where;
  	} else if(where >= img.pixels.length) {
  		where = where -img.pixels.length; 		
  	}

    // result
  	iVec2 where_mod = iVec2(where, mod);
  	return where_mod;
	}
	


	// where mod classic
	private iVec2 where_mod_pix_classic(int where, int i, int w, int h, PImage img) {
		int mod = 0 ;
		// ref side bigger
		int bigger_side = bigger_side(w, h);

		if(direction == SOUTH || direction == EAST) {
			if(progress_line >= w) {
				progress_line = 0;
			}
			where = i + w - (progress_line *2);
		}
		if(direction == NORTH || direction == WEST) {
			where = i ;
		}
    
		if(direction == SOUTH || direction == NORTH) {
			mod = where%bigger_side;
			where = mod *w +header_col;
			update_header_col(mod, w, img);
		}
		return iVec2(where,mod);
	}
 


	private iVec2 where_mod_pix_other(int where, int i, int w, int h, PImage img) {
		int mod = 0 ;
		// ref side most bigger
		int bigger_side = bigger_side(w, h);

		// first step
  	if(direction == SOUTH || direction == NORTH) {
  		// second step 
  		if(direction == NORTH) {
  			where = i ;
  		} else {
  			if(progress_line > w) {
					progress_line = 0;
				}
				where = i +w - (progress_line *2);
  		}	

      // third step
  		if(pix.x < pix.y) {
  			mod = where%bigger_side;
  			where = mod *w +header_col;
  		} else {
  			mod = where%bigger_side;
  			where = mod *h +header_col;
  			
  			// try to manage the weird behavior when the second pix 'y' is also upper '1' ;
  			where = where_behavior_distribution(where);
	  		// end try to manage the weird behavior			
  		}
  		update_header_col(mod, w, img);
  	} else {
  		// second step 
  		// back to the classic
  		iVec2 temp = where_mod_pix_classic(where, i, w, h, img);
			where =  temp.x ;
  		mod = temp.y ;
  	}
		return iVec2(where, mod);
	}



	private int bigger_side(int w, int h) {
		if(w > h ) {
			return w;
		} else {
			return h;
		}
	}
  
	private int where_behavior_distribution(int where) {
		if(behavior_security ) {
			float div = 1 ;
			if(pix.y > 0) {
				if(pix.y == 1) {
					div = pix.x ;
				} else {
					div = (float)pix.x / (float)pix.y ;
				}
			}
			where /= div ;
		}
		return where ;
	}

	private void update_header_col(int mod, int ref_length_side, PImage img) {
		if(mod == ref_length_side -1) {
	    header_col++;
	  }
	  if(header_col >= img.height) {
			header_col = 0 ;
		}
	}
	/**


	*/









/**
END
*/

}







/**

END CLASS PixGen

*/








/**
pixelate_id
v 0.0.2
*/
int [] pix_rank_id(iVec2 original_canvas, iVec2 pix_size) { 
  int row_original_canvas = 0 ;
  int new_canvas_x = int(original_canvas.x /pix_size.x);
  int new_canvas_y = int(original_canvas.y /pix_size.y);
  
  int length_original_canvas = original_canvas.x *original_canvas.y;
  int [] array_id = new int[length_original_canvas];
  int id_rank = 0;

  int new_id_row = 0 ;
  int count_line = 0 ;
  for(int i = 0 ; i < length_original_canvas ; i++) {
  	// count line and give the id row for the new canvas
    if(i%original_canvas.x == 0) {
    	if(count_line == pix_size.y) {
	    	new_id_row++ ;
	    	count_line = 0 ;
	    }
	    count_line++ ;
    } 
    // define the id rank
    int id_pix_new_canvas = floor(i /pix_size.x);
    int temp = row_original_canvas -new_id_row;
    id_rank = id_pix_new_canvas -(temp *new_canvas_x);

    if(i%original_canvas.x == (original_canvas.x -1)) {
      row_original_canvas++ ;
    }
    array_id[i] = id_rank;
  } 
  return array_id;
}





/**
Class CanvasPix
v 0.0.1
*/
class CanvasPix {
  ID_pixelate [] list ;
  iVec pix ;
  iVec2 canvas ;

  CanvasPix(int [] full_list, iVec2 canvas, iVec pix) {
    this.pix = pix ;
    this.canvas = canvas ;
    list = pixelate(full_list);
  }


  ID_pixelate [] pixelate(int [] raw_list) {
    int length = raw_list[raw_list.length -1] ;
    ID_pixelate [] small_list = new ID_pixelate[length] ;
    for(int i = 0 ; i < small_list.length ; i++) {
      small_list[i] = new ID_pixelate() ;
    }

    for(int i = 0 ; i < raw_list.length ; i++) {
      int small_id =  raw_list[i] ;
      if(small_id < small_list.length) {
        small_list[small_id].add(i) ;
      } 
    }
    return small_list ;
  }

  ID_pixelate [] get_list() {
    return list ;
  }
}

/**
Class ID_pixelate
*/
class ID_pixelate {
  ArrayList<Integer> id_list ;
  ID_pixelate() {
    id_list = new ArrayList<Integer>() ;
  }

  void add(int id) {
    id_list.add(id) ;
  }
}



/**

END PixGen

*/