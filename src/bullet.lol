BTW --- Bullet object ---
O HAI IM Bullet

    I HAS A texture
    I HAS A position ITZ I IZ vector2 YR 0.0 AN YR 0.0 MKAY
    I HAS A originRect ITZ A BUKKIT
    I HAS A origin ITZ A BUKKIT
    I HAS A speed ITZ A NUMBAR
    I HAS A alive ITZ A TROOF

    HOW IZ I initBullet YR texturePath AN YR originRect AN YR origin
        ME'Z texture R I IZ RAYLIB'Z LOADTEXTURE YR texturePath MKAY
        ME'Z alive R FAIL
        ME'Z originRect R originRect
        ME'Z origin R origin
    IF U SAY SO

    HOW IZ I setBullet YR pos AN YR speed
        ME'Z position'Z x R pos'Z x
        ME'Z position'Z y R pos'Z y
        ME'Z speed R speed
        ME'Z alive R WIN
    IF U SAY SO

    HOW IZ I getRect YR destSize
        I HAS A rect ITZ I IZ rectangle YR ME'Z position'Z x AN YR ME'Z position'Z y AN YR destSize'Z x AN YR destSize'Z y MKAY
        FOUND YR rect
    IF U SAY SO

    HOW IZ I updateBullet
        ME'Z position'Z y R SUM OF ME'Z position'Z y AN PRODUKT OF ME'Z speed AN I IZ RAYLIB'Z GETFRAMETIME MKAY
        DIFFRINT ME'Z position'Z y AN BIGGR OF ME'Z position'Z y AN -30
        O RLY?, YA RLY
            ME'Z alive R FAIL
        OIC
    IF U SAY SO

    HOW IZ I drawBullet YR destSize
        I HAS A destRect ITZ I IZ rectangle YR ME'Z position'Z x AN YR ME'Z position'Z y AN YR destSize'Z x AN YR destSize'Z y MKAY
        I IZ drawTexturePro ...
			YR ME'Z texture AN YR ME'Z originRect AN YR destRect ...
			AN YR ME'Z origin AN YR 0.0 AN YR white ...
        MKAY
    IF U SAY SO
KTHX
BTW --- End of Bullet object ---