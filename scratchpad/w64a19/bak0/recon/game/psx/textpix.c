/* game/psx/textpix.c -- RECONSTRUCTED (NFS4 PSX text pixel-width calc)
 *   C TU: SLD source = C:\nfs4\GAME\PSX\TEXTPIX.C -> CC1PSX lane (methodology 3.25;
 *   migrated from textpix.cpp, task #90). Self-contained per C-lane convention.
 *   2 free fns: textnpixels(str,n) sums glyph advance widths over up to n decoded code-points
 *   (decoder fn-ptr read off the currentfont blob reads+advances the string; getcharacter()
 *   -> glyph block, advance byte at charactertbl+8); textpixels(string) = textnpixels(string, 0x100).
 */

/* glyph-info record (matches nfs4_types.h charactertbl, 11 bytes) */
typedef struct charactertbl {
    unsigned char index[2];              /* +0x0 */
    unsigned char width, height;         /* +0x2 */
    unsigned char u[2], v[2];            /* +0x4 */
    char          advance, xoffset, yoffset;   /* +0x8 */
} charactertbl;

/* SJIS/ANSI code-point reader: reads the next glyph code from *str and advances *str.
 * The active decoder is selected by setfont and stored in the currentfont fn-ptr slot. */
typedef int (*FontDecoder)(char **str);

extern unsigned char currentfont[];      /* font-state blob @ 0x80135ba0 */
extern charactertbl *getcharacter(int code);   /* eaclib EACPSXZ glyph-info lookup */

/* ---- textnpixels  [TEXTPIX.C:61-98] SLD-VERIFIED ---- */
int textnpixels(char *str, int n)
{
  charactertbl *ch;
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
      code = (*(FontDecoder *)(fontbase + 0xa0))(&str);
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
