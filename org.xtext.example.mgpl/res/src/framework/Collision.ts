import Ball from "./Ball.js";
import Rectangle from "./Rectangle.js";

export function touches(ball: Ball, player: Rectangle): boolean {
    const playerRightEdge = player.x + player.width;
    const playerTop = player.y;
    const playerBottom = player.y + player.height;
    const ballTop =  ball.y;
    const ballBottom =  ball.y + ball.radius;
    if(ball.x <= playerRightEdge && ballBottom >= playerTop && ballTop <= playerBottom) {
        return true;
    }
    return false;
}