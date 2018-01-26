import Shape2D from "./Shape2D";
import {Boundaries} from "./Types";
import IMoveable from "./IMoveable";

export default class Triangle extends Shape2D implements IMoveable {

    public width: number;
    public height: number;

    static color: string = '#fff';

    static produce() {
        return new Triangle(0,0,0,0, 1, () => {});
    }

    animate: (r: Triangle) => void

    constructor(x: number, y:number, width: number, height: number, visible: number, handler: (r: Triangle) => void = () => {}) {
        super(x,y, visible);
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