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

/* W66-A3 (link): the stream array IS in the image; the splat blob emits it under
 * the project label `Font` (data_8010CCD4_r17.data.s, symbol_addrs Font=0x80135E58).
 * Alias the PsyQ spelling onto it -- name-only, no second copy. */
extern FntStream _fnt[8] __asm__("Font");   /* @0x80135E58 : open font streams */
extern int _fnt_count __asm__("D_80135FD8");          /* @0x80135FD8 : number of open streams */
extern int _fnt_active __asm__("D_80135FDC");         /* @0x80135FDC : current active stream id */
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
 *       (catalog: choose_reload_regs / reload-inheritance identity).
 *
 *   W53-A12 re-attack, NO MOVEMENT (6 both before and after; recorded so the ground is not
 *   re-walked).  The 4-diff half is purely a sched2 POSITION question: retail issues the two
 *   `sw $a2,0x1C/0x20($sp)` (r and g) between `addiu $sp` and the callee-save block, i.e.
 *   sched2 floated them ABOVE the whole prologue save run, and puts b's store in the `bltz`
 *   delay slot.  Falsified this wave: five further init ORDERS on top of the six already
 *   recorded -- r,g,b then maxx (10); r,g / maxx / b (6); r / g / maxx / b (6); b,g,r then
 *   maxx (10); the chained `r = g = b = 0x80` (10) -- and three FENCE placements, which is
 *   the instrument the catalog names for a sched-issue-position residual: a void-tail
 *   `__asm__("" : : "i"(0))` after the colour block (9, +1 insn), the same before `maxx`
 *   (6), and a read-only fence on `id` (9, +1 insn).  MECHANISM NOTE explaining why the
 *   fence cannot win here: a fence is a BARRIER, so it can stop an insn from moving but
 *   cannot make one float FURTHER up -- and the stores must move UP, past the prologue.
 *   r/g/b are stack AUTOs (not register-resident), so every fence form that touches them
 *   also costs the +1 `lw` the cost profile predicts.  NAMED NEXT ANGLE: make the colour
 *   defaults register-resident for their whole live range (they are only spilled because
 *   the glyph loop re-reads them), then the zero-cost fence forms become available; or dial
 *   sched2's ready list via the dependence chain of the FIRST post-prologue insn.
 *
 *   W61-A4 -- THE (a) HALF IS SOLVED: 6 -> 2, count still EXACT 199/199.  W53-A12's own
 *   mechanism note ("a fence is a BARRIER, so it can stop an insn from moving but cannot make
 *   one float FURTHER up -- and the stores must move UP, past the prologue") is exactly the
 *   signature of a PER_FN_TEXT_MOVES row, not of a source lever: the residual IS a pure line
 *   relocation.  Retail emits `li $a2,0x80; sw $a2,0x1C($sp); sw $a2,0x20($sp)` BEFORE the ten
 *   callee-save stores; cc1 emits both stores after them (and after `sw $zero,0x14($sp)`).
 *   Relocating exactly those two lines reproduces retail's prologue verbatim -- same class as
 *   the landed W60-A3 `_BlitClear` row (sched2 emission position, expressed as a relocation).
 *   Probe-verified through the gate's own code (scratchpad/w61a4, W60_TEXT_MOVES_FILE hook on
 *   a scratchpad copy of tools/vprobe.py; run twice, identical).  Anchors are label-agnostic
 *   (no `$L<n>`) and the `li` anchor tolerates the trailing hex comment, per the W60 12F craft
 *   rules; `sw $6,28($sp)` occurs exactly ONCE in the region, so the two rows cannot collide.
 *   ORCHESTRATOR WIRING (I cannot edit tools/*.py):
 *       PER_FN_TEXT_MOVES["recon/syslib/psx/libgpu/FONT.c"] = {
 *           "FntFlush": [
 *               {"take": r"\tsw\t\$6,28\(\$sp\)\n", "after": r"\tli\t\$6,128[^\n]*\n"},
 *               {"take": r"\tsw\t\$6,32\(\$sp\)\n", "after": r"\tsw\t\$6,28\(\$sp\)\n"},
 *           ],
 *       }
 *   RESIDUAL 2 = the (b) reload-inheritance half only, re-tested in the NEW basin per 04Z
 *   (rung tables and lever verdicts are basin-relative) and all still falsified:
 *   `TermPrim(&fs->draw_mode)` 2 (inert) / dropping the `dr` local entirely 14 /
 *   void-tail fence before the call 9 (and -1 insn) / read-only fence on `dr` 45 (+1 insn).
 *   VERSION AXIS CLOSED per-FUNCTION too (W61-A4, the 12G flag-dropping splice applied to the
 *   maspsx lane, both fns spliced): 2.6.3 = 98/183 | 2.7.2 = 74/173 | 2.7.2-970404 = as-fails |
 *   2.8.0 = 6/4 (FntPrint WORSE) | 2.8.1 (wired) = 6/3 | 2.91.66 = 182/255 | 2.95.2 = 156/243.
 *   No rung to wire; the whole-TU NFS4_FORCE_CC1_ALT path still cannot reach the sub-2.8 rungs
 *   at all (it does not drop `-mno-split-addresses`), only the per-fn splice can.
 *
 *   W55-A8 re-attack on the (b) reload-inheritance half, STILL 6 (recorded so the ground is
 *   not re-walked a third time): `volatile DR_MODE *dr` + `(void *)` casts at the three use
 *   sites = 6 (no movement -- the volatile view does force a reload, but sched hoists it to
 *   exactly where our register copy already sat); `DR_MODE * volatile dr` (volatile POINTER,
 *   i.e. a real stack home for dr) = 21 / 202 insns (spills at every use); and one more
 *   colour-init order (r,g then maxx then b) on the (a) half = 6.  Both halves remain what
 *   the W52/W53 receipts say they are.
 *
 *   W64-A3 -- FntPrint RE-VERIFIED PASS 240/240 (the W63 TEXT_MOVES row is wired and
 *   holding).  FntFlush's PLACEMENT axis re-probed in THIS 2-diff basin, all reverted:
 *   a void-tail fence immediately after `dr = &fs->draw_mode;` 2 (inert) * `dr` assigned
 *   just before the call instead of at the top 2 (inert) * `TermPrim(dr)` hoisted above
 *   the whole field-load block 27 (200 insns) * an identity launder on `dr` right before
 *   the call 45 (200 insns) * a void-tail fence right before the call 9 (198 insns).
 *   MECHANISM (so the next belt starts from the right place, not from spellings): the
 *   `dr` pseudo is SPILLED, so its def emits an output reload into $a2 plus the store,
 *   and reload1.c's choose_reload_regs then satisfies the call-argument input reload by
 *   INHERITING $a2 (it still validly contains the pseudo).  Retail did not inherit, i.e.
 *   in retail $a2 was no longer valid at that point.  Nothing in this block writes $a2
 *   (all eight following field loads are long-lived and take callee-saved registers), so
 *   the named angle is unchanged and precise: manufacture a SHORT-LIVED value between the
 *   spill and the call that the allocator must put in $a2 -- the 14C intruder-eviction
 *   device -- and the inheritance is invalidated for free.  There is no such value in the
 *   source today, and a hard-register clobber fence is pin-adjacent (user sign-off).
 *
 *   W71-A10 (2026-08-21) -- RE-GATED 2 @199/199 (twice), and the W64-A3 mechanism note
 *   above is re-confirmed: nothing in the field-load block can be turned into a
 *   short-lived $a2 value from source.  FALSIFIED this pass (all gated, all reverted):
 *   split-load for `boty` (`boty = fs->tile.h; boty = cury + (short)boty;`) 2, inert *
 *   `boty` computed BEFORE `rightx` 13 @198 (it eats the TermPrim delay-slot `addu
 *   $s7,$s1,$v0` -- the W52 lever (2) is order-sensitive, do not reorder that pair) *
 *   `dr = &_fnt[id].draw_mode;` instead of `&fs->draw_mode` 13 @200 (re-derives the array
 *   address) * `dr` assigned after `p = fs->primbuf;` 2, inert * removing the blank line
 *   before `TermPrim(dr)` (i.e. no statement-group change at all) 2, inert.
 *   The window between the `dr` spill and the call contains ONLY the eight long-lived
 *   field loads (all callee-saved, no reloads), so there is no reload for $a2 to collide
 *   with; the two short-lived values that DO exist there (`fs->tile.w`, `fs->tile.h`)
 *   already take $v0/$v1 in BOTH builds.  The angle stays exactly as W64-A3 named it. */
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
 * NEAR-MISS (W56, 80 -> 3 diffs; ours 239 / retail 240): retail mutates the variadic `id`
 * parameter itself, which produces its stack home and fixes the whole active-stream entry path.
 * A signed-byte zero-pad flag removes the spurious mask; statement-ordering the width clamp
 * before `bufPtr`, keeping the explicit sign `else`, and staging the `%c` vararg through a
 * block-local pointer match the remaining large regions.  The dependency-shaped preloop
 * `percent = ch ^ (ch ^ '%')` is mathematically constant but delays pseudo birth just enough for
 * GCC 2.8.x to allocate retail s4='%' / s5=0xCCCCCCCD.  The final residual is only reorg's
 * filled initial zero-check slot (retail nop) plus jump2 reusing v0=-1 instead of rematerializing
 * a2=-1.  Hand-rolled vararg pointer bumps remain required; stdarg `va_arg` regresses. */
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
    signed char padZeros;
    int num;
    int len;
    int width;
    signed char *f;
    char *bufPtr;
    char sign;
    unsigned int ch;
    int percent;

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

    ch = *f;
    if (ch == 0)
        goto fnt_done;
    /* MATCH (W63-A3, 3 -> 2 and the count became EXACT 240/240): retail leaves the
     * `beqz $a0` zero-check delay slot EMPTY; reorg steals `percent`'s `li $s4,37`
     * from the fall-through thread into it (fill_slots_from_thread), so ours ran one
     * instruction short.  A void-tail fence at the HEAD of that thread is the one
     * instrument that reaches reorg (stop_search_p returns 1 at any asm) and it is
     * zero-insn.  Placement variants all measure identically (2/240): fence before
     * this block, fence inside it, and a read-only fence on `ch`; the void-tail form
     * is kept because it neither adds a ref nor names a value. */
    __asm__("" : : "i"(0));
    {
        percent = ch ^ (ch ^ '%');
    }
    for (; ch; ch = *++f) {
        if (ch != percent) {
            WriteChar(ch);
            continue;
        }

        ch = *++f;
        if (ch == percent) {
            WriteChar(percent);
            continue;
        }

        width = 0;
        padZeros = ch == '0';
        while (ch >= '0' && ch <= '9') {
            width = (width * 10) + (ch - '0');
            ch = *++f;
        }
        if (width <= 0)
            width = 1;
        bufPtr = (char *)&args;

        switch (ch) {
        case 'd':
            num = *(int *)args; args = (void *)((char *)args + 4);
            if (num < 0) {
                num = -num;
                sign = '-';
            } else {
                sign = 0;
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

        case 'c': {
            int *arg = (int *)args;
            --bufPtr;
            *bufPtr = (char)*arg;
            args = (void *)(arg + 1);
            len = 1;
            break;
        }

        case 's':
            bufPtr = *(char **)args; args = (void *)((char *)args + 4);
            len = strlen(bufPtr);
            break;
        }

        while (len < width) {
            WriteChar(' ');
            width--;
        }
        /* MATCH (W63-A3): retail materializes the loop sentinel FRESH
         * (`addiu $a2,$zero,-1`) where every natural spelling of this countdown
         * gives us a COPY of the peel's -1 (`addu $a2,$v0,$zero`) -- cse's
         * constant-sharing: at the sentinel's DEF a register already holds -1, and
         * cse substitutes it (the launder protects USES, so a sentinel declared
         * INSIDE the guard is still copied).  Cure = give the sentinel its own
         * pseudo BEFORE the peel test, then identity-launder it so cse can neither
         * fold it back nor feed it to the peel's own compare -- both -1s are then
         * materialized independently, exactly retail's instruction set.
         * FALSIFIED first (all gate-measured, this basin): the plain comma-peel
         * (2), explicit peel with two literal -1 (2), laundered sentinel declared
         * inside the guard (2), void-tail fence between peel and loop (2),
         * read-only fence on len (2), peel spelled `len >= 0` (3, loses retail's
         * own `li $v0,-1`), un-laundered sentinel before the peel (5), laundered
         * sentinel used in BOTH tests (7), double launder (64).
         * The residual after this edit is a PURE ONE-LINE RELOCATION (`li $6,-1`
         * belongs after the peel branch, not before it) -- probe-verified TWICE as
         * PASS 240/240 with the PER_FN_TEXT_MOVES row below (scratchpad/w63a3):
         *     "recon/syslib/psx/libgpu/FONT.c": {
         *         "FntPrint": [
         *             {"take":  r"\tli\t\$6,-1[^\n]*\n",
         *              "after": r"\tbeq\t\$5,\$2,\$L\d+\n"},
         *         ],
         *     }
         * (the FONT.c entry already exists for FntFlush -- ADD this key to it;
         * a duplicate rel key would silently shadow the earlier entry, 12F). */
        {
            int neg1 = -1;
            __asm__("" : "=r"(neg1) : "0"(neg1));   /* cse constant-sharing breaker */
            len--;
            if (len != -1) {
                do {
                    WriteChar(*bufPtr++);
                    len--;
                } while (len != neg1);
            }
        }
    }
fnt_done:
    fs->textbuf[fs->textlen] = 0;
    return fs->textlen;
}
#undef WriteChar
