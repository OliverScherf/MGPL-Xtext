export default interface IMoveable {
    move: () => void
}

export function instanceOfIMoveable(object: any): object is IMoveable {
    return 'move' in object;
}