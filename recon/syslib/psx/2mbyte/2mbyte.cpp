/* syslib/psx/2mbyte/2mbyte.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\2mbyte.obj   (xlsx provenance)
 *               == libsn.lib(SNMAIN.OBJ)       (disasm-v3 "// obj:")
 *   This is the PSX program ENTRY POINT -- SN Systems crt0, "2 MB" RAM variant
 *   (retail PSX: stack top = 0x80200000 = top of 2 MiB).
 *
 *   4 symbols (a single fall-through routine + the GCC ctor hook):
 *     __main @0x800E4024 -- GCC global-constructor hook; empty in the SN runtime.
 *     stup2  @0x800E402C -- entry: clear BSS                         (IDA: `start`, __noreturn)
 *     stup1  @0x800E4050 -- set $sp/$gp/$fp, compute + InitHeap()    (falls through from stup2)
 *     stup0  @0x800E40CC -- call main(); never returns (`break 1`)   (falls through from stup1)
 *   stup2/stup1/stup0 are a fall-through chain (no `jr` between them) => modeled as ONE C
 *   function `start()` with the three label boundaries kept as @VA breadcrumbs.
 *
 *   The register-level boot setup ($sp/$gp/$fp install, `break`) cannot be expressed in
 *   portable C; it is kept under `#ifdef __mips__` (faithful on the PSX target) with a host
 *   (x86) no-op fallback so this TU still typechecks in the whole-tree compile sweep.
 *   On a real PsyQ rebuild the toolchain crt0 provides this; here it is a faithful decode.
 */
#include "../../../nfs4_types.h"

extern "C" {

/* ---- cross-TU call targets (jal targets decoded from EXE bytes; disasm-v3 mislabelled
 *      both by +0x10000 in the boot region -- real targets verified against NFS4.EXE) ---- */
extern int  main(void);                                /* @0x800A4730  GAME\COMMON\NFS3.CPP   */
extern void InitHeap(void *head, unsigned long size);  /* @0x800FDD18  libapi (syslib C57.obj) */

/* ---- crt0 data ---- */
extern unsigned int _stacksize;   /* linker sym: bytes reserved for the stack (subtracted off the
                                   *             stack top to bound the heap) */
/* stack-top table @0x800E40D8 (real EXE bytes: four words, all 2 MiB); stup1 reads slot [1]. */
static const unsigned int _stacktab[4] = { 0x00200000u, 0x00200000u, 0x00200000u, 0x00200000u };

/* ---- __main @0x800E4024 : GCC global-ctor hook -- provided by PsyQ libsn (crt0 pulls it). ---- */
extern "C" void __main(void);

/* ---- start @0x800E402C (stup2 -> stup1 -> stup0) : program entry point ---- */
void start(void)
{
    /* --- stup2 @0x800E402C: zero the BSS region [0x8013DD7C, 0x80148B04). --- */
    {
        int *p = (int *)0x8013DD7Cu;     /* @0x800E402C lui/ori  __bss_start */
        int *e = (int *)0x80148B04u;     /* @0x800E4034 lui/ori  __bss_end   */
        while (p < e) *p++ = 0;          /* @0x800E403C..4048 loop */
    }

    /* --- stup1 @0x800E4050: install stack/$gp/$fp, then InitHeap(base, size). ---
     * heap_base = (_bss_end masked to physical) | KSEG0 ; heap_size = (sp_phys - _stacksize) - heap_phys */
    {
        unsigned int sp_phys   = _stacktab[1];                     /* @0x800E4070  0x00200000 (2 MiB)   */
        unsigned int heap_phys = (0x80148B04u << 3) >> 3;          /* @0x800E4084/88  0x00148B04         */
        unsigned int heap_size = (sp_phys - _stacksize) - heap_phys; /* @0x800E4098/9C                   */
        void        *heap_base = (void *)(heap_phys | 0x80000000u); /* @0x800E40A0  0x80148B04           */
#ifdef __mips__
        /* $sp = 0x80200000 (top of 2 MiB), $gp = 0x8013C54C (small-data anchor), $fp = $sp. */
        register unsigned int sp asm("$sp") = sp_phys | 0x80000000u;   /* @0x800E4074/78 */
        __asm__ volatile("la $gp, 0x8013C54C\n\tmove $fp, $sp"
                         : : "r"(sp) : "gp", "fp");                   /* @0x800E40AC..B4 */
#endif
        InitHeap(heap_base, heap_size);                                /* @0x800E40B8 jal InitHeap */
    }

    /* --- stup0 @0x800E40CC: enter the game, then halt (should never return). --- */
    main();                          /* @0x800E40CC jal main */
#ifdef __mips__
    __asm__ volatile("break 1");     /* @0x800E40D4 -- trap if main() ever returns */
#endif
    for (;;) { }
}

} /* extern "C" */
