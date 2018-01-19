import Shape2D from "./Shape2D.js";

export function arrayOfN<T>(n: number, produceFunc: () => T): T[] {
    let arr: T[] = [];
    for(let i = 0; i<n; i++) {
        arr[i] = produceFunc();
    }
    return arr;
}