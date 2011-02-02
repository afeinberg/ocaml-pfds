module type OrderedType =
sig
  type t
  val compare : t -> t -> int
end

module type HeapSig = sig
  type elt
  type t
  val empty : t
  val is_empty : t -> bool
  val add : elt -> t -> t
  val merge : t -> t -> t
  val peek_min : t -> elt option
  val take_min : t -> t
end

module LeftistHeap (O : OrderedType) : HeapSig with type elt = O.t =
struct
  type elt = O.t
  type t = Empty | Heap of int * elt * t * t
      
  let empty = Empty
  let is_empty = function Empty -> true
    | _ -> false


  let rank = function Empty -> 0
    | Heap (r, _, _, _) -> r
      
  let make_heap x a b =
    if (rank a) > (rank b) then
      Heap ((rank b) + 1, x, a, b)
    else
      Heap ((rank a) + 1, x, b, a)
        
  let rec merge a b =  
    match (a, b) with
        (_, Empty) -> a
      | (Empty, _) -> b
      | (Heap(_, x, a1, b1) as h1, (Heap(_, y, a2, b2) as h2)) ->
        (if (O.compare x y) <= 0 then
            make_heap x a1 (merge b1 h2)
         else
            make_heap y a2 (merge h1 b2))
          
  let add x h = merge (Heap(1, x, Empty, Empty)) h

  let peek_min = function Heap(_, x, a, b) -> Some x
    | _ -> None
      
  let take_min = function Heap(_, x, a, b) -> merge a b
    | _ -> raise Not_found
      
end
    
      

    
