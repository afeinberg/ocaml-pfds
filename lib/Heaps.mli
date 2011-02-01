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

module LeftistHeap (O : OrderedType) : HeapSig with type elt = O.t


