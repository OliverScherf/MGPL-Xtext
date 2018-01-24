import Game from "./framework/Game.js";
import Rectangle from "./framework/rectangle.js";
import Triangle from "./framework/Triangle.js";
import { touches } from "./framework/Collision.js";
import Circle from "./framework/Circle.js";
import {arrayOfN} from "./framework/Util.js";

enum Pong {
    width = 400, 
    height = 300, 
    speed = 95
};

enum Invaders {
    width = 500, 
    height = 500,
    x = 300,
    y = 200,
    speed = 100
}

let alien_increment: number = 6;
let alien_y_increment: number = 0;
let bullet_increment: number = 17;
let counter: number = 0;
let i: number;


const game: Game = new Game(Invaders.width, Invaders.height, Invaders.x, Invaders.y, Invaders.speed);

// aliens
const aliens = arrayOfN(10, Circle.produce);

// aliens
const bullets = arrayOfN(10, Rectangle.produce);

//create gun
const gun = new Triangle(250, 50, 25, 12);

// animations
const lead_alien_animate = (lead_alien: Circle) => {
    if (Invaders.width - 100 < lead_alien.x + alien_increment  || lead_alien.x + alien_increment < 100)
    {
    	alien_increment = -alien_increment;
    } 

    if (2 <= counter)
     { alien_y_increment = -1;
	  counter = 0;}
    else
     { counter = counter +1;
       alien_y_increment = 0;}

    lead_alien.x = lead_alien.x + alien_increment;
    lead_alien.y = lead_alien.y + alien_y_increment;
}

const alien_animate = (alien: Circle) => {
    alien.x = alien.x + alien_increment;
    alien.y = alien.y + alien_y_increment;
}

const bullet_animate = (cur_bullet: Rectangle) => {
    if (cur_bullet.visible)
    {
	for (i = 0; i < 10; i = i+1)
	{
	   if (aliens[i].visible  && touches(cur_bullet, aliens[i]))
	      { aliens[i].visible = 0;
		   cur_bullet.visible = 0;}     
      }
	
      cur_bullet.y = cur_bullet.y  + bullet_increment;
      if (Invaders.height < cur_bullet.y )
	    {cur_bullet.visible = 0;} 
    }
}

// init block
for (i = 0; i < 5; i = i+1)
    {
        bullets[i].width = 2;
        bullets[i].height = 20;
        bullets[i].visible = 0;
        bullets[i].animate = bullet_animate;
    }

    for (i = 0; i < 10; i = i+1)
    {
        aliens[i].radius = 4;
        aliens[i].animate = alien_animate;
    }

    aliens[0].animate = lead_alien_animate;

    aliens[0].x = 250;
    aliens[0].y = 300;
    aliens[1].x = 230;
    aliens[1].y = 320;
    aliens[2].x = 270;
    aliens[2].y = 320;
    aliens[3].x = 210;
    aliens[3].y = 340;
    aliens[4].x = 250;
    aliens[4].y = 340;
    aliens[5].x = 290;
    aliens[5].y = 340;
    aliens[6].x = 190;
    aliens[6].y = 360;
    aliens[7].x = 230;
    aliens[7].y = 360;
    aliens[8].x = 270;
    aliens[8].y = 360;
    aliens[9].x = 310;
    aliens[9].y = 360;


// register up () => {}
game.registerKeyEvent('LEFT', () => {
    if (50 < gun.x)
       { gun.x = gun.x -5; } 
});

// register down () => {}
game.registerKeyEvent('RIGHT', () => {
    if (gun.x < Invaders.width - 50)
       { gun.x = gun.x + 5; } 
});

// register SPACE () => {}
game.registerKeyEvent('SPACE', () => {
    for (i = 0; i < 5; i = i+1)
    {
        if (! bullets[i].visible)
        { bullets[i].visible = 1;
	    bullets[i].x = gun.x + gun.width/2;
	    bullets[i].y = gun.y + gun.height;
	    i = 6; // break out of the loop
        } 
    } 
});

game.init([...aliens, ...bullets, gun]);





