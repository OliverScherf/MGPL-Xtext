import Circle from "./Circle.js";
import Rectangle from "./Rectangle.js";
import Triangle from "./Triangle.js";
import { CollisionObject, Boundaries } from './Types.js';

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

export function touches2(a: CollisionObject, b: CollisionObject): boolean {
    const aDim = a.getBoundaries();
    const bDim = b.getBoundaries();
    // touch right edge
    if(aDim.x <= (bDim.x + bDim.width) && (aDim.y + aDim.height) >= bDim.y && aDim.y <= (bDim.y + bDim.height)) {
        return true;
    }

    // touch left edge
    if((aDim.x + aDim.width) >= bDim.x && (aDim.y + aDim.height) >= bDim.y && aDim.y <= (bDim.y + bDim.height)) {
        return true;
    }

    // touch top edge
    if((aDim.y + aDim.height) >= bDim.y && (aDim.x + aDim.width) >= bDim.x && aDim.x <= (bDim.x + bDim.width)) {
        return true;
    }

    // touch bottom edge
    if((aDim.y) <= (bDim.y + bDim.height) && (aDim.x + aDim.width) >= bDim.x && aDim.x <= (bDim.x + bDim.width)) {
        return true;
    }

    return false;
}