/* syslib/psx/libgpu/FONT.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3; Ghidra
 *   mangled the id-bounds checks).  obj libgpu.lib(FONT.OBJ): the PsyQ debug-font printer.
 *
 *   COMPILED AS C by USER RULING (2026-07-25, uniformity over diff count): cc1plus (C++) measured
 *   strictly better per-fn diff counts than cc1 (C) on this TU -- FntFlush 252->350 (w26-a1
 *   dual-compile audit). Migrated anyway for source-uniformity across syslib/eaclib. Do NOT revert
 *   to .cpp without a user decision; see recon/syslib/psx/libcd/cdread.c,
 *   recon/syslib/psx/libcd/iso9660.c and recon/eaclib/psx/eacpsxz/cdfs.c for the sibling KEEP-CPP-
 *   turned-uniform TUs (same ruling, same date). C89 dialect fix note: `bool wrap` -> `int wrap`
 *   (no bool keyword in C89) and FntFlush's post-`if` locals (ot/text/p/curx/cury/boty/remain/
 *   autoupd/rightx) hoisted to plain declarations at function top with their computation moved to
 *   separate assignment statements after `fs = &_fnt[id];` (C89 forbids declarations after
 *   statements in the same block; the original interspersed decl+init form is C++-only).
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

extern void  TermPrim(void *p);          /* libgpu P09 @0x80107020 */
extern void  AddPrim(void *ot, void *p); /* libgpu P06 @0x80107040 */
extern void  DrawOTag(u_long *ot);       /* libgpu SYS @0x800EDCB4 */
extern unsigned strlen(const char *s);   /* libc C27 (returns int in the original) */

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
typedef struct FntStream FntStream;

extern FntStream _fnt[8];       /* @0x80135E58 : open font streams */
extern int _fnt_count;          /* @0x80135FD8 : number of open streams */
extern int _fnt_active;         /* @0x80135FDC : current active stream id */
extern char *D_801369E4;        /* @0x801369E4 : "0123456789ABCDEF" */

/* @0x800F6D18 : convert a stream's accumulated text into font sprites and draw the OT.
 * An out-of-range id falls back to the active stream; if THAT stream has no text buffer
 * (never opened) the call is a no-op returning NULL.
 * NEAR-MISS (verify_asm 252/209 vs 199, improved from 258 this wave -- w24-a5): structurally
 * correct (entry bounds check, r/g/b digit-escape decode, do-while loop shape and the &fs->ot
 * address-escape spill all confirmed against the raw and present) but the register roles
 * cascade differently past the entry block -- allocator coloring, not semantics. Left as a
 * (weak) floor: real headroom likely remains, this is not exhausted.
 * w24-a5 PINPOINTED the concrete allocator delta: the oracle keeps `remain` (fs->maxchars
 * countdown) resident in $fp for the whole function and fills $s2 with `p` (fs->primbuf) right
 * in the entry block; our build instead put `rightx` (fs->x+fs->w) in $fp, left $s2 UNUSED in
 * the entry block, and shuttled `remain` through a caller-saved temp straight to a NEW stack
 * slot (frame 96B vs the oracle's 80B). Also: the oracle materializes the r/g glyph-colour
 * defaults (sw a2,0x1C/0x20(sp)) BEFORE the callee-save push block; ours does all three r/g/b
 * AFTER it (unresolved, see below).
 * TRIED THIS WAVE: (1) reordering `remain/curx/cury/boty/p/autoupd/rightx` local declarations
 * with `remain` alone moved later -- ZERO effect (not a simple declaration-order-only lever).
 * (2) `for`->`while`-with-trailing-decrement desugar of the main loop -- zero effect (gcc
 * lowers both identically here). (3) **moving `u_char *p` to be declared 2nd (right after
 * `text`, before `remain`) -- WORKED, 258->252, applied below.** It still doesn't get `p` into
 * $s2 (oracle's slot) or free a register for `remain` (both still off), but it measurably
 * changes downstream coloring for the better with zero regressions -- keep building on this
 * lever (try moving `p` even earlier / paired with `curx`,`cury` reordering next) rather than
 * re-trying (1)/(2). NOTE: `boty` is a dead end for the $s2-pressure theory -- it's
 * stack-cached in BOTH builds (never register-resident in the oracle either), so
 * eliminating its local won't free a register. */
/* MATCH (w51-a8, 2026-08-09): FntFlush's loop body is TRANSPLANTED from the
 * byte-matched PsyQ sibling `C:\Temp\psyz\decomp\src\libgpuont.c` (Xeeynamo's
 * psyz, PsyQ 4.7 / gcc-2.7.2 -- a MATCHED, non-INCLUDE_ASM FntFlush).  The vendor
 * shape differs from the earlier hand reconstruction in four load-bearing ways and
 * takes the fn 250 -> 184 diffs, 211 -> 203 insns (oracle 199):
 *   (1) loop control = `c = *text; while (c) { if (!remain) break; ... c = *++text;
 *       if (!c) break; remain--; }` -- the char is held in a fn-scope int, the
 *       capacity countdown happens at the very END of the body (after the second
 *       exit test), NOT in a `for`-increment;
 *   (2) the dispatch is `c2 = c & 0xFF` + `c2 != ' '` / `c2 <= ' '` with a real
 *       `switch` on TAB/LF and goto-labels do_tab / do_char / check_x /
 *       set_linebreak -- one shared wrap-flag block reached from three edges;
 *   (3) the `~c<r><g><b>` escape WALKS the cursor in place (`*++text`) instead of
 *       computing a `next = text + 4` and indexing off it;
 *   (4) the glyph index uses the vendor's `%16`/`/16` pair on a plain int
 *       (`u = (c2 % 16) * 8; v = (c2 / 16) * 8;`) rather than a hand-decoded
 *       shift/multiply chain.
 * Residual 184 @203-vs-199: still 4 insns long and the callee-saved band is
 * rotated (frame 88 vs the oracle's 80); the w24-a5 `remain`-in-$fp / `p`-in-$s2
 * analysis below still describes it. */
extern u_long *FntFlush(int id)
{
    FntStream *fs;
    int r = 0x80, g = 0x80, b = 0x80;   /* default glyph colour */
    int   maxx = 0;
    u_long *ot;                /* address escapes across the AddPrim/DrawOTag calls below --
                                 * high register pressure spills it to the stack (reloaded at
                                 * each use), rather than the cheaper fs+0x10 rematerialization. */
    u_char *text;
    u_char *p;
    int   curx;
    int   cury;
    int   boty;
    int   remain;
    int   autoupd;
    int   rightx;
    int   c, c2, wrap;
    u_char u, v;

    if (!(id >= 0 && id < _fnt_count)) {
        FntStream *act = &_fnt[_fnt_active];
        if (act->textbuf == NULL)
            return NULL;
        id = _fnt_active;
    }
    fs = &_fnt[id];
    ot = &fs->ot;

    text    = (u_char *)fs->textbuf;
    p       = (u_char *)fs->primbuf;
    curx    = fs->x;
    cury    = fs->y;
    boty    = cury + fs->h;
    remain  = fs->maxchars;
    autoupd = fs->autoupd;
    rightx  = fs->x + fs->w;

    TermPrim(ot);
    c = *text;
    while (c) {
        if (!remain) break;
        wrap = 0;
        c2 = c & 0xFF;
        if (c2 != ' ') {
            if (c2 <= ' ') {
                switch (c2) {
                case 9:  goto do_tab;
                case 10: goto set_linebreak;
                }
                goto do_char;
            } else if (c2 == '~') {
                if (*++text == 'c') {
                    r = 16 * (*++text - 48);
                    g = 16 * (*++text - 48);
                    b = 16 * (*++text - 48);
                }
            } else {
                goto do_char;
            do_tab:
                curx += 0x20;
                goto check_x;
            do_char:
                c2 = *text;
                if (c2 >= 'a' && c2 <= 'z') c2 -= 0x40; else c2 -= 0x20;
                u = (c2 % 16) * 8;
                v = (c2 / 16) * 8;
                p[0xc] = u;
                p[0xd] = v;
                *(short *)(p + 8)  = (short)curx;
                *(short *)(p + 10) = (short)cury;
                p[4] = (u_char)r;
                p[5] = (u_char)g;
                p[6] = (u_char)b;
                AddPrim(ot, p);
                p += 0x10;
                curx += 8;
            check_x:
                if (curx >= rightx && !autoupd) {
                set_linebreak:
                    wrap = 1;
                }
            }
        } else {
            curx += 8;
            if (curx >= rightx && !autoupd) wrap = 1;
        }
        if (wrap) {
            if (maxx < curx) maxx = curx;
            cury += 8;
            curx = fs->x;
            if (cury >= boty) break;
        }
        c = *++text;
        if (!c) break;
        remain--;
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
 * NEAR-MISS (verify_asm 97/239 vs 240, improved from 103/241 this wave -- w24-a5): the vararg
 * reads are hand-rolled pointer bumps (`*(T*)args; args += 4;`), not the stdarg.h `va_arg()`
 * macro -- the oracle DEREFERENCES before advancing the cursor (matches this shape), while the
 * project's va_arg macro expands to advance-then-dereference-old (verified: switching back
 * regresses badly). A previously-documented "commutative constant-register tie ('%'=37 vs the
 * /10 magic-multiply constant, s4<->s5) plus an a0/a2 role tie in the entry bounds check" was
 * tried in both orders with zero effect -- true. w24-a5 found a DIFFERENT, working lever on the
 * same entry block: replacing the repeated inline `(int)id` casts with ONE named `int idn`
 * local (computed once right after `va_start`, cast back to `id` only where the original
 * pointer type is still needed) dropped 103->97 and 241->239 insns, zero regressions -- this is
 * a genuinely different shape from the already-tried operand-order swaps (same VALUE, different
 * SOURCE REPRESENTATION: named int vs repeated pointer-to-int casts). The oracle still puts
 * `addu s3,a0,zero` (a0->s3, i.e. id/f) in a different cycle slot than ours in the
 * fnt_active-resolution block -- that specific tie is still open; the s4/s5 constant swap
 * (37 vs the magic /10 divisor) is also still open and per the prior note not worth re-trying
 * via reordering. */
#define WriteChar(c)                                                        \
    fs->textbuf[fs->textlen++] = (c);                                       \
    if (fs->textlen > fs->maxchars) {                                       \
        return -1;                                                          \
    }

extern int FntPrint(const char *id, ...)
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

    int idn;

    va_start(args, id);
    idn = (int)id;
    if (idn < 0 || idn >= _fnt_count) {
        f = (signed char *)id;
        idn = _fnt_active;
        if (_fnt[idn].textbuf == NULL)
            return -1;
    } else {
        f = *(signed char **)args; args = (void *)((char *)args + 4);
    }
    id = (const char *)idn;

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
