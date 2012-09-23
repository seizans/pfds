####################################
PFDS chap9 Numerical Representations
####################################

:日時: 2012-09-23
:作者: @seizans

9章イントロ (p115)
==================

List と Nat のアナロジー
------------------------

- Nil と Zero
- Cons と Succ
- tail と pred
- append と plus

BinomialHeap と BinaryNumber のアナロジー
-----------------------------------------

- insert/delete と increment/decrement
- combine と add

Numerical Representation で作るデータ構造
-----------------------------------------

Heap
    increment と addition を効率的にしたいデータ構造

Random-Access List (Flexible Array)
    increment と decrement を効率的にしたいデータ構造

9.1 Positional Number Systems (p116)
------------------------------------

用語・概念の準備

数字表現の順序
    普通の10進表現と逆順で書く
    (例) 13の2進表現 -> 1011

表現セットの定義

:weight w0..wm: b0..bm が持つ重み、後ろが重くなるようにする
:set of digits Di: bi が取り得る値のset、基本的にiによらず固定

"redundunt"
    同じ数値を表す表現が複数ある決め方
    なお、最後の要素は0以外とする

Dense
    全ての位に何かしらの要素を入れる表現

Sparse
    0 の位は省略するような表現

9.2 Binary Numbers
==================

9.2.1 Binary Random-Access Lists
================================

Random-Access List (One-sided flexible array)
    lookup と update を持つ.(cons, head, tail も従来通り持つ)

ここで選ぶ方法
    :使うTree: complete binary leaf tree
    :使う表現: dense representation

- Complete Binary Leaf Tree の要素数は 2^n
- cons は dense の inc から straight forward
    - 違いは繰り上がり後の One を作るときに link という変換が必要なくらい
- tail もだいたい dec から straight forward
- lookup と update は対応する数値処理は無いけど、普通に O(log n) で実装できる
- 特に話すことがあまり無かった...
