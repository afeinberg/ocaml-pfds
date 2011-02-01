open OUnit
open Heaps

module OrderedInt  = struct 
  type t = int
  let compare = compare
end

let test_heap impl =
  let module H = (val impl: HeapSig with type elt = int) in
  let h = H.empty in
  let h1 = H.add 1 h in
  let h2 = H.add 2 h1 in
  let h3 = H.take_min h2 in

  assert_equal ~msg:"add works" (H.peek_min h1) (Some 1) ;
  assert_equal ~msg:"peek_min returns min" (H.peek_min h2) (Some 1) ;
  assert_equal ~msg:"take_min removes min" (H.peek_min h3) (Some 2)

let test_leftist_heap _ = 
  let module IntLeftistHeap = LeftistHeap (OrderedInt) in
  test_heap (module IntLeftistHeap : HeapSig with type elt = int)

let tests =
  "Heaps" >::: [
    "leftist_heap" >:: test_leftist_heap 
  ]
