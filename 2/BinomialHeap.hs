module BinomialHeap (BinomialHeap) where

import Heap

data Tree a = NODE a [Tree a]
newtype BinomialHeap a = BH [(Int, Tree a)]

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


--h1 = insert 5 BH []

