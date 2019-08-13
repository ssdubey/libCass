open Ctypes
open PosixTypes
open Foreign

 (* let sigemptyset = foreign "sigemptyset" (ptr sigset_t @-> returning int) *)
(* type cassSession
type cassStatement
type cassCluster
type uuid
type cassFuture
type cassError
type cassUuid
type cassUuidGen *)

module type TYPE = 
sig
val cassCluster : int typ
end


(* let ml_cass_session_new = foreign "cass_session_new" (void @-> returning double) *)
let ml_cass_cluster_new = foreign "cass_cluster_new" (void @-> returning cassCluster)

(* external ml_cass_session_new : unit -> cassSession = "cass_session_new"
external ml_cass_statement_new : string -> int -> cassStatement = "cass_statement_new"
external ml_cass_cluster_new : unit -> cassCluster = "cass_cluster_new"
external ml_cass_cluster_set_contact_points : cassCluster -> string -> unit = "cass_cluster_set_contact_points"
external ml_cass_uuid_gen_new : unit -> uuid = "cass_uuid_gen_new"
external ml_cass_session_execute : cassSession -> cassStatement -> cassFuture = "cass_session_execute"
external ml_cass_future_wait : cassFuture -> unit = "cass_future_wait"
external ml_cass_future_error_code : cassFuture -> cassError = "cass_future_error_code"
external ml_cass_future_free : cassFuture -> unit = "cass_future_free"
external ml_cass_statement_free : cassStatement -> unit = "cass_statement_free"
external ml_cass_uuid_gen_time : uuid -> cassUuid = "cass_uuid_gen_time"
external ml_cass_session_connect : cassSession -> cassCluster -> cassFuture = "cass_session_connect" *)
(* external ml_cass_ok : cassError = "CASS_OK" *)


(* print_error
create_cluster
connect_session
execute_query
prepare_query
insert_into_tuple
select_from_tuple *)

 let create_cluster hosts = 
	let cluster = ml_cass_cluster_new () in 
		ml_cass_cluster_set_contact_points cluster hosts;
		cluster
(*
let execute_query session query = 
	let statement = ml_cass_statement_new query 0 in 
	let future = ml_cass_session_execute session statement in 
		ml_cass_future_wait future;

		let rc = ml_cass_future_error_code future in
			 
			 (*skipping code here*)

			 ml_cass_future_free future;
			 ml_cass_statement_free statement;

			 rc;;

(* let insert_into_tuple session = 
	let CASS_UUID_STRING_LENGTH = 37 in
	let query = "INSERT INTO examples.tuples (id, item) VALUES (?, ?)" in
	let statement = ml_cass_statement_new query 2 in
		ml_cass_uuid_gen_time *)
*)
let connect_session session cluster = 
	let future = ml_cass_session_connect session cluster in
		ml_cass_future_wait future;

		let rc = ml_cass_future_error_code future in 
			(* if rc != 0 then  *)
			ml_cass_future_free future;

			rc

 
let () = begin
  let sess = ml_cass_session_new () in
  let hosts = "127.0.0.1" in 
  let cluster = create_cluster hosts in
  let uuid_gen = ml_cass_uuid_gen_new in 
  (* ignore @@ Printf.printf "%s" uuid_gen *)

  	let response = connect_session sess cluster in
  	(* let a = ml_cass_session_connect (ml_cass_session_new ()) 
  	(ml_cass_cluster_set_contact_points (ml_cass_cluster_new ()) 
  	hosts) in (); *)



  		if response != 0 then
  			print_string "problem in establishing connection"
  		else
  			print_string "connection established"


  	execute_query sess "CREATE KEYSPACE examples WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '3' }";
  	(* execute_query sess "CREATE TABLE examples.tuples (id timeuuid, item frozen<tuple<text, bigint>>, PRIMARY KEY(id))"; *)

    (* insert_into_tuple sess; *)

();



  (* Printf.printf "Sdfs";
  ignore @@ ml_cass_session_new ();
  ignore @@ ml_cass_statement_new "stmt" 7; *)
  (* ml_execute_query (ml_cass_session_new ()) "CREATE KEYSPACE examples WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '3' }" *)
  (*ml_insert_into_tuple session;
  ml_select_from_tuple session*)
end



(* (* open Libcassandra;; *)

Printf.printf "Sdfs";
ignore @@ ml_cass_session_new ();
ml_execute_query (ml_cass_session_new ()) "CREATE KEYSPACE examples WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '3' }"
 *)