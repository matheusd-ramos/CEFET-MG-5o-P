- fun cyclen ([], _) = []
= |   cyclen (L, 0) = L
= |   cyclen (x::xs, n) = cyclen(xs @ [x], n-1);
