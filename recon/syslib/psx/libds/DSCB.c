/* syslib/psx/libds/DSCB.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libds.lib(DSCB.OBJ).  The only libds object NFS4 links: the two CD-streaming
 *   callback registrars.
 *
 *     DslCB DsReadyCallback(DslCB func)  @0x80108824
 *         Installs the "data-ready" callback; returns the previous one.  The handler
 *         pointer lives in the obj-local word @0x801489E4.
 *
 *     int   DsDataCallback(DslCB func)   @0x80108838
 *         Installs `func` as the CD-ROM DMA-completion callback by forwarding to the
 *         public libetc DMACallback() for DMA channel 3 (CD-ROM).  The channel index
 *         (a0 = 3) is set in the jal delay slot, so the effective call is
 *         DMACallback(3, func); its return value is passed straight through.
 *         (Ghidra drops both args -> "DMACallback()"; disasm-v3 is authoritative here.)
 */

typedef void (*DslCB)(unsigned char intr, unsigned char *result);

extern int DMACallback(int ch, int func);   /* libetc INTR.obj @0x800F28AC */

/* NOT gp-relative in the oracle (lui/addiu, not $gp) despite being 4 bytes -- force .bss
 * placement so it doesn't fall into the -G4 small-data window. (NOTE: libcd/streamhelp.c also
 * carries a placeholder `int _ds_ready_cb ST_BSS;` reserving this same @VA -- pre-existing
 * cross-TU duplicate storage, out of libpad/libds scope to reconcile here.) */
#define ST_BSS __attribute__((section(".bss")))
static DslCB ds_ready_cb ST_BSS;   /* @0x801489E4 : current data-ready callback */

/* NEAR-MISS (5, WEAK floor): oracle materializes the &ds_ready_cb address ONCE (lui+addiu into
 * v1) and reuses it for both the load and the store; our build re-derives the address
 * independently per access (direct-load/direct-store macro idiom, dest-as-hi-scratch discards
 * the base after each). Tried+reverted: explicit `DslCB *p=&ds_ready_cb;` local -- no effect,
 * gcc still split the two accesses. */
extern DslCB DsReadyCallback(DslCB func)   /* @0x80108824 */
{
    DslCB old = ds_ready_cb;
    ds_ready_cb = func;
    return old;
}

/* FLOOR (6 diffs): same family as the tree-wide PadStartCom/PadStopCom epilogue-order floor
 * (wave lead a7, libgte: 71 oracle sites, proven unreproducible under our CC1PSX regardless of
 * C shape/flags) -- oracle schedules `sw ra` BEFORE the a1=func arg-move and folds the sp-restore
 * into the jr-ra delay slot; ours reorders both. Not re-ground per wave guidance. */
extern int DsDataCallback(DslCB func)      /* @0x80108838 */
{
    return DMACallback(3, (int)func);
}
