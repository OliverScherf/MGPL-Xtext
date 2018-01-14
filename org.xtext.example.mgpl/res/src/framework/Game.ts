import Ball from "./Ball.js";
import Rectangle from "./rectangle.js";

enum KeyBindings {
    UP = 38,
    DOWN = 40
}

type GameObject = Ball | Rectangle

export default class Game {
    private canvas: HTMLCanvasElement;
    private context: CanvasRenderingContext2D;
    private width: number = window.innerWidth;
    private height: number = window.innerHeight;
    private keyPressed: boolean[];
    private renderables: GameObject[];
    private onArrowDown: () => void;
    private onArrowUp: () => void;

    constructor(width: number, height: number) {
        this.width = width;
        this.height = height;
    }

    private createWorld() {
        this.canvas = document.createElement('canvas');
        this.context = this.canvas.getContext('2d');
        document.body.appendChild(this.canvas);
        this.canvas.height = this.height;
        this.canvas.width = this.width;
        this.keyPressed = [];
        this.renderables = [];
    }

    private paintBackground() {
        this.context.fillStyle = '#779';
        this.context.fillRect(0, 0, this.canvas.width, this.canvas.height); 
    }

    public registerOnArrowDown(onArrowDown: () => void){
       this.onArrowDown = onArrowDown;
    }
    public registerOnArrowUp(onArrowUp: () => void){
        this.onArrowUp = onArrowUp;
     }

    // gameloop
    private gameLoop(){
        if(this.keyPressed[KeyBindings.UP]) {
            this.onArrowUp();
        }
        if(this.keyPressed[KeyBindings.DOWN]) {
            this.onArrowDown();
        }

        // update moveables
        this.renderables.forEach(item => {
            if (item instanceof Ball) {
                item.move();   
            }
        });

        // paint ball & rectangle
        this.paintBackground();
        this.renderables.forEach(renderable => renderable.render(this.canvas, this.context));
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

    public init(renderables: GameObject[]) {
        this.createWorld();
        this.setupKeyListener();
        this.renderables = renderables;
        window.requestAnimationFrame(() => this.gameLoop())
    }
}