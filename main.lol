HAI 1.4
CAN HAS RAYLIB?
CAN HAS MATH?

BTW Utils functions

BTW --- Color creator ---
HOW IZ I color YR red AN YR green AN YR blue AN YR alpha
	I HAS A array ITZ A BUKKIT
	array HAS A r ITZ red
	array HAS A g ITZ green
	array HAS A b ITZ blue
	array HAS A a ITZ alpha
	FOUND YR array
IF U SAY SO

I HAS A white ITZ I IZ color YR 255 AN YR 255 AN YR 255 AN YR 255 MKAY
I HAS A yellow ITZ I IZ color YR 252 AN YR 221 AN YR 9 AN YR 255 MKAY
I HAS A red ITZ I IZ color YR 218 AN YR 18 AN YR 26 AN YR 255 MKAY
I HAS A ameriRed ITZ I IZ color YR 178 AN YR 34 AN YR 52 AN YR 255 MKAY
I HAS A ameriBlue ITZ I IZ color YR 60 AN YR 59 AN YR 110 AN YR 255 MKAY
BTW --- End of Color creator ---

BTW --- Vector2 creator ---
HOW IZ I vector2 YR posx AN YR posy
	I HAS A vec2 ITZ A BUKKIT
	vec2 HAS A x ITZ posx
	vec2 HAS A y ITZ posy
	FOUND YR vec2
IF U SAY SO
BTW --- End of Vector2 creator ---

BTW --- Rectangle creator ---
HOW IZ I rectangle YR posx AN YR posy AN YR w AN YR h
	I HAS A rect ITZ A BUKKIT
	rect HAS A x ITZ posx
	rect HAS A y ITZ posy
	rect HAS A width ITZ w
	rect HAS A height ITZ h
	FOUND YR rect	
IF U SAY SO
BTW --- End of Rectangle creator ---

BTW Define some keys
I HAS A KEYRIGHT ITZ 262
I HAS A KEYLEFT ITZ 263
I HAS A KEYDOWN ITZ 264
I HAS A KEYUP ITZ 265
I HAS A KEYW ITZ 87
I HAS A KEYA ITZ 65
I HAS A KEYS ITZ 83
I HAS A KEYD ITZ 68
I HAS A KEYZ ITZ 90
I HAS A KEYSPACE ITZ 32

BTW DrawTexturePro wrapper
HOW IZ I drawTexturePro YR texture AN YR source AN YR dest AN YR origin AN YR rotation AN YR color	
	I IZ RAYLIB'Z DRAWTEXTUREPRO ...
		YR texture ...
		AN YR source'Z x AN YR source'Z y AN YR source'Z width AN YR source'Z height ...
		AN YR dest'Z x AN YR dest'Z y AN YR dest'Z width AN YR dest'Z height ...
		AN YR origin'Z x AN YR origin'Z y ...
		AN YR PRODUKT OF rotation AN QUOSHUNT OF 180.0 AN 3.141592 ...
		AN YR color'Z r AN YR color'Z g AN YR color'Z b AN YR color'Z a ...
	MKAY
IF U SAY SO

HOW IZ I checkCollisionRecs YR rec1 AN YR rec2
    I HAS A x1 ITZ DIFFRINT rec1'Z x AN BIGGR OF rec1'Z x AN SUM OF rec2'Z x AN rec2'Z width
    I HAS A x2 ITZ DIFFRINT rec2'Z x AN BIGGR OF rec2'Z x AN SUM OF rec1'Z x AN rec1'Z width
    I HAS A y1 ITZ DIFFRINT rec1'Z y AN BIGGR OF rec1'Z y AN SUM OF rec2'Z y AN rec2'Z height
    I HAS A y2 ITZ DIFFRINT rec2'Z y AN BIGGR OF rec2'Z y AN SUM OF rec1'Z y AN rec1'Z height
    FOUND YR ALL OF x1 AN x2 AN y1 AN y2 MKAY
IF U SAY SO

OBTW
BOTH SAEM <x> AN BIGGR OF <x> AN <y>   BTW x >= y
BOTH SAEM <x> AN SMALLR OF <x> AN <y>  BTW x <= y
DIFFRINT <x> AN SMALLR OF <x> AN <y>   BTW x > y
DIFFRINT <x> AN BIGGR OF <x> AN <y>    BTW x < y
TLDR

BTW --- End of utils functions ---
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
BTW --- Player object ---
O HAI IM Player
	I HAS A texture
	I HAS A hitbox
	I HAS A position
	I HAS A lifes ITZ A NUMBR

	I HAS A SOURCE ITZ I IZ rectangle YR 0.0 AN YR 0.0 AN YR 231.0 AN YR 240.0 MKAY
	I HAS A ORIGIN ITZ I IZ vector2 YR 0.0 AN YR 0.0 MKAY

	HOW IZ I initPlayer
		ME'Z texture R I IZ RAYLIB'Z LOADTEXTURE YR "assets/graphics/a_fk_leaf.png" MKAY
		ME'Z position R I IZ rectangle YR 600.0 AN YR 660.0 AN YR 50.0 AN YR 50.0 MKAY
		ME'Z lifes R 3
		ME'Z hitbox R I IZ rectangle YR 100.0 AN YR 660.0 AN YR 20.0 AN YR 20.0 MKAY
	IF U SAY SO

	HOW IZ I movement
		I HAS A movement ITZ 0.0
		I HAS A possibleNewPos ITZ ME'Z position'Z x

        BTW Check key pressed
		EITHER OF I IZ RAYLIB'Z IZKEYDOWN YR KEYLEFT MKAY AN I IZ RAYLIB'Z IZKEYDOWN YR KEYA MKAY
		O RLY?, YA RLY
			movement R PRODUKT OF -1.0 AN 200.0
		MEBBE EITHER OF I IZ RAYLIB'Z IZKEYDOWN YR KEYRIGHT MKAY AN I IZ RAYLIB'Z IZKEYDOWN YR KEYD MKAY
			movement R 200.0
		OIC

        possibleNewPos R SUM OF ME'Z position'Z x AN PRODUKT OF movement AN I IZ RAYLIB'Z GETFRAMETIME MKAY

		BTW Check the window limits
		I HAS A offsetLeft ITZ DIFF OF possibleNewPos AN -50.0
		I HAS A offsetRight ITZ SUM OF possibleNewPos AN 50.0
		I HAS A leftOnScreen ITZ DIFFRINT offsetLeft AN SMALLR OF offsetLeft AN 60.0
		I HAS A rightOnScreen ITZ DIFFRINT offsetRight AN BIGGR OF offsetRight AN 1250.0

		BOTH OF leftOnScreen AN rightOnScreen
		O RLY?, YA RLY, ME'Z position'Z x R possibleNewPos, OIC
	IF U SAY SO

	HOW IZ I updatePlayer
		ME IZ movement MKAY
		ME'Z hitbox'Z x R SUM OF ME'Z position'Z x AN 15
		ME'Z hitbox'Z y R SUM OF ME'Z position'Z y AN 15
	IF U SAY SO

	HOW IZ I drawPlayer
		I IZ drawTexturePro ...
			YR ME'Z texture AN YR ME'Z SOURCE AN YR ME'Z position ...
			AN YR ME'Z ORIGIN AN YR 0.0 AN YR white ...
		MKAY
        BTW I IZ RAYLIB'Z DRAWRECTANGLEREC YR ME'Z hitbox'Z x AN YR ME'Z hitbox'Z y AN YR ME'Z hitbox'Z width AN YR ME'Z hitbox'Z height AN YR 255 AN YR 255 AN YR 255 AN YR 255 MKAY
	IF U SAY SO
KTHX
BTW --- End of Player object ---

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
                BOTH SAEM posToCheck'Z x AN 1220
                O RLY?, YA RLY
                    moveDown R WIN
                    ME'Z direction R PRODUKT OF -1 AN ME'Z direction
                OIC
            NO WAI
                posToCheck R pos'Z SRS ME'Z leftMost
                BOTH SAEM posToCheck'Z x AN 40
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

HOW IZ I drawBackground
    I HAS A rectStripe ITZ I IZ rectangle YR 0.0 AN YR 0.0 AN YR 1260.0 AN YR 55.0 MKAY
    IM IN YR stripes UPPIN YR n WILE DIFFRINT n AN 13
        BOTH SAEM MOD OF n AN 2 AN 0
        O RLY?, YA RLY
            I IZ RAYLIB'Z DRAWRECTANGLEREC YR ...
                rectStripe'Z x AN YR rectStripe'Z y AN YR ...
                rectStripe'Z width AN YR rectStripe'Z height AN YR ...
                ameriRed'Z r AN YR ameriRed'Z g AN YR ameriRed'Z b AN YR ...
                ameriRed'Z a ...
            MKAY
        NO WAI
            I IZ RAYLIB'Z DRAWRECTANGLEREC YR ...
                rectStripe'Z x AN YR rectStripe'Z y AN YR ...
                rectStripe'Z width AN YR rectStripe'Z height AN YR ...
                white'Z r AN YR white'Z g AN YR white'Z b AN YR white'Z a ...
            MKAY
        OIC
        rectStripe'Z y R SUM OF rectStripe'Z y AN 55
    IM OUTTA YR stripes
    I IZ RAYLIB'Z DRAWRECTANGLEREC YR 0.0 AN YR 0.0 AN YR 500.0 AN YR 385.0 AN YR 60 AN YR 59 AN YR 110 AN YR 255 MKAY
IF U SAY SO

I IZ RAYLIB'Z WINDUS YR 1260 AN YR 720 AN YR "Flag Wars 3: America Invaders" MKAY
I IZ RAYLIB'Z FPS YR 60 MKAY

I HAS A player ITZ LIEK A Player
player IZ initPlayer MKAY

I HAS A playerBullet ITZ LIEK A Bullet
I IZ playerBullet'Z initBullet YR ...
    "assets/graphics/a_fk_leaf.png" AN YR ...
    player'Z SOURCE AN YR player'Z ORIGIN ...
MKAY

I HAS A block ITZ LIEK A Block
block IZ initBlock MKAY
I HAS A blockPosition ITZ A BUKKIT
IM IN YR setPosition UPPIN YR n WILE DIFFRINT n AN 6
    blockPosition HAS A SRS n ITZ I IZ rectangle YR SUM OF 120.0 AN PRODUKT OF 200.0 AN n AN YR 600.0 AN YR 50.0 AN YR 80.0 MKAY
IM OUTTA YR setPosition

I HAS A star ITZ LIEK A Star
star IZ initStar MKAY
I HAS A starAlive ITZ A BUKKIT
I HAS A starPosition ITZ A BUKKIT
I HAS A starX ITZ 40.0
I HAS A starY ITZ 30.0
I HAS A starIndex ITZ 0
I HAS A index ITZ 0
IM IN YR setPosition UPPIN YR n WILE DIFFRINT n AN 99 BTW 9 * 11
    I HAS A row ITZ QUOSHUNT OF n AN 11
    I HAS A col ITZ MOD OF n AN 11
    BOTH SAEM MOD OF SUM OF row AN col AN 2 AN 0
    O RLY?, YA RLY
        starPosition HAS A SRS index ITZ I IZ rectangle YR SUM OF starX AN PRODUKT OF col AN 42.0 AN YR SUM OF starY AN PRODUKT OF row AN 40.0 AN YR 39.0 AN YR 37.0 MKAY
        starAlive HAS A SRS index ITZ WIN
        index R SUM OF index AN 1
    OIC
IM OUTTA YR setPosition

IM IN YR mainLoop
    player IZ updatePlayer MKAY
    I IZ star'Z updateStar YR starPosition AN YR starAlive MKAY

    playerBullet'Z alive
    O RLY?, YA RLY
        I HAS A destSize ITZ I IZ vector2 YR 20.0 AN YR 20.0 MKAY
        I HAS A playerBulletRect ITZ playerBullet IZ getRect YR destSize MKAY
        playerBullet IZ updateBullet MKAY
        star IZ checkCollision YR starPosition AN YR starAlive AN YR playerBulletRect MKAY
        O RLY?, YA RLY
            playerBullet'Z alive R FAIL
        OIC
    OIC

    BOTH OF I IZ RAYLIB'Z IZKEYPRESSED YR KEYSPACE MKAY AN NOT playerBullet'Z alive
    O RLY?, YA RLY
        playerBullet IZ setBullet YR player'Z position AN YR -200.0 MKAY
    OIC

    I IZ RAYLIB'Z BEGINDRAW MKAY
    I IZ RAYLIB'Z BAKGROUND YR 0 AN YR 0 AN YR 0 AN YR 255 MKAY
    I IZ drawBackground MKAY
    I IZ player'Z drawPlayer MKAY

    playerBullet'Z alive
    O RLY?, YA RLY
        I HAS A destSize ITZ I IZ vector2 YR 20.0 AN YR 20.0 MKAY
        I IZ playerBullet'Z drawBullet YR destSize MKAY
    OIC

    I IZ block'Z drawBlock YR blockPosition MKAY
    I IZ star'Z drawStar YR starPosition AN YR starAlive MKAY
    I IZ RAYLIB'Z STOPDRAW MKAY
    I IZ RAYLIB'Z CLOZE MKAY, O RLY?, YA RLY, GTFO, OIC
IM OUTTA YR mainLoop

I IZ RAYLIB'Z UNLOADTEXTURE YR playerBullet'Z texture MKAY
I IZ RAYLIB'Z UNLOADTEXTURE YR player'Z texture MKAY
I IZ RAYLIB'Z UNLOADTEXTURE YR player'Z texture MKAY
I IZ RAYLIB'Z UNLOADTEXTURE YR star'Z texture MKAY
I IZ RAYLIB'Z CLOZEWINDUS MKAY

KTHXBYE