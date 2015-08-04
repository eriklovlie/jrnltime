open Core.Std

let main =
  Core_extended.Shell.run_full "jrnl" ["--export"; "json"; "@time"]
  |> Jrnljson_j.jrnl_of_string
  |> fun jrnl ->
     let open Jrnljson_t in
     let n_hours =
       let workstart = List.filter jrnl.entries ~f:(fun e -> String.is_substring ~substring:"workstart" e.title)
       and workend = List.filter jrnl.entries ~f:(fun e -> String.is_substring ~substring:"workend" e.title)
       and workhours e1 e2 =
         let t1 = Time.of_string (e1.date ^ "T" ^ e1.time)
         and t2 = Time.of_string (e2.date ^ "T" ^ e2.time) in
         Time.Span.to_hr (Time.diff t2 t1)
       in
       let hours = List.map2_exn workstart workend ~f:workhours in
       List.fold hours ~init:0.0 ~f:(+.)
     in
     let n_days = List.fold jrnl.entries ~init:String.Set.empty ~f:(fun a e -> Set.add a e.date) |> Set.length in
     let in_lieu = n_hours -. Float.of_int (n_days * 8) in
     printf "days: %d, hours in lieu: %f\n" n_days in_lieu

let spec =
  let open Command.Spec in
  empty

(* TODO add option to disable standup 15 minute overhead *)
let command =
  Command.basic
    ~summary:"Time tracking using jrnl"
    ~readme:(fun () -> "Extract hours in lieu from your jrnl.")
    spec
    (fun () -> main)

let () =
  Command.run ~version:"1.0" command
