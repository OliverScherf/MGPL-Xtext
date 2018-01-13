import Shape2D from "./Shape2D.js";

export default class Circle extends Shape2D {

    public radius: number;

    constructor(x: number, y:number, radius: number) {
        super(x,y);
        this.radius = radius;
    }

    static color: string = 'red';

    public render(canvas: HTMLCanvasElement, ctx: CanvasRenderingContext2D): void {
        ctx.fillStyle = Circle.color;
        ctx.beginPath();
        ctx.arc(this.x,this.y,this.radius,0,Math.PI*2);
        ctx.fill();
    }
}