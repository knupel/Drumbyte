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
	update_info() ;
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



void update_info() {
	if(read_osc_book() != null && read_osc_book().length>0) {
		Object [] info = Arrays.copyOfRange(read_osc_book(),0, 2);
		Object [] pix = Arrays.copyOfRange(read_osc_book(),2, read_osc_book().length);
		// title
		// cast 
		String current_pioche_path = "" ;
		if(info[0] instanceof String) {
			current_pioche_path = "" + (String)info[0];
		}
		String sub_title = "" ;
		if(info[1] instanceof String) {
			sub_title = "" + (String)info[1];
		}
		mess_title = sub_title + current_pioche_path;
		mess_info = hex_pix_work(pix) ;

	} else {
	  mess_title = "Pas de donnée reçu actuellement, revenez demain";
	}

}








/**
HEXA integter
*/
String hex_pix_work(Object [] pix) {
	String hex_list = ("") ;
  int surface_letter = int(text_size_pixel *text_size_pixel *text_size_pixel  *.9);
  int num_letter_be_hex = 0;
  if(!info_fullscreen_is) {
  	num_letter_be_hex = (get_canvas().width *get_canvas().height) / surface_letter ;
  } else {
  	num_letter_be_hex = (width *height) / surface_letter ;
  }
  int start_max = 0 ;
  if(num_letter_be_hex < pix.length) {
  	start_max = pix.length - num_letter_be_hex ;
  }
  int start = int(random(start_max)) ;
  int end = 1 ;
  if(pix.length < num_letter_be_hex) {
  	end = pix.length -1 ;
  } else {
  	end = start +num_letter_be_hex ;
  }

  
  if(start >= 0 && end > start +1) {
  	for(int i = start ; i < end ; i++) {
  		if(pix[i] instanceof Integer) {
  			Integer integer = (int)pix[i] ;
  			String hex = hex(integer) + " " ;
  			hex_list += hex ;
  		}
  	}
  }
  return hex_list ;
}