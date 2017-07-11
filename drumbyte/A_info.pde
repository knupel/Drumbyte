/**
drumbyte display info
v 0.0.4
*/

PFont ocra_24 ;
PFont grotesk ;

int text_size_titre = 24;
int text_size_pixel = 10;
int pos_x_text = 0;
int pos_y_text = 0;
int margin_text = 0 ;






void drumbyte_createFont() {
	ocra_24 = loadFont("font_vlw/OCRAStd-24.vlw") ;
	grotesk = createFont("font/DigiGroteskNEF-Bold.otf", text_size_titre);
}

void drumbyte_text() {
	margin_text = 20 ;
  pos_x_text = margin_text;
  pos_y_text = 80;

  display_info_fullscreen(false);

	display_title(mess_title);
	display_pix_work_text(mess_info);
}











/**
INFO
*/



void update_title_for_osc() {
	// title
	String current_pioche_path = get_pioche().get_path() ;

	if(moulinette_is && !generation_is) {
		mess_title = "Moulinette active avec " + current_pioche_path ;

	}
	if(generation_is && !moulinette_is) {
		mess_title = "Pixel Generation actif" ;
	}

	if(generation_is && moulinette_is) {
		mess_title = "Pixel Generation actif et Moulinette active avec " + current_pioche_path;
	}
}








/**
HEXA integter
*/
String hex_pix_work() {
	String hex_list = ("") ;
  int surface_letter = int(text_size_pixel *text_size_pixel *text_size_pixel  *.9);
  int num_letter_be_hex = 0;
  if(!info_fullscreen_is) {
  	num_letter_be_hex = (get_canvas().width *get_canvas().height) / surface_letter ;
  } else {
  	num_letter_be_hex = (width *height) / surface_letter ;
  }
  int start_max = 0 ;
  if(num_letter_be_hex < pix_work.size()) {
  	start_max = pix_work.size() - num_letter_be_hex ;
  }
  int start = int(random(start_max)) ;
  int end = 1 ;
  if(pix_work.size() < num_letter_be_hex) {
  	end = pix_work.size() -1 ;
  } else {
  	end = start +num_letter_be_hex ;
  }

  
  if(start >= 0 && end > start +1) {
  	for(int i = start ; i < end ; i++) {
  		Integer integer = pix_work.get(i) ;
  		String hex = hex(integer) + " " ;
  		// println(hex);
  		hex_list += hex ;
  	}
  }
  return hex_list ;
}