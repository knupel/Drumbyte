/**
Pioche 
2017-2017
v 0.3.0
Direction artistique Antoine Thibaudeau
code Stan le Punk
*/

/**
method
v 0.0.3
*/
ArrayList<Album> pioche_list;

void build_pioche(String path) {
  String select_path = null ;

	if(folder_selected_is()) {
		select_path = path;
		reset_folder_selection();
	} else {
		select_path = sketchPath() +"/"+path;
	}

	if(pioche_list == null) {
		pioche_list = new ArrayList<Album>();
	}
	File f = new File(select_path) ;
	int num_file_pioche = 0 ;

	// count the pertinent file 
	for(int i = 0 ; i < f.listFiles().length ; i++) {
    String file_name = f.list()[i] ;
		String lastThree = file_name.substring(file_name.length()-3, file_name.length());
		if (lastThree.equals("JPG") || lastThree.equals("jpg") || lastThree.equals("BMP") || lastThree.equals("bmp")) {
			num_file_pioche++ ;
		}
	}

	PImage [] pioche_img = new PImage[num_file_pioche] ;
	String [] pioche_info = new String[num_file_pioche] ;
  
  int count = 0 ;
	for(int i = 0 ; i < f.listFiles().length ; i++) {
    String file_name = f.list()[i] ;
		String lastThree = file_name.substring(file_name.length()-3, file_name.length());
		if (lastThree.equals("JPG") || lastThree.equals("jpg") || lastThree.equals("BMP") || lastThree.equals("bmp")) {
			String path_img = path +"/"+file_name;
			pioche_img[count] = loadImage(path_img);
			pioche_info[count] = file_name+" || "+pioche_img[count].width+"x"+pioche_img[count].height;
			count++ ;

		}
	}

  String [] s = path.split("/") ;
  Album a = new Album(s[s.length -1], path);
	a.build(pioche_img, pioche_info);

	pioche_list.add(a) ;
}


/**
current pioche
To do that we need to create a permanent album
*/
Album pioche;
/**
select
*/
void select_pioche(String pioche_name) {
	if(pioche_list != null && pioche_list.size() > 0) {
		for(Album a : pioche_list) {
			if(a.get_name().equals(pioche_name)) {
				pioche = a ;
				break ;
			}
		}
	} else {
		println("No class Album is available") ;
	}
}

void select_pioche(int which) {
	if(pioche_list != null && pioche_list.size() > 0) {
		if(which < pioche_list.size()) {
			Album a = pioche_list.get(which) ;
			pioche = a ;
		}
	} else {
		println("No class Album is available") ;
	}
}




/**
size
v 0.0.2
*/
int pioche_size() {
	return pioche_list.size() ;
}

int pioche_image_size() {
	if(pioche != null) {
		return pioche.size() ;
	} else {
    println("pioche_image_size() is null") ;
    return -1 ;
	} 
}

/**
select
*/
void select_image_pioche(int target) {
  if(pioche_image_size() > 0) {
    pioche.select(target) ;
  } else {
    println("No pioche available") ;
  }  
}


/**
get pioche
v 0.0.2
*/
Album get_pioche() {
	if(pioche_size() > 0) {
		return pioche;
	} else {
  	println("pioche_size() is null");
  	return null;
  }
}

String get_pioche_name() {
	if(pioche_size() > 0) {
		return pioche.get_name();
	} else {
  	println("pioche_size() is null");
  	return "pioche is null" ;
  }
}

String get_pioche_path() {
	if(pioche_size() > 0) {
		return pioche.get_path();
	} else {
  	println("pioche_size() is null");
  	return "pioche is null" ;
  }
}

void get_pioche_list() {
	for(Album a : pioche_list) {
		println(a.get_name(), a.get_path());
	}
}

/**
get image from pioche
v 0.0.2
*/
PImage get_pioche_image() {		
	if(pioche_image_size() > 0) {
    return pioche.get_img();
  } else {
  	println("pioche_image_size() is null");
  	return null ;
  }
}

PImage get_pioche_image(int target) {
	if(pioche_image_size() > 0) {
    return pioche.get_img(target);
  } else {
  	println("pioche_image_size() is null");
  	return null ;
  }
}


int get_pioche_image_id() {
	if(pioche_image_size() > 0) {
		return pioche.get_id();
	} else {
  	println("pioche_image_size() is null");
  	return 0 ;
  }
}

String get_pioche_image_name(int target) {
	if(pioche_image_size() > 0) {
		return pioche.info(target);
	} else {
  	println("pioche_image_size() is null");
  	return "pioche is null" ;
  }
}

int get_pioche_image_width(int target) {
	if(pioche_image_size() > 0) {
		return pioche.width(target);
	} else {
  	println("pioche_image_size() is null");
  	return 0 ;
  }
}

int get_pioche_image_height(int target) {
	if(pioche_image_size() > 0) {
		return pioche.height(target);
	} else {
  	println("pioche_image_size() is null");
  	return 0 ;
  }
}

int get_pioche_image_pixels_length(int target) {
	if(pioche_image_size() > 0) {
		return pioche.length(target);
	} else {
  	println("pioche_image_size() is null");
  	return 0 ;
  }
}