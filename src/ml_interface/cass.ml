(*Here I am doing every thing in main function of C in ml. Other C functions are being accessed from the cstub*)

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
external ml_cass_cluster_new : unit -> cassCluster = "cass_cluster_new"
external ml_cass_cluster_set_contact_points : cassCluster -> string -> unit = "cass_cluster_set_contact_points"
external ml_cass_uuid_gen_new : unit -> uuid = "cass_uuid_gen_new"
external ml_cass_cluster_free : cassCluster -> unit = "cass_cluster_free"
external ml_cass_session_free : cassSession -> unit = "cass_session_free"
external ml_cass_uuid_gen_free : uuid -> unit = "cass_uuid_gen_free"

external cstub_cass_future_error_message: cassFuture -> unit = "cstub_cass_future_error_message"
external cstub_connect_session : cassSession -> cassCluster -> int = "cstub_connect_session"
external cstub_execute_query : cassSession -> string -> cassError = "cstub_execute_query"
external cstub_insert_into_tuple : cassSession -> uuid -> cassError = "cstub_insert_into_tuple"
external cstub_select_from_tuple : cassSession -> cassError = "cstub_select_from_tuple"

let create_cluster hosts = 
	(* let cstub_create_cluster hosts *)

	let cluster = ml_cass_cluster_new () in 
		ml_cass_cluster_set_contact_points cluster hosts;
		cluster

let execute_query session query = 
	cstub_execute_query session query
	

let print_error future =
	cstub_cass_future_error_message future


let connect_session session cluster = 
	cstub_connect_session session cluster
		

let _ = 
	let sess = ml_cass_session_new () in 
  	let hosts = "127.0.0.1" in 
  	let cluster = create_cluster hosts in
  	let uuid_gen = ml_cass_uuid_gen_new () in 
 
  	let response = connect_session sess cluster in
  		(* if response == 2 then begin
  			ml_cass_cluster_free cluster;
  			ml_cass_session_free sess
  		end; *)
		
	execute_query sess "CREATE KEYSPACE examples WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '3' }";
  	execute_query sess "CREATE TABLE examples.tuples (id timeuuid, item frozen<tuple<text, bigint>>, PRIMARY KEY(id))";

  	cstub_insert_into_tuple sess uuid_gen;
  	cstub_select_from_tuple sess;

  	ml_cass_cluster_free cluster;
  	ml_cass_session_free sess;

  	ml_cass_uuid_gen_free uuid_gen


