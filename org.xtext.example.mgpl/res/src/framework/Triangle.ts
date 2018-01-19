import Shape2D from "./Shape2D.js";

export default class Triangle extends Shape2D {

    public width: number;
    public height: number;

    static color: string = '#000';

    constructor(x: number, y:number, width: number, height: number) {
        super(x,y);
        this.width = width;
        this.height = height;
    }

    public render(canvas: HTMLCanvasElement, ctx: CanvasRenderingContext2D): void {
        ctx.beginPath();
        ctx.moveTo(this.x, this.y);
        ctx.lineTo(this.x - (this.width / 2), this.y + this.height);
        ctx.lineTo(this.x + (this.width / 2), this.y + this.height);
        ctx.lineTo(this.x, this.y);
        
        // the outline
        ctx.lineWidth = 1;
        ctx.strokeStyle = Triangle.color;
        ctx.stroke();
        
        // the fill color
        ctx.fillStyle = Triangle.color;
        ctx.fill();
    }
}