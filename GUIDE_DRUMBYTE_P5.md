USER GUIDE
--
export image 'p'

add pioche 'o'

display info 'i'




CODER GUIDE
--
GUIDE DRUMBYTE
V 0.0.3


DRUMBYTE
--
Drumbyte
--
Set your canvas
--
void set_size_drumbyte(iVec2 canvas);
>définie la taille de la zone de travail

void set_size_drumbyte(int w, int h);
>définie la taille de la zone de travail

void set_size_drumbyte(iVec2 canvas, boolean alpha);

void set_size_drumbyte(int w, int h, boolean alpha);


See your image
--
PImage get_drumbyte_img() ;
>retourne l'état actuel de l'image


Export
--
void export(String extension);
>only 'jpg' and 'bmp' actually









CANVAS
--
main
--
void new_canvas(int num) ;

void create_canvas(int widh, int height, int type, int which_one) ;
>type is ARGB or RGB


int canvas_size() ;
>return the num of canvas used

void select_canvas(int which_one) ;

PImage get_canvas(int which) ;

PImage get_canvas() ;

int get_canvas_id() ;

void update_canvas(PImage img) ;

void update_canvas(PImage img, int which_one);

void clean_canvas(int which_canvas);

void clean_canvas(int which_canvas, int coulour);


effect
--
void alpha_canvas(int target_canvas, float change);
>in target, to select on which canvas where the alpha is modified
>float change, value add to the alpha.




SHOW / CANVAS
--
void set_show() ;

void show_canvas(int num) ;

iVec2 get_offset_canvas() ;
>return the offset of canvas when there is a fullscreen mode

int get_offset_canvas_x() ;
>return the offset of canvas when there is a fullscreen mode

int get_offset_canvas_y() ;
>return the offset of canvas when there is a fullscreen mode













GENERATOR
--

PIX_GEN 
--

int get_header();

void set_header(int header);

void set_pix(int x, int y);

public iVec2 get_pix();

void colour_line(c) ;

void colour(PImage img, int colour);

void colour(PImage img, int colour, float entry, float exit);

void draw(PImage img, int direction, iVec2 pix, boolean side);

void draw(PImage img, int direction, iVec2 pix)

void security_distribution(boolean security);
>enable the method who solve in the a little part the problem of distribution pixel the the NORTH and SOUTH when the pixel 'x' and 'y' have a different size
>by default the security is 'on'







MOULINETTE
--

--
void moulinette_horizontale_is(boolean verticale_is) 
>choice the display horizontal or vertical

PImage moulinette_horizontale(int paste_entry, PImage origin, int origin_entry, int length_pixels_duplicate);
>hash the pioche image with horizontal slide

PImage moulinette_verticale(int paste_entry, PImage origin, int origin_entry, int length_pixels_duplicate);
>hash the pioche image with vertical slide

???????
PImage moulinette(int paste_entry, PImage origin, int origin_entry, int length_pixels_duplicate);
>return a new PImage with array pixels pasted
?????


Set moulinette
--
void set_moulinette(float entry, float length, float where);
>float entry : valeur de 0 à 1, ou '0' est la première image de la pioche et '1' la dernière
>float length : valeur de 0 à 1 indique le nombre de pixel qui doit être copié à partir du point d'entrée, '0' aucune pixel n'est copié, '1' toutes les pixels sont copiées à partir du point d'entrée.
>float where : valeur de 0 à 1, endroit ou sont colées les pixels sur l'image finale - canvas -, où '0' est la première pixel et '1' la dernière

void set_moulinette(int entry, int length, int where);
>same than above method, but here we don't use a coordonnate system but directly the length of the image in pixel.

void set_moulinette(iVec2 entry_coord, int length, iVec2 where_coord);


entry
--
void set_entry_moulinette(iVec2 entry_pioche_img_coord);

void set_entry_moulinette(int entry_in_img_pioche);

void set_entry_moulinette(float entry_norm);


length must be copy
--
void set_length_moulinette(float norm_length_pix_must_be_copy);

void set_length_moulinette(int num_pix_must_be_copy);


copy destination
--
void set_destination_moulinette(iVec2 where_start_in_canvas_coord);

void set_destination_moulinette(int where_start_in_canvas);

void set_destination_moulinette(float norm_where);




















PIOCHE MOULINETTE
--
int get_current_id_pioche_moulinette();
>return the id of the current pioche

void select_pioche_moulinette(int which_one);





PIOCHE
--
void build_pioche(String path);
>String path, the path is write from the sketch folder, not from the computer root.
>For present, the file accepte is jpg and bmp

int pioche_size()
>return the quantity of pioche available

int pioche_image_size();
>return the quantity of image in the current pioche




select
--
select_image_pioche(int target);
>select an image to use

void select_pioche_moulinette(int which_pioche);
>select a new pioche to work + update the String info

void select_pioche(int which_pioche);
>select a new pioch to work


get
--
PImage get_pioche_image();
>return PImage of current pioche

int get_pioche_image_id()
>return the id number of image selected from the pioche

String get_pioche_name();
>return name of the current pioche

String get_pioche_path();
>return name of the current path

Album get_pioche();
>return the current Album



get target
--
String get_pioche_image_name(int target); 
>return name of the target pioche img

int get_pioche_image_width(int target) ;
>retourne la longueur de l'image ciblée

int get_pioche_image_height(int target) ;
>retourne la largeur de l'image ciblée

int get_pioche_pixels_length(int target)
>retourne le nombre de pixels de l'image ciblée

PImage get_pioche_image(int target) ;
>return PImage of target pioche




































