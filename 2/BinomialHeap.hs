module BinomialHeap (BinomialHeap) where

import Heap

data Tree a = NODE a [Tree a]
  deriving Show
newtype BinomialHeap a = BH [(Int, Tree a)]
  deriving Show

rank :: (Int, Tree a) -> Int
rank (r, _) = r

tree :: (Int, Tree a) -> Tree a
tree (_, t) = t

root :: (Int, Tree a) -> a
root (_, (NODE x _)) = x

link :: Ord a => (Int, Tree a) -> (Int, Tree a) -> (Int, Tree a)
link (r, t1@(NODE x1 c1)) (_, t2@(NODE x2 c2))
  | x1 <= x2  = (r + 1, NODE x1 (t2:c1))
  | otherwise = (r + 1, NODE x2 (t1:c2))

insTree :: Ord a => (Int, Tree a) -> [(Int, Tree a)] -> [(Int, Tree a)]
insTree t [] = [t]
insTree t ts@(t':ts')
  | rank t < rank t' = t : ts
  | otherwise = insTree (link t t') ts'


mrg :: Ord a => [(Int, Tree a)] -> [(Int, Tree a)] -> [(Int, Tree a)]
mrg ts1 [] = ts1
mrg [] ts2 = ts2
mrg ts1@(t1:ts1') ts2@(t2:ts2')
  | rank t1 < rank t2 = t1 : mrg ts1' ts2
  | rank t2 < rank t1 = t2 : mrg ts1 ts2'
  | otherwise = insTree (link t1 t2) (mrg ts1' ts2')


removeMinTree :: Ord a => [(Int, Tree a)] -> ((Int, Tree a), [(Int, Tree a)])
removeMinTree [] = error "empty heap"
removeMinTree [t] = (t, [])
removeMinTree (t : ts)
  | root t < root t' = (t, ts)
  | otherwise = (t', t : ts')
  where
    (t', ts') = removeMinTree ts


instance Heap BinomialHeap where
  empty = BH []
  isEmpty (BH ts) = null ts
  insert x (BH ts) = BH (insTree (0, (NODE x [])) ts)
  merge (BH ts1) (BH ts2) = BH (mrg ts1 ts2)
  findMin (BH ts) = root t
    where (t, _) = removeMinTree ts
  deleteMin (BH ts) = BH (mrg (zip [0..] (reverse ts1)) ts2)
    where ((_, NODE x ts1), ts2) = removeMinTree ts


h1 = insert 5 (BH [])
h2 = insert 6 h1
h3 = insert 9 h2
h4 = insert 8 h3
h5 = insert 1 h4
h6 = insert 2 h5
h7 = insert 13 h6
h8 = insert 20 h7
h9 = insert 3 h8
h10 = insert 7 h9
h11 = insert 0 h10

h12 = findMin h11
h13 = deleteMin h11
h14 = findMin h13
h15 = deleteMin h13
h16 = findMin h15
h17 = deleteMin h15
h18 = findMin h17
h19 = deleteMin h17
h20 = findMin h19
h21 = deleteMin h19
h22 = findMin h21
h23 = deleteMin h21

h24 = merge h9 h21
h25 = findMin h24
h26 = deleteMin h24
h27 = findMin h26
h28 = deleteMin h26
h29 = findMin h28
h30 = deleteMin h28

