/* syslib/psx/libgpu/P34.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P34.OBJ): SetDrawMove @0x8010C698.  Builds a DR_MOVE (frame-buffer
 *   block copy) primitive: copies rect (src x/y, w/h) to dest (x,y).  Length byte = 5 only
 *   when both w and h are non-zero (a degenerate rect produces a 0-length no-op).
 *
 * MATCH (W52-A10, 2026-08-09): PASS 24/24, pin-free and fence-free.
 *   The whole 11-diff residual was a RECONSTRUCTION-SHAPE artifact, not an allocator tie.
 *   The prior body hand-rolled the packet as `int *w = (int *)p` + byte-offset casts
 *   (`((u_char *)p)[3] = len`, `w[1] = ...`) plus a zero-insn read fence to manufacture
 *   retail's `addu $t0,$a0,$zero` parm copy.  Writing what a 1998 Sony library programmer
 *   actually wrote -- the REAL PsyQ types (`DR_MOVE {u_long tag; u_long code[5];}`,
 *   `RECT {short x,y,w,h}`, `P_TAG {unsigned addr:24; unsigned len:8; ...}`) and the REAL
 *   `setlen()` macro from libgpu.h -- reproduces every register role for free:
 *     - `setlen(p,len)` = the P_TAG `len:8` BITFIELD store, which cc1 lowers to the
 *       oracle's single `sb $a0,0x3($t0)` (a byte-offset cast forced the base to stay in
 *       $a0, which is exactly what pinned `len` off $a0 and cost the extra insn);
 *     - one `p` pseudo (no `w` alias) frees $a0 for `len` and lets the parm copy into $t0
 *       survive on its own -- the fence is no longer needed and was removed;
 *     - `p->code[k]` array-element stores schedule the `lw $a0,0($a1)` into the load-delay
 *       slot that our `nop` used to occupy (25 -> 24 insns).
 *   Cross-checked against the byte-matched PsyQ sibling C:\Temp\psyz\decomp\src\libgpu\prim.c
 *   (Xeeynamo's psyz -- a MATCHED, non-INCLUDE_ASM SetDrawMove); the body below is that
 *   shape with PsyQ 4.3's own header types.  Ladder A/B on the OLD source was flat
 *   (2.6.0/2.6.3/2.7.2-970404/2.7.2/2.8.0/2.8.1 all 11 diffs, 2.91.66 9, 2.95.2 27), which
 *   correctly said "not a compiler-version identity" -- it was the source. */

typedef unsigned char  u_char;
typedef unsigned long  u_long;

typedef struct {                /* primitive tag: 24-bit OT link + 8-bit word length */
    unsigned addr:24;
    unsigned len:8;
    u_char   r0, g0, b0, code;
} P_TAG;

typedef struct { short x, y; short w, h; } RECT;

typedef struct {                /* MoveImage */
    u_long tag;
    u_long code[5];
} DR_MOVE;

#define setlen(p, _len) (((P_TAG *)(p))->len = (u_char)(_len))

extern void SetDrawMove(DR_MOVE *p, RECT *rect, int x, int y)   /* @0x8010C698 */
{
    int len = 5;
    if (!rect->w || !rect->h)
        len = 0;
    setlen(p, len);
    p->code[0] = 0x01000000;                    /* GPU cmd: VRAM->VRAM blit */
    p->code[1] = 0x80000000;
    p->code[2] = *(int *)&rect->x;              /* source x|y */
    p->code[3] = (y << 16) | (x & 0xffff);      /* dest   x|y */
    p->code[4] = *(int *)&rect->w;              /* w|h */
}
