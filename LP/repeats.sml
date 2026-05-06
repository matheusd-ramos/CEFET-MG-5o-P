- fun repeats [] = false
= |   repeats [_] = false
= |   repeats (x::y::xs) = if x = y then true else repeats (y::xs);
