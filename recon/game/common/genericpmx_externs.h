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
extern void ChangeTPage(u_short *p, int n);                                      /* gfx */
extern void Texture_CloneUVPmx(Draw_tPixMap *src, int n, Draw_tPixMap *dst);     /* texture.obj */
extern void Texture_LoadPmx(char *a, char *b, int c, int d, int e, int f, int g, Draw_tPixMap *pm);  /* texture.obj */
extern void Texture_ResetPaletteSharing(void);                                   /* texture.obj */
extern "C" {
void *loadfileadr(char *filename, int memory_class);
shapetbl *locateshapez(char *shapeFile, char *shapeName);
int purgememadr(void *ptr);
int sprintf(char *buffer, const char *format, ...);
}

#endif /* GENERICPMX_EXTERNS_H */
