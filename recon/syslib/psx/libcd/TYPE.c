/* TYPE.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcd.lib(TYPE.OBJ) [auth: nfs4-v7-funcs-only.xlsx -> nfs4\syslib\psx\TYPE.obj].
 *   The PsyQ libcd disc-status / disc-type probe.  Surfaced by the whole-tree link harness
 *   (declared in lib/libfns.h, called by cdfs.cpp + audiomus.cpp, never defined -- the
 *   EXE SLD marker mis-attributed these to RANDOM.ASM; the xlsx obj map is authoritative).
 *
 *     int CdDiskReady(int mode)  @0x800E8448  -- poll the drive until the disc is stable.
 *     int CdGetDiskType(void)    @0x800E8584  -- classify the disc (data vs audio via the
 *                                                ISO9660 "CD001" magic at sector 16).
 *
 *   Faithful to the MIPS control-flow (goto-structured where the asm uses irregular
 *   branches).  CD commands: 1=CdlNop, 9=CdlPause, 19=CdlGetTN(0x13), 27=CdlReadS(0x1B). */

extern int  CdControlB(unsigned char com, unsigned char *p, unsigned char *r); /* SYS.obj @0x800F7B24 */
extern int  CdControl (unsigned char com, unsigned char *p, unsigned char *r); /* SYS.obj @0x800F78B4 */
extern void CdIntToPos(int i, unsigned char *p);                               /* SYS.obj @0x800F7CF4 */
extern int  CdReady   (int mode, unsigned char *r);                            /* SYS.obj @0x800F786C */
extern int  CdGetSector(void *madr, int size);                                 /* SYS.obj @0x800F7C70 */
extern void VSync(int mode);                                                   /* libetc @0x800F231C */
extern int  printf(const char *fmt, ...);                                      /* libc   @0x801028AC */
extern int  strncmp(const char *a, const char *b, int n);                      /* libc   @0x800EB1D0 */

/* @0x800E8448 : wait for a stable disc.  Returns 16 (shell-open/error), 2 (ready) or 5. */
extern int CdDiskReady(int mode)
{
    unsigned char result[8];
    int cc;
    int i;

    CdControlB(1, 0, result);                       /* CdlNop -> status */
    if (result[0] & 0x10) return 16;                /* shell open / error */

    cc = CdControlB(19, 0, result);                 /* CdlGetTN */
    if (mode == 1) {
        int ready;                                   /* named bool temp -- matches oracle's a0-held
                                                        * cc-copy coloring + speculative v0=5/v0=2
                                                        * delay-slot fills (w24-a10: 23->5 diffs;
                                                        * residual 5 = 3 more delay-slot filler-
                                                        * placement swaps, scheduler-only) */
        if (result[0] != 2) return 5;
        ready = cc != 0;
        /* MATCH (w55-a5): ARM ORDER = branch polarity, 6 -> PASS 79/79.  Retail
         * branches AWAY on the ready case (`bnez $a0; nop; j <ret>; li $v0,5`),
         * i.e. `return 2;` is the OUT-OF-LINE arm and `return 5;` the shared
         * fall-through tail -- so the SKIP TARGET must be spelled as the guard.
         * `if (ready) return 2; return 5;` gives the mirror `beqz` layout.
         * (Equivalent winners: `if (ready == 0) return 5; return 2;` on a plain
         * `ready = cc`, and the `goto ok` form.  A ternary and a bare `ready = cc`
         * with `if (ready != 0) return 2;` both stay at 6.) */
        if (!ready) return 5;
        return 2;
    }

    for (i = 0; i < 10; i++) {
        if (result[0] & 2) {
            if (result[0] == 2 && cc != 0) return 2;
        retry:                                      /* @0x800E84EC */
            VSync(30);
            cc = CdControlB(19, 0, result);         /* CdlGetTN */
            if (result[0] & 0x10) return 16;
            if (result[0] != 2) goto retry;
            if (cc == 0)        goto retry;
            return 2;
        }
        VSync(30);
        cc = CdControlB(19, 0, result);             /* CdlGetTN */
        if (result[0] & 0x10) return 16;
    }
    return 5;
}

/* @0x800E8584 : classify the disc.  Returns 16 (error), 2 (ISO9660 data), 1 (other/no
 *               magic / command error) or the audio bit ((result[0] & 2) != 0). */
extern int CdGetDiskType(void)
{
    unsigned char locp[8];                          /* sp+0x10  */
    unsigned char sector[2048];                     /* sp+0x18  */
    unsigned char result[8];                        /* sp+0x818 */
    int rdy, i, one;

    CdControl(1, 0, result);                        /* CdlNop -> status */
    if (result[0] & 0x10) return 16;

    /* MATCH (w47 opacity/identity fence, ZERO insns): `locp` sits at sp+16 and the sector
     * number is also 16, so cse forwards the live `li a0,16` into the address computation
     * (`addu a1,sp,a0`) where retail rematerializes `addiu a1,sp,16`.  The fence makes the
     * value opaque to cse at zero instruction cost.  5 -> 3 diffs. */
    { int sec = 16;  CdIntToPos(sec, locp); } /* sector 16 = ISO PVD */
    CdControl(27, locp, 0);                          /* CdlReadS from locp */

    /* w24-a10: explicit goto-retry (not a for-loop with a post-loop `if(rdy==1)` re-check) --
     * matches the oracle's control-flow shape exactly (the ready-arm is reached via a direct
     * edge from the CdReady==1 branch OR by falling out of the retry-exhausted guard, never by
     * a genuinely separate re-test) and drops an unneeded persistent register the for-loop
     * shape forced (99->76 insns net, 61->54 diffs). */
    /* MATCH (named loop sentinel, same lever as cd_cw's `sentinel`): retail keeps the loop's
     * comparison constant 1 in a CALLEE-SAVED reg across the retry loop (`li s1,1` ... `beq v1,s1`,
     * frame 0x830 with s1 saved) and still emits a FRESH `li v0,1` for the post-loop `rdy == 1`
     * test.  A bare literal in the loop test gives one caller-saved `li v1,1` that the increment
     * then reuses (`addu s0,s0,v1` instead of retail's `addiu s0,s0,1`), no s1, frame 0x828.
     * 54 -> 39 diffs, ours 76 -> 81 vs oracle 82. */
    /* MATCH (statement order): retail zeroes the retry counter BEFORE materializing the
     * sentinel (`addu s0,zero,zero; li s1,1`); the reverse order emits them swapped. 39->37. */
    i = 0;
    one = 1;
retry:
    rdy = CdReady(0, result);
    if (rdy != one) {
        i++;
        if (i < 10) {
            CdControl(27, locp, 0);                  /* CdlReadS retry */
            goto retry;
        }
    }

    /* MATCH (block order / branch polarity): retail reaches the ISO-check arm through the
     * TAKEN edge of `beq v1,v0` and lays it OUT-OF-LINE after the audio/error tail, so the
     * not-ready path is the fall-through.  Written as `if (rdy == 1) { ... }` the arm is inlined
     * and the branch inverts to `bne`.  goto-ready: 37 -> 5 diffs. */
    if (rdy == 1) goto ready;

    if (result[0] & 0x10) return 16;
    if ((result[0] & 1) && (result[1] & 0x40)) {
        printf("Command Error: ");
        return 1;
    }
    {
        /* named temp -- oracle compiles the audio-bit test as `andi;sltu`, not the `srl;andi`
         * bit-shift form a bare `(result[0] & 2) != 0` expression picked. */
        int audio = result[0] & 2;
        return audio != 0;
    }
ready:
    CdControl(9, 0, 0);                          /* CdlPause */
    CdGetSector(sector, 512);                    /* 512 words = 2048 bytes */
    if (strncmp((char *)sector + 1, "CD001", 5) != 0) return 1;
    return 2;                                    /* ISO9660 data disc */
}

