import Shape2D from "./Shape2D.js";

export default class Rectangle extends Shape2D {

    public width: number;
    public height: number;

    static color: string = '#000';

    constructor(x: number, y:number, width: number, height: number) {
        super(x,y);
        this.width = width;
        this.height = height;
    }

    public render(canvas: HTMLCanvasElement, ctx: CanvasRenderingContext2D): void {
        ctx.fillStyle = Rectangle.color;
        ctx.fillRect(this.x, this.y, this.width, this.height);
    }
}