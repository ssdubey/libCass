open Ctypes
open PosixTypes
open Foreign
(* open Ctypecass *)

(* type cassSession
let cassSession : cassSession structure typ = structure "CassSession"

val string_of_char_ptr : char ptr -> string
val char_ptr_of_string : string -> char ptr
let string = view ~read: ~write: (ptr char) *)

(* let ml_cass_session_new = foreign "cass_session_new" (void @-> returning string) *)

(* type timezone
let timezone : timezone structure typ = structure "timezone" *)

let string = 
  view (char ptr)
     ~read:Ctypecass.string_of_char_ptr 
    ~write:char_ptr_of_string  




(* let time = foreign "time" (ptr time_t @-> returning time_t) *)

(* type timeval
let timeval : timeval structure typ = structure "timeval" *)

(* let () = seal timeval *)

(*type window = unit ptr
let window : window typ = ptr void

let initscr =
  foreign "initscr" (void @-> (returning window)) *)
  
(* let ml_cass_session_new = foreign "cass_session_new" (void @-> ) *)

 (* type cassSession
 external ml_cass_session_new : unit -> cassSession = "cass_session_new" *)
 
let _ = begin
  (* let sess = ml_cass_session_new () in *)

();

end