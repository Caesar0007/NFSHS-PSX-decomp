/* Isolated proof that track.h exposes SaveSurface's real member APIs. */
#include "C:/Temp/nfs4-decomp/recon/game/common/track.h"

void (SaveSurface::*p875_save)(Trk_NewSimQuad *) = &SaveSurface::Save;
void (SaveSurface::*p875_restore)() = &SaveSurface::RestoreAll;

inline void *operator new(unsigned int, void *storage) { return storage; }

SaveSurface *p875_construct_surface(void *storage, int numEntries)
{
    return new (storage) SaveSurface(numEntries);
}
