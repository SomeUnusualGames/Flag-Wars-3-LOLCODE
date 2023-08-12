[Gameplay]

Hello everyone. This is another of a series of videos where I pick up a particular programming language that I never used and make a game with it. This time I'm going to take a look at LOLCODE.

# LOLCODE
LOLCODE is an esoteric programming language deveolped in 2007 by Adam Lindsay. Its syntax is inspired by "lolspeak" which was used in pictures of cats doing random funny things called lolcats. Maybe it's because I'm a cat person but I actually like these dumb memes, they're kind of cute :)

![lolcat1](https://i.imgur.com/yc2THedm.jpg)
![lolcat2](https://i.imgur.com/kOmY5z5m.jpg)
![lolcat3](https://i.imgur.com/ua30iJXm.jpg)

Thanks to the Wayback Machine, I was able to read the 
original LOLCODE website. According to the FAQ, there was never a complete specification of the language, and there were several implementations made by different users with different languages, from Python to PHP and Perl.

![https://i.imgur.com/ft7F8nv.png](https://i.imgur.com/ft7F8nv.png)

## lci: LOLCODE interpreter
The implementation that beat them all is lci. lci is a LOLCODE interpreter made in the C language by Justin Meza at some point in 2007. I have to say, while I'm not a C expert, for an esoteric language this is one of the most well structured C project I've ever seen. It's really easy to navigate and it also includes a Doxyfile to generate documentation.

The 1.2 version of this implementation completed the specifications of LOLCODE with pretty much everything a programming language needs: operators, control flow, functions, input/output...

The 1.3 version added a very powerful feature called BUKKIT, which is like an _array_ that can contain other variables and even functions and other BUKKITs. Since they can contain functions (called FUNKSHUNs) it is possible to define "objects". You can see here that you can use the identifier `ME` to refer to the calling object, which would be like "this" or "self" in other languages. You also have inheritance and even multiple-inheritance, but I really didn't need to use this last feature.

There was a final version 1.4 which added an extra feature to the interpreter: bindings. With this, you can add bindings to almost any C library to LOLCODE. The author provided bindings to libraries like stdio, stdlib, sockets and string. Here is where I added the binding to raylib and was able to make a game with this funny language. I also had to modify a couple of other things, since I'm a dumb Windows user, had to remove some and replace some libraries, but at the end I got it to compile! All of this is documented in a readme.

So, as for the game...

## The game
I split it into 4 parts:
- The player, represented by this leaf
- The "blocks" represented as these bottles
- The enemies
- The bullets

Each of these is a different "object" where I defined all of the methods and functions, and then in the main file create new objects that inherit from those.

### Poor man's preprocessor
Before beginning, I wanted to split the code into different parts, because having everything in the same file was unconfortable. Since the language doesn't have this feature, what I did was to create a script in another esoteric language called Dogescript. All this script does is look for a comment with this specific pattern: `BTW INCLUDE "file.lol" PLS` and put all the contents of that file there. I like to call it poor man's preprocessor.

Now, all of the objects have an `init` method, this is a "constructor" that I have to call manually after creating the object. The variables defined at the top of the object belong to the _parent_ object, and they are **not inherited to the child object**. Note how in the player's `init` method I use `ME'Z` and the variable, this is a way to refer to the variables defined in the parent object, whereas in the bullet object I use `ME HAS A` to **create a variable in the child object**. If the object inherits more than once it's important to do this so the child objects don't use the variables of the parent.

### Player
There isn't much happening in the player code. A method to check for collision, movement and update/draw logic. Take a look here where I check if the player is getting out of bounds: 

```LOLCODE
I HAS A offsetLeft ITZ DIFF OF possibleNewPos AN -50.0
I HAS A offsetRight ITZ SUM OF possibleNewPos AN 50.0
I HAS A leftOnScreen ITZ DIFFRINT offsetLeft AN SMALLR OF offsetLeft AN 60.0
I HAS A rightOnScreen ITZ DIFFRINT offsetRight AN BIGGR OF offsetRight AN 1250.0
BOTH OF leftOnScreen AN rightOnScreen
O RLY?, YA RLY, ME'Z position'Z x R possibleNewPos, OIC
```

The language doesn't have a way to check if a variable is greater than, less than, greater or equal than... but luckily, there's a way to check for equality with `BOTH SAEM` and inequality with `DIFFRINT`, and also to get the biggest number with `BIGGR OF` and smaller with `SMALLR OF`. With these, is easy to imitate the numerical comparison operators:

```LOLCODE
BOTH SAEM <x> AN BIGGR OF <x> AN <y>   BTW x >= y
BOTH SAEM <x> AN SMALLR OF <x> AN <y>  BTW x <= y
DIFFRINT <x> AN SMALLR OF <x> AN <y>   BTW x > y
DIFFRINT <x> AN BIGGR OF <x> AN <y>    BTW x < y
```
This way I can easily check if the player is getting offscreen.

In the main script, the object is created like this: `I HAS A player ITZ LIEK A Player` and then initialize it by calling `player IZ initPlayer MKAY`

### Blocks (bottles of syrup that protect the player)

The "blocks" as I call them, are represented by these bottles of syrup that protects the player from the attacks. They are created inside an array called `blockList`.

```LOLCODE
I HAS A blockList ITZ A BUKKIT
IM IN YR setPosition UPPIN YR n WILE DIFFRINT n AN 6
    blockList HAS A SRS n ITZ LIEK A Block
    I HAS A currentBlock ITZ blockList'Z SRS n
    I HAS A currentRect ITZ I IZ rectangle YR SUM OF 120.0 AN PRODUKT OF 200.0 AN n AN YR 600.0 AN YR 50.0 AN YR 80.0 MKAY
    currentBlock IZ initBlock YR currentRect AN YR 0.0 MKAY
IM OUTTA YR setPosition
```

This is how you loop in LOLCODE. `setPosition` is the label of this loop, `UPPIN YR` means the variable increases starting at 0, and the exit condition is self explanatory: `WILE DIFFRINT n AN 6`.

The interesting part of this object is the `checkCollisionBlock` method. First, it does a bit of calculation to get the real hitbox (because the texture is rotated), check if a given rectangle collides with it, and then decides what to return depending on the state of the `startX` variable: 0 if the block got destroyed, 1 if the block is still alive but damaged and -1 if there's no collision. This is done this way because, in the main script, depending on the number returned, a different sound is played.

### The enemies

The "invaders" are represented as the 50 stars. Just like the blocks, they are created inside a BUKKIT called `starList`:

```LOLCODE
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
```
This part of the code is a bit longer because of the way the stars are in the flag.

The stars move all at the same time to a specific direction, then they move down and to the opposite direction, how do they know when to move down?

What I did was to save the position of the "leftmost" and "rightmost" stars, which are set as the first one and the fifth. When the leftmost or the rightmost star dies, we loop to the stars next to it until we found one that is alive. Because of the disposition of the stars, sometimes some stars move offscreen or they move down when they didn't reach the edge of the screen, but it's okay, I can live with that...

The `Star` object also counts the stars alive in order to increase the speed at different points the less stars alive are. This is done with LOLCODE's `switch`:

```LOLCODE
Star'Z aliveCount, WTF?
    OMG 25, Star'Z MAXTIMER R 0.4, GTFO
    OMG 10, Star'Z MAXTIMER R 0.3, GTFO
    OMG 2, Star'Z MAXTIMER R 0.13, GTFO
    OMG 1, Star'Z MAXTIMER R 0.08, GTFO
    OMGWTF, GTFO
OIC
```

Here, `MAXTIMER` is the timer that controls how fast the stars should move. `OMG` are the different cases, and `GTFO` is used as a `break`. The comma is used as a "soft" new line, since all cases are a single line, we don't have to write the `OMG` and `GTFO` in different lines. `OMGWTF` is the default case.

### The bullets

Finally we have the bullets, represented as a small leaf for the player and a nuke for the stars. These two share the same parent object since they do the same, but changing where they move and what they collide with. The stars' bullet objects are alse stored in an array, in a similar way than the other objects:

```LOLCODE
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
```
As you can see here, every bullet has randomized timers, which are used to check when the nuke should be fired. So, how do we get random numbers? One possible solution could be to use `rand` provided by `stdlib`, which LOLCODE already has bindings for. What I did instead was to use the same method as this project called [LOLTracer](https://github.com/LoganKelly/LOLTracer), which is a raytracer made in pure LOLCODE, made by Logan Kelly. He actually implemented all of the necessary functions in LOLCODE to make a simple raytracer, one of them was an implementation of the `rand()` function. I used it with a function that returns a number between a and b.

# Conclusions

One of the main criticisms of LOLCODE is that is "not esoteric enough." It could be considered a conventional programming language that just happens to have a quirky syntax. In my opinion, if the language designer never meant for people to take it seriously, it should be considered an esolang. I like to see this language as if COBOL was made in caveman English rather than "cat" English.

Anyway, I actually liked using this language. I read somewhere that when bilingual people talk in their non-native language, there's like a "switch" in their brain; at some point I felt kind of the same when making this game, I wrote `ME HAS A alive ITZ WIN` and my brain didn't see anything wrong with this other than "define a variable called alive in the object and set it to true."

Thank you for watching/reading!