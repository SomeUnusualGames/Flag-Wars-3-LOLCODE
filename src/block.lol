
O HAI IM Block
    I HAS A texture

    I HAS A SOURCE ITZ I IZ rectangle YR 0.0 AN YR 0.0 AN YR 50.0 AN YR 80.0 MKAY
    I HAS A ORIGIN ITZ I IZ vector2 YR 25.0 AN YR 40.0 MKAY

    HOW IZ I initBlock
        ME'Z texture R I IZ RAYLIB'Z LOADTEXTURE YR "assets/graphics/syrup.png" MKAY
    IF U SAY SO

    HOW IZ I drawBlock YR pos
        IM IN YR drawBlocks UPPIN YR i WILE DIFFRINT i AN 6
            I IZ drawTexturePro ...
                YR ME'Z texture AN YR ME'Z SOURCE AN YR pos'Z SRS i ...
                AN YR ME'Z ORIGIN AN YR -1.570796 AN YR white ...
            MKAY
        IM OUTTA YR drawBlocks
    IF U SAY SO
KTHX