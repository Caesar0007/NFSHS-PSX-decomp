/* nullfunc.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj NULLFUNC.ASM: asyncidle -- the async-engine idle hook.  A pure no-op
 *   (the EXE body is exactly `jr $ra; nop`).  Installed as the async idle/poll
 *   callback when no streaming work is pending.  Surfaced by the link harness
 *   (declared in lib/libfns.h, referenced by nsync.cpp / feaudio.cpp, never defined). */

/* @0x800F6114 : void asyncidle(void) { }  (jr $ra; nop) */
extern "C" void asyncidle(void)
{
}
