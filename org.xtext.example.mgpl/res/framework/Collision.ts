import Circle from "./Circle";
import Rectangle from "./Rectangle";
import Triangle from "./Triangle";
import { CollisionObject, Boundaries } from './Types';

export function touches(a: CollisionObject, b: CollisionObject): boolean {
    const aDim = a.getBoundaries();
    const bDim = b.getBoundaries();
    return aDim.x < bDim.x + bDim.width && aDim.x + aDim.width > bDim.x && aDim.y < bDim.y + bDim.height && aDim.y + aDim.height > bDim.y;
}