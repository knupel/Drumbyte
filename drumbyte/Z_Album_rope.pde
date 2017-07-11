/**
Album
v 0.0.3
*/
class Album {
	private PImage [] img;
	private String [] info;
	private int id = 0 ;
	private String name;
	private String path = null;
  
  /**
  constructor
  */
	Album(String name) {
		this.name = name;
	}

	Album(String name, String path) {
		this.name = name;
		this.path = path;
	}
  
  /**
  method
  */
	void build(PImage [] img, String [] info) {
		if(info.length == img.length) {
			this.img = img ;
			this.info = info ;
		} else {
			println("The array length is different, it's not possible to build the album");
		}
	}

	int size() {
		return img.length ;
	}

	int get_id() {
		return id ;
	}

	void select(int target){
		if(target < size()) {
			id = target ;
		}
	}
  
  String get_name() {
  	return name;
  }

  String get_path() {
  	return path;
  }

	PImage get_img() {
		return img[id];
	}

	PImage get_img(int target) {
		if(target < size()) { 
			return img[target] ;
		} else return null ;
	}

	int width() {
		return img[id].width ;
	}

	int height() {
		return img[id].height ;
	}

	int width(int target) {
		if(target < size()) { 
			return img[target].width ;
		} else return -1 ;		
	}

	int height(int target) {
		if(target < size()) { 
			return img[target].height ;
		} else return -1 ;	
	}
  
  int length() {
		return img[id].pixels.length ;
	}

	int length(int target) {
		if(target < size()) { 
			return img[target].pixels.length ;
		} else return -1 ;	
	}

	String info() {
		return info[id] ;
	}

	String info(int target) {
		if(target < size()) { 
			return info[target] ;
		} else return null ;	
	}
}