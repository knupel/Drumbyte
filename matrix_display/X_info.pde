/**
info
v 0.0.1
*/

boolean info_fullscreen_is = false;
void display_info_fullscreen(boolean state_is) {
	info_fullscreen_is = state_is;
}
String mess_info = ("") ;
String mess_title = ("") ;



void display_title(String title) {
	int interlignage = text_size_titre + (text_size_titre/3) ;
	int pos_x = 0 ;
	if(!info_fullscreen_is) {
		pos_x = pos_x_text +get_offset_canvas_x();
	} else {
		pos_x = pos_x_text ;
	}
	
	fill(255) ;
	textSize(text_size_titre) ;
	textFont(grotesk);

	// title
  int pos_y = 0 ;
	if(!info_fullscreen_is) {
		pos_y =  interlignage *1 +get_offset_canvas_y();
	} else {
		pos_y = interlignage *1;
	}


	text(title,pos_x, pos_y) ;

}


void display_pix_work_text(String message) {
  //pixel
	fill(0,255,0) ;
	textFont(ocra_24);
	textSize(text_size_pixel);
	int interlignage = text_size_pixel + (text_size_pixel/3);
	textLeading(interlignage);
 

	int pos_x = 0 ;
	int pos_y = 0;
	int size_x =0;
	int size_y= 0;
	if(!info_fullscreen_is) {
		pos_x = pos_x_text +get_offset_canvas_x();
		pos_y = pos_y_text +get_offset_canvas_y();
		size_x = get_canvas().width -margin_text;
		size_y = get_canvas().height -pos_y_text;
		// size_y = get_canvas().height -margin_text -pos_y_text;
	} else {
		pos_x = pos_x_text ;
		pos_y = pos_y_text ;
		size_x = width -margin_text;
		size_y = height -margin_text -pos_y;
	}
	text(message, pos_x, pos_y, size_x, size_y);
}