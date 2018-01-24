import Shape2D from "./Shape2D";
import IMoveable from "./IMoveable";
import {Boundaries} from "./Types";

export default class Circle extends Shape2D implements IMoveable {

    public radius: number;

    static produce() {
        return new Circle(0, 0, 0, () => {});
    }
    animate: (c:Circle) => void

    constructor(x: number, y:number, radius: number, handler: (b: Circle) => void) {
        super(x,y);
        this.radius = radius;
        this.animate = handler;
    }

    static color: string = 'red';

    public render(canvas: HTMLCanvasElement, ctx: CanvasRenderingContext2D): void {
        ctx.fillStyle = Circle.color;
        ctx.beginPath();
        ctx.arc(this.x,this.y,this.radius,0,Math.PI*2);
        ctx.fill();
    }

    public move() {
        this.animate(this);
    }

    getBoundaries(): Boundaries {
        return {
            x: this.x,
            y: this.y,
            height: this.radius,
            width: this.radius
        }
    }
}