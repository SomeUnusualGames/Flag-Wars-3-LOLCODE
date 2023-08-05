BTW --- Bullet object ---
O HAI IM Bullet
    I HAS A texture
    I HAS A position ITZ I IZ vector2 YR 0.0 AN YR 0.0 MKAY
    I HAS A originRect ITZ A BUKKIT
    I HAS A origin ITZ A BUKKIT
    I HAS A speed ITZ A NUMBAR
    I HAS A alive ITZ A TROOF

    OBTW Do not fall in the trap of doing this:
            ME'Z texture R I IZ RAYLIB ...
            ME'Z alive R FAIL
        if I'm not mistaken, in this way I'm setting the variables on the
        **parent class** and not the **child class**, which means if the
        parent class inherits more than once, the second object will overwrite
        the first one, which obviously is not want we intend.
        With "HAS A" we are creating a new variable within the child class.
    TLDR
    HOW IZ I initBullet YR texturePath AN YR originRect AN YR origin
        ME HAS A texture ITZ I IZ RAYLIB'Z LOADTEXTURE YR texturePath MKAY
        ME HAS A alive ITZ FAIL
        ME HAS A originRect ITZ originRect
        ME HAS A origin ITZ origin
    IF U SAY SO

    HOW IZ I setBullet YR pos AN YR speed
        ME'Z position'Z x R pos'Z x
        ME'Z position'Z y R pos'Z y
        ME'Z speed R speed
        ME'Z alive R WIN
    IF U SAY SO

    HOW IZ I updateBullet
        ME'Z position'Z y R SUM OF ME'Z position'Z y AN PRODUKT OF ME'Z speed AN I IZ RAYLIB'Z GETFRAMETIME MKAY
        EITHER OF ...
        DIFFRINT ME'Z position'Z y AN BIGGR OF ME'Z position'Z y AN -30 AN ...
        BOTH SAEM ME'Z position'Z y AN BIGGR OF ME'Z position'Z y AN 800.0
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

    HOW IZ I getRect YR destSize
        I HAS A rect ITZ I IZ rectangle YR ME'Z position'Z x AN YR ME'Z position'Z y AN YR destSize'Z x AN YR destSize'Z y MKAY
        FOUND YR rect
    IF U SAY SO
KTHX

BTW --- End of Bullet object ---