import Circle from "./Circle.js";
import Rectangle from "./Rectangle.js";
import Triangle from "./Triangle.js";


export type Boundaries = {
    x: number,
    y: number,
    height: number,
    width: number
}

export type CollisionObject = Circle | Rectangle | Triangle;