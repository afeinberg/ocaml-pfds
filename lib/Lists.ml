module type StackSig = 
sig
  type 'a t

  val empty : 'a t
  val is_empty : 'a t -> bool
  val cons : 'a -> 'a t -> 'a t
  val head : 'a t -> 'a
  val tail : 'a t -> 'a t
end

module ListStack : StackSig =
struct
  type 'a t = Nil | Cons of 'a * 'a t
  exception Empty
    
  let empty = Nil
  let is_empty = function
  Nil -> true 
    | _ -> false
        
  let cons x s = Cons(x, s)
    
  let head = function
  Nil -> raise Not_found
    | Cons(x, s) -> x
        
  let tail = function
  Nil -> raise Empty
    | Cons(x, s) -> s
end

let rec update = function 
[], i, y -> raise Not_found
  | x :: xs, 0, y -> y :: xs
  | x :: xs, i, y -> x :: update(xs, i - 1, y)
    
