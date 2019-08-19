open Ctypes
open PosixTypes
open Foreign

type 'a typ

val view :
  read:('a -> 'b) ->
  write:('b -> 'a) ->
  'a typ -> 'b typ



val string_of_char_ptr : char ptr -> string
val char_ptr_of_string : string -> char ptr



val string    : string typ
