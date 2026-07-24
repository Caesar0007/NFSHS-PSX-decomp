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

extern FntStream _fnt[8];       /* @0x80135E58 : open font streams */
extern int _fnt_count;          /* @0x80135FD8 : number of open streams */
extern int _fnt_active;         /* @0x80135FDC : current active stream id */
extern char *D_801369E4;        /* @0x801369E4 : "0123456789ABCDEF" */

/* @0x800F6D18 : convert a stream's accumulated text into font sprites and draw the OT.
 * An out-of-range id falls back to the active stream; if THAT stream has no text buffer
 * (never opened) the call is a no-op returning NULL.
 * NEAR-MISS (verify_asm ~258/209 vs 199): structurally correct (entry bounds check, r/g/b
 * digit-escape decode, do-while loop shape and the &fs->ot address-escape spill all confirmed
 * against the raw and now present) but the register roles cascade differently past the entry
 * block (fp/s7/s2/s6 role reassignment) -- allocator coloring, not semantics. Left as a floor. */
extern "C" u_long *FntFlush(int id)
{
    FntStream *fs;
    int r = 0x80, g = 0x80, b = 0x80;   /* default glyph colour */
    int   maxx = 0;

    if (!(id >= 0 && id < _fnt_count)) {
        FntStream *act = &_fnt[_fnt_active];
        if (act->textbuf == NULL)
            return NULL;
        id = _fnt_active;
    }
    fs = &_fnt[id];
    u_long *ot = &fs->ot;      /* address escapes across the AddPrim/DrawOTag calls below --
                                 * high register pressure spills it to the stack (reloaded at
                                 * each use), rather than the cheaper fs+0x10 rematerialization. */

    u_char *text  = (u_char *)fs->textbuf;
    int   remain  = fs->maxchars;
    int   curx    = fs->x;
    int   cury    = fs->y;
    int   boty    = cury + fs->h;
    u_char *p     = (u_char *)fs->primbuf;
    int   autoupd = fs->autoupd;
    int   rightx  = fs->x + fs->w;

    TermPrim(ot);
    for (; *text != 0; remain--) {
        if (remain == 0) break;
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
        } else if (c == 0x7e) {                       /* '~c<r><g><b>' colour escape: r/g/b are
                                                         * ASCII DIGITS ('0'-'9'), not raw bytes. */
            if (text[1] == 'c') {
                next = text + 4;
                r = (text[2] - 0x30) << 4;
                g = (text[3] - 0x30) << 4;
                b = (text[4] - 0x30) << 4;
            }
        } else {
render:
            {
                int idx = ((unsigned)(c - 0x61) < 0x1A) ? (int)(signed char)c - 0x40 : (int)(char)c - 0x20;
                int q   = (idx < 0) ? idx + 0xf : idx;
                p[0xc] = (u_char)((idx - (q >> 4) * 0x10) * 8);   /* u */
                p[0xd] = (u_char)((q >> 4) << 3);                 /* v */
                *(short *)(p + 8)  = (short)curx;
                *(short *)(p + 10) = (short)cury;
                p[4] = (u_char)r;
                p[5] = (u_char)g;
                p[6] = (u_char)b;
                AddPrim(ot, p);
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
        AddPrim(ot, fs);
        if (autoupd != 0) {
            fs->w = (short)(maxx - fs->x);
            fs->h = (short)(cury - (fs->y - 8));
        }
    }
    DrawOTag(ot);
    fs->textlen = 0;
    fs->textbuf[0] = 0;
    return ot;
}

/* @0x800F7034 : printf-style append into a stream's text buffer (%x/%X/%c/%d/%s + width).
 * Psy-Q also accepts the format string itself as the first argument, selecting the active stream.
 * NEAR-MISS (verify_asm ~103/241 vs 240): the vararg reads are hand-rolled pointer bumps
 * (`*(T*)args; args += 4;`), not the stdarg.h `va_arg()` macro -- the oracle DEREFERENCES
 * before advancing the cursor (matches this shape), while the project's va_arg macro expands
 * to advance-then-dereference-old (verified: switching back regresses 103->125). Residual is a
 * commutative constant-register tie ('%'=37 vs the /10 magic-multiply constant, s4<->s5) plus
 * an a0/a2 role tie in the entry bounds check -- both tried in both orders, allocator coloring. */
#define WriteChar(c)                                                        \
    fs->textbuf[fs->textlen++] = (c);                                       \
    if (fs->textlen > fs->maxchars) {                                       \
        return -1;                                                          \
    }

extern "C" int FntPrint(const char *id, ...)
{
    char buf[0x200];
    va_list args;
    FntStream *fs;
    u_char padZeros;
    int num;
    int len;
    int width;
    signed char *f;
    char *bufPtr;
    char sign;
    unsigned int ch;

    va_start(args, id);
    if ((int)id < 0 || (int)id >= _fnt_count) {
        f = (signed char *)id;
        id = (const char *)_fnt_active;
        if (_fnt[(int)id].textbuf == NULL)
            return -1;
    } else {
        f = *(signed char **)args; args = (void *)((char *)args + 4);
    }

    fs = &_fnt[(int)id];
    if (fs->textlen > fs->maxchars)
        return -1;

    for (; ch = *f, ch; ++f) {
        if (ch != '%') {
            WriteChar(ch);
            continue;
        }

        ch = *++f;
        if (ch == '%') {
            WriteChar('%');
            continue;
        }

        width = 0;
        padZeros = ch == '0';
        while (ch >= '0' && ch <= '9') {
            width = (width * 10) + (ch - '0');
            ch = *++f;
        }
        bufPtr = (char *)&args;
        if (width <= 0)
            width = 1;

        switch (ch) {
        case 'd':
            num = *(int *)args; args = (void *)((char *)args + 4);
            sign = 0;
            if (num < 0) {
                num = -num;
                sign = '-';
            }
            len = 0;
            do {
                do {
                    *--bufPtr = (num % 10U) + '0';
                    num /= 10U;
                    len++;
                } while (len == 0);
            } while (num != 0);
            if (sign != 0) {
                *--bufPtr = sign;
                len++;
            }
            break;

        case 'X':
        case 'x':
            len = 0;
            num = *(int *)args; args = (void *)((char *)args + 4);
            do {
                do {
                    *--bufPtr = D_801369E4[num % 16U];
                    num /= 16U;
                    len++;
                } while (len == 0);
            } while (num != 0);
            if (padZeros) {
                while (len < width) {
                    *--bufPtr = '0';
                    len++;
                }
            }
            break;

        case 'c':
            *--bufPtr = (char)(*(int *)args); args = (void *)((char *)args + 4);
            len = 1;
            break;

        case 's':
            bufPtr = *(char **)args; args = (void *)((char *)args + 4);
            len = strlen(bufPtr);
            break;
        }

        while (len < width) {
            WriteChar(' ');
            width--;
        }
        len--;
        while (len != -1) {
            WriteChar(*bufPtr++);
            len--;
        }
    }
    fs->textbuf[fs->textlen] = 0;
    return fs->textlen;
}
#undef WriteChar
