(** Routine de sérialisation **)
include Marshal

let match_flag s = 
  let rec flags acc = function 
    | -1 -> acc 
    | x -> begin match s.[x] with
      | 'n' -> flags (Marshal.No_sharing :: acc) (x - 1)
      | 'f' | 'c' | 'l' -> flags (Marshal.Closures :: acc) (x - 1)
      | 'u' | 'b' | '+' -> flags (Marshal.Compat_32 :: acc) (x - 1)
      | _ -> flags acc (x - 1)
    end
  in flags [] (String.length s - 1)
  
let dump ?(flags = "") file value =
  let opflag = [
    Open_wronly;
    Open_creat;
    Open_trunc
  ] in
  let chan =  open_out_gen opflag 511 file 
  and flags_v = match_flag flags in 
  Marshal.to_channel chan value flags_v;
  close_out chan

let load file = 
  let chan = open_in file in 
  let v = Marshal.from_channel chan in
  close_in chan;
  v

let serialize ?(flags = "") value =
  let flags_v = match_flag flags in
  Marshal.to_string value flags_v

let unserialize ?(offset = 0) s = 
  Marshal.from_string s offset
 
