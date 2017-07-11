/**
Drumbyte
v 0.1.1
*/

boolean generation_is = false ;
boolean moulinette_is = false ;
void reset() {
  generation_is = false;
  moulinette_is = false;
  clear_pix_work();
}



ArrayList<Integer> pix_work ;
boolean collect_pix_work = false ;


int step_collection_pix = 100 ;
void set_pix_work(int step_collection_pix) {
  this.step_collection_pix = step_collection_pix ;
  pix_work = new ArrayList<Integer>() ;
}

void collect_pix_work() {
  collect_pix_work = true ;
}

void clear_pix_work() {
  pix_work.clear() ;
  collect_pix_work = false ;
}


void add_pix_work(int... pix) {
  for(int i = 0 ; i < pix.length ; i += step_collection_pix) {
    pix_work.add(pix[i]);
  }
}



/**
set drumbyte canvas
v 0.0.2
*/
void set_size_drumbyte(int w, int h) {
  set_size_drumbyte(w, h, false, 1);
}

void set_size_drumbyte(int w, int h, int num) {
  set_size_drumbyte(w, h, false, num);
}

void set_size_drumbyte(iVec2 canvas) {
  set_size_drumbyte(canvas.x, canvas.y, false, 1);
}

void set_size_drumbyte(iVec2 canvas, int num) {
  set_size_drumbyte(canvas.x, canvas.y, false, num);
}

void set_size_drumbyte(iVec2 canvas, boolean alpha) {
  set_size_drumbyte(canvas.x, canvas.y, alpha, 1);
}

void set_size_drumbyte(iVec2 canvas, boolean alpha, int num) {
  set_size_drumbyte(canvas.x, canvas.y, alpha, num);
}

// main method
void set_size_drumbyte(int w, int h, boolean alpha, int num) {
  new_canvas(num) ;
  for(int i = 0 ; i < canvas_size() ; i++) {
    if(alpha) { 
      create_canvas(w, h, ARGB, i);
    } else {
      create_canvas(w, h, RGB, i);
    }
  } 
}













