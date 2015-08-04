open Core.Std

let main =
  Core_extended.Shell.run_full "jrnl" ["--export"; "json"; "@time"]
  |> Jrnljson_j.jrnl_of_string
  |> fun jrnl ->
     let open Jrnljson_t in
     List.iter jrnl.entries
               ~f:(fun entry -> printf "entry: %s\n" (entry.title ^ " " ^ entry.body))
     
let spec =
  let open Command.Spec in
  empty

(* TODO add option to disable standup 15 minute overhead *)
let command =
  Command.basic
    ~summary:"Time tracking using jrnl"
    ~readme:(fun () -> "Bla bla")
    spec
    (fun () -> main)

let () =
  Command.run ~version:"1.0" command
