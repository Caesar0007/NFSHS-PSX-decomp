/* syslib/psx/libpad/WAITRC2.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3 authoritative).
 *   obj libpad.lib(WAITRC2.OBJ): the root-counter-2 (Timer 2) busy-wait helpers used throughout the
 *   SIO0 controller protocol (PADMAIN/PADCMD).  setRC2wait arms a wait of N timer ticks; chkRC2wait
 *   reports whether that wait has elapsed yet, accounting for the 16-bit counter wrapping and the
 *   /8 prescale.  Ghidra decompiled chkRC2wait as an empty `void` -- it is NOT: it returns a BOOL
 *   (1 = expired, 0 = still waiting), confirmed by the `slt; xori 1` at its tail and by every caller
 *   doing `while (chkRC2wait() == 0)`. */

/* PSX Root Counter 2 (literal MMIO device registers). */
#define T2_VALUE  (*(volatile unsigned short *)0x1F801120)   /* current count */
#define T2_MODE   (*(volatile unsigned short *)0x1F801124)   /* mode/prescale (bit 0x200 = /1, else /8) */
#define T2_TARGET (*(volatile unsigned short *)0x1F801128)   /* reload target */

extern int _startTime;   /* RC2 count snapshot at the start of the wait */
extern int _waitTime;    /* wait length, in (prescaled) ticks */

/* @0x8010BFE8 : setRC2wait -- begin a wait of `ticks` and return the current counter value. */
extern unsigned setRC2wait(int ticks)
{
    unsigned short now = T2_VALUE;
    _waitTime  = ticks;
    _startTime = now;
    return now;
}

/* @0x8010C008 : chkRC2wait -- 1 once `_waitTime` ticks have elapsed since setRC2wait, else 0. */
extern int chkRC2wait(void)
{
    unsigned cur = T2_VALUE & 0xffff;
    unsigned elapsed;

    if (cur < (unsigned)_startTime) {                 /* counter wrapped past _startTime */
        if (T2_TARGET == 0)
            cur += 0x10000;
        else
            cur += T2_TARGET;
    }
    if ((T2_MODE & 0x200) == 0)
        elapsed = (cur - (unsigned)_startTime) >> 3;  /* /8 prescale */
    else
        elapsed = cur - (unsigned)_startTime;

    return elapsed < (unsigned)_waitTime ? 0 : 1;
}
