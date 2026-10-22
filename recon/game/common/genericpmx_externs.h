/* genericpmx_externs.h -- cross-TU decls for game/common/genericpmx.cpp (NFS4 generic-PMX tex loader).
 *   Types (Draw_tPixMap, GameSetup_tData, CTrackSpec) live in nfs4_types.h. genericpmx OWNS its
 *   g*Pixmap/g*Palette/gPixmaps globals (defined in the .cpp). */
#ifndef GENERICPMX_EXTERNS_H
#define GENERICPMX_EXTERNS_H

/* ---- cross-TU globals ---- */
extern GameSetup_tData GameSetup_gData;       /* gmesetup.obj */
extern char     *Paths_Paths[50];          /* paths.obj */
extern CTrackSpec TrackSpec_gSpec;            /* trackspec.obj */

/* ---- cross-TU functions ---- */
/* Retail parameter identities: ChangeTPage3c1349..3c135c,
 * Texture_CloneUVPmx46c1e0..46c212, Texture_LoadPmx46bf1f..46bf8f.
 * Header baseline/evidence: build/nc12/genericpmx_contracts_20261022.
 * rx/ry are placement coordinates, not width/height. */
extern void ChangeTPage(u_short *tpage, int nabr);                                  /* drawc.obj */
extern void Texture_CloneUVPmx(Draw_tPixMap *pmx, int mode, Draw_tPixMap *rpmx);     /* texture.obj */
extern void Texture_LoadPmx(char *f, char *n, int ctrl, int rx, int ry, int cx, int cy, Draw_tPixMap *pmx);  /* texture.obj */
extern void Texture_ResetPaletteSharing(void);                                   /* texture.obj */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/locatshp.h"
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/nsync.h"
}
extern "C" {
/* Canonical PsyQ4.3 STDIO.H:35, including the non-const fmt interface. */
int sprintf(char *buffer, char *fmt, ...);
}

#endif /* GENERICPMX_EXTERNS_H */
