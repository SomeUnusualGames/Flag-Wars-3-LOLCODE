BTW --- Star object ---
BTW 39 ticks of movement to move down
O HAI IM Star
    I HAS A texture

	I HAS A SOURCE ITZ I IZ rectangle YR 0.0 AN YR 0.0 AN YR 39.0 AN YR 37.0 MKAY
	I HAS A ORIGIN ITZ I IZ vector2 YR 19.5 AN YR 18.5 MKAY

    I HAS A MAXTIMER ITZ 0.6
    I HAS A timer ITZ 0.6
    I HAS A leftMost ITZ 0
    I HAS A rightMost ITZ 5
    I HAS A direction ITZ 20.0

    HOW IZ I initStar
        ME'Z texture R I IZ RAYLIB'Z LOADTEXTURE YR "assets/graphics/star.png" MKAY
    IF U SAY SO

    HOW IZ I checkCollision YR pos AN YR alive AN YR bulletRect
        IM IN YR checkStars UPPIN YR n WILE DIFFRINT n AN 50
            I HAS A collision ITZ I IZ checkCollisionRecs YR pos'Z SRS n AN YR bulletRect MKAY
            I HAS A isAlive ITZ alive'Z SRS n
            BOTH OF collision AN isAlive
            O RLY?, YA RLY
                alive'Z SRS n R FAIL
                BOTH SAEM n AN ME'Z leftMost
                O RLY?, YA RLY
                    IM IN YR getNewLeft UPPIN YR i WILE DIFFRINT i AN 50
                        I HAS A currentIndex ITZ SUM OF i AN n
                        alive'Z SRS currentIndex, O RLY?, YA RLY
                            ME'Z leftMost R currentIndex
                            VISIBLE "new leftmost found"
                            VISIBLE ME'Z leftMost
                            FOUND YR WIN
                        OIC
                    IM OUTTA YR getNewLeft
                    BTW No new leftMost star found... player won? Maybe check if leftMost = rightMost
                MEBBE BOTH SAEM n AN ME'Z rightMost
                    IM IN YR getNewLeft NERFIN YR i WILE DIFFRINT i AN -50
                        I HAS A currentIndex ITZ SUM OF i AN n
                        alive'Z SRS currentIndex, O RLY?, YA RLY
                            ME'Z rightMost R currentIndex
                            VISIBLE "new rightmost found"
                            VISIBLE ME'Z rightMost
                            FOUND YR WIN
                        OIC
                    IM OUTTA YR getNewLeft
                    BTW No new rightMost star found... player won? Maybe check if leftMost = rightMost
                OIC
                FOUND YR WIN
            OIC
        IM OUTTA YR checkStars
        FOUND YR FAIL
    IF U SAY SO

    HOW IZ I updateStar YR pos AN YR alive
        I HAS A moveDown ITZ FAIL
        ME'Z timer R DIFF OF ME'Z timer AN I IZ RAYLIB'Z GETFRAMETIME MKAY
        BOTH SAEM ME'Z timer AN SMALLR OF ME'Z timer AN 0
        O RLY?, YA RLY
            ME'Z timer R ME'Z MAXTIMER
            I HAS A posToCheck ITZ A BUKKIT
            DIFFRINT ME'Z direction AN SMALLR OF ME'Z direction AN 0
            O RLY?, YA RLY
                posToCheck R pos'Z SRS ME'Z rightMost
                BTW 1220 - (rightMost-5) * (-20) | rightMost goes from 5 to 0 -> results in 0, 20, 40... 100 -> 1220, 1200...
                I HAS A starLimit ITZ DIFF OF 1220 AN PRODUKT OF DIFF OF ME'Z rightMost AN 5 AN -20
                BOTH SAEM posToCheck'Z x AN BIGGR OF posToCheck'Z x AN starLimit
                O RLY?, YA RLY
                    moveDown R WIN
                    ME'Z direction R PRODUKT OF -1 AN ME'Z direction
                OIC
            NO WAI
                posToCheck R pos'Z SRS ME'Z leftMost
                I HAS A starLimit ITZ SUM OF 40 AN PRODUKT OF ME'Z leftMost AN 20
                BOTH SAEM posToCheck'Z x AN SMALLR OF posToCheck'Z x AN starLimit
                O RLY?, YA RLY
                    moveDown R WIN
                    ME'Z direction R PRODUKT OF -1 AN ME'Z direction
                OIC
            OIC
            IM IN YR moveStars UPPIN YR n WILE DIFFRINT n AN 50
                I HAS A pos ITZ starPosition'Z SRS n
                alive'Z SRS n, O RLY?, YA RLY
                    moveDown, O RLY?, YA RLY
                        pos'Z y R SUM OF pos'Z y AN I IZ MATH'Z ABS YR ME'Z direction MKAY
                    NO WAI
                        pos'Z x R SUM OF pos'Z x AN ME'Z direction
                    OIC
                OIC
            IM OUTTA YR moveStars
        OIC
    IF U SAY SO

    HOW IZ I drawStar YR pos AN YR alive
        IM IN YR drawStars UPPIN YR n WILE DIFFRINT n AN 50
            alive'Z SRS n, O RLY?, YA RLY
                I IZ drawTexturePro ...
                    YR ME'Z texture AN YR ME'Z SOURCE AN YR pos'Z SRS n ...
                    AN YR ME'Z ORIGIN AN YR 0.0 AN YR white ...
                MKAY
            OIC
        IM OUTTA YR drawStars
    IF U SAY SO
KTHX

BTW --- End of Star object ---