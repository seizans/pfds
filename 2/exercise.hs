
suffixes :: [a] -> [[a]]
suffixes [] = [[]]
suffixes xs@(_:xs') = xs : suffixes xs'

testSuffixes = suffixes [1,2,3,4,5,6,7]
