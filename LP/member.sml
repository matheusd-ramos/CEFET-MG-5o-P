- fun member (e, []) = false
= |   member (e, x::xs) = if e = x then true else member (e, xs);
