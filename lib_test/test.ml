open OUnit
open Heaps

let _ = run_test_tt_main 
  ("Purely Functional Data Structures" >:::
      [ 
        TestHeaps.tests 
      ])
