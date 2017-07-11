/**
setting sound
v 0.1.1

*/
void setting_sound_system() {
  // set sound


  // set spectrum
  int num_spectrum_bands = 128 ;
  float scale_spectrum_sound = .2 ;
  int length_analyze = num_spectrum_bands *2 ;
  set_sound(length_analyze);
  set_spectrum(num_spectrum_bands, scale_spectrum_sound);

  // beat setting
  float [] beat_part_sensibility = {1.5,.8,.3,.3}; 
  iVec2 [] beat_in_out = new iVec2[beat_part_sensibility.length];
  beat_in_out[0] = iVec2(0,5);
  beat_in_out[1] = iVec2(5,30);
  beat_in_out[2] = iVec2(30,85);
  beat_in_out[3] = iVec2(85,128);
  set_beat_advance(beat_in_out, beat_part_sensibility);


  float threshold_sensibility = 1.;
  float time_to_reset = 2.;
  set_time_track(threshold_sensibility, time_to_reset);
}












/**
sound method
*/
void show_spectrum(Vec2 pos, int size) {
  for(int i = 0; i < num_bands(); i++) {
    float pos_x = i * band_size +pos.x;
    float pos_y = pos.y + abs(size) ;
    float size_x = band_size ;
    float size_y = -(spectrum(i) *size) ;
    rect(pos_x, pos_y, size_x, size_y) ;
  } 
}


void show_beat(Vec2 pos, int size) {
  for(int i = 0; i < num_bands() ; i++) {
      if(beat_is(i)) {
      float pos_x = i * band_size +pos.x ;
      float pos_y = pos.y + abs(size) ;
      float size_x = band_size ;
      float size_y = -size ;
      rect (pos_x, pos_y, size_x, size_y) ;
    }
  } 
}