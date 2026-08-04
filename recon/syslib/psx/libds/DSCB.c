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

/* w48-a8: the old "aspsx shares one la base across consecutive same-symbol accesses" reading of
 * this fn was FALSIFIED against the REAL ASPSX 2.77 (04C law): assembling `lw $2,sym / sw $4,sym`
 * with C:/Temp/psq43/PSSN/ASPSX.EXE emits `lui $2;lw $2,%lo($2)` + `lui $at;sw $4,%lo($at)` --
 * i.e. it expands each access INDEPENDENTLY, exactly like GNU-as/maspsx.  The oracle's single
 * `lui v1; addiu v1,v1,%lo; lw 0(v1); sw 0(v1)` is therefore COMPILER output: gcc materializes
 * the ADDRESS as a register value (the `la` macro) whenever (a) the address is written as a real
 * pointer local and (b) TARGET_SPLIT_ADDRESSES is OFF (`-mno-split-addresses`) so the LO_SUM
 * cannot be folded back into the two MEMs.  See PER_TU_FLAGS no_split_addresses for this TU. */
extern DslCB DsReadyCallback(DslCB func)   /* @0x80108824 */
{
    DslCB *p = &ds_ready_cb;
    DslCB old = *p;
    *p = func;
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
