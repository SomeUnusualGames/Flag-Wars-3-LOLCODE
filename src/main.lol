HAI 1.4
CAN HAS RAYLIB?
CAN HAS MATH?

BTW INCLUDE "utils.lol" PLS
BTW INCLUDE "bullet.lol" PLS
BTW INCLUDE "player.lol" PLS
BTW INCLUDE "block.lol" PLS
BTW INCLUDE "star.lol" PLS

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