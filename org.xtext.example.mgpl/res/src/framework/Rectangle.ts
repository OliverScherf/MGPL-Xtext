import Shape2D from "./Shape2D.js";
import { Boundaries } from "./Types.js";
import IMoveable from "./IMoveable.js";

export default class Rectangle extends Shape2D implements IMoveable {

    public width: number;
    public height: number;
    animate: (r: Rectangle) => void

    static color: string = '#000';

    static produce() {
        return new Rectangle(0,0,0,0, () => {});
    }

    constructor(x: number, y:number, width: number, height: number, handler: (r: Rectangle) => void = () => {}) {
        super(x,y);
        this.width = width;
        this.height = height;
        this.animate = handler;
    }

    public render(canvas: HTMLCanvasElement, ctx: CanvasRenderingContext2D): void {
        ctx.fillStyle = Rectangle.color;
        ctx.fillRect(this.x, this.y, this.width, this.height);
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