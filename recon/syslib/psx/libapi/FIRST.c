/* syslib/psx/libapi/FIRST.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj FIRST.obj ; libapi.lib.  firstfile + _first_patch -- the libapi "first-file" wrapper that
 *   works around a retail-BIOS bug.  firstfile() strips the device prefix off `name`, walks the BIOS
 *   Device Control Block (DCB) table (kernel globals: base @0x150, byte-count @0x154; 0x50-byte
 *   entries), saves the matching device's first-file handler and swaps in _first_patch, then calls
 *   the BIOS firstfile2().  When the BIOS later invokes the device handler it hits _first_patch,
 *   which restores the original handler in the DCB and forwards the call -- a one-shot, self-removing
 *   patch.  NOTE: firstfile() returns firstfile2()'s DIRENTRY* result (Ghidra typed firstfile2 void
 *   and mis-attributed the return to the patch pointer; the disasm returns $v0 from firstfile2).
 *
 *   The 0x150/0x154 kernel globals and the 0x50-byte DCB layout are part of the PSX BIOS ABI (fixed
 *   addresses), represented here as literal volatile pointers per the HW/BIOS-global rule.
 *
 *   Oracle tracing shows two searches: the first saves the real handler and the second installs
 *   the one-shot patch.  The pathname scan is signed, preserves the original `name` for firstfile2,
 *   and the DCB byte-count division is unsigned (0xCCCCCCCD >> 6).
 *
 * w25-a2 SURVEY (-fno-delayed-branch splice project, methodology sec 3.25.3b): UNRELATED for both
 *   fns -- register-coloring floor (per w24-a7's prior "60/40" diagnosis, re-confirmed here): our
 *   frame allocates one MORE callee-saved s-reg than the oracle (firstfile: ours s2/s4/s5, sp-48;
 *   oracle s2/s3, sp-40 -- one fewer live temp across the DCB-walk loop; _first_patch: ours
 *   s2/s4/s5/s6, sp-48; oracle s2/s3/s4/s5, sp-40, same one-reg-over pattern). No jal-arg-slot or
 *   epilogue-reorder signature lines present in either diff (the epilogue lw-ra/addiu-sp deltas
 *   are pure byte-offset shifts caused by the extra saved register, not a slot/order swap).
 *   Empirically whole-TU `-fno-delayed-branch` test (w25-a2, reverted, not committed): firstfile
 *   68->136 diffs, _first_patch 44->54 diffs -- both MUCH WORSE. Confirms neither fn is
 *   delayed-branch-related; do NOT splice. Needs a genuine register-coloring lever instead
 *   (one fewer live local across the two DCB-table walks). */

extern int   strcmp(const char *a, const char *b);     /* libc C23 @0x800E5D7C */
extern void *firstfile2(const char *name, void *dir);  /* A66.OBJ : BIOS B0:0x42 */

/* PSX BIOS Device Control Block: 0x50 bytes.  Only the name pointer (+0x00) and the per-device
 * first-file handler slot (+0x34) are touched here. */
typedef struct DCB {
    char  *name;        /* +0x00 */
    int    _r1[12];     /* +0x04 .. +0x30 */
    void  *firstfile;   /* +0x34 : first-file handler (patch target) */
    int    _r2[6];      /* +0x38 .. +0x4C */
} DCB;                  /* sizeof == 0x50 */

/* BIOS device-table kernel globals (fixed ABI addresses). */
#define BIOS_DCB_BASE   (*(DCB **)0x150)   /* @kernel 0x150 : DCB table base pointer */
#define BIOS_DCB_BYTES  (*(int  *)0x154)   /* @kernel 0x154 : DCB table size in bytes */

typedef int (*FirstFn)(int *state, int arg, int arg2);

extern FirstFn _first_save;          /* @0x80148A7C : saved original device handler */
/* MATCH (w48-a7): UNSIZED.  The oracle materializes this address INSIDE the DCB search loop, at
 * the strcmp call site (`lui $a1,%hi; addiu $a1,$a1,%lo` = one `la` macro).  With the size known,
 * -msplit-addresses gives gcc a separate `(high _first_devname)` pseudo that loop.c hoists out of
 * the loop into a CALLEE-SAVED register -- costing a whole extra saved reg (7 vs the oracle's 6)
 * and rotating every other saved-reg role.  IDT Ch9's rule (methodology 3.12 #5) both ways:
 * omit the size, or give the correct one -- here the omission is what retail's codegen shows. */
extern char    _first_devname[];     /* @0x80148A84 : device prefix extracted from `name` */

/* @0x80109F5C : _first_patch -- restore the device's real handler, then forward the call. */
extern int _first_patch(int *state, int arg, int arg2)
{
    DCB *e, *end, *lim;
    unsigned int cnt;
    FirstFn saved;

    if (*state == 0)
        *state = 1;
    cnt  = (unsigned int)BIOS_DCB_BYTES / (unsigned int)sizeof(DCB);
    e    = BIOS_DCB_BASE;
    /* MATCH (w48-a7): the oracle computes the table end into a CALLER-saved temp, tests THAT in
     * the zero-trip guard, and only copies it into the callee-saved loop bound inside the guard
     * (`addu $v1,$s0,$v0; sltu $v0,$s0,$v1; beqz $v0,..; addu $s1,$v1,$zero`).  The copy survives
     * because the destination outlives its source (make_regs_eqv); computing straight into `end`
     * coalesces it away. */
    lim  = e + cnt;
    saved = _first_save;   /* loop-invariant: hoist the un-patch value (oracle materializes it before the search) */
    if (e < lim) {
        end = lim;
scan:
        if (e->name != 0 && strcmp(e->name, _first_devname) == 0) {
            e->firstfile = (void *)saved;   /* un-patch (one-shot) */
        } else {
            e++;
            if (e < end) goto scan;
        }
    }
    return (*_first_save)(state, arg, arg2);   /* forward $a2=$s5 too (oracle @0x8010a034); re-reads the global fresh */
}

/* @0x80109DC0 : firstfile */
extern void *firstfile(char *name, void *dir)
{
    DCB  *e, *end;
    char *p;
    signed char *scan;
    int   found;

    /* extract the device prefix (characters before ':') into _first_devname */
    p = _first_devname;
    scan = (signed char *)name;
    while (*scan > ':')
        *p++ = (unsigned char)*scan++;
    *p = '\0';

    /* pass 1: locate the device, remember its current first-file handler */
    found = 0;
    e   = BIOS_DCB_BASE;
    end = e + (unsigned int)BIOS_DCB_BYTES / (unsigned int)sizeof(DCB);
    for (; e < end; e++) {
        if (e->name != 0 && strcmp(e->name, _first_devname) == 0) {
            _first_save = (FirstFn)e->firstfile;
            found = 1;
            break;
        }
    }
    if (!found)
        return 0;

    /* pass 2: install the self-removing patch into that device */
    e   = BIOS_DCB_BASE;
    end = e + (unsigned int)BIOS_DCB_BYTES / (unsigned int)sizeof(DCB);
    for (; e < end; e++) {
        if (e->name != 0 && strcmp(e->name, _first_devname) == 0) {
            e->firstfile = (void *)_first_patch;
            break;
        }
    }
    return firstfile2(name, dir);
}
