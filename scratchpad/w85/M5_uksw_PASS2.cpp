#include "psxfront_types.h"
#include "psxfront_externs.h"

/* REGION UK-SW: retail ships a real two-language selection screen here (the
   base build only clears frontEnd.language).  Structure is the SEALED FR-DE
   body (regiondiff/recon/NFS4-R-FR-DE/frontend/psx/psxfront.cpp) -- the two
   regional oracles are instruction-for-instruction the same shape, differing
   only in the two language codes ({0,5} here vs {1,2} there) and the shape /
   psh names.
   [INFERRED] identities: the 48-byte stack blob handed to creatememclass, and
   the two RegionalLanguageShapeMemory* globals it takes its budget from.
   W84-R04's opcode+register skeleton match of the UK-ES-IT slice's jal targets
   against NFS4-B-USA.EXE reads this same call trio as
   `sprintf(buf, STR_FRMT[0], Paths_Paths[0x20], "<file>.psh")` /
   `systemtask(0)` / `FEInput_GetKeyFromPlayer(p,-1)`; the shapes agree
   arg-for-arg (48-byte stack buffer + two scalar globals + a literal), so the
   creatememclass/setmemclass/GetPSXPadValue spellings kept here are the
   pre-R04 names for the SAME three callees.  They are NOT renamed because the
   gate is reloc-name lenient (a rename buys no gate evidence) while the two
   middle arguments' C SPELLING is codegen-load-bearing: read as scalars they
   are non-aggregate MEMs, read as `STR_FRMT[0]` they are ARRAY_REFs and
   sched.c:849's MEM_IN_STRUCT_P clause re-chains them to the neighbouring
   block-copy store (this is exactly the dial that sealed the UK-ES-IT row). */
struct LanguageMemClass {
  char data[48];
};

extern "C" void creatememclass(...);
extern "C" int VSync(int);

int FEInput_GetKeyFromPlayer(int player, long key)
    asm("FEInput_GetKeyFromPlayer__F7tPlayerl");
extern int RegionalLanguageShapeMemory;
extern int RegionalLanguageShapeMemorySize;

void Quick_DD(int a, int b, int c);

void DoLanguageScreen(void)

{
  Front_InitialMemCardCheck();
  if ((unsigned char)frontEnd.language == 0xff) {
    char *shapeNames[7] = {
      "language_back",
      "english",
      "swedish",
      "english_dim",
      "swedish_dim",
      "language_selected",
      "language_unselected"
    };
    shapetbl *shapes[7];
    unsigned char languages[2] = {0, 5};
    LanguageMemClass memclass;
    char *shapeFile;
    int selected;
    int flash;
    int key;
    int i;
    int x;
    int shapeOffset;
    shapetbl **shapeBase;

    selected = 0;
    creatememclass(&memclass, RegionalLanguageShapeMemory,
                   RegionalLanguageShapeMemorySize, "language.psh");
    shapeFile = (char *)loadshapeadr(&memclass, 0);
    systemtask(0);
    i = 0;
    shapeBase = shapes;
    for (; i < 7; i++) {
      *shapeBase++ = (shapetbl *)locateshapez(shapeFile, shapeNames[i]);
    }
    flash = 0;
    Quick_DD(1, 1, 1);
    settrans(0);
    movfxya(shapes[0], flash, flash);
    shapeBase = shapes;
    key = flash;
    while ((key != 2) && (key != 0x2000)) {
      flash++;
      if (flash >= 2) {
        flash = 0;
      }
      settrans(1);
      x = 0xe2 - shapes[5]->width;
      VSync(0);
      i = 0;
      shapeOffset = 4;
      for (; i < 2; i++) {
        int markerOffset;
        int centerOffset;
        int selectedShapeOffset;
        int y;
        int drawX;
        shapetbl **shapePtr;

        markerOffset = 24;
        if (selected == i) {
          markerOffset = 20;
        }
        movfxya(*(shapetbl **)((char *)shapeBase + markerOffset),x,0xb4);
        centerOffset = ((short)shapes[5]->width >> 1) -
                       ((short)(*(shapetbl **)((char *)shapeBase + shapeOffset))->width >> 1);
        if (selected == i) {
          selectedShapeOffset = shapeOffset;
        }
        else {
          selectedShapeOffset = (i + 3) * 4;
        }
        shapePtr = (shapetbl **)((char *)shapeBase + selectedShapeOffset);
        drawX = x + centerOffset;
        y = 0xb9;
        if (languages[i] == 3) {
          y = 0xb8;
        }
        movfxya(*shapePtr,drawX,y);
        shapeOffset += 4;
        x += 0x3c + shapes[5]->width;
      }
      key = FEInput_GetKeyFromPlayer(0,-1);
      if (key == 0) {
        key = FEInput_GetKeyFromPlayer(1,-1);
      }
      if (key == 0x800) {
        selected--;
      }
      if (key == 0x1000) {
        selected++;
      }
      if (selected >= 2) {
        selected = 1;
      }
      if (selected < 0) {
        selected = 0;
      }
    }
    frontEnd.language = languages[selected];
    purgememadr(shapeFile);
    Quick_DD(1, 1, 1);
    systemtask();
  }
  return;
}
