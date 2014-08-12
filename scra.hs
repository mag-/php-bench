import Data.Char          (toUpper)
import Data.List          (delete, sortBy)
import Data.Ord           (compare)
import System.Environment (getArgs)

match :: String -> String -> Bool
match []   _      = False
match _    []     = True
match desk (w:ws) | elem w   desk = match (delete w   desk) ws
                  | elem '*' desk = match (delete '*' desk) ws
                  | otherwise     = False

search :: String -> [String] -> [String]
search = filter . match

prettyPrint :: [String] -> IO ()
prettyPrint words = mapM_ putStrLn $ sortBy compareLength words
    where compareLength s1 s2 = compare (length s1) (length s2)

main = do
    args  <- getArgs
    words <- readFile "ODS6.txt"

    let dictionary = lines words
        firstArg   = if length args == 1 then args !! 0
                                         else error "One parameter needed"
        results    = search (map toUpper firstArg) dictionary

    prettyPrint results

