import Circle from "./Circle";
import Rectangle from "./Rectangle";
import Triangle from "./Triangle";


export type Boundaries = {
    x: number,
    y: number,
    height: number,
    width: number
}

export type CollisionObject = Circle | Rectangle | Triangle;