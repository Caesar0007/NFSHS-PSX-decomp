/* syslib/psx/libds/DSCB.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
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

extern "C" int DMACallback(int ch, int func);   /* libetc INTR.obj @0x800F28AC */

static DslCB ds_ready_cb;   /* @0x801489E4 : current data-ready callback */

extern "C" DslCB DsReadyCallback(DslCB func)   /* @0x80108824 */
{
    DslCB old = ds_ready_cb;
    ds_ready_cb = func;
    return old;
}

extern "C" int DsDataCallback(DslCB func)      /* @0x80108838 */
{
    return DMACallback(3, (int)func);
}
