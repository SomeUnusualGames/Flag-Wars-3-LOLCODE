#include "binding.h"
#include "raylib.h"
#include <math.h>
//#include "inet.h"  /* for sockets */

char *sanitizeInput(char *input)
{
	unsigned int size = 16;
	unsigned int cur = 0;
	char *temp = malloc(sizeof(char) * size);
	int pos = 0;
	int c;
	void *mem = NULL;
	while (c = input[pos]) {
		temp[cur] = (char)c;
		cur++;
		pos++;
		/* Reserve space to escape colon in input */
		if (c == ':') {
			cur++;
		}
		if (cur > size - 1) {
			/* Increase buffer size */
			size *= 2;
			mem = realloc(temp, sizeof(char) * size);
			if (!mem) {
				perror("realloc");
				free(temp);
				return NULL;
			}
			temp = mem;
		}
		/* Escape colon in input */
		if (c == ':') {
			temp[cur - 1] = ':';
		}
	}
	temp[cur] = '\0';
	return temp;
}

ValueObject *getArg(struct scopeobject *scope, char *name)
{
	IdentifierNode *id = createIdentifierNode(IT_DIRECT, (void *)copyString(name), NULL, NULL, 0);
	ValueObject *val = getScopeValue(scope, scope, id);
	deleteIdentifierNode(id);
	return val;
}
/*
ReturnObject *iopenWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "addr");
	ValueObject *arg2 = getArg(scope, "port");
	char *addr = getString(castStringImplicit(arg1, scope));
	int port = getInteger(arg2);

	inet_host_t *h = malloc(sizeof(inet_host_t));
	if (!strcmp(addr, "ANY")) {
		inet_open(h, IN_PROT_TCP, (const char *)IN_ADDR_ANY, port);
	} else {
		inet_open(h, IN_PROT_TCP, addr, port);
	}

	ValueObject *ret = createBlobValueObject(h);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *ilookupWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "addr");
	char *addr = getString(castStringImplicit(arg1, scope));

	char *h = inet_lookup(addr);

	ValueObject *ret = createStringValueObject(h);
	return createReturnObject(RT_RETURN, ret);
}


ReturnObject *iacceptWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "local");
	inet_host_t *host = (inet_host_t *)getBlob(arg1);

	inet_host_t *h = malloc(sizeof(inet_host_t));
	inet_accept(h, host);

	ValueObject *ret = createBlobValueObject(h);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *iconnectWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "local");
	ValueObject *arg2 = getArg(scope, "addr");
	ValueObject *arg3 = getArg(scope, "port");
	inet_host_t *host = (inet_host_t *)getBlob(arg1);
	char *addr = getString(castStringImplicit(arg2, scope));
	int port = getInteger(arg3);

	inet_host_t *h = malloc(sizeof(inet_host_t));
	inet_setup(h, IN_PROT_TCP, addr, port);
	inet_connect(host, h);

	ValueObject *ret = createBlobValueObject(h);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *icloseWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "local");
	inet_host_t *host = (inet_host_t *)getBlob(arg1);

	inet_close(host);

	ValueObject *ret = createBlobValueObject(host);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *isendWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "local");
	ValueObject *arg2 = getArg(scope, "remote");
	ValueObject *arg3 = getArg(scope, "data");
	inet_host_t *local = (inet_host_t *)getBlob(arg1);
	inet_host_t *remote = (inet_host_t *)getBlob(arg2);
	char *data = getString(castStringImplicit(arg3, scope));

	int n = inet_send(local, remote, data, strlen(data));

	ValueObject *ret = createIntegerValueObject(n);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *ireceiveWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "local");
	ValueObject *arg2 = getArg(scope, "remote");
	ValueObject *arg3 = getArg(scope, "amount");
	inet_host_t *local = (inet_host_t *)getBlob(arg1);
	inet_host_t *remote = (inet_host_t *)getBlob(arg2);
	int amount = getInteger(arg3);

	char *data = malloc(sizeof(char) * (amount + 1));
	int len = inet_receive(remote, local, data, amount, -1);
	data[len] = '\0';

	char *sanitized = sanitizeInput(data);
	free(data);

	ValueObject *ret = createStringValueObject(sanitized);
	return createReturnObject(RT_RETURN, ret);
}
*/

ReturnObject *fopenWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "filename");
	ValueObject *arg2 = getArg(scope, "mode");
	char *filename = getString(castStringImplicit(arg1, scope));
	char *mode = getString(castStringImplicit(arg2, scope));

	FILE *f = fopen(filename, mode);

	ValueObject *ret = createBlobValueObject(f);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *freadWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "file");
	ValueObject *arg2 = getArg(scope, "length");
	FILE *file = (FILE *)getBlob(arg1);
	int length = getInteger(arg2);

	char *buf = malloc(sizeof(char) * (length + 1));
	int len = fread(buf, 1, length, file);
	buf[len] = '\0';

	char *sanitized = sanitizeInput(buf);
	free(buf);

	ValueObject *ret = createStringValueObject(sanitized);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *fwriteWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "file");
	ValueObject *arg2 = getArg(scope, "data");
	FILE *file = (FILE *)getBlob(arg1);
	char *data = getString(castStringExplicit(arg2, scope));

	fwrite(data, 1, strlen(data), file);

	return createReturnObject(RT_DEFAULT, NULL);
}

ReturnObject *fcloseWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "file");
	FILE *file = (FILE *)getBlob(arg1);

	fclose(file);

	return createReturnObject(RT_DEFAULT, NULL);
}

ReturnObject *ferrorWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "file");
	FILE *file = (FILE *)getBlob(arg1);

	ValueObject *ret = createBooleanValueObject(file == NULL || ferror(file));
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *rewindWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "file");
	FILE *file = (FILE *)getBlob(arg1);

	rewind(file);

	return createReturnObject(RT_DEFAULT, NULL);
}

ReturnObject *strlenWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "string");
	char *string = getString(castStringImplicit(arg1, scope));

	size_t len = strlen(string);

	ValueObject *ret = createIntegerValueObject((long long)len);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *stratWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "string");
	ValueObject *arg2 = getArg(scope, "position");
	char *string = getString(castStringImplicit(arg1, scope));
	long long position = getInteger(arg2);

	char *temp = malloc(sizeof(char) * 2);
	temp[0] = string[position];
	temp[1] = 0;

	ValueObject *ret = createStringValueObject(temp);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *srandWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "seed");
	int seed = getInteger(arg1);

	srand(seed);

	return createReturnObject(RT_DEFAULT, NULL);
}

ReturnObject *randWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "max");
	unsigned int max = getInteger(arg1);

	unsigned int val = (rand() % max);

	ValueObject *ret = createIntegerValueObject(val);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *sqrtfWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "n");
	float n = getFloat(arg1);

	float val = sqrtf(n);

	ValueObject *ret = createFloatValueObject(val);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *powfWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "base");
	float base = getFloat(arg1);
	ValueObject *arg2 = getArg(scope, "exponent");
	float exponent = getFloat(arg2);

	float val = powf(base, exponent);

	ValueObject *ret = createFloatValueObject(val);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *absWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "n");
	float n = getFloat(arg1);

	float val = abs(n);

	ValueObject *ret = createFloatValueObject(val);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *powf2Wrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "base");
	float base = getFloat(arg1);

	float val = powf(base, 2.0f);

	ValueObject *ret = createFloatValueObject(val);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *sinfWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "value");
	float value = getFloat(arg1);

	float res = sinf(value);

	ValueObject *ret = createFloatValueObject(res);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *cosfWrapper(struct scopeobject *scope)
{
	ValueObject *arg1 = getArg(scope, "value");
	float value = getFloat(arg1);

	float res = cosf(value);

	ValueObject *ret = createFloatValueObject(res);
	return createReturnObject(RT_RETURN, ret);
}

/* Measure string width for default font */
ReturnObject *MeasureTextWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "text");
	char *text = getString(castStringImplicit(arg0, scope));

	ValueObject *arg1 = getArg(scope, "fontSize");
	int fontSize = getInteger(arg1);

	int result = MeasureText(text, fontSize);

	ValueObject *ret = createIntegerValueObject(result);

	return createReturnObject(RT_RETURN, ret);
}

/* Initialize window and OpenGL context */
ReturnObject *InitWindowWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "width");
	int width = getInteger(arg0);

	ValueObject *arg1 = getArg(scope, "height");
	int height = getInteger(arg1);

	ValueObject *arg2 = getArg(scope, "title");
	char *title = getString(castStringImplicit(arg2, scope));

	InitWindow(width, height, title);
	return createReturnObject(RT_DEFAULT, NULL);
}

/* Check if KEY_ESCAPE pressed or Close icon pressed */
ReturnObject *WindowShouldCloseWrapper(struct scopeobject *scope)
{
	bool result = WindowShouldClose();

	ValueObject *ret = createBooleanValueObject(result);

	return createReturnObject(RT_RETURN, ret);
}

/* Close window and unload OpenGL context */
ReturnObject *CloseWindowWrapper(struct scopeobject *scope)
{
	CloseWindow();
	return createReturnObject(RT_DEFAULT, NULL);
}

ReturnObject *SetTargetFPSWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "fps");
	int fps = getInteger(arg0);

	SetTargetFPS(fps);
	return createReturnObject(RT_DEFAULT, NULL);
}

/* Setup canvas (framebuffer) to start drawing */
ReturnObject *BeginDrawingWrapper(struct scopeobject *scope)
{
	BeginDrawing();
	return createReturnObject(RT_DEFAULT, NULL);
}

/* End canvas drawing and swap buffers (double buffering) */
ReturnObject *EndDrawingWrapper(struct scopeobject *scope)
{
	EndDrawing();
	return createReturnObject(RT_DEFAULT, NULL);
}

/* Set background color (framebuffer clear color) */
ReturnObject *ClearBackgroundWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "r");
	int r = getInteger(arg0);
	ValueObject *arg1 = getArg(scope, "g");
	int g = getInteger(arg1);
	ValueObject *arg2 = getArg(scope, "b");
	int b = getInteger(arg2);
	ValueObject *arg3 = getArg(scope, "a");
	int a = getInteger(arg3);
	Color color = (Color){r, g, b, a};
	ClearBackground(color);
	return createReturnObject(RT_DEFAULT, NULL);
}

/* Draw text (using default font) */
ReturnObject *DrawTextWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "text");
	char *text = getString(castStringImplicit(arg0, scope));

	ValueObject *arg1 = getArg(scope, "posX");
	int posX = getInteger(arg1);

	ValueObject *arg2 = getArg(scope, "posY");
	int posY = getInteger(arg2);

	ValueObject *arg3 = getArg(scope, "fontSize");
	int fontSize = getInteger(arg3);

	ValueObject *arg4 = getArg(scope, "r");
	int r = getInteger(arg4);
	ValueObject *arg5 = getArg(scope, "g");
	int g = getInteger(arg5);
	ValueObject *arg6 = getArg(scope, "b");
	int b = getInteger(arg6);
	ValueObject *arg7 = getArg(scope, "a");
	int a = getInteger(arg7);

	Color color = (Color){r, g, b, a};
	DrawText(text, posX, posY, fontSize, color);
	return createReturnObject(RT_DEFAULT, NULL);
}

/* Check if a key is being pressed */
ReturnObject *IsKeyDownWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "key");
	int key = getInteger(arg0);

	bool result = IsKeyDown(key);

	ValueObject *ret = createBooleanValueObject(result);

	return createReturnObject(RT_RETURN, ret);
}

/* Check if a key has been pressed once */
ReturnObject *IsKeyPressedWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "key");
	int key = getInteger(arg0);

	bool result = IsKeyPressed(key);

	ValueObject *ret = createBooleanValueObject(result);

	return createReturnObject(RT_RETURN, ret);
}

/* Draw a color-filled circle (Vector version) */
ReturnObject *DrawCircleVWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "center");
	Vector2 center = getVector2(arg0);
	ValueObject *arg1 = getArg(scope, "radius");
	float radius = getFloat(arg1);

	ValueObject *arg2 = getArg(scope, "r");
	int r = getInteger(arg2);
	ValueObject *arg3 = getArg(scope, "g");
	int g = getInteger(arg3);
	ValueObject *arg4 = getArg(scope, "b");
	int b = getInteger(arg4);
	ValueObject *arg5 = getArg(scope, "a");
	int a = getInteger(arg5);

	Color color = (Color){r, g, b, a};
	DrawCircleV(center, radius, color);
	return createReturnObject(RT_DEFAULT, NULL);
}

/* Draw a color-filled triangle (vertex in counter-clockwise order!) */
ReturnObject *DrawTriangleWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "v1x");
	float v1x = getFloat(arg0);
	ValueObject *arg1 = getArg(scope, "v1y");
	float v1y = getFloat(arg1);
	
	ValueObject *arg2 = getArg(scope, "v2x");
	float v2x = getFloat(arg2);
	ValueObject *arg3 = getArg(scope, "v2y");
	float v2y = getFloat(arg3);

	ValueObject *arg4 = getArg(scope, "v3x");
	float v3x = getFloat(arg4);
	ValueObject *arg5 = getArg(scope, "v3y");
	float v3y = getFloat(arg5);

	ValueObject *arg6 = getArg(scope, "r");
	int r = getInteger(arg6);
	ValueObject *arg7 = getArg(scope, "g");
	int g = getInteger(arg7);
	ValueObject *arg8 = getArg(scope, "b");
	int b = getInteger(arg8);
	ValueObject *arg9 = getArg(scope, "a");
	int a = getInteger(arg9);

	Color color = (Color){r, g, b, a};

	DrawTriangle((Vector2){v1x, v1y}, (Vector2){v2x, v2y}, (Vector2){v3x, v3y}, color);
	return createReturnObject(RT_DEFAULT, NULL);
}

ReturnObject *ColorWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "r");
	int r = getInteger(arg0);
	ValueObject *arg1 = getArg(scope, "g");
	int g = getInteger(arg1);
	ValueObject *arg2 = getArg(scope, "b");
	int b = getInteger(arg2);
	ValueObject *arg3 = getArg(scope, "a");
	int a = getInteger(arg3);

	Color color = (Color){r, g, b, a};
	ValueObject *ret = createColorValueObject(color);
	return createReturnObject(RT_RETURN, ret);
}

ReturnObject *Vector2Wrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "x");
	float x = getFloat(arg0);
	ValueObject *arg1 = getArg(scope, "y");
	float y = getFloat(arg1);

	Vector2 vector2 = (Vector2){x, y};
	ValueObject *ret = createVector2ValueObject(vector2);
	return createReturnObject(RT_RETURN, ret);
}


/* Load texture from file into GPU memory (VRAM) */
ReturnObject *LoadTextureWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "fileName");
	char *fileName = getString(castStringImplicit(arg0, scope));

	Texture2D result = LoadTexture(fileName);

	ValueObject *ret = createTexture2DValueObject(result);

	return createReturnObject(RT_RETURN, ret);
}

/* Draw a Texture2D */
ReturnObject *DrawTextureWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "texture");
	Texture2D texture = getTexture2D(arg0);
	ValueObject *arg1 = getArg(scope, "posX");
	int posX = getInteger(arg1);

	ValueObject *arg2 = getArg(scope, "posY");
	int posY = getInteger(arg2);

	ValueObject *arg3 = getArg(scope, "r");
	int r = getInteger(arg3);
	ValueObject *arg4 = getArg(scope, "g");
	int g = getInteger(arg4);
	ValueObject *arg5 = getArg(scope, "b");
	int b = getInteger(arg5);
	ValueObject *arg6 = getArg(scope, "a");
	int a = getInteger(arg6);

	Color tint = (Color){r, g, b, a};
	DrawTexture(texture, posX, posY, tint);
	return createReturnObject(RT_DEFAULT, NULL);
}

/* Draw a color-filled rectangle */
ReturnObject *DrawRectangleRecWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "x");
	float x = getFloat(arg0);
	ValueObject *arg1 = getArg(scope, "y");
	float y = getFloat(arg1);
	ValueObject *arg2 = getArg(scope, "width");
	float width = getFloat(arg2);
	ValueObject *arg3 = getArg(scope, "height");
	float height = getFloat(arg3);

	Rectangle rect = (Rectangle){x, y, width, height};

	ValueObject *arg4 = getArg(scope, "r");
	int r = getInteger(arg4);
	ValueObject *arg5 = getArg(scope, "g");
	int g = getInteger(arg5);
	ValueObject *arg6 = getArg(scope, "b");
	int b = getInteger(arg6);
	ValueObject *arg7 = getArg(scope, "a");
	int a = getInteger(arg7);
	Color color = (Color){r, g, b, a};

	DrawRectangleRec(rect, color);
	return createReturnObject(RT_DEFAULT, NULL);
}


/* Draw a part of a texture defined by a rectangle with 'pro' parameters */
ReturnObject *DrawTextureProWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "texture");
	Texture2D texture = getTexture2D(arg0);
	ValueObject *arg1 = getArg(scope, "sourcex");
	float sourcex = getFloat(arg1);
	ValueObject *arg2 = getArg(scope, "sourcey");
	float sourcey = getFloat(arg2);
	ValueObject *arg3 = getArg(scope, "sourcew");
	float sourcew = getFloat(arg3);
	ValueObject *arg4 = getArg(scope, "sourceh");
	float sourceh = getFloat(arg4);
	Rectangle source = (Rectangle){sourcex, sourcey, sourcew, sourceh};

	ValueObject *arg5 = getArg(scope, "destx");
	float destx = getFloat(arg5);
	ValueObject *arg6 = getArg(scope, "desty");
	float desty = getFloat(arg6);
	ValueObject *arg7 = getArg(scope, "destw");
	float destw = getFloat(arg7);
	ValueObject *arg8 = getArg(scope, "desth");
	float desth = getFloat(arg8);
	Rectangle dest = (Rectangle){destx, desty, destw, desth};

	ValueObject *arg9 = getArg(scope, "originx");
	float originx = getFloat(arg9);
	ValueObject *arg10 = getArg(scope, "originy");
	float originy = getFloat(arg10);
	Vector2 origin = (Vector2){originx, originy};
	
	ValueObject *arg11 = getArg(scope, "rotation");
	float rotation = getFloat(arg11);

	ValueObject *arg12 = getArg(scope, "r");
	int r = getInteger(arg12);
	ValueObject *arg13 = getArg(scope, "g");
	int g = getInteger(arg13);
	ValueObject *arg14 = getArg(scope, "b");
	int b = getInteger(arg14);
	ValueObject *arg15 = getArg(scope, "a");
	int a = getInteger(arg15);

	DrawTexturePro(texture, source, dest, origin, rotation, (Color){r, g, b, a});
	return createReturnObject(RT_DEFAULT, NULL);
}


ReturnObject *UnloadTextureWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "texture");
	Texture2D texture = getTexture2D(arg0);
	
	UnloadTexture(texture);
	return createReturnObject(RT_DEFAULT, NULL);
}

ReturnObject *DrawFPSWrapper(struct scopeobject *scope)
{
	ValueObject *arg0 = getArg(scope, "x");
	int x = getInteger(arg0);
	ValueObject *arg1 = getArg(scope, "y");
	int y = getInteger(arg1);

	DrawFPS(x, y);

	return createReturnObject(RT_DEFAULT, NULL);
}

/* Get time in seconds for last frame drawn (delta time) */
ReturnObject *GetFrameTimeWrapper(struct scopeobject *scope)
{
	float result = GetFrameTime();

	ValueObject *ret = createFloatValueObject(result);

	return createReturnObject(RT_RETURN, ret);
}


/* Get elapsed time in seconds since InitWindow() */
ReturnObject *GetTimeWrapper(struct scopeobject *scope)
{
	float result = (float)GetTime();

	ValueObject *ret = createFloatValueObject(result);

	return createReturnObject(RT_RETURN, ret);
}

void loadLibrary(ScopeObject *scope, IdentifierNode *target)
{
	char *name = NULL;
	int status;
	ScopeObject *lib = NULL;
	IdentifierNode *id = NULL;
	ValueObject *val = NULL;
	if (target == NULL) return;

	name = resolveIdentifierName(target, scope);
	if (!name) goto loadLibraryAbort;

	if (!strcmp(name, "STDLIB")) {
		lib = createScopeObject(scope);
		if (!lib) goto loadLibraryAbort;

		loadBinding(lib, "MIX", "seed", &srandWrapper);
		loadBinding(lib, "BLOW", "max", &randWrapper);

		id = createIdentifierNode(IT_DIRECT, (void *)copyString("STDLIB"), NULL, NULL, 0);
		if (!id) goto loadLibraryAbort;

		if (!createScopeValue(scope, scope, id)) goto loadLibraryAbort;

		val = createArrayValueObject(lib);
		if (!val) goto loadLibraryAbort;
		lib = NULL;

		if (!updateScopeValue(scope, scope, id, val)) goto loadLibraryAbort;
		deleteIdentifierNode(id);
	} else if (!strcmp(name, "STDIO")) {
		lib = createScopeObject(scope);
		if (!lib) goto loadLibraryAbort;

		loadBinding(lib, "OPEN", "filename mode", &fopenWrapper);
		loadBinding(lib, "DIAF", "file", &ferrorWrapper);
		loadBinding(lib, "LUK", "file length", &freadWrapper);
		loadBinding(lib, "SCRIBBEL", "file data", &fwriteWrapper);
		loadBinding(lib, "AGEIN", "file", &rewindWrapper);
		loadBinding(lib, "CLOSE", "file", &fcloseWrapper);

		id = createIdentifierNode(IT_DIRECT, (void *)copyString("STDIO"), NULL, NULL, 0);
		if (!id) goto loadLibraryAbort;

		if (!createScopeValue(scope, scope, id)) goto loadLibraryAbort;

		val = createArrayValueObject(lib);
		if (!val) goto loadLibraryAbort;
		lib = NULL;

		if (!updateScopeValue(scope, scope, id, val)) goto loadLibraryAbort;
		deleteIdentifierNode(id);
	/*
	} else if (!strcmp(name, "SOCKS")) {
		lib = createScopeObject(scope);
		if (!lib) goto loadLibraryAbort;

		loadBinding(lib, "RESOLV", "addr", &ilookupWrapper);
		loadBinding(lib, "BIND", "addr port", &iopenWrapper);
		loadBinding(lib, "LISTN", "local", &iacceptWrapper);
		loadBinding(lib, "KONN", "local addr port", &iconnectWrapper);
		loadBinding(lib, "CLOSE", "local", &icloseWrapper);
		loadBinding(lib, "PUT", "local remote data", &isendWrapper);
		loadBinding(lib, "GET", "local remote amount", &ireceiveWrapper);

		id = createIdentifierNode(IT_DIRECT, (void *)copyString("SOCKS"), NULL, NULL, 0);
		if (!id) goto loadLibraryAbort;

		if (!createScopeValue(scope, scope, id)) goto loadLibraryAbort;

		val = createArrayValueObject(lib);
		if (!val) goto loadLibraryAbort;
		lib = NULL;

		if (!updateScopeValue(scope, scope, id, val)) goto loadLibraryAbort;
		deleteIdentifierNode(id);
	*/
	} else if (!strcmp(name, "STRING")) {
		lib = createScopeObject(scope);
		if (!lib) goto loadLibraryAbort;

		loadBinding(lib, "LEN", "string", &strlenWrapper);
		loadBinding(lib, "AT", "string position", &stratWrapper);

		id = createIdentifierNode(IT_DIRECT, (void *)copyString("STRING"), NULL, NULL, 0);
		if (!id) goto loadLibraryAbort;

		if (!createScopeValue(scope, scope, id)) goto loadLibraryAbort;

		val = createArrayValueObject(lib);
		if (!val) goto loadLibraryAbort;
		lib = NULL;

		if (!updateScopeValue(scope, scope, id, val)) goto loadLibraryAbort;
		deleteIdentifierNode(id);
	} else if (!strcmp(name, "MATH")) {
		lib = createScopeObject(scope);
		if (!lib) goto loadLibraryAbort;

		loadBinding(lib, "SQRT", "n", &sqrtfWrapper);
		loadBinding(lib, "POW", "base exponent", &powfWrapper);
		loadBinding(lib, "POW2", "base", &powf2Wrapper);
		loadBinding(lib, "ABS", "n", &absWrapper);
		loadBinding(lib, "SIN", "value", &sinfWrapper);
		loadBinding(lib, "COS", "value", &cosfWrapper);

		id = createIdentifierNode(IT_DIRECT, (void *)copyString("MATH"), NULL, NULL, 0);
		if (!id) goto loadLibraryAbort;

		if (!createScopeValue(scope, scope, id)) goto loadLibraryAbort;

		val = createArrayValueObject(lib);
		if (!val) goto loadLibraryAbort;
		lib = NULL;

		if (!updateScopeValue(scope, scope, id, val)) goto loadLibraryAbort;
		deleteIdentifierNode(id);
	} else if (!strcmp(name, "RAYLIB")) {
		lib = createScopeObject(scope);
		if (!lib) goto loadLibraryAbort;

		loadBinding(lib, "COLUR", "r g b a", &ColorWrapper);
		loadBinding(lib, "VEKTOR2", "x y", &Vector2Wrapper);
		loadBinding(lib, "MEASURETEXT", "text fontSize", &MeasureTextWrapper);
		loadBinding(lib, "WINDUS", "width height title", &InitWindowWrapper);
		loadBinding(lib, "FPS", "fps", &SetTargetFPSWrapper);
		loadBinding(lib, "CLOZE", NULL, &WindowShouldCloseWrapper);
		loadBinding(lib, "BEGINDRAW", NULL, &BeginDrawingWrapper);
		loadBinding(lib, "BAKGROUND", "r g b a", &ClearBackgroundWrapper);
		loadBinding(lib, "TEXT", "text posX posY fontSize r g b a", &DrawTextWrapper);
		loadBinding(lib, "STOPDRAW", NULL, &EndDrawingWrapper);
		loadBinding(lib, "CLOZEWINDUS", NULL, &CloseWindowWrapper);
		loadBinding(lib, "IZKEYDOWN", "key", &IsKeyDownWrapper);
		loadBinding(lib, "IZKEYPRESSED", "key", &IsKeyPressedWrapper);
		loadBinding(lib, "DRAWCIRCLEV", "center radius r g b a", &DrawCircleVWrapper);
		loadBinding(lib, "DRAWTRIANGLE", "v1x v1y v2x v2y v3x v3y r g b a", &DrawTriangleWrapper);
		loadBinding(lib, "LOADTEXTURE", "fileName", &LoadTextureWrapper);
		loadBinding(lib, "DRAWTEXTURE", "texture posX posY r g b a", &DrawTextureWrapper);
		loadBinding(lib, "DRAWTEXTUREPRO", "texture sourcex sourcey sourcew sourceh destx desty destw desth originx originy rotation r g b a", &DrawTextureProWrapper);
		loadBinding(lib, "DRAWRECTANGLEREC", "x y width height r g b a", &DrawRectangleRecWrapper);
		loadBinding(lib, "UNLOADTEXTURE", "texture", &UnloadTextureWrapper);
		loadBinding(lib, "DRAWFPS", "x y", &DrawFPSWrapper);
		loadBinding(lib, "GETFRAMETIME", NULL, &GetFrameTimeWrapper);
		loadBinding(lib, "GETTIME", NULL, &GetTimeWrapper);

		id = createIdentifierNode(IT_DIRECT, (void *)copyString("RAYLIB"), NULL, NULL, 0);
		if (!id) goto loadLibraryAbort;

		if (!createScopeValue(scope, scope, id)) goto loadLibraryAbort;

		val = createArrayValueObject(lib);
		if (!val) goto loadLibraryAbort;
		lib = NULL;

		if (!updateScopeValue(scope, scope, id, val)) goto loadLibraryAbort;
		deleteIdentifierNode(id);
	}

	if (name) free(name);
	return;

loadLibraryAbort: /* In case something goes wrong... */

	/* Clean up any allocated structures */
	if (name) free(name);
	if (lib) deleteScopeObject(lib);
	if (id) deleteIdentifierNode(id);
	if (val) deleteValueObject(val);
	return;
}

void loadBinding(ScopeObject *scope, char *name, const char *args, struct returnobject *(*binding)(struct scopeobject *))
{
	IdentifierNode *id = NULL;
	StmtNodeList *stmts = NULL;
	BindingStmtNode *stmt = NULL;
	StmtNode *wrapper = NULL;
	int status;
	BlockNode *body = NULL;
	IdentifierNodeList *ids = NULL;
	IdentifierNode *arg = NULL;
	if (name == NULL || binding == NULL) return;

	id = createIdentifierNode(IT_DIRECT, (void *)copyString(name), NULL, NULL, 0);
	if (!id) goto loadBindingAbort;

	stmts = createStmtNodeList();
	if (!stmts) goto loadBindingAbort;

	stmt = createBindingStmtNode(binding);
	if (!stmt) goto loadBindingAbort;

	wrapper = createStmtNode(ST_BINDING, stmt);
	if (!wrapper) goto loadBindingAbort;
	stmt = NULL;

	status = addStmtNode(stmts, wrapper);
	if (!status) goto loadBindingAbort;
	wrapper = NULL;

	body = createBlockNode(stmts);
	if (!body) goto loadBindingAbort;
	stmts = NULL;

	ids = createIdentifierNodeList();
	if (!ids) goto loadBindingAbort;

	const char *start = args;
	while (start != NULL) {
		char *end = strchr(start, ' ');
		char *temp = NULL;
		unsigned int len = 0;

		if (end != NULL) len = (end - start);
		else len = strlen(start);

		temp = malloc(sizeof(char) * (len + 1));
		strncpy(temp, start, len);
		temp[len] = '\0';

		if (end != NULL) start = (end + 1);
		else start = NULL;

		arg = createIdentifierNode(IT_DIRECT, (void *)temp, NULL, NULL, 0);
		if (!arg) goto loadBindingAbort;

		status = addIdentifierNode(ids, arg);
		if (!status) goto loadBindingAbort;
	}

	FuncDefStmtNode *interface = createFuncDefStmtNode(NULL, id, ids, body);
	if (!interface) goto loadBindingAbort;

	ValueObject *val = createFunctionValueObject(interface);
	if (!val) goto loadBindingAbort;

	createScopeValue(scope, scope, id);
	updateScopeValue(scope, scope, id, val);

	return;

loadBindingAbort: /* In case something goes wrong... */

	if (id) deleteIdentifierNode(id);
	if (val) deleteValueObject(val);
	else if (interface) deleteFuncDefStmtNode(interface);
	else {
		if (arg) deleteIdentifierNode(arg);
		if (ids) deleteIdentifierNodeList(ids);
		if (body) deleteBlockNode(body);
		if (stmts) deleteStmtNodeList(stmts);
		if (wrapper) deleteStmtNode(wrapper);
		if (stmt) deleteBindingStmtNode(stmt);
	}
	return;
}
