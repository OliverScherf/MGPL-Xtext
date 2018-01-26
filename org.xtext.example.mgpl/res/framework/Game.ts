import Circle from "./Circle";
import Rectangle from "./Rectangle";
import Triangle from "./Triangle";
import { instanceOfIMoveable } from "./IMoveable";
import Shape2D from "./Shape2D";

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
    private gameSpeed: number;
    private windowX: number;
    private windowY: number;
    private keyPressed: boolean[];
    private renderables: Shape2D[];
    private onArrowDown: () => void;
    private onArrowUp: () => void;
    private keyEvents: {[index:string] : () => void};

    constructor(width: number, height: number, windowX: number = 0, windowY: number = 0, gameSpeed: number = 0) {
        this.width = width;
        this.height = height;
        this.keyEvents = {};
        this.keyPressed = [];
        this.gameSpeed = gameSpeed > 0 ? gameSpeed : 0;
        this.windowX = windowX;
        this.windowY = windowY;
    }

    private createWorld() {
        this.canvas = document.createElement('canvas');
        this.canvas.style.position = 'absolute';
        this.canvas.style.top = `${this.windowY}px`;
        this.canvas.style.left = `${this.windowX}px`;
        this.context = this.canvas.getContext('2d');
        document.body.appendChild(this.canvas);
        this.canvas.height = this.height;
        this.canvas.width = this.width;
        this.renderables = [];
    }

    private paintBackground() {
        this.context.fillStyle = '#000';
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
        // update moveable game object
        this.renderables.forEach(item => {
            if(instanceOfIMoveable(item)) {
                item.move();
            }
        });

        // paint game objects
        this.paintBackground();
        this.renderables.
            filter(item => item.visible === 1)
            .forEach(renderable => renderable.render(this.canvas, this.context));
        // continue game loop
        setTimeout(() => {
            requestAnimationFrame(() => this.gameLoop());
        }, 100 - this.gameSpeed);   
    }

    // loop for inputs, e.g. pressed keys 
    private inputLoop() {
        // update input-controlled game objects
        this.keyPressed.forEach((itemStatus, index) => {
            if(itemStatus && this.keyEvents[KeyBindings[index]]) {
                this.keyEvents[KeyBindings[index]]();
            }
        });
        // paint game objects
        this.paintBackground();
        this.renderables.
            filter(item => item.visible === 1)
            .forEach(renderable => renderable.render(this.canvas, this.context));
        requestAnimationFrame(() => this.inputLoop());
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
        window.requestAnimationFrame(() => this.inputLoop())
    }
}
