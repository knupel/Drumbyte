/**
OSC big message 2017-2017
v 0.1.0.3
Send big message via OscP5 library
http://stanlepunk.xyz

bases on OscP5 library v 2.0.4
https://github.com/sojamo/oscp5

*/
import oscP5.*;
import netP5.*;

Osc_book osc_book ;

void osc_book_builder(int num_chapter, int first_port, String ip_address){
  osc_book = new Osc_book(num_chapter, first_port,ip_address) ;
  println("Osc Datagram size is 300 by default");
  build_osc_emitter(300) ;
}

void osc_book_builder(int num_chapter, int first_port, String ip_address, int size_datagram){
	osc_book = new Osc_book(num_chapter, first_port, ip_address) ;
  build_osc_emitter(size_datagram) ;
}


void osc_debug() {
	osc_book.debug() ;
}


/**
add data methode
*/
void add_osc_data(Object... list) {
	osc_book.add(list) ;
}

void add_osc_data(int [] list) {
	for(int i : list) {
		osc_book.add(i) ;
	}	
}

void add_osc_data(float [] list) {
	for(float f : list) {
		osc_book.add(f) ;
	}	
}

void add_osc_data(boolean [] list) {
	for(boolean b : list) {
		osc_book.add(b) ;
	}	
}

void add_osc_data(String [] list) {
	for(String s : list) {
		osc_book.add(s) ;
	}	
}

void add_osc_data(byte [] list) {
	for(byte b : list) {
		osc_book.add(b) ;
	}	
}

void add_osc_data(long [] list) {
	for(long lo : list) {
		osc_book.add(lo) ;
	}	
}

void add_osc_data(short [] list) {
	for(short sh : list) {
		osc_book.add(sh) ;
	}	
}

void add_osc_data(double [] list) {
	for(double db : list) {
		osc_book.add(db) ;
	}	
}




/**
send message
*/
void send_message(String title) {
  osc_book.write(title);
  osc_book.send();
	osc_book.clear();
}






/**
big message 
v 0.1.1.1
*/
OscP5 [] emitter_list;
NetAddress [] dest_list;

void build_osc_emitter(int size_datagram) {
	emitter_list = new OscP5[osc_book.max_chapters];
	dest_list = new NetAddress[osc_book.max_chapters];
	int port = osc_book.first_port ;
	if(size_datagram < 1) {
		size_datagram = 1;
		System.err.println("Osc Datagram size cannot be under 1, instead 1 is used");
	}

	if(size_datagram > 9220) {
		size_datagram = 9220;
		System.err.println("Osc Datagram size cannot exceed 9220, instead 9220 is used");
	}

	// build emitter and receveir
	for(int i = 0 ; i < osc_book.max_chapters ; i++) {
		OscProperties op = new OscProperties();
		op.setDatagramSize(size_datagram); // 9220 is the max to push to the datagram limit
		op.setListeningPort(port);
		osc_book.set_chapter_length(op.datagramSize());
		emitter_list[i] = new OscP5(this, op);
		dest_list[i] = new NetAddress(osc_book.ip, port);
		port++ ;
	}
}

class Osc_book {
	boolean debug = false ;

	ArrayList book ;

	float bool_unit = 1. ;
	float misc_unit = 5. ;
	float string_unit = 6.1 ;

	int first_port ;
	String ip = "";
	int max_chapters; // number of chapter in the osc book
	int chapter_length = 1400; // if we go upper that sometime there is an outBound error
	

	float count_unit = 0;
	// the max is 9207, but we need place to build header message


	Osc_book(int max_chapters, int first_port, String ip) {
		book = new ArrayList();
		this.first_port = first_port;
		this.ip = ip;
		this.max_chapters = max_chapters;
	}


	public void set_chapter_length(int length) {
		chapter_length = length;
	}



	public void add(Object... obj) {
		if(!message_ready_is) {
			for(int i = 0 ; i < obj.length ; i++) {
				count(obj[i]);
				book.add(obj[i]);
			}
		} else {
			println("The previous message is not tottaly send, try later");
		}
	}

  
  boolean message_ready_is = false ;
  int num_of_message_be_sent = 0 ;
  ArrayList<OscMessage> osc_chapter_message = new ArrayList<OscMessage>();
	public void write(String title) {
    // write message if the previous message has be sent
    String instant = Integer.toString(minute())+Integer.toString(second())+Integer.toString((int)random(1000));
    int id_book = Integer.parseInt(instant);
    if(!message_ready_is) {
    	int num_of_message_be_sent = ceil(count_unit / (float)chapter_length) ;
    	// println("message must be sent", num_of_message_be_sent, chapter_length);

			// debug
			if(debug) {
				println("Number of chapters sent for this book:", num_of_message_be_sent);
				println("Book size in OSC unit:", count_unit);
			}
      
      // write
    	int which_part = 0;
	    float total_gauge = 0 ;
	    if(num_of_message_be_sent <= emitter_list.length) {
	    	for(int i = 0 ; i < num_of_message_be_sent ; i++) {
					float unit = .0 ;
					float start = .0 ;


          OscMessage chapter_temp = new OscMessage(title);

          chapter_temp.add(id_book) ; // id book
          chapter_temp.add(i); // which chapter
					chapter_temp.add(num_of_message_be_sent) ; // total chapter
					int ratio = 6 ; // but why is not 3 like the number of add information for header, I don't know....
					start = ratio*misc_unit ;

					for(float gauge = start ; gauge < chapter_length ; gauge += unit) {
						if(which_part < book.size()) {
							Object obj = book.get(which_part) ;
							if(obj instanceof Boolean) {
								unit = bool_unit  ;
							} else if(obj instanceof String) {
								String str = (String)obj ;
								int length = str.length() ;
								unit = string_unit *length ;
							} else {
								unit = misc_unit ;
							}
							chapter_temp.add(obj);
							which_part++;
						} else {
							break;
						}			
					}
          // write chapter
					osc_chapter_message.add(chapter_temp) ;
				}
			} else {
				println("There is",max_chapters,"chapter in your book, you need",num_of_message_be_sent,"chapter. Increase the number of chapter of you osc book emitter");
			}
			message_ready_is = true ;
    } else {
			println("The previous message is not totally send, try later");
		}
	}


	public void send() {
    for(int i = 0 ; i < emitter_list.length && i < osc_chapter_message.size() ; i++) {
      OscMessage mess = osc_chapter_message.get(i) ;
    	emitter_list[i].send(mess, dest_list[i]);
    }
		message_ready_is = false ;
		num_of_message_be_sent = 0 ;
	}

	public void debug() {
		debug = true ;
	}



	public void clear() {
		debug = false ;
		count_unit = 0 ;
		osc_chapter_message.clear() ;
		book.clear();
	}




	private void count(Object obj) {
		if(obj instanceof Boolean) {
			count_unit += bool_unit ;
		} else if(obj instanceof String) {
			String s = (String) obj ;
			count_unit = count_unit + (s.length() *string_unit);
		} else {
			count_unit += misc_unit ;
		}
	}
}














































/**
BOOK OSC RECEPTION
v 0.0.5
*/

/**
library book
v 0.0.4
*/
Object [] read_osc_book() {
	if(library != null && library.size() > 0 ) {
		int target = library.size() - 1 ;
		return read_osc_book(target) ;
	} else return null ;
}

Object [] read_osc_book(int which) {
  if(library != null && library.size() > which) {
    return library.get(which).get() ;
  } else return null ;
}




ArrayList<Book> library ;
void archive_book() {
  if(library == null) {
    library = new ArrayList<Book>() ;
  }
  Book book = new Book(chapters_book) ;
  library.add(book);
}

class Book {
  Chapter [] chapters;
  
  Book(ArrayList<Chapter> ch_list) {
    chapters = new Chapter[ch_list.size()] ;
    for(Chapter c : ch_list) {
      chapters[c.which_chapter] = c ;
    }
  }


  Object [] get() {
    int length = 0 ;
    for(int i = 0 ; i < chapters.length ; i++) {
    	if(chapters[i] != null) {
    		length += chapters[i].content.length ;
    	}   
    }

    Object [] global_content = new Object[length] ;
    int count = 0 ;
    for(int i = 0 ; i < chapters.length ; i++) {
    	if(chapters[i] != null) {
	      for(int k = 0 ; k < chapters[i].content.length ; k++) {
	        global_content[count] = chapters[i].content[k] ;
	        count++ ;
	      }  
	    }   
    }
    if(global_content != null) return global_content ; else return null ;
  }
}

class Chapter {
  int id_book;
  int which_chapter;
  int num_chapter;
  Object [] content;

  Chapter(int id_book, int which_chapter, int num_chapter, Object... content) {
    this.num_chapter = num_chapter;
    this.id_book = id_book;
    this.content = content.clone();
    this.which_chapter = which_chapter ;
  }
}







/**
write chapter from OSC
*/
boolean new_book ;
int num_chapter ;
int id_book ;
boolean [] chapter_received ;
ArrayList<Chapter> chapters_book ;

boolean book_ready ;


void archive_osc_book(OscMessage osc_receive) {
  // check for new book
  if(id_book != osc_receive.get(0).intValue()) {
    new_book = true ;
  }

  if(new_book) {
    // prepare a new book
    if(chapters_book == null) {
      chapters_book = new ArrayList<Chapter>() ;
    } else {
      chapters_book.clear() ;
    }
    // check for the num of chapter
    num_chapter = osc_receive.get(2).intValue() ;
    chapter_received = new boolean[num_chapter];

    boolean [] temp = new boolean[num_chapter] ;
    for(int i = 0 ; i < chapter_received.length ; i++) {
      temp[i] = false;
    }
    chapter_received = temp.clone();
    // memorize the id book
    id_book = osc_receive.get(0).intValue();
    // check true for incoming chapter
    int which_chapter = osc_receive.get(1).intValue();
    chapter_received[which_chapter] = true ;
    // archive chapter
    archive_osc_chapter(id_book, which_chapter, num_chapter, osc_receive) ;
    // confirm the first chapter is ok, nevermind if this one is not the first in the order
    new_book = false ;
  } else {
    if(id_book == osc_receive.get(0).intValue()) {
      // check true for incoming chapter
      int which_chapter = osc_receive.get(1).intValue();
      archive_osc_chapter(id_book, which_chapter, num_chapter, osc_receive) ;
      chapter_received[which_chapter] = true ;
    }
  }

  // check if the book edition is completed
  if(book_completed_is(chapter_received)){
  	archive_book();
  }
}




boolean book_completed_is(boolean... chapter_completed) {
  int count_chapter = 0 ;
  for(boolean c : chapter_completed) {
    if(c == false) {
      break ;
    } else {
      count_chapter++ ;
    }
  }
  if(count_chapter == chapter_completed.length) return true ; else return false ;
}



void archive_osc_chapter(int id_book, int which_chapter, int num_chapter, OscMessage osc_receive) {
	int header = 3 ;
  int chapter_length = osc_receive.arguments().length -header; 
  Object [] obj = new Object[chapter_length] ;
  for(int i = header ; i < osc_receive.arguments().length ; i++) {
    // must be tranlate here
    obj[i -header] = osc_receive.getArgument(i);
  }

  Chapter chapter = new Chapter(id_book, which_chapter, num_chapter, obj);
  chapters_book.add(chapter) ;
}





