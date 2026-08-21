/* game/psx/textpix.c -- RECONSTRUCTED (NFS4 PSX text pixel-width calc)
 *   C TU: SLD source = C:\nfs4\GAME\PSX\TEXTPIX.C -> CC1PSX lane (methodology 3.25;
 *   migrated from textpix.cpp, task #90). Self-contained per C-lane convention.
 *   2 free fns: textnpixels(str,n) sums glyph advance widths over up to n decoded code-points
 *   (decoder fn-ptr read off the currentfont blob reads+advances the string; getcharacter()
 *   -> glyph block, advance byte at charactertbl+8); textpixels(string) = textnpixels(string, 0x100).
 */

#include "font_types.h"

extern unsigned char currentfont[];      /* font-state blob @ 0x80135ba0 */
extern FONTFILECHAR *getcharacter(int code);   /* eaclib EACPSXZ glyph-info lookup */

/* ---- textnpixels  [TEXTPIX.C:61-98] SLD-VERIFIED ---- */
int textnpixels(char *str, int n)
{
  FONTFILECHAR *ch;
  int code;
  int stringlen;
  int i;
  int dx;
  unsigned char *fontbase;

  i = 0;
  stringlen = 0;
  if (0 < n) {
    fontbase = currentfont;
    do {
      code = (*(getcode *)(fontbase + 0xa0))(&str);
      if (code == 0) {
        return stringlen;
      }
      i = i + 1;
      ch = getcharacter(code);
      if (ch != 0) {
        dx = (signed char)ch->advance;
        stringlen = stringlen + dx;
      }
    } while (i < n);
  }
  return stringlen;
}

/* ---- textpixels  [TEXTPIX.C:101-102] SLD-VERIFIED ---- */
int textpixels(char *string)
{
  return textnpixels(string, 0x100);
}

/* end of textpix.c */
