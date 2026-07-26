/* eaclib/psx/sndpsxz/sbhdrcpy.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbhdrcpy.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7BA8.  SNDbankheadercopy -- copy a loaded bank's header into `dst` and rebase its patch
 *   pointers to the new buffer, repointing the bank table at the copy.  Ghidra nfs4-f.exe.c (sbhdrcpy).
 */

struct SNDGlobals {
    char pad0[0x3c];
    signed char initialized;
    char pad3d[0x5b];
    int bank_table;
};
extern struct SNDGlobals sndgs;
extern int SNDbankheadersize(int bankId);          /* sbhdrsze */
extern void *memcpy(void *dst, const void *src, int n);   /* C42 (BIOS thunk) */

extern int SNDbankheadercopy(void *dst, int bankId);   /* @0x800E7BA8 */

/* SNDbankheadercopy @0x800E7BA8 : memcpy the bank header to `dst`, relocate each patch pointer (+0x14 for
 *   bank type 4, else +0xc) relative to `dst`, then point the bank table entry at `dst`.
 *
 * NEAR-MISS 13 diffs (ours 82 / oracle 81).  Register ALLOCATION is already oracle-exact
 * (i=$v1, src20=$a0, dst20=$a1, src12=$a2, dst12=$a3, origin=$t0, type4=$t1, dest=$s1, bankId=$s3);
 * the residual is two emission-ORDER ties:
 *   (a) prologue -- the oracle emits the `dest=$a0` param copy first and puts the `bankId=$a1` copy
 *       in the guard's `bnez` delay slot; ours emits them the other way round (reorg fills the slot
 *       with whichever copy is emitted last).  FALSIFIED: decl-order swap, assigning `dest` after
 *       the decls, taking `unsigned char *dest` as the parameter directly (31 diffs) -- the local
 *       cast copy is load-bearing.
 *   (b) the oracle fills the `lw s0,0(s0)` load-delay slot with `addu $v1,$zero,$zero` (i = 0),
 *       leaving `addu $a0,$s0,$zero` for the end of the preheader; ours nops that slot and emits
 *       `move v1,zero` last -- the +1 instruction.  The oracle's `i = 0` therefore sits in the
 *       PRE-guard block, i.e. before `if (count)`.  FALSIFIED (each measured): hoisting `i = 0`
 *       above the guard, block-local or function-scope (both 82/81, and `i` slides to $a3 taking the
 *       whole pointer set with it -- longer live range = lower allocno priority, whereas the oracle
 *       ranks `i` FIRST); natural `for` with the walkers assigned before it (27 diffs, setup moves
 *       hoist above the guard); index form `bankData + i*4 + 0x14` (77 insns -- our cc1 CSEs the
 *       four address expressions down to TWO givs where retail keeps four, the same weaker-CSE
 *       identity seen across this archive).
 * NO SLD EVIDENCE is available (sbhdrcpy.obj has only a type-2 symbol record). */
extern int SNDbankheadercopy(void *dst, int bankId)
{
    unsigned char *dest = (unsigned char *)dst;
    struct SNDGlobals *base = &sndgs;
    int size;
    unsigned char *bankData;

    if (base->initialized == 0)
        return -10;
    size = SNDbankheadersize(bankId);
    if (size < 0)
        return size;
    memcpy(dest, *(unsigned char **)(bankId * 0xc + base->bank_table), size);
    bankData = *(unsigned char **)(bankId * 0xc + base->bank_table);
    {
        unsigned char *origin;
        int type4;
        unsigned char *dst12;
        unsigned char *src12;
        unsigned char *dst20;
        unsigned char *src20;
        int i;

        if (*(unsigned short *)(bankData + 6) != 0) {
            origin = bankData;
            type4 = 4;
            dst12 = dest;
            src12 = bankData;
            dst20 = dest;
            src20 = bankData;
            i = 0;
        do {
            if (*(unsigned char *)(bankData + 4) == type4) {
                int sp = *(int *)(src20 + 0x14);
                if (sp != 0)
                    *(int *)(dst20 + 0x14) = (int)dest + (sp - (int)origin);
            } else {
                int sp = *(int *)(src12 + 0xc);
                if (sp != 0)
                    *(int *)(dst12 + 0xc) = (int)dest + (sp - (int)bankData);
            }
            dst12 += 4;
            src12 += 4;
            dst20 += 4;
            src20 += 4;
            i++;
        } while (i < (int)(unsigned)*(unsigned short *)(bankData + 6));
        }
    }
    *(int *)(bankId * 0xc + sndgs.bank_table) = (int)dest;
    return 0;
}
