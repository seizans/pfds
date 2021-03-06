============================================================
PFDS 6.4.1
============================================================
:Author: @seizans
:Date: 2012/4/14

6.4 The Phisicist's Method
==========================
- (ならし計算量) = (complete cost) - (ポテンシャル変化量) :P69中程
    - (complete cost) = (unshared cost) + (shared cost) なので・・・
    - ⇔ (ならし計算量) = (unshared cost) + ( (shared cost 変化量) - (ポテンシャル変化量) )
- complete cost: 遅延評価を含む処理でも、正確評価だと考えた場合の計算量
    - unshared cost がいつも定数なので、結局 shared cost とほぼイコール
- 発想は、コストを支払うタイミングを修正している感じ (P61第2パラグラフ)
    - Create : Pay off : Execute の3つの瞬間がある
    - Execute の時に払っていたものを Create の時に払う構造にした

よくわかっていないこと
----------------------
- (shared cost) = (debtが増加し得る量) らしい?? (P69の中程)
- (ポテンシャル変化量) は (debt増加量) を意味するらしい(P69中程)
- (ならし計算量) = (unshared cost) + (支払ったdebt) らしい(P69中程、第二パラグラフ最後)
- 物理学者メソッドは銀行家メソッドより弱いがシンプルらしい
- 物理学者メソッドは遅延が incremental でも嬉しくなく、monolithic のときに使うらしい
- だけど結局 6.4.1 の解析では shared も debt も出てこない・・・(ならし計算量と Complete cost と potential だけ)
- など

6.4.1 Binomial Heaps
============================================================

改良の動機
----------
- insert の時間を Persistent な使い方でも O(1) にしたい
    - 5.3 でならし計算量を O(1) にしたが、Persistent な使い方だと O(log n)

insert
``````
- 普通だと O(log n)
- 5章のPhisicist's Method で O(1)
- しかし最悪の場合を何回も使う場合は O(log n) かかる
    - 最悪の場合: binary表現が 1111 のようなとき
- 単純に lazy にすることで解決する話

コードの修正点
--------------
- type Heap = Tree list から type Heap = Tree list susp へ: これがメイン
- Heap を引数に取る場合の ts が $ts になっている
- lazy が付いたもの: insert, merge, deleteMin

ならし計算量の解析
------------------

ポテンシャルの定義
``````````````````
binary表現にした場合の 0 の数をポテンシャルとする
    - 注意: 5.3 では 1 の数をポテンシャルにしていたが今は逆
    - saving と debt の違いを反映しているとか

insert
``````
- insert から呼ぶ link の回数を k とする ( = 最下位桁に並ぶ0の個数)
- すると insert の complete cost は k + 1
- 一方、ポテンシャル変化量は k - 1 (最初のk桁が0になった)
- よって、ならし計算量は (k + 1) - (k - 1) = 2 = 0(1)

removeMinTree
`````````````
- 実装は同じなので complete cost は log n
- ポテンシャル変化量は -log n ~ 0
- よって、ならし計算量は log n から 2 log n の間であり O(log n)

findMin
```````
- removeMinTree をやってから root をやる
- root は 1 しかかからない、removeMinTree は上記の通り
- よってならしは O(log n)

merge
`````
- complete cost は mrg の計算量
- mrg は前と同じ実装で、計算量は O(log n)
- mrg のポテンシャル変化量は - log n から log n の間
    - 前者は 1000 + 111 など、後者は 1111 + 1 など
- よって、ならし計算量はたかだか O(log n)

deleteMin
`````````
- removeMinTree やってから $mrg をやる
- どちらのならし計算量も O(log n)
- よって deleteMin のならし計算量も O(log n)
