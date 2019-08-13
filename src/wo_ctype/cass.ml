type cassSession
type cassStatement
type cassCluster
type uuid
type cassFuture  
type cassError = Failure | Success
type cassUuid
type cassUuidGen
type stubtype

external ml_cass_session_new : unit -> cassSession = "cass_session_new"
external ml_cass_statement_new : string -> int -> cassStatement = "cass_statement_new"
external ml_cass_cluster_new : unit -> cassCluster = "cass_cluster_new"
external ml_cass_cluster_set_contact_points : cassCluster -> string -> unit = "cass_cluster_set_contact_points"
external ml_cass_uuid_gen_new : unit -> uuid = "cass_uuid_gen_new"
external ml_cass_session_execute : cassSession -> cassStatement -> cassFuture = "cass_session_execute"
external ml_cass_future_wait : cassFuture -> unit = "cass_future_wait"
external ml_cass_future_error_code : cassFuture -> int = "cass_future_error_code"
external ml_cass_future_free : cassFuture -> unit = "cass_future_free"
external ml_cass_statement_free : cassStatement -> unit = "cass_statement_free"
external ml_cass_uuid_gen_time : uuid -> cassUuid = "cass_uuid_gen_time"
external ml_cass_session_connect : cassSession -> cassCluster -> cassFuture = "cass_session_connect"
external mlstub_cass_future_error_message: cassFuture -> unit = "cstub_cass_future_error_message"
external ml_cass_cluster_free : cassCluster -> unit = "cass_cluster_free"
external ml_cass_session_free : cassSession -> unit = "cass_session_free"

external cstub_connect_session : cassSession -> cassCluster -> int = "cstub_connect_session"
external cstub_execute_query : cassSession -> string -> cassError = "cstub_execute_query"
(* external ml_get_raw_data : unit -> string = "get_raw_data" *)
(* external ml_add_data : int -> int -> int = "add_data" *)
(* external ml_cass_ok : cassError = "CASS_OK" *)
external osum : int->int->int = "stub_sum";;
(* external ofsum : float->float->float = "fsum";; *)
(* external ostr : char->char="str";; *)



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

let print_error future =
	mlstub_cass_future_error_message future


let connect_session session cluster = 
	
	cstub_connect_session session cluster
	(* let future = ml_cass_session_connect session cluster in
		ml_cass_future_wait future;

		let rc = ml_cass_future_error_code future in
			
			(* if rc <> 0 then print_error future;

			ml_cass_future_free future; *)

			rc *)


let () = begin
  let sess = ml_cass_session_new () in 
  let hosts = "127.0.0.1" in 
  let cluster = create_cluster hosts in
  let uuid_gen = ml_cass_uuid_gen_new () in 
  
  	let response = connect_session sess cluster in
  			ml_cass_cluster_free cluster;
  			ml_cass_session_free sess;
  			
  	(* let a = ml_cass_session_connect (ml_cass_session_new ()) 
  	(ml_cass_cluster_set_contact_points (ml_cass_cluster_new ()) 
  	hosts) in (); *)

  	(* match response with 
  	| Success -> print_string "\nconnection established\n";
  	| _ -> print_string "\nproblem in establishing connection\n"; *)

  		 (*  if response <> 1 then
  			print_string "problem in establishing connection"
  		else
  			print_string "connection established" ;
  			Printf.printf "\nresponse = %d\n" response; *)
 

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