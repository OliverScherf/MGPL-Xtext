import Circle from "./Circle.js";

export default class Ball extends Circle {

    handleMove: (b:Ball) => void

    constructor(x: number, y:number, radius: number, handler: (b: Ball) => void){
        super(x,y,radius);
        this.handleMove = handler;
    }

    public move() {
        this.handleMove(this);
    }
} 