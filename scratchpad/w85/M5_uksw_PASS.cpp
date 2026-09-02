#include "psxfront_types.h"
#include "psxfront_externs.h"

/* REGION UK-SW: retail ships a real two-language selection screen here (the
   base build only clears frontEnd.language).  Structure is the SEALED FR-DE
   body (regiondiff/recon/NFS4-R-FR-DE/frontend/psx/psxfront.cpp) -- the two
   regional oracles are instruction-for-instruction the same shape, differing
   only in the two language codes ({0,5} here vs {1,2} there) and the shape /
   psh names.
   CALLEE NAMES (W85-M5, applying W84-R04's identification): the three callees
   an earlier wave spelled `creatememclass` / `setmemclass` / `GetPSXPadValue`
   are, by R04's opcode+register skeleton match of the regional jal targets
   against NFS4-B-USA.EXE, `sprintf` / `systemtask` / FEInput_GetKeyFromPlayer.
   The shapes agree arg-for-arg and the trio is exactly the idiom DoTitleScreen
   uses two functions earlier in the base TU
   (`sprintf(fileName,STR_FRMT[0],Paths_Paths[0x20],art); loadshapeadr(fileName,0);
   systemtask(0);`), so the 48-byte stack blob is that `char fileName[48]` and
   the two loaded globals are STR_FRMT[0] / Paths_Paths[0x20].  All three
   renames were applied and RE-GATED: REGION-PASS (182) holds.
   ⚠️ The ARRAY_REF spelling of the two middle arguments is codegen-relevant in
   general (sched.c:849 MEM_IN_STRUCT_P re-chains an ARRAY_REF load to a
   neighbouring varying-address block-copy store -- that is the dial that
   sealed the UK-ES-IT row, whose 9-name initializer copies through a LOOP).
   It is harmless here because this TU's 7-name initializer is unrolled with
   constant frame addresses, so no varying-address store exists to chain to. */
extern "C" int VSync(int);

/* PSXFront.obj STAT (file-local) global, same carrier the base TU declares. */
static char *STR_FRMT[2];

int FEInput_GetKeyFromPlayer(int player, long key)
    asm("FEInput_GetKeyFromPlayer__F7tPlayerl");
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
    char fullName[48];
    char *shapeFile;
    int selected;
    int flash;
    int key;
    int i;
    int x;
    int shapeOffset;
    shapetbl **shapeBase;

    selected = 0;
    sprintf(fullName, STR_FRMT[0], Paths_Paths[0x20], "language.psh");
    shapeFile = (char *)loadshapeadr(fullName, 0);
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
