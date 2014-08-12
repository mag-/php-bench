import Data.Char          (toUpper)
import Data.List          (delete, sortBy)
import Data.Ord           (compare)
import System.Environment (getArgs)

import qualified Data.ByteString.Char8 as BS

match :: String -> String -> Bool
match []   _      = False
match _    []     = True
match desk (w:ws) | elem w   desk = match (delete w   desk) ws
                  | elem '*' desk = match (delete '*' desk) ws
                  | otherwise     = False

search :: String -> [BS.ByteString] -> [BS.ByteString]
search desk words = filter (match desk . BS.unpack) words

prettyPrint :: [BS.ByteString] -> IO ()
prettyPrint words = mapM_ BS.putStrLn $ sortBy compareLength words
    where compareLength s1 s2 = compare (BS.length s1) (BS.length s2)

main = do
    args  <- getArgs
    words <- BS.readFile "ODS6.txt"

    let dictionary = BS.lines words
        firstArg   = if length args == 1 then args !! 0
                                         else error "One parameter needed"
        results    = search (map toUpper firstArg) dictionary

    prettyPrint results

