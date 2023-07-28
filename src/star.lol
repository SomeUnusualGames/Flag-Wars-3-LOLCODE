BTW --- Star object ---
BTW 39 ticks of movement to move down
O HAI IM Star
    I HAS A texture

	I HAS A SOURCE ITZ I IZ rectangle YR 0.0 AN YR 0.0 AN YR 39.0 AN YR 37.0 MKAY
	I HAS A ORIGIN ITZ I IZ vector2 YR 19.5 AN YR 18.5 MKAY

    I HAS A MAXTIMER ITZ 0.8
    I HAS A timer ITZ 0.8

    HOW IZ I initStar
        ME'Z texture R I IZ RAYLIB'Z LOADTEXTURE YR "assets/graphics/star.png" MKAY
    IF U SAY SO

    HOW IZ I updateStar YR pos
        ME'Z timer R DIFF OF ME'Z timer AN I IZ RAYLIB'Z GETFRAMETIME MKAY
        BOTH SAEM ME'Z timer AN SMALLR OF ME'Z timer AN 0
        O RLY?, YA RLY
            ME'Z timer R ME'Z MAXTIMER
            IM IN YR moveStars UPPIN YR n WILE DIFFRINT n AN 99
                I HAS A row ITZ QUOSHUNT OF n AN 11
                I HAS A col ITZ MOD OF n AN 11
                BOTH SAEM MOD OF SUM OF row AN col AN 2 AN 0
                O RLY?, YA RLY
                    I HAS A pos ITZ starPosition'Z SRS n
                    pos'Z x R SUM OF pos'Z x AN 20.0
                OIC
            IM OUTTA YR moveStars
        OIC
    IF U SAY SO

    HOW IZ I drawStar YR pos
        IM IN YR drawStars UPPIN YR n WILE DIFFRINT n AN 99
            I HAS A row ITZ QUOSHUNT OF n AN 11
            I HAS A col ITZ MOD OF n AN 11
            BOTH SAEM MOD OF SUM OF row AN col AN 2 AN 0
            O RLY?, YA RLY
                I IZ drawTexturePro ...
                    YR ME'Z texture AN YR ME'Z SOURCE AN YR pos'Z SRS n ...
                    AN YR ME'Z ORIGIN AN YR 0.0 AN YR white ...
                MKAY
            OIC
        IM OUTTA YR drawStars
    IF U SAY SO
KTHX

BTW --- End of Star object ---