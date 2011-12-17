
import Control.Applicative
import Data.Maybe

suffixes :: [a] -> [[a]]
suffixes [] = [[]]
suffixes xs@(_:xs') = xs : suffixes xs'

testSuffixes = suffixes [1,2,3,4,5,6,7]


-- Ex 2.3
insertTreeM :: Ord a => a -> Tree a -> Tree a
insertTreeM x t = fromMaybe t $ insertTreeM' t
  where
    insertTreeM' Tip = Just $ Bin x Tip Tip
    insertTreeM' (Bin y l r)
        | x > y = Bin y l <$> insertTreeM' r
        | x < y = do
            l' <- insertTreeM' l
            return $ Bin y l' r
        | otherwise = Nothing

