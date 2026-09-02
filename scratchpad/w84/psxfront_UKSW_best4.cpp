#include "psxfront_types.h"
#include "psxfront_externs.h"

struct LanguageMemClass {
  char data[48];
};

extern "C" void creatememclass(...);
extern "C" void setmemclass(int);
extern "C" int VSync(int);

extern int GetPSXPadValue(int value, int player);
extern int RegionalLanguageShapeMemory;
extern int RegionalLanguageShapeMemorySize;

void Quick_DD(int a, int b, int c);

static inline int LanguageShapeOffset(int selected, int index, int selectedOffset)
{
  if (selected == index) {
    return selectedOffset;
  }
  return (index + 3) * 4;
}

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
    shapetbl *anchorShape;

    selected = 0;
    creatememclass(&memclass, RegionalLanguageShapeMemory,
                   RegionalLanguageShapeMemorySize, "language.psh");
    shapeFile = (char *)loadshapeadr(&memclass, 0);
    setmemclass(0);

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
    key = 0;

    while ((key != 2) && (key != 0x2000)) {
      flash++;
      if (flash >= 2) {
        flash = 0;
      }

      settrans(1);
      do {
        anchorShape = shapes[5];
        do {
          shapeOffset = 4;
          do {
            x = 0xe2 - anchorShape->width;
            VSync(0);
            i = 0;
          } while (0);
        } while (0);
      } while (0);

language_draw_loop:
      if (i < 2) {
        int centerOffset;
        int markerOffset;
        int selectedShapeOffset;
        markerOffset = 24;
        if (selected == i) {
          markerOffset = 20;
        }
        movfxya(*(shapetbl **)((char *)shapeBase + markerOffset), x, 0xb4);
        centerOffset = ((short)shapes[5]->width >> 1) -
                       ((short)(*(shapetbl **)((char *)shapeBase + shapeOffset))->width >> 1);
        selectedShapeOffset = LanguageShapeOffset(selected, i, shapeOffset);
        movfxya(*(shapetbl **)((char *)shapeBase + selectedShapeOffset),
                x + centerOffset,
                languages[i] == 3 ? 0xb8 : 0xb9);
        shapeOffset += 4;
        i++;
        x += 0x3c + shapes[5]->width;
        goto language_draw_loop;
      }

      key = GetPSXPadValue(0, -1);
      if (key == 0) {
        key = GetPSXPadValue(1, -1);
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
}
