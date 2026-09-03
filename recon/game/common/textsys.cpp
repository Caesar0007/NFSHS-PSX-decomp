/* game/psx/textsys.cpp -- RECONSTRUCTED (NFS4 PSX text/word system; C++ TU)
 *   8 fns: TextSys_LoadWordsGeneric/LoadInGame/LoadWords, Word/WordFlags/WordX/WordY, UnloadWords.
 *   GTE-free. Full SYM-locals applied.
 */
#include "textsys_types.h"
#include "textsys_externs.h"

/* Textsys.obj-owned initialized data.  SYM identifies langFileName as
 * `char *[6]` at 0x8011E140; the initializer is independently preserved by
 * the matched NFS2 PC-beta Textsys source.  The D_* names anchor the existing
 * byte-exact residual literals until Textsys.obj's complete rodata run is
 * migrated without disturbing the PASS LoadInGame scheduling. */
extern char D_800565F0[];
extern char D_800565FC[];
extern char D_80056608[];
extern char D_80056614[];
extern char D_80056620[];
extern char D_8005662C[];
char *langFileName[6] = {
  D_800565F0, D_800565FC, D_80056608,
  D_80056614, D_80056620, D_8005662C
};

/* gp-rel pointer owned by Textsys.obj. */
char *wordFile;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void TextSys_LoadWordsGeneric(int language,char *path);
void TextSys_LoadInGame(int language);
void TextSys_LoadWords(int language);
char * TextSys_Word(int wordnum);
int TextSys_WordFlags(int wordnum);
int TextSys_WordX(int wordnum);
int TextSys_WordY(int wordnum);
void TextSys_UnloadWords(void);


/* ---- TextSys_LoadWordsGeneric__FiPc  [TEXTSYS.CPP:41-52] SLD-VERIFIED ---- */
void TextSys_LoadWordsGeneric(int language,char *path)

{
  char string [250];

  if (language < 7) {
    if (wordFile != (char *)0x0) {
      purgememadr(wordFile);
    }
    /* @0x800B91B0 sprintf(string,"%s%s",path,langFileName[language]) -- return discarded;
     * @0x800B91BC/C4 wordFile = loadfileadr(string,0) ($v0). The reconstruction captured
     * sprintf's byte-count return into wordFile and discarded loadfileadr's pointer (H44). */
    sprintf(string,"%s%s",path,langFileName[language]);
    wordFile = (char *)loadfileadr(string,0);
  }
  return;
}

/* ---- TextSys_LoadInGame__Fi  [TEXTSYS.CPP:55-58] SLD-VERIFIED ---- */
void TextSys_LoadInGame(int language)

{
  char fullpath [80];
  
  sprintf(fullpath,"%s%s",Paths_Paths[0x1a],"p");
  TextSys_LoadWordsGeneric(language,fullpath);
  return;
}

/* ---- TextSys_LoadWords__Fi  [TEXTSYS.CPP:62-63] SLD-VERIFIED ---- */
void TextSys_LoadWords(int language)

{
  TextSys_LoadWordsGeneric(language,Paths_Paths[0x22]);
  return;
}

/* ---- TextSys_Word__Fi  [TEXTSYS.CPP:69-75] SLD-VERIFIED ---- */
char * TextSys_Word(int wordnum)

{
  /* ORIGINAL-NAME-RECOVERED: offset -- the symbol-bearing NFS2 Textsys.c
     retains this name for the same 12-byte word-table lookup. */
  /* ORIGINAL-NAME-RECOVERED: phrase -- the same symbol-bearing function
     retains this name for the resolved string pointer. */
  int *offset;
  char *phrase;

  offset = (int *)(wordFile + wordnum * 12 + 8);
  phrase = wordFile + *offset;
  return phrase;
}

/* ---- TextSys_WordFlags__Fi  [TEXTSYS.CPP:120-126] SLD-VERIFIED ---- */
int TextSys_WordFlags(int wordnum)

{
  /* ORIGINAL-NAME-RECOVERED: sptr -- retained by the symbol-bearing NFS2
     Textsys.c implementation of the same flags lookup. */
  /* ORIGINAL-NAME-RECOVERED: s -- the same symbol-bearing function retains
     this name for the zero-extended flags result. */
  char *sptr;
  int s;

  sptr = wordFile + wordnum * 12 + 3;
  s = *sptr & 0xff;
  return s;
}

/* ---- TextSys_WordX__Fi  [TEXTSYS.CPP:132-141] SLD-VERIFIED ---- */
int TextSys_WordX(int wordnum)

{
  /* ORIGINAL-NAME-RECOVERED: xptr -- retained by the symbol-bearing NFS2
     Textsys.c implementation of the same X-coordinate lookup. */
  /* ORIGINAL-NAME-RECOVERED: x -- the same symbol-bearing function retains
     this name for the loaded coordinate. */
  short *xptr;
  int x;

  xptr = (short *)(wordFile + wordnum * 12 + 4);
  x = *xptr;
  return x;
}

/* ---- TextSys_WordY__Fi  [TEXTSYS.CPP:147-156] SLD-VERIFIED ---- */
int TextSys_WordY(int wordnum)

{
  /* ORIGINAL-NAME-RECOVERED: yptr -- retained by the symbol-bearing NFS2
     Textsys.c implementation of the same Y-coordinate lookup. */
  /* ORIGINAL-NAME-RECOVERED: y -- the same symbol-bearing function retains
     this name for the loaded coordinate. */
  short *yptr;
  int y;

  yptr = (short *)(wordFile + wordnum * 12 + 6);
  y = *yptr;
  return y;
}

/* ---- TextSys_UnloadWords__Fv  [TEXTSYS.CPP:162-165] SLD-VERIFIED ---- */
void TextSys_UnloadWords(void)

{
  if (wordFile != (char *)0x0) {
    purgememadr(wordFile);
  }
  wordFile = (char *)0x0;
  return;
}

/* end of textsys.cpp */
