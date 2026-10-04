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
extern char *langFileName[6];   /* defined after the first function (see below) */

/* gp-rel pointer owned by Textsys.obj. */
/* Initialized => emitted HERE, ahead of the function literals ("%s%s", "p"):
 * retail textsys.obj .sdata is wordFile 0x8013d458 / "%s%s" d45c / "p" d464. */
char *wordFile = 0;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void TextSys_LoadWordsGeneric(int language,char *path);
void TextSys_LoadInGame(int language);
void TextSys_LoadWords(int language);
char * TextSys_Word(int wordnum);
int TextSys_WordFlags(int wordnum);
int TextSys_WordX(int wordnum);
int TextSys_WordY(int wordnum);
void TextSys_UnloadWords(void);


/* ---- TextSys_LoadWordsGeneric__FiPc  [TEXTSYS.CPP:41-52]
 * Native SYM exact; 28/33 SLD tags exact, final epilogue region open. ---- */
/* The "SimpleMem" tag at 0x800565E4 in front of these strings belongs
 * to stats.obj: retail SYM shows Textsys.obj never saw that header.
 * The loadfileadr return, not sprintf's byte count, owns wordFile.
 * Raw calls: sprintf @0x800B91B0; loadfileadr @0x800B91BC/C4. */
void TextSys_LoadWordsGeneric(int language,char *path)

{
  char string [250];

  if (language < 7) {


    if (wordFile != (char *)0x0) {
      purgememadr(wordFile); }
    sprintf(string,"%s%s",path,langFileName[language]);

    wordFile = (char *)loadfileadr(string,0);
  }
}

/* Textsys.obj: the language file names (.rodata 0x800565F0..) and their pointer table (.data).  Defined HERE, after
   the first function, because retail emits the "SimpleMem" tag ahead of these strings. */
char *langFileName[6] = {
  "text.eng", "text.ger", "text.fre",
  "text.spa", "text.ita", "text.swe"
};

/* ---- TextSys_LoadInGame__Fi  [TEXTSYS.CPP:55-58] SLD-VERIFIED ---- */
void TextSys_LoadInGame(int language)

{
  char fullpath [80];
  sprintf(fullpath,"%s%s",Paths_Paths[0x1a],"p");
  TextSys_LoadWordsGeneric(language,fullpath);
}

/* ---- TextSys_LoadWords__Fi  [TEXTSYS.CPP:62-63] SLD-VERIFIED ---- */
void TextSys_LoadWords(int language)

{
  TextSys_LoadWordsGeneric(language,Paths_Paths[0x22]);
}

/* ---- TextSys_Word__Fi  [TEXTSYS.CPP:69-75] SLD-VERIFIED ---- */
/* ORIGINAL-NAME-RECOVERED: offset and phrase are retained by the
 * symbol-bearing NFS2 Textsys.c for the same 12-byte lookup. */
char * TextSys_Word(int wordnum)

{
  int *offset;
  char *phrase;

  offset = (int *)(wordFile + wordnum * 12 + 8);
  phrase = wordFile + *offset;
  return phrase;
}

/* ---- TextSys_WordFlags__Fi  [TEXTSYS.CPP:120-126] SLD-VERIFIED ---- */
/* ORIGINAL-NAME-RECOVERED: sptr and s are retained by the
 * symbol-bearing NFS2 Textsys.c flags lookup. */
int TextSys_WordFlags(int wordnum)

{
  char *sptr;
  int s;

  sptr = wordFile + wordnum * 12 + 3;
  s = *sptr & 0xff;
  return s;
}

/* ---- TextSys_WordX__Fi  [TEXTSYS.CPP:132-141] SLD-VERIFIED ---- */
/* ORIGINAL-NAME-RECOVERED: xptr and x are retained by the
 * symbol-bearing NFS2 Textsys.c X-coordinate lookup. */
int TextSys_WordX(int wordnum)

{
  short *xptr;
  int x;

  xptr = (short *)(wordFile + wordnum * 12 + 4);



  x = *xptr;
  return x;
}

/* ---- TextSys_WordY__Fi  [TEXTSYS.CPP:147-156] SLD-VERIFIED ---- */
/* ORIGINAL-NAME-RECOVERED: yptr and y are retained by the
 * symbol-bearing NFS2 Textsys.c Y-coordinate lookup. */
int TextSys_WordY(int wordnum)

{
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
    purgememadr(wordFile); }
  wordFile = (char *)0x0;
}

/* end of textsys.cpp */
