(* Exercise 4.1 in PFDS(Purely Functional Data Structures) *)
(* dropA の定義 *)
fun lazy dropA (0, s) = s
       | dropA (n, $NIL) = $NIL
       | dropA (n, $CONS (x, s)) = $CONS (x, take (n-1, s))

(* lazy を定義通りに展開すると以下になる *)
fun dropA (n', s') = $case (n', s') of
    | (0, s) => force (s)
    | (n, $NIL) => force ($NIL)
    | (n, $CONS (x, s)) => force (dropA (n-1, s))

(* 場合分けのすべての結果に force が付いているので前にくくり出しても同じ *)
fun dropA (n', s') = force ($case (n', s') of
    | (0, s) => s
    | (n, $NIL) => $NIL
    | (n, $CONS (x, s)) => dropA (n-1, s)
    )

(* ヘルパーを使って書き換えた以下と同じになっている *)
fun dropA (n', s') =
    let fun drop' (n', s') = case (n', s') of
        | (0, s) => s
        | (n, $NIL) => $NIL
        | (n, $CONS (x, s)) => force ($ drop' (n-1, s))
    in drop' (n', s')

(* dropB の定義から lazy を展開 *)
fun dropB (n', s') =
    let fun drop' (n', s') = case (n', s') of
        | (0, s) => s
        | (n, $NIL) => $NIL
        | (n, $CONS (x, s)) => drop' (n-1, s)
    in drop' (n', s')

(* 上記、最後の dropA と dropB を見比べて、違いは dropA に force ($~ ) があることだけで、これで結果が等価であることがわかる *)
