module Bob exposing (..)

import Regex exposing(contains, regex)


hey : String -> String
hey str =
  if (contains (regex "^[\s]*$") str) then
    "Fine. Be that way!"
  else
    "abc"
