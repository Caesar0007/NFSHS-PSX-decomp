/* eaclib/psx/sndpsxz/sdspuirq.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\sdspuirq.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x8010BF80 .. 0x8010BFA4].  SPU IRQ-enable mask (bit 0x40 of SPUCNT @ ctrl+0x1aa).
 *   Ghidra nfs4-f.exe.c (sdspuirq).
 */

extern "C" int DAT_80147e2c;        /* SPU control register base (address) */

extern "C" int iSNDpsxenablespuirq(void);    /* @0x8010BF80 */

/* iSNDpsxenablespuirq @0x8010BF80 : set the SPU IRQ-enable bit in SPUCNT. */
extern "C" int iSNDpsxenablespuirq(void)
{
    *(unsigned short *)(DAT_80147e2c + 0x1aa) =
        *(unsigned short *)(DAT_80147e2c + 0x1aa) | 0x40;
    return DAT_80147e2c;
}

/* iSNDpsxdisablespuirq @0x8010BFA4 : clear the SPU IRQ-enable bit in SPUCNT. */
extern "C" int iSNDpsxdisablespuirq(void)
{
    *(unsigned short *)(DAT_80147e2c + 0x1aa) =
        *(unsigned short *)(DAT_80147e2c + 0x1aa) & 0xffbf;
    return DAT_80147e2c;
}
