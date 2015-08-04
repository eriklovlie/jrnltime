(* Auto-generated from "jrnljson.atd" *)


type entry = Jrnljson_t.entry = {
  body: string;
  date: string;
  starred: bool;
  time: string;
  title: string
}

type jrnl = Jrnljson_t.jrnl = { entries: entry list }

let write_entry : _ -> entry -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"body\":";
    (
      Yojson.Safe.write_string
    )
      ob x.body;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"date\":";
    (
      Yojson.Safe.write_string
    )
      ob x.date;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"starred\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.starred;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"time\":";
    (
      Yojson.Safe.write_string
    )
      ob x.time;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"title\":";
    (
      Yojson.Safe.write_string
    )
      ob x.title;
    Bi_outbuf.add_char ob '}';
)
let string_of_entry ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_entry ob x;
  Bi_outbuf.contents ob
let read_entry = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_body = ref (Obj.magic 0.0) in
    let field_date = ref (Obj.magic 0.0) in
    let field_starred = ref (Obj.magic 0.0) in
    let field_time = ref (Obj.magic 0.0) in
    let field_title = ref (Obj.magic 0.0) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 4 -> (
                match String.unsafe_get s pos with
                  | 'b' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'y' then (
                        0
                      )
                      else (
                        -1
                      )
                    )
                  | 'd' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                        3
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 5 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'e' then (
                  4
                )
                else (
                  -1
                )
              )
            | 7 -> (
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'd' then (
                  2
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_body := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_date := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_starred := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_time := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_title := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 4 -> (
                  match String.unsafe_get s pos with
                    | 'b' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'y' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | 'd' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                          3
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 5 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'e' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 7 -> (
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'd' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_body := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_date := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_starred := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_time := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_title := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x1f then Ag_oj_run.missing_fields p [| !bits0 |] [| "body"; "date"; "starred"; "time"; "title" |];
        (
          {
            body = !field_body;
            date = !field_date;
            starred = !field_starred;
            time = !field_time;
            title = !field_title;
          }
         : entry)
      )
)
let entry_of_string s =
  read_entry (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__1 = (
  Ag_oj_run.write_list (
    write_entry
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
  Ag_oj_run.read_list (
    read_entry
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_jrnl : _ -> jrnl -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"entries\":";
    (
      write__1
    )
      ob x.entries;
    Bi_outbuf.add_char ob '}';
)
let string_of_jrnl ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_jrnl ob x;
  Bi_outbuf.contents ob
let read_jrnl = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_entries = ref (Obj.magic 0.0) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          if len = 7 && String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' then (
            0
          )
          else (
            -1
          )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_entries := (
              (
                read__1
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            if len = 7 && String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' then (
              0
            )
            else (
              -1
            )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_entries := (
                (
                  read__1
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x1 then Ag_oj_run.missing_fields p [| !bits0 |] [| "entries" |];
        (
          {
            entries = !field_entries;
          }
         : jrnl)
      )
)
let jrnl_of_string s =
  read_jrnl (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
