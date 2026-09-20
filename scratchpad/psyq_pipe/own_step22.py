"""Blob ownership step 22 (2026-09-20) -- the three remaining non-tag read-only literals.
  libcd stcdint.c (SDK C_011.obj)  .rdata 0x80057110/32 = "DMA STATUS ERROR %x\\n" padded to 32 (byte-exact with PsyQ 4.3).
        _st_dma is linked as a byte-exact CERTIFICATE (asm/cert/_st_dma.s) that names the string D_80057110, so the object
        defines it under that name as a 32-byte const array; the preserved C under `#if 0` had the WRONG wording
        ("StCdInterrupt: DMA ch busy %08x\\n") and is corrected.
  libcd cdcont.c (SDK SYS.obj)     .rdata 0x80057100 = "none": PsyQ 4.3's SYS.obj returns it from CdComstr/CdIntstr; retail
        has neither function, only the literal => the leftover of an unused static inline (same class as libgpu SYS.c).
  eacpsxz callback.c               .rodata 0x800575B8/80 = "lockmutex - MUTEX IS ALREADY LOCKED.\\n" and
        "unlockmutex - MUTEX WAS NOT LOCKED.\\n": retail has allocmutex/freemutex but NO lockmutex/unlockmutex code, and
        the strings sit exactly where callback.obj's read-only data belongs in link order (shptype #324 < callback #331 <
        INTR_DMA #376) => unused static inlines of callback.c."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


s = rd('recon/syslib/psx/libcd/stcdint.c')
a = '__asm__("\\t.set reorder\\n\\t.set at\\n");' + NL + '__asm__(".text\\n"'
assert s.count(a) == 1
s = s.replace(a, '/* C_011.obj .rdata (retail 0x80057110, 32 bytes, byte-exact with PsyQ 4.3): the message _st_dma prints.  The' + NL +
              ' * certificate below names it D_80057110; once _st_dma is matched from C this becomes the printf literal. */' + NL +
              'const char D_80057110[32] = "DMA STATUS ERROR %x\\n";' + NL + NL + a)
b = 'printf("StCdInterrupt: DMA ch busy %08x\\n",'
assert s.count(b) == 1
s = s.replace(b, 'printf("DMA STATUS ERROR %x\\n",   /* retail text @0x80057110 (the old wording here was invented) */')
wr('recon/syslib/psx/libcd/stcdint.c', s)

s = rd('recon/syslib/psx/libcd/cdcont.c').rstrip(NL) + NL + NL
s += ('/* SYS.obj .rdata (retail 0x80057100): "none".  PsyQ 4.3\'s SYS.obj returns it from CdComstr()/CdIntstr() for an' + NL +
      ' * out-of-range code; retail has NEITHER function, only the literal -- what an unused static inline leaves behind. */' + NL +
      'static __inline__ const char *CdComstr(unsigned char com)' + NL + '{' + NL +
      '    return com > 0x1b ? "none" : (const char *)0;' + NL + '}' + NL)
wr('recon/syslib/psx/libcd/cdcont.c', s)

s = rd('recon/eaclib/psx/eacpsxz/callback.c').rstrip(NL) + NL + NL
s += ('/* callback.obj .rodata (retail 0x800575B8, 80 bytes): the two diagnostics of lockmutex/unlockmutex.  Retail has no code' + NL +
      ' * for either (only allocmutex/freemutex), so they are unused static inlines whose literals the compiler still emits. */' + NL +
      'extern int printf(const char *, ...);' + NL +
      'static __inline__ void lockmutex(short *mutex)' + NL + '{' + NL +
      '    if (*mutex != 0)' + NL + '        printf("lockmutex - MUTEX IS ALREADY LOCKED.\\n");' + NL + '    *mutex = 1;' + NL + '}' + NL +
      'static __inline__ void unlockmutex(short *mutex)' + NL + '{' + NL +
      '    if (*mutex == 0)' + NL + '        printf("unlockmutex - MUTEX WAS NOT LOCKED.\\n");' + NL + '    *mutex = 0;' + NL + '}' + NL)
wr('recon/eaclib/psx/eacpsxz/callback.c', s)
