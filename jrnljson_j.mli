(* Auto-generated from "jrnljson.atd" *)


type entry = Jrnljson_t.entry = {
  body: string;
  date: string;
  starred: bool;
  time: string;
  title: string
}

type jrnl = Jrnljson_t.jrnl = { entries: entry list }

val write_entry :
  Bi_outbuf.t -> entry -> unit
  (** Output a JSON value of type {!entry}. *)

val string_of_entry :
  ?len:int -> entry -> string
  (** Serialize a value of type {!entry}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_entry :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> entry
  (** Input JSON data of type {!entry}. *)

val entry_of_string :
  string -> entry
  (** Deserialize JSON data of type {!entry}. *)

val write_jrnl :
  Bi_outbuf.t -> jrnl -> unit
  (** Output a JSON value of type {!jrnl}. *)

val string_of_jrnl :
  ?len:int -> jrnl -> string
  (** Serialize a value of type {!jrnl}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_jrnl :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> jrnl
  (** Input JSON data of type {!jrnl}. *)

val jrnl_of_string :
  string -> jrnl
  (** Deserialize JSON data of type {!jrnl}. *)

