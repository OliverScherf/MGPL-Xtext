import Circle from "./Circle.js";
import Rectangle from "./Rectangle.js";
import Triangle from "./Triangle.js";
import { instanceOfIMoveable } from "./IMoveable.js";
import Shape2D from "./Shape2D.js";

enum KeyBindings {
    UP = 38,
    DOWN = 40,
    LEFT = 37,
    RIGHT = 39,
    SPACE = 32
}

export default class Game {
    private canvas: HTMLCanvasElement;
    private context: CanvasRenderingContext2D;
    private width: number = window.innerWidth;
    private height: number = window.innerHeight;
    private keyPressed: boolean[];
    private renderables: Shape2D[];
    private onArrowDown: () => void;
    private onArrowUp: () => void;
    private keyEvents: {[index:string] : () => void};

    constructor(width: number, height: number) {
        this.width = width;
        this.height = height;
        this.keyEvents = {};
        this.keyPressed = [];
    }

    private createWorld() {
        this.canvas = document.createElement('canvas');
        this.context = this.canvas.getContext('2d');
        document.body.appendChild(this.canvas);
        this.canvas.height = this.height;
        this.canvas.width = this.width;
        this.renderables = [];
    }

    private paintBackground() {
        this.context.fillStyle = '#779';
        this.context.fillRect(0, 0, this.canvas.width, this.canvas.height); 
    }

    public registerKeyEvent(keyType: string, callback: () => void ) {
        console.log(this.keyEvents);
        this.keyEvents[keyType] = callback;
    }
    public registerOnArrowDown(onArrowDown: () => void){
       this.onArrowDown = onArrowDown;
    }
    public registerOnArrowUp(onArrowUp: () => void){
        this.onArrowUp = onArrowUp;
     }

    // gameloop
    private gameLoop(){
        this.keyPressed.forEach((itemStatus, index) => {
            if(itemStatus && this.keyEvents[KeyBindings[index]]) {
                this.keyEvents[KeyBindings[index]]();
            }
        });

        // update moveables
        this.renderables.forEach(item => {
            if(instanceOfIMoveable(item)) {
                item.move();
            }
        });

        // paint ball & rectangle
        this.paintBackground();
        this.renderables.
            filter(item => item.visible === 1)
            .forEach(renderable => renderable.render(this.canvas, this.context));
        
        // continue game loop
        requestAnimationFrame(() => this.gameLoop());
    }

    // setup listener
    private setupKeyListener() {
        window.addEventListener("keydown", (e) => {
            this.keyPressed[e.which] = true;
         });
         window.addEventListener("keyup", (e) =>{
            this.keyPressed[e.which] = false;
         });
    }

    public init(renderables: Shape2D[]) {
        this.createWorld();
        this.setupKeyListener();
        this.renderables = renderables;
        window.requestAnimationFrame(() => this.gameLoop())
    }
}
