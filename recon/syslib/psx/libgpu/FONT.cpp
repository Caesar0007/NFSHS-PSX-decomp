/* syslib/psx/libgpu/FONT.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3; Ghidra
 *   mangled the id-bounds checks).  obj libgpu.lib(FONT.OBJ): the PsyQ debug-font printer.
 *
 *   A FntStream (0x30 B, array @0x80135E58, count @0x80135FD8, active id @0x80135FDC) is a
 *   self-describing text overlay: its first 16 bytes double as a TILE background-box primitive
 *   (tag/colour/x/y/w/h), its `ot` field heads the per-character sprite list, and textbuf/textlen
 *   accumulate the formatted string.  FntPrint formats into textbuf; FntFlush turns the text into
 *   8x8 font sprites and draws the OT.  The character glyph index is
 *   (c >= 'a' ? c - 0x40 : c - 0x20), laid out in a 16-wide 8x8 font texture.
 *
 *   `id` selects a stream: a valid (0 <= id < count) id is used directly, otherwise the active
 *   stream is used.  (Ghidra rendered the bounds as the impossible `id<0 || id>=-1` -- disasm
 *   gives the real test.) */

typedef unsigned long  u_long;
typedef unsigned char  u_char;
typedef unsigned short u_short;

#include <stdarg.h>
#include <stddef.h>   /* NULL */

extern "C" void  TermPrim(void *p);          /* libgpu P09 @0x80107020 */
extern "C" void  AddPrim(void *ot, void *p); /* libgpu P06 @0x80107040 */
extern "C" void  DrawOTag(u_long *ot);       /* libgpu SYS @0x800EDCB4 */
extern "C" unsigned strlen(const char *s);   /* libc C27 (returns int in the original) */

struct FntStream {              /* 0x30 bytes; @0x80135E58 + id*0x30 */
    u_long tag;                 /* +0x00 : TILE bg-box tag */
    u_char r, g, b, code;       /* +0x04 : bg-box colour + GPU code (code != 0 => draw box) */
    short  x, y;                /* +0x08 : clip / box origin */
    short  w, h;                /* +0x0C : clip / box size */
    u_long ot;                  /* +0x10 : sprite OT head ('this') */
    int    _u14, _u18;          /* +0x14, +0x18 */
    int    maxchars;            /* +0x1C : text capacity */
    void  *primbuf;             /* +0x20 : per-character sprite buffer */
    char  *textbuf;             /* +0x24 : accumulated text */
    int    textlen;             /* +0x28 : current text length */
    int    autoupd;             /* +0x2C : auto-fit the clip box to the text */
};

static FntStream _fnt[8];       /* @0x80135E58 : open font streams */
static int _fnt_count;          /* @0x80135FD8 : number of open streams */
static int _fnt_active;         /* @0x80135FDC : current active stream id */

static FntStream *fnt_pick(int id)
{
    if (id >= 0 && id < _fnt_count)
        return &_fnt[id];
    return &_fnt[_fnt_active];
}

/* @0x800F6D18 : convert a stream's accumulated text into font sprites and draw the OT. */
extern "C" u_long *FntFlush(int id)
{
    FntStream *fs = fnt_pick(id);
    char r = (char)0x80, g = (char)0x80, b = (char)0x80;   /* default glyph colour */
    int   maxx = 0;
    u_char *text  = (u_char *)fs->textbuf;
    int   remain  = fs->maxchars;
    int   curx    = fs->x;
    int   cury    = fs->y;
    int   boty    = cury + fs->h;
    u_char *p     = (u_char *)fs->primbuf;
    int   autoupd = fs->autoupd;
    int   rightx  = fs->x + fs->w;

    TermPrim(&fs->ot);
    for (; *text != 0 && remain != 0; remain--) {
        u_char  c    = *text;
        bool    wrap = false;
        u_char *next = text;
        if (c == 0x20) {                              /* space */
            curx += 8;
            if (curx >= rightx && autoupd == 0) wrap = true;
        } else if (c < '!') {
            if (c == 9) {                             /* tab */
                curx += 0x20;
                if (curx >= rightx && autoupd == 0) wrap = true;
            } else if (c == 10) {                     /* newline */
                wrap = true;
            } else {
                goto render;
            }
        } else if (c == 0x7e) {                       /* '~c<r><g><b>' colour escape */
            if (text[1] == 'c') {
                next = text + 4;
                r = (char)(text[2] << 4);
                g = (char)(text[3] << 4);
                b = (char)(text[4] << 4);
            }
        } else {
render:
            {
                int idx = ((unsigned)(c - 0x61) < 0x1A) ? (int)(char)c - 0x40 : (int)(char)c - 0x20;
                int q   = (idx < 0) ? idx + 0xf : idx;
                p[0xc] = (u_char)((idx - (q >> 4) * 0x10) * 8);   /* u */
                p[0xd] = (u_char)((q >> 4) << 3);                 /* v */
                *(short *)(p + 8)  = (short)curx;
                *(short *)(p + 10) = (short)cury;
                p[4] = (u_char)r;
                p[5] = (u_char)g;
                p[6] = (u_char)b;
                AddPrim(&fs->ot, p);
                p += 0x10;
            }
            curx += 8;
            if (curx >= rightx && autoupd == 0) wrap = true;
        }
        if (wrap) {
            if (maxx < curx) maxx = curx;
            cury += 8;
            curx = fs->x;
            if (boty <= cury) break;
        }
        text = next + 1;
    }
    if (fs->code != 0) {                              /* draw the background box */
        AddPrim(&fs->ot, fs);
        if (autoupd != 0) {
            fs->w = (short)(maxx - fs->x);
            fs->h = (short)(cury - (fs->y - 8));
        }
    }
    DrawOTag(&fs->ot);
    fs->textlen = 0;
    fs->textbuf[0] = 0;
    return &fs->ot;
}

/* @0x800F7034 : printf-style append into a stream's text buffer (%x/%X/%c/%d/%s + width). */
extern "C" int FntPrint(int id, const char *format, ...)
{
    FntStream *fs = fnt_pick(id);
    if (fs->textlen > fs->maxchars)
        return -1;
    va_list ap;
    va_start(ap, format);

    const char *f = format;
    char c = *f;
    while (c != 0) {
        if (c == '%') {
            f++;
            c = *f;
            if (c == '%') {
                fs->textbuf[fs->textlen++] = c;
                if (fs->maxchars < fs->textlen) { va_end(ap); return -1; }
            } else {
                int  width = 0;
                bool spacepad = (c != '0');
                while ((unsigned)(c - '0') < 10) { width = width * 10 + (c - '0'); f++; c = *f; }
                if (width < 1) width = 1;

                char tmp[16];
                char *s   = tmp + sizeof(tmp);
                int   cnt = 0;
                bool  emit_now = false;

                if (c == 'x' || c == 'X') {
                    unsigned v = va_arg(ap, unsigned);
                    do { *--s = "0123456789ABCDEF"[v & 0xf]; v >>= 4; cnt++; } while (v != 0);
                    if (!spacepad) {                  /* zero-pad */
                        while (cnt < width) { *--s = '0'; cnt++; }
                        emit_now = true;
                    }
                } else if (c == 'c') {
                    *--s = (char)va_arg(ap, int);
                    cnt = 1;
                } else if (c == 'd') {
                    int sv = va_arg(ap, int);
                    char sign = 0;
                    unsigned v = (unsigned)sv;
                    if (sv < 0) { v = (unsigned)(-sv); sign = '-'; }
                    do { *--s = (char)('0' + v % 10); v /= 10; cnt++; } while (v != 0);
                    if (sign) { *--s = sign; cnt++; emit_now = true; }
                } else if (c == 's') {
                    s = va_arg(ap, char *);
                    cnt = (int)strlen(s);
                }

                if (!emit_now) {
                    if (cnt < width) {                /* space-pad on the left */
                        do {
                            fs->textbuf[fs->textlen++] = 0x20;
                            if (fs->maxchars < fs->textlen) { va_end(ap); return -1; }
                            width--;
                        } while (cnt < width);
                    }
                }
                while (--cnt != -1) {                 /* emit the generated characters */
                    fs->textbuf[fs->textlen++] = *s++;
                    if (fs->maxchars < fs->textlen) { va_end(ap); return -1; }
                }
            }
        } else {
            fs->textbuf[fs->textlen++] = c;
            if (fs->maxchars < fs->textlen) { va_end(ap); return -1; }
        }
        f++;
        c = *f;
    }
    va_end(ap);
    fs->textbuf[fs->textlen] = 0;
    return fs->textlen;
}
