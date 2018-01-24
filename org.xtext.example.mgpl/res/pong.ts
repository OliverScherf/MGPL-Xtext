import Game from "./framework/Game";
import Rectangle from "./framework/Rectangle";
import { touches } from "./framework/Collision";
import Circle from "./framework/Circle";

enum Pong {
    width = 400, 
    height = 300, 
    speed = 100
};

const paddle_increment: number = 10;
let ball_x_increment: number = 5;
let ball_y_increment: number = 2;
const paddle_width: number = 5;
const paddle_height: number = 40;
const ball_size: number = 10;

const game: Game = new Game(Pong.width, Pong.height, 0,0, Pong.speed);
// create paddle
const paddle: Rectangle = new Rectangle(Pong.width / 10, Pong.height /2, paddle_width, paddle_height);

// specify callback for ball
const animation = (cur_ball: Circle) => {
    	// if ball has reached either the left or right, reverse its direction
	if  (cur_ball.x < 0  &&  ball_x_increment < 0 || Pong.width - ball_size < cur_ball.x  && 0 < ball_x_increment) {
        ball_x_increment = -ball_x_increment;
    }

    // if ball has reached either the top or bottom, reverse its direction
    if (cur_ball.y < 0 || Pong.height - ball_size < cur_ball.y) {
        ball_y_increment = -ball_y_increment;
    }

    // if ball touches the paddle, reverse its direction
    if (touches(cur_ball, paddle)) {
        ball_x_increment = -ball_x_increment;
    }
 
    // on each step of the animation, move the ball
    cur_ball.x = cur_ball.x + ball_x_increment;
    cur_ball.y = cur_ball.y + ball_y_increment;
}

// create ball with callback
const ball:Circle = new Circle(Pong.width / 2, Pong.height / 2, ball_size / 2, animation);

// register up () => {}
game.registerKeyEvent('UP', () => {
    if (paddle_increment < paddle.y) {
        paddle.y = paddle.y -paddle_increment;
    }
});

// register down () => {}
game.registerKeyEvent('DOWN', () => {
    if (paddle.y < Pong.height - 2*paddle_increment) {
        paddle.y = paddle.y + paddle_increment;
    }
});

game.init([paddle, ball]);





