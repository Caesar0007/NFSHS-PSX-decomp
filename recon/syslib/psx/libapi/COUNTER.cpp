/* syslib/psx/libapi/COUNTER.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj COUNTER.obj ; libapi.lib.  Root-counter (RCnt) API -- direct hardware-register access (NOT a BIOS
 *   trampoline): SetRCnt @0x800E9E70, GetRCnt @0x800E9F0C, StartRCnt @0x800E9F44.  RCnt regs at 0x1F801100
 *   (count) / +4 mode / +8 target, 16 bytes apart; IRQ mask at 0x1F801074.  IDA verbatim.
 */
extern "C" const unsigned int rcnt_irqbits[4] = { 0x10, 0x20, 0x40, 0x1 };   /* @0x801234BC : per-RCnt IRQ_MASK bit (data-mat from EXE) */

extern "C" int SetRCnt(unsigned short spec, short target, short mode)   /* @0x800E9E70 */
{
    short v3 = 72;
    if (spec >= 3u) return 0;
    int base = 16 * spec + 0x1F801100;
    *(volatile unsigned short *)(base + 4) = 0;
    *(volatile unsigned short *)(base + 8) = target;
    int v6;
    if (spec >= 2u) {
        v6 = mode & 0x1000;
        if (spec == 2) {
            v6 = mode & 0x1000;
            if ((mode & 1) == 0) v3 = 584;
        }
    } else {
        if ((mode & 0x10) != 0) v3 = 73;
        v6 = mode & 0x1000;
        if ((mode & 1) == 0) v3 |= 0x100;
    }
    int result = 1;
    if (v6 != 0) v3 |= 0x10;
    *(volatile unsigned short *)(16 * spec + 0x1F801104) = v3;
    return result;
}

extern "C" int GetRCnt(unsigned short spec)   /* @0x800E9F0C */
{
    if (spec >= 3u) return 0;
    return *(volatile unsigned short *)(16 * spec + 0x1F801100);
}

extern "C" int StartRCnt(unsigned short spec)   /* @0x800E9F44 */
{
    *(volatile unsigned int *)0x1F801074 |= rcnt_irqbits[spec];
    return spec < 3u;
}
