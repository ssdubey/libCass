type session
external ml_cass_session_new : unit -> session = "cass_session_new"
(* external ml_execute_query : session -> string -> unit = "execute_query" *)
(* external ml_insert_into_tuple : session -> unit = "insert_into_tuple" *)
(* external ml_select_from_tuple : session -> unit = "select_from_tuple" *)

let () = begin
  Printf.printf "Sdfs";
  ignore @@ ml_cass_session_new ();
  (* ml_execute_query (ml_cass_session_new ()) "CREATE KEYSPACE examples WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '3' }" *)
  (*ml_insert_into_tuple session;
  ml_select_from_tuple session*)
end