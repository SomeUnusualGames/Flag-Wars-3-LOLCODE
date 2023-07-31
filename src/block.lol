
O HAI IM Block
    I HAS A texture

    I HAS A source ITZ I IZ rectangle YR 0.0 AN YR 0.0 AN YR 50.0 AN YR 80.0 MKAY
    I HAS A ORIGIN ITZ I IZ vector2 YR 25.0 AN YR 40.0 MKAY

    HOW IZ I initBlock
        ME'Z texture R I IZ RAYLIB'Z LOADTEXTURE YR "assets/graphics/syrup.png" MKAY
    IF U SAY SO

    HOW IZ I checkCollisionBlock YR pos AN YR alive AN YR blockStart AN YR bulletRect
        IM IN YR checkBlocks UPPIN YR i WILE DIFFRINT i AN 6
            I HAS A collision ITZ I IZ checkCollisionRecs YR pos'Z SRS i AN YR bulletRect MKAY
            I HAS A isAlive ITZ alive'Z SRS i
            BOTH OF collision AN isAlive
            O RLY?, YA RLY
                BOTH SAEM blockStart'Z SRS i AN 100
                O RLY?, YA RLY
                    alive'Z SRS i R FAIL
                NO WAI
                    blockStart'Z SRS i R SUM OF blockStart'Z SRS i AN 50.0                
                OIC
                FOUND YR WIN
            OIC
        IM OUTTA YR checkBlocks
        FOUND YR FAIL
    IF U SAY SO

    HOW IZ I drawBlock YR pos AN YR alive AN YR startX
        IM IN YR drawBlocks UPPIN YR i WILE DIFFRINT i AN 6
            alive'Z SRS i
            O RLY?, YA RLY
                ME'Z source'Z x R startX'Z SRS i
                I IZ drawTexturePro ...
                    YR ME'Z texture AN YR ME'Z source AN YR pos'Z SRS i ...
                    AN YR ME'Z ORIGIN AN YR -1.570796 AN YR white ...
                MKAY
            OIC
        IM OUTTA YR drawBlocks
    IF U SAY SO
KTHX