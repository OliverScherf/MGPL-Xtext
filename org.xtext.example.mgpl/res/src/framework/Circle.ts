import Shape2D from "./Shape2D.js";
import IMoveable from "./IMoveable.js";

export default class Circle extends Shape2D implements IMoveable {

    public radius: number;
    handleMove: (c:Circle) => void

    constructor(x: number, y:number, radius: number, handler: (b: Circle) => void) {
        super(x,y);
        this.radius = radius;
        this.handleMove = handler;
    }

    static color: string = 'red';

    public render(canvas: HTMLCanvasElement, ctx: CanvasRenderingContext2D): void {
        ctx.fillStyle = Circle.color;
        ctx.beginPath();
        ctx.arc(this.x,this.y,this.radius,0,Math.PI*2);
        ctx.fill();
    }

    public move() {
        this.handleMove(this);
    }
}