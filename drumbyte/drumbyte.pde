/**
drumbyte 2017-2017 
v 0.1.0
Build with Processing 3.3.5
Direction artistique Antoine Thibaudeau
Code Stan le Punk
http://stanlepunk.xyz/
*/


void settings() {
  size(100,100) ;
  /*
  fullScreen(1);
  fullscreen_is = true ;
    */
}

/**
//-----------------------------------SETUP starts here / SETUP commence ici-----------------------------------//
*/
void setup() {
  background(0);
    /**
  // changement ci-dessous
  // OSC pour envoyer les info à l'autre sketch afin qu'il reçoive les informations récoltées.
  // ici tu peux changer l'adresse ip pour envoyer vers un autre ordinateur, dans un réseau local
  */
  String ip_same_computer = "127.0.0.1" ;
  String address_ip_local_network = ip_same_computer ;
  set_OSC(address_ip_local_network) ;

  // setup drumbyte
  iVec2 canvas = iVec2(600,840);
  boolean alpha = true;
  int num_canvas = 3 ;
  
  set_size_drumbyte(canvas, alpha, num_canvas);
  set_show(); 
  setting_sound_system();
  drumbyte_createFont();

  /**
  // changement ci-dessous
  // ici on demande de collecter une pixel chaque 100 pixel, moins d'info à gérer cela évite le ralentissmeent de l'appli lors de la collecte.
  */
  int collect_pix_each_pix = 100 ;
  set_pix_work(collect_pix_each_pix);


  // setup moulinette
  pioche_setup_Cheuch() ;
  
  preset_moulinette();

  // setup generation
  //set_generation();
  set_DrumGen();
}

////////////////////////////////////////  end of the SETUP / fin du SETUP ////////////////////////////////////////  


//-----------------------------------DRAW starts here / DRAW commence ici-----------------------------------//

void draw() {
  /**
  // changement ci-dessous
  // changement du nom de variable qui autorise la collecte d'information sur les pixel
  */
  if(collect_info_is) collect_pix_work();

  // drumbyte_effect(0) ;
    
  background_rope(0) ;

  //printTempo(180, frameRate, get_pioche_name()) ;

  
    //moulinette_drumbyte();
   DrumByte_Cheuch();
   
   // alpha_control(1, -1) ;

   DrumGen_Cheuch();
  
    

//-----------------------------------INTERACTIONS DRAW-----------------------------------//   

//-----------------GROSSE CAISSE//

  if(show_must_go_on) {
    switch_show_canvas();
    // show_canvas(2);
    // show_canvas(2);
  }


  /**
  // Changement ci-dessous
  // boolean use to write the titlte and send via OSC to Matrix Affichage
  */
  if(display_canvas_1) {
    moulinette_is = true ;
  }
  if(display_canvas_2) {
     generation_is = true ;
  }
  
//-----------------CAISSE CLAIRE//
  // change_image();


//-----------------CRASH//

 

//-----------------TOM BASS//




/*
    if(get_time_track() > .1) {
      show_canvas(1);
    }


  drumbyte_generation();
  
  // effect
  // alpha_control(1, -.001) ;
  // drumbyte_effect(1);
  show_canvas(1);
  */

  /**
  // changement ci-dessous
  // Ici on envoi les données collectées vers l'autre application qui affichera le texte
  */  
  if(collect_info_is) {
     update_title_for_osc() ;
     osc_send_info();
  }


  if(folder_selected_is()) {
    build_pioche(selected_path_folder());
  }

  /**
  // changement ci-dessous
  // ces lignes sont désactivées, plus besoin car le rendu ce fait via une autre application
  */  
  
  // affiche texte
  /*
  if(display_info_is) {
    drumbyte_text();
  } 
  */



  interaction();
  reset();
  
}



////////////////////////////////////////  end of the DRAW / fin du DRAW ////////////////////////////////////////  











//-----------------------------------INTERACTIONS ACTIONS (keyPressed())-----------------------------------//    



// GROSSE CAISSE //



/**
  changement ci-dessous
  // creation d'une variable pour aurosier ou non la collecte d'info
*/ 
boolean collect_info_is = true ;

void keyPressed() {  
  /**
  changement ci-dessous
  activation et désactivation de la variable d'autoriasation de collect d'info
  */
  if(key == 's') {
    collect_info_is = (collect_info_is)? false:true ;
  }

  if(key == ' ') {
    new_pioche();
  }

  if(key == 'i') {
    display_info_is = (display_info_is)? false:true;
  }
    
  if(key == 'e') {
    change_pioche_crash_rvb();
  }

  if(key == 'p') {
    println("export bmp");
    //export("jpg") ;
    export("bmp") ;
  }

  if(key == 'o') {
    select_folder("choisissez un dossier pioche");
  }

  if(key == 'b') {
    int which_pioche = floor(random(pioche_image_size()));
    select_image_pioche(which_pioche);
  }
  
  if(key == 'r') {
    if(reverse_is) reverse_is = false ; else reverse_is = true;

    
  }
  if(key == 'm'){
    if(mirror_is) mirror_is = false ; else mirror_is = true;   
  }


  final int k = keyCode;

  if (k == 'a') {
    if (looping)  {
      noLoop();
    } else {
      loop();
    }
  }
}