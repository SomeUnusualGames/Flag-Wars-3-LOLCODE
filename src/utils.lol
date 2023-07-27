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

HOW IZ I getIndex YR i
	i, WTF?
		OMG 0, FOUND YR "zero"
		OMG 1, FOUND YR "one"
		OMG 2, FOUND YR "two"
		OMG 3, FOUND YR "three"
		OMG 4, FOUND YR "four"
		OMG 5, FOUND YR "five"
		OMG 6, FOUND YR "six"
		OMG 7, FOUND YR "seven"
		OMG 8, FOUND YR "eight"
		OMG 9, FOUND YR "nine"
	OIC
IF U SAY SO

BTW End of utils functions