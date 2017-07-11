boolean change_canvas = false ;

boolean show_must_go_on = false ;
boolean display_info_is = false ;

boolean tom = false ;

void interaction() {
  show_must_go_on = true ;
  // if(beat_is()) show_must_go_on = true 
}

/**
switch display
v 0.0.2
*/
boolean display_canvas_1, display_canvas_2 ;

void switch_show_canvas() {
	float input_change = mouseX ;
	int border = width/2 ;
  
  // clean and choice
	if(input_change > border) {
		display_canvas_2 = true;
	} else {
		display_canvas_2 = false ;
		int c = color(0);
		clean_canvas(2, c);
	}

	if(input_change <= border) {
		display_canvas_1 = true;
	} else {
		display_canvas_1 = false ;
		int c = color(0);
		clean_canvas(1, c);
	}
  
  // display
  if(display_canvas_1) {
    show_canvas(1);
  }
  if(display_canvas_2) {
    show_canvas(2);
  }
}



