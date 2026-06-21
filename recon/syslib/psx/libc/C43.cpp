/* syslib/psx/libc/C43.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\C43.obj   (xlsx provenance)
 *               == libc.lib(C43.OBJ)        (disasm-v3 "// obj:")
 *   Single fn: memset @0x800E4318 (16 bytes).
 *
 *   In the retail build memset is a 4-instruction PSX BIOS trampoline:
 *       0xD4318  $t2 = 0xA0          ; A0-table vector base
 *       0xD431C  jr   $t2            ; jump to BIOS
 *       0xD4320  $t1 = 0x2B          ; (delay slot) BIOS function # = A0:0x2B = memset
 *   i.e. the EA libc forwards memset to the console BIOS (proto from BIOS: void *memset(void*,int,int)).
 *   That trampoline is a target-specific dispatch detail; the SEMANTICS are pure C, and ~30 TUs
 *   call memset, so the tree provides a correct, self-contained definition here (a PsyQ rebuild
 *   would resolve memset from libc/BIOS the same way). Behavior-faithful; @VA breadcrumb kept.
 */

extern "C" void *memset(void *s, int c, int n)   /* @0x800E4318  BIOS A0:0x2B */
{
    unsigned char *p = (unsigned char *)s;
    while (n-- > 0) *p++ = (unsigned char)c;
    return s;
}
