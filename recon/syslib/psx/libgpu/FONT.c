/* syslib/psx/libgpu/FONT.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3; Ghidra
 *   mangled the id-bounds checks).  obj libgpu.lib(FONT.OBJ): the PsyQ debug-font printer.
 *
 *   COMPILED AS C by USER RULING (2026-07-25, uniformity over diff count): cc1plus (C++) then
 *   measured strictly better per-fn diff counts than cc1 (C) on this TU. Do NOT revert to .cpp
 *   without a user decision; see recon/syslib/psx/libcd/cdread.c, recon/syslib/psx/libcd/iso9660.c
 *   and recon/eaclib/psx/eacpsxz/cdfs.c for the sibling KEEP-CPP-turned-uniform TUs (same ruling,
 *   same date).  [W52-A10: that C-vs-C++ penalty is now MOOT for FntFlush -- the C lane reaches
 *   6 diffs at an EXACT 199/199 instruction count once the reconstruction uses the real PsyQ
 *   types; the old gap was shape, not language.]  C89 dialect note: `bool wrap` -> `int wrap`
 *   and FntFlush's locals are plain declarations at function top with their computation in
 *   separate assignment statements (C89 forbids declarations after statements in a block).
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

typedef struct {                /* TILE (libgpu.h) : the bg-box primitive, 0x10 bytes */
    u_long tag;
    u_char r0, g0, b0, code;
    short  x0, y0;
    short  w,  h;
} TILE;

typedef struct {                /* DR_MODE (libgpu.h) : 0x0C bytes */
    u_long tag;
    u_long code[2];
} DR_MODE;

typedef struct {                /* SPRT_8 (libgpu.h) : one 8x8 glyph, 0x10 bytes */
    u_long  tag;
    u_char  r0, g0, b0, code;
    short   x0, y0;
    u_char  u0, v0;
    u_short clut;
} SPRT_8;

struct FntStream {              /* 0x30 bytes; @0x80135E58 + id*0x30 */
    TILE     tile;              /* +0x00 : bg-box primitive (code != 0 => draw box) */
    DR_MODE  draw_mode;         /* +0x10 : sprite OT head ('this') + tpage/clip words */
    int      maxchars;          /* +0x1C : text capacity */
    SPRT_8  *primbuf;           /* +0x20 : per-character sprite buffer */
    char    *textbuf;           /* +0x24 : accumulated text */
    int      textlen;           /* +0x28 : current text length */
    int      autoupd;           /* +0x2C : auto-fit the clip box to the text */
};
typedef struct FntStream FntStream;

extern FntStream _fnt[8];       /* @0x80135E58 : open font streams */
extern int _fnt_count;          /* @0x80135FD8 : number of open streams */
extern int _fnt_active;         /* @0x80135FDC : current active stream id */
extern char *D_801369E4;        /* @0x801369E4 : "0123456789ABCDEF" */

/* @0x800F6D18 : convert a stream's accumulated text into font sprites and draw the OT.
 * An out-of-range id falls back to the active stream; if THAT stream has no text buffer
 * (never opened) the call is a no-op returning NULL.
 *
 * MATCH (W52-A10, 2026-08-09): 184 -> 6 diffs, instruction count now EXACT 199/199 and the
 * frame EXACT (0x50, every stack slot at the oracle's offset: dr@0x10 maxx@0x14 boty@0x18
 * r@0x1C g@0x20 b@0x24).  Four independent shape corrections, each gate-measured; the whole
 * previous "allocator coloring cascade / weak floor" diagnosis below was WRONG -- it was
 * RECONSTRUCTION SHAPE all the way down (same lesson as P34/SetDrawMove this wave).
 *
 *   (1) REAL PsyQ TYPES instead of byte-offset casts (the big one, 184 -> 36).  FntStream is
 *       a TILE (0x00) + DR_MODE (0x10) + fields, and the glyph cursor is an `SPRT_8 *`, not a
 *       `u_char *` walked with `p += 0x10`.  Writing `p->u0/v0/x0/y0/r0/g0/b0` + `AddPrim(dr,
 *       p++)` and `AddPrim(dr, &fs->tile)` gives the oracle's addressing for free; the old
 *       hand-rolled `*(short *)(p + 8)` form cost registers and a bigger frame.  Declaration
 *       order is psyz's (dr, fs, curx/cury, maxx, boty, p, rightx, autoupd, remain, wrap,
 *       text, c2, c, u/v, r/g/b) -- that IS the oracle's stack-slot order.
 *   (2) SPLIT LOAD FROM ADD for rightx (methodology 3.12 #15b): `rightx = fs->tile.w;
 *       rightx = curx + (short)rightx;` loads `w` into its own temp early and lets gcc
 *       schedule the `addu $s7,$s1,$v0` into the TermPrim jal's delay slot, exactly as retail.
 *   (3) SIGNED-CHAR TYPING of the text cursor (36 -> 13).  `signed char *text` + `signed char
 *       c` (NOT `u_char *` / `int`): the escape-digit reads `16 * (*++text - 48)` then emit
 *       the oracle's sign-extending `lb`, the loop-carried char is a QImode pseudo loaded with
 *       `lbu` and sign-extended per use (`sll 24; sra 24` -- the oracle's shared-delay-slot
 *       pair in the a-z/else arms of do_char), and `c2 = c;` replaces the wrong `c2 = c &
 *       0xFF` (which emitted an `andi` retail does not have).  cc1 defaults `char` to
 *       UNSIGNED on this toolchain (04M/w47-a10), so the `signed` keyword is load-bearing.
 *   (4) LOOP TAIL ORDER `++text; remain--; c = *text; if (!c) break;` (13 -> 6, and the count
 *       became exact).  Retail's test block is `addiu $s0,1; addiu $fp,-1; lb; lbu; bnez`,
 *       i.e. the capacity countdown sits BEFORE the reload where it fills the load-delay slot
 *       (psyz's `c = *++text; if (!c) break; remain--;` put it in the branch delay slot
 *       instead, costing a nop AND blocking the entry-test cross-jump).  With this order gcc
 *       cross-jumps the peeled entry test into the bottom block, reproducing retail's single
 *       `j` loop entry.  `remain` is dead after the loop, so the extra decrement on the
 *       final iteration is semantically free.
 *
 * LADDER (04U, re-run on the NEW source -- the verdict changed with the shape, so re-ladder
 * after any large rewrite): wired lane (2.8 + maspsx + no_split_addresses + jtbl_at_fusion)
 * 6 diffs; ladder lane 2.6.0 108 / 2.6.3 104 / 2.7.2-970404 39 / 2.7.2 91 / 2.8.0 39 /
 * 2.8.1 39 / 2.91.66 213 / 2.95.2 170.  KEEP THE WIRED LANE.
 *
 * RESIDUAL 6, two classes, both count-neutral:
 *   (a) 4 diffs -- retail floats `sw $a2,0x1C(sp)` / `sw $a2,0x20(sp)` (the r/g defaults)
 *       ABOVE the ten callee-save stores; ours emits them after.  Pure sched2 ready-list
 *       ordering inside the prologue block.  FALSIFIED: all six init-order permutations of
 *       `maxx/r/g/b` (m,r,g,b = 6 -- best; r,m,g,b 6; r,g,m,b 6; m,b,g,r 8; r,g,b,m 10;
 *       b,g,r,m 10) -- the two stores never move across the save block.
 *   (b) 2 diffs -- the TermPrim argument: retail RELOADS `dr` from its stack slot
 *       (`sw $a2,0x10(sp); lw $a0,0x10(sp)`) while ours keeps it live in $a2 and copies
 *       (`addu $a0,$a2,$zero`).  This is reload INHERITANCE (retail's dr pseudo had no hard
 *       reg at the call, so the arg setup became a load that sched hoisted to the top).
 *       FALSIFIED: assigning `dr` immediately before the call, and calling
 *       `TermPrim(&fs->draw_mode)` directly -- both still 6.  Known no-source-lever class
 *       (catalog: choose_reload_regs / reload-inheritance identity). */
extern u_long *FntFlush(int id)
{
    DR_MODE  *dr;
    FntStream *fs;
    int    curx, cury;
    int    maxx;
    int    boty;
    SPRT_8 *p;
    int    rightx;
    int    autoupd;
    int    remain;
    int    wrap;
    signed char *text;
    int    c2;
    signed char c;
    u_char u, v;
    int    r, g, b;

    maxx = 0;
    r = 0x80; g = 0x80; b = 0x80;       /* default glyph colour */

    if (!(id >= 0 && id < _fnt_count)) {
        FntStream *act = &_fnt[_fnt_active];
        if (act->textbuf == NULL)
            return NULL;
        id = _fnt_active;
    }
    fs = &_fnt[id];
    dr = &fs->draw_mode;

    p       = fs->primbuf;
    autoupd = fs->autoupd;
    text    = (signed char *)fs->textbuf;
    remain  = fs->maxchars;
    curx    = fs->tile.x0;
    cury    = fs->tile.y0;
    rightx  = fs->tile.w;
    rightx  = curx + (short)rightx;     /* split load from add: w lands in its own temp */
    boty    = cury + fs->tile.h;

    TermPrim(dr);
    c = *text;
    while (c) {
        if (!remain) break;
        wrap = 0;
        c2 = c;
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
                c = *text;
                if (c >= 'a' && c <= 'z') c2 = c - 0x40; else c2 = c - 0x20;
                u = (c2 % 16) * 8;
                v = (c2 / 16) * 8;
                p->u0 = u;
                p->v0 = v;
                p->x0 = curx;
                p->y0 = cury;
                p->r0 = r;
                p->g0 = g;
                p->b0 = b;
                AddPrim(dr, p++);
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
            curx = fs->tile.x0;
            if (cury >= boty) break;
        }
        ++text;
        remain--;
        c = *text;
        if (!c) break;
    }
    if (fs->tile.code) {                              /* draw the background box */
        AddPrim(dr, &fs->tile);
        if (autoupd) {
            autoupd = maxx;
            fs->tile.w = autoupd - fs->tile.x0;
            fs->tile.h = cury - ((u_short)fs->tile.y0 - 8);
        }
    }
    DrawOTag((u_long *)dr);
    fs->textlen = 0;
    *fs->textbuf = 0;
    return (u_long *)dr;
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
