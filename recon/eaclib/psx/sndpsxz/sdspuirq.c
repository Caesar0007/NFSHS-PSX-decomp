/* eaclib/psx/sndpsxz/sdspuirq.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\sdspuirq.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x8010BF80 .. 0x8010BFA4].  SPU IRQ-enable mask (bit 0x40 of SPUCNT @ ctrl+0x1aa).
 *   Ghidra nfs4-f.exe.c (sdspuirq).
 */

extern int DAT_80147e2c[];      /* SPU control register base (address); unsized array forces the oracle's
                                     * separate-%hi-scratch load `lui v0; lw v1,%lo(v0)` (vs dest-self-temp) */

extern int iSNDpsxenablespuirq(void);    /* @0x8010BF80 */

/* iSNDpsxenablespuirq @0x8010BF80 : set the SPU IRQ-enable bit in SPUCNT.  Returns the new SPUCNT value
 *   (the RMW result lands in $v0 and the store fills nothing -> v0 survives as the return; oracle keeps the
 *   base ptr in $v1 and the value in $v0). */
extern int iSNDpsxenablespuirq(void)
{
    unsigned short v = *(unsigned short *)(DAT_80147e2c[0] + 0x1aa) | 0x40;
    *(volatile unsigned short *)(DAT_80147e2c[0] + 0x1aa) = v;
    return v;
}

/* iSNDpsxdisablespuirq @0x8010BFA4 : clear the SPU IRQ-enable bit in SPUCNT. */
extern int iSNDpsxdisablespuirq(void)
{
    unsigned short v = *(unsigned short *)(DAT_80147e2c[0] + 0x1aa) & 0xffbf;
    *(volatile unsigned short *)(DAT_80147e2c[0] + 0x1aa) = v;
    return v;
}
