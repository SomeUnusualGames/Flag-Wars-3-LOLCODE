HAI 1.4
CAN HAS RAYLIB?
CAN HAS MATH?

BTW INCLUDE "utils.lol" PLS
BTW INCLUDE "bullet.lol" PLS
BTW INCLUDE "player.lol" PLS
BTW INCLUDE "block.lol" PLS
BTW INCLUDE "star.lol" PLS

OBTW
    TODO:
    - Game over screen
    - The less star alive are, the faster they should move
    - Start a new game when all stars are dead
    - Add sounds, music (must add them to raylib bindings first)
TLDR

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
playerBullet IZ initBullet YR ...
    "assets/graphics/a_fk_leaf.png" AN YR ...
    player'Z SOURCE AN YR player'Z ORIGIN AN YR 0.0 AN YR 0.0 AN YR 0.0 ...
MKAY

I HAS A blockList ITZ A BUKKIT
IM IN YR setPosition UPPIN YR n WILE DIFFRINT n AN 6
    blockList HAS A SRS n ITZ LIEK A Block
    I HAS A currentBlock ITZ blockList'Z SRS n
    I HAS A currentRect ITZ I IZ rectangle YR SUM OF 120.0 AN PRODUKT OF 200.0 AN n AN YR 600.0 AN YR 50.0 AN YR 80.0 MKAY
    currentBlock IZ initBlock YR currentRect AN YR 0.0 MKAY
IM OUTTA YR setPosition

I HAS A starList ITZ A BUKKIT
I HAS A starX ITZ 40.0
I HAS A starY ITZ 30.0
I HAS A index ITZ 0
IM IN YR setPosition UPPIN YR n WILE DIFFRINT n AN 99 BTW 9 * 11
    I HAS A row ITZ QUOSHUNT OF n AN 11
    I HAS A col ITZ MOD OF n AN 11
    BOTH SAEM MOD OF SUM OF row AN col AN 2 AN 0
    O RLY?, YA RLY
        starList HAS A SRS index ITZ LIEK A Star
        I HAS A currentStar ITZ starList'Z SRS index
        I HAS A currentRect ITZ I IZ rectangle YR SUM OF starX AN PRODUKT OF col AN 42.0 AN YR SUM OF starY AN PRODUKT OF row AN 40.0 AN YR 39.0 AN YR 37.0 MKAY
        currentStar IZ initStar YR currentRect MKAY
        index R SUM OF index AN 1
    OIC
IM OUTTA YR setPosition

I HAS A enemyBulletSource ITZ I IZ rectangle YR 0.0 AN YR 0.0 AN YR 30.0 AN YR 80.0 MKAY
I HAS A enemyBulletOrigin ITZ I IZ vector2 YR 15.0 AN YR 40.0 MKAY

I HAS A enemyBulletList ITZ A BUKKIT
IM IN YR createEnemyBullet UPPIN YR n WILE DIFFRINT n AN 3
    enemyBulletList HAS A SRS n ITZ LIEK A Bullet
    I HAS A currentEnemyBullet ITZ enemyBulletList'Z SRS n
    I HAS A randTimer ITZ I IZ random YR 8.0 AN YR 15.0 MKAY
    currentEnemyBullet IZ initBullet YR ...
        "assets/graphics/boy.png" AN YR ...
        enemyBulletSource AN YR enemyBulletOrigin ...
        AN YR randTimer AN YR 8.0 AN YR 15.0 ...
    MKAY
IM OUTTA YR createEnemyBullet

IM IN YR mainLoop
    player IZ updatePlayer MKAY
    Star IZ update YR starList MKAY

    playerBullet'Z alive
    O RLY?, YA RLY
        I HAS A destSize ITZ I IZ vector2 YR 20.0 AN YR 20.0 MKAY
        I HAS A playerBulletRect ITZ I IZ playerBullet'Z getRekt YR destSize MKAY

        playerBullet IZ updateBullet MKAY

        Star IZ collision YR starList AN YR playerBulletRect MKAY
        O RLY?, YA RLY
            playerBullet'Z alive R FAIL
        NO WAI
            Block IZ checkCollisionBlock YR blockList AN YR playerBulletRect MKAY
            O RLY?, YA RLY, playerBullet'Z alive R FAIL, OIC
        OIC
    OIC

    BOTH OF I IZ RAYLIB'Z IZKEYPRESSED YR KEYSPACE MKAY AN NOT playerBullet'Z alive
    O RLY?, YA RLY
        playerBullet IZ setBullet YR player'Z position AN YR -265.0 MKAY
    OIC

    IM IN YR enemyShoot UPPIN YR n WILE DIFFRINT n AN 3
        I HAS A currentBullet ITZ enemyBulletList'Z SRS n
        currentBullet'Z alive
        O RLY?, YA RLY,
            I HAS A destSize ITZ I IZ vector2 YR 30.0 AN YR 80.0 MKAY
            I HAS A enemyBulletRect ITZ I IZ currentBullet'Z getRekt YR destSize MKAY
            currentBullet IZ updateBullet MKAY
            BTW Star IZ collision YR starList AN YR playerBulletRect MKAY
            BTW O RLY?, YA RLY, playerBullet'Z alive R FAIL, OIC
            Player IZ collision YR enemyBulletRect MKAY
            O RLY?, YA RLY
                currentBullet'Z alive R FAIL
                VISIBLE "GAME VOER"
                BTW TODO: Game mover message
            NO WAI
                Block IZ checkCollisionBlock YR blockList AN YR enemyBulletRect MKAY
                O RLY?, YA RLY, currentBullet'Z alive R FAIL, OIC
            OIC
        NO WAI
            currentBullet IZ updateTimer YR starList MKAY
        OIC
    IM OUTTA YR enemyShoot

    I IZ RAYLIB'Z BEGINDRAW MKAY
    I IZ RAYLIB'Z BAKGROUND YR 0 AN YR 0 AN YR 0 AN YR 255 MKAY
    I IZ drawBackground MKAY
    I IZ player'Z drawPlayer MKAY

    playerBullet'Z alive
    O RLY?, YA RLY
        I HAS A destSize ITZ I IZ vector2 YR 20.0 AN YR 20.0 MKAY
        playerBullet IZ drawBullet YR destSize AN YR 0.0 MKAY
    OIC

    IM IN YR enemyDraw UPPIN YR n WILE DIFFRINT n AN 3
        I HAS A currentBullet ITZ enemyBulletList'Z SRS n
        currentBullet'Z alive
        O RLY?, YA RLY
            I HAS A destSize ITZ I IZ vector2 YR 30.0 AN YR 80.0 MKAY
            currentBullet IZ drawBullet YR destSize AN YR 0.0 MKAY
        OIC
    IM OUTTA YR enemyDraw

    IM IN YR drawStars UPPIN YR n WILE DIFFRINT n AN 50        
        I HAS A currentStar ITZ starList'Z SRS n
        currentStar IZ draw MKAY
    IM OUTTA YR drawStars

    IM IN YR drawBlocks UPPIN YR n WILE DIFFRINT n AN 6
        I HAS A currentBlock ITZ blockList'Z SRS n
        currentBlock IZ drawBlock MKAY
    IM OUTTA YR drawBlocks

    I IZ RAYLIB'Z STOPDRAW MKAY
    I IZ RAYLIB'Z CLOZE MKAY, O RLY?, YA RLY, GTFO, OIC
IM OUTTA YR mainLoop

I IZ RAYLIB'Z UNLOADTEXTURE YR enemyBullet'Z texture MKAY
I IZ RAYLIB'Z UNLOADTEXTURE YR playerBullet'Z texture MKAY
I IZ RAYLIB'Z UNLOADTEXTURE YR player'Z texture MKAY
I IZ RAYLIB'Z UNLOADTEXTURE YR Block'Z texture MKAY
I IZ RAYLIB'Z UNLOADTEXTURE YR Star'Z texture MKAY
I IZ RAYLIB'Z CLOZEWINDUS MKAY

KTHXBYE