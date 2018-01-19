import Circle from "./Circle.js";
import Rectangle from "./Rectangle.js";

export function touches(circle: Circle, player: Rectangle): boolean {
    const playerRightEdge = player.x + player.width;
    const playerTop = player.y;
    const playerBottom = player.y + player.height;
    const circleTop =  circle.y;
    const circleBottom =  circle.y + circle.radius;
    if(circle.x <= playerRightEdge && circleBottom >= playerTop && circleTop <= playerBottom) {
        return true;
    }
    return false;
}