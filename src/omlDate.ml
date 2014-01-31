(*
  year : Année courante
  month : 0 -> 11
  mont_day : 1 -> 31 
  hour : 0 -> 23
  min : 0 -> 59
  sec : 0 -> 60
  week_day : 0 -> 6 (0 = Dimanche)
  year_day : 0 -> 365 (1/1/1900 = 0)
*)
type date = {
  year : int;
  month : int; 
  month_day : int; 
  hour : int;
  min : int;
  sec : int;
  week_day : int;
  year_day : int;
}

(* Renvoi le temps Unix (en seconde) *)
let timestamp = Unix.time

(* Convertit un temps Unix.tm en date *)
let of_tm (t : Unix.tm) = 
  {
    year        = t.tm_year + 1900;
    month       = t.tm_mon;
    month_day   = t.tm_mday;
    hour        = t.tm_hour;
    min         = t.tm_min;
    sec         = t.tm_sec;
    week_day    = t.tm_wday; 
    year_day    = t.tm_yday
  }

(* Convertit une date en Unix.tm *)
let to_tm t : Unix.tm = 
  {
    tm_sec   = t.sec;
    tm_min   = t.min;
    tm_hour  = t.hour;
    tm_mday  = t.month_day;
    tm_mon   = t.month;
    tm_year  = t.year - 1900;
    tm_wday  = t.week_day;
    tm_yday  = t.year_day;
    tm_isdst = true;
  }

(* Transforme un nombre de seconde en champ date*)
let make ?(local = true) t = 
  if local then of_tm (Unix.localtime t)
  else of_tm (Unix.gmtime t)

(* Renvoi le temps courant en date *)
let current ?(local = true) () = 
  make ~local:local (timestamp ())

(* Convertit une date en nombre de seconde *)
let mktime t = fst (Unix.mktime (to_tm t))


