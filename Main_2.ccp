/*  did you want me to set up the diffrent classes for the gameobjects?
John S.*/ 



#include<iostream>
#include<allegro5\allegro.h>
#include<allegro5\allegro_image.h>
#include<allegro5\allegro_primitives.h>
#include<allegro5\allegro_ttf.h>
#include<iostream>
using namespace std;

int collision(int b1_x, int b1_y, int b1_w, int b1_h, int b2_x, int b2_y, int b2_w, int b2_h);

bool keys[] = {false, false , false , false ,
				false , false, false ,false};
enum KEYS{W, S, A, D, UP, DOWN, LEFT, RIGHT};

//******************SHELL VARIABLES
const int WIDTH = 700;
const int HEIGHT = 600;

bool done = false;

float gameTime = 0;
int frames = 0;
int gameFPS = 0;



//**************************************
//PROJECT VARIABLES
//******************************************
float player_x = 10;
float player_y = 550;

int player_vx = 5;
int player_vy = 5;

int Wall_1_X =  200;
int Wall_1_Y =  350;
int Wall_2_X = 450;
int Wall_2_Y = 0;

const int Wall_W =  20;
const int Wall_H = 350;



float gravity_x = 10;
float gravity_y = 10;

//****************************************
//ALLEGRO VARIABLES
//****************************************
ALLEGRO_BITMAP *player = NULL;
ALLEGRO_BITMAP *Wall_1 = NULL;
ALLEGRO_BITMAP *Wall_2 = NULL;
ALLEGRO_DISPLAY *display = NULL;
ALLEGRO_EVENT_QUEUE *event_queue = NULL;
ALLEGRO_TIMER *timer;





int main()
{

	if(!al_init())
		return -1;

	display = al_create_display(WIDTH, HEIGHT);


	if(!display)
		return -1;
	//*********************ADDON INSTALL
	al_install_keyboard();
	al_init_image_addon();
	al_init_font_addon();
	al_init_ttf_addon();
	al_init_primitives_addon();

	//******************
	//ALLEGRO VARIABLES INIT
	//*****************************
	player = al_create_bitmap(30, 50);

	al_set_target_bitmap(player);
	al_clear_to_color(al_map_rgb(0, 0, 0));

	Wall_1 = al_create_bitmap(Wall_W, Wall_H);

	al_set_target_bitmap(Wall_1);
	al_clear_to_color(al_map_rgb(0, 0, 0));

	Wall_2 = al_create_bitmap(Wall_W, Wall_H);

	al_set_target_bitmap(Wall_2);
	al_clear_to_color(al_map_rgb(0, 0, 0));

	al_set_target_bitmap(al_get_backbuffer(display));


	//****************TIMER INIT AND STARTUP
	event_queue = al_create_event_queue();
	timer = al_create_timer(1.0 / 60);

	al_register_event_source(event_queue ,al_get_timer_event_source(timer));
	al_register_event_source(event_queue, al_get_keyboard_event_source());

	al_start_timer(timer);
	gameTime = al_current_time();

	while(!done)
	{
		ALLEGRO_EVENT ev;
		al_wait_for_event(event_queue, &ev);

	 if(ev.type == ALLEGRO_EVENT_TIMER)
		 {
		if(collision(player_x ,player_y, 25, 50, Wall_1_X, Wall_1_Y, Wall_W, Wall_H)==1)
			keys[D] = false;

		if(collision(player_x ,player_y, 25, 50, Wall_1_X, Wall_1_Y, Wall_W, Wall_H) ==2)
			keys[A] = false;

		if(collision(player_x ,player_y, 25, 50, Wall_2_X, Wall_2_Y, Wall_W, Wall_H)  == 4)
			keys[D] = false;

		if(collision(player_x ,player_y, 25, 50, Wall_2_X, Wall_2_Y, Wall_W, Wall_H) == 3)
			keys[A] = false;

		if(keys[A] == true)
			player_x =  player_x -  5;

		if(keys[D] == true)
			player_x = player_x + 5;

		if(keys[W] == true)
			player_y = player_y - 5;

		if(keys[S] == true)
			player_y= player_y +5;

		}
	
	 else if(ev.type == ALLEGRO_EVENT_KEY_DOWN)
		{
			switch(ev.keyboard.keycode)
			{
			case ALLEGRO_KEY_ESCAPE:
				done = true;
				break;
			case ALLEGRO_KEY_A:
				keys[A] = true;
				break;
			case ALLEGRO_KEY_D:
				keys[D] = true;
				break;
			case ALLEGRO_KEY_W:
				keys[W] = true;
				break;
			case ALLEGRO_KEY_S:
				keys[S] = true;
				break;
			case ALLEGRO_KEY_UP:
				keys[UP] = true;
				break;
			case ALLEGRO_KEY_DOWN:
				keys[DOWN] = true;
				break;
			case ALLEGRO_KEY_LEFT:
				keys[LEFT] = true;
				break;
			case ALLEGRO_KEY_RIGHT:
				keys[RIGHT] =true;
				break;
			}
		}
		else if(ev.type == ALLEGRO_EVENT_KEY_UP){

			switch(ev.keyboard.keycode)
		{
			case ALLEGRO_KEY_A:
				keys[A] = false;
				break;
			case ALLEGRO_KEY_D:
				keys[D] = false;
				break;
			case ALLEGRO_KEY_W:
				keys[W] = false;
				break;
			case ALLEGRO_KEY_S:
				keys[S] = false;
				break;
			case ALLEGRO_KEY_UP:
				keys[UP] = false;
				break;
			case ALLEGRO_KEY_DOWN:
				keys[DOWN] = false;
				break;
			case ALLEGRO_KEY_LEFT:
				keys[LEFT] = false;
				break;
			case ALLEGRO_KEY_RIGHT:
				keys[RIGHT] =false;
				break;
		}
		}
	
	al_clear_to_color(al_map_rgb(255, 255, 255));
	al_draw_bitmap(player, player_x, player_y, 0);
	al_draw_bitmap(Wall_1, Wall_1_X, Wall_1_Y, 0);
	al_draw_bitmap(Wall_2, Wall_2_X, Wall_2_Y, 0);

	al_flip_display();
	}
}

	
int collision(int b1_x, int b1_y, int b1_w, int b1_h, int b2_x, int b2_y, int b2_w, int b2_h)
{
    if ((b1_x + b1_w) == b2_x && b1_y + b1_h > b2_y)
		return 1;
	if((b1_x == b2_x + b2_w && b1_y + b1_h > b2_y))
		return 2;
	if((b1_x == b2_x + b2_w && b1_y < b2_y + b2_h))
		return 3;
	 if ((b1_x + b1_w) == b2_x &&  b1_y < b2_y + b2_h)
		return 4;
	
 
}
 
			










