-- Spanish naming grid for the naming screen.
-- Adds accented vowels and ñ (both cases) plus ¿ ¡ punctuation.
-- Keeps the essential: letters, space, PK/MN markers, basic punctuation.
-- Removes rarely-used chars (×, ♂, ♀, :, ;, [, ]) to make room.
-- Every glyph here is registered by lang/charmap.lua on the localized
-- font page, so each cell renders as a single character.
return {
  upper = {
    { "A", "B", "C", "D", "E", "F", "G", "H", "I" },
    { "J", "K", "L", "M", "N", "O", "P", "Q", "R" },
    { "S", "T", "U", "V", "W", "X", "Y", "Z", " " },
    { "Á", "É", "Í", "Ó", "Ú", "Ñ", "Ü", "(", ")" },
    { "-", "?", "!", "¿", "¡", "/", ".", ",", "ED" },
    { "lower case" },
  },
  lower = {
    { "a", "b", "c", "d", "e", "f", "g", "h", "i" },
    { "j", "k", "l", "m", "n", "o", "p", "q", "r" },
    { "s", "t", "u", "v", "w", "x", "y", "z", " " },
    { "á", "é", "í", "ó", "ú", "ñ", "ü", "(", ")" },
    { "-", "?", "!", "¿", "¡", "/", ".", ",", "ED" },
    { "UPPER CASE" },
  },
}
