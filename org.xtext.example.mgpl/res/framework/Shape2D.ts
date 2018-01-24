export default class Shape2D {
    public x: number;
    public y: number;
    public visible: 0 | 1;

    static produce():Shape2D {
        return new Shape2D(0,0);        
    }

    constructor(x: number, y:number) {
        this.x = x;
        this.y = y;
        this.visible = 1;
    }
    
    render(canvas: HTMLCanvasElement, ctx: CanvasRenderingContext2D): void {

    }
}