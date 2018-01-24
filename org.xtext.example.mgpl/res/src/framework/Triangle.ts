import Shape2D from "./Shape2D.js";
import {Boundaries} from "./Types.js";
import IMoveable from "./IMoveable.js";

export default class Triangle extends Shape2D implements IMoveable {

    public width: number;
    public height: number;

    static color: string = '#000';

    static produce() {
        return new Triangle(0,0,0,0, () => {});
    }

    animate: (r: Triangle) => void

    constructor(x: number, y:number, width: number, height: number, handler: (r: Triangle) => void = () => {}) {
        super(x,y);
        this.width = width;
        this.height = height;
        this.animate = handler;
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

    public move() {
        this.animate(this);
    }

    getBoundaries(): Boundaries {
        return {
            x: this.x,
            y: this.y,
            height: this.height,
            width: this.width
        }
    }
}