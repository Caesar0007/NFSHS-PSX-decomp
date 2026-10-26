/* eaclib/psx/sndpsxz/splysdef.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\splysdef.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   1 fn @0x800E6834 (80 bytes): SNDplaysetdef -- initialise an SND "play descriptor" to defaults.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub/thunk.  C-linkage.  Part of the EA SND runtime.
 *
 *   The 20-byte SNDPLAYOPTS layout is recorded in NFS4.SYM; this initializer sets:
 *     patnum=-1; bhandle=-1; keynum=0x3C; velocity/vol/fxlevel0=0x7F;
 *     pan/bend=0x40; use3dpos=0; pitchmult/timemult=0x1000; azimuth/elevation=0.
 */
#include "splysdef.h"
#include "../../../shared/SNDPLAYOPTS.h"

int SNDplaysetdef(struct SNDPLAYOPTS *def)   /* @0x800E6834 : §3.2 non-void — the oracle reserves $v0 for
                                             a return of 0 (addu v0,zero,zero), which pushes the 0x40
                                             constant to $v1; declared void drops both. extern so the
                                             return-type change is unmangled / caller-safe. */
{
    /* The store order matches the retail instruction schedule. `bhandle` is
     * stored through a signed-byte view so the -1 sentinel stays a single -1
     * immediate even though the shared layout spells the field as plain char. */
    struct SNDPLAYOPTS *d = def;
    d->patnum = -1;
    *(signed char *)&d->bhandle = -1;
    d->keynum = 0x3C;
    d->pitchmult = 0x1000;
    d->timemult = 0x1000;
    d->velocity = 0x7F;
    d->vol = 0x7F;
    d->pan = 0x40;              /* interleaved here to match the oracle schedule */
    d->fxlevel0 = 0x7F;
    d->bend = 0x40;
    d->use3dpos = 0;
    d->azimuth = 0;
    d->elevation = 0;
    return 0;
}
