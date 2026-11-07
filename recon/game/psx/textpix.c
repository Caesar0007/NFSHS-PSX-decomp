/* game/psx/textpix.c -- RECONSTRUCTED (NFS4 PSX text pixel-width calc)
 *   C TU: SLD source = C:\nfs4\GAME\PSX\TEXTPIX.C -> CC1PSX lane (methodology 3.25;
 *   migrated from textpix.cpp, task #90). Self-contained per C-lane convention.
 *   2 free fns: textnpixels(str,n) sums glyph advance widths over up to n decoded code-points
 *   (decoder fn-ptr read off the currentfont blob reads+advances the string; getcharacter()
 *   -> glyph block, advance byte at charactertbl+8); textpixels(string) = textnpixels(string, 0x100).
 */

#include "font_types.h"

extern unsigned char currentfont[];      /* font-state blob @ 0x80135ba0 */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
#ifdef __cplusplus
extern "C" {
#endif
#include "eaclib/psx/eacpsxz/textfor.h"
#ifdef __cplusplus
}
#endif

/* ---- textnpixels  [TEXTPIX.C:61-98] SLD-VERIFIED ---- */

#line 60 "C:/nfs4/GAME/PSX/TEXTPIX.C"
int textnpixels(char *str, int n)
{
  int code;
  int stringlen;
  int i;


  unsigned char *fontbase; /* SYM-CODEGEN-CARRIER: fontbase -- every direct/cast/index form folds to %hi/%lo(currentfont+160) (FAIL 5, 36/37); a stmt-expr base ({ currentfont; }) + 0xa0 = PASS but +6 blocks (GAME11) */ i = 0;






  stringlen = 0; while (i < n) {

      struct charactertbl *ch;
      fontbase = currentfont;

      code = (*(getcode *)(fontbase + 0xa0))(&str);
      if (code == 0) {
        break;
      }
      i = i + 1;
      ch = getcharacter(code);
      if (ch != 0) {

        int dx = (signed char)ch->advance;






        stringlen = stringlen + dx;
      }
    }
  return stringlen;
}

/* ---- textpixels  [TEXTPIX.C:101-102] SLD-VERIFIED ---- */

#line 100 "C:/nfs4/GAME/PSX/TEXTPIX.C"
int textpixels(char *string)
{
  return textnpixels(string, 0x100);
}

/* end of textpix.c */
