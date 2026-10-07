/* Tiny bridge loaded with the frontend/movie overlay.  Keeping these wrappers out of core_api.c
 * means race memory does not pay for APIs used only by PsyQ CdRead/STR playback. */

typedef unsigned char u_char;
typedef struct CdlLOC { u_char minute, second, sector, track; } CdlLOC;

extern u_char CD_status;
extern u_char CD_mode;
extern CdlLOC CD_pos;
extern int CD_getsector2(void *dst, int words);
extern int DMACallback(int channel, int callback);

int CdStatus(void) { return (unsigned int)CD_status; }
int CdMode(void) { return (unsigned int)CD_mode; }
void *CdLastPos(void) { return &CD_pos; }
int CdGetSector2(void *dst, int words) { return CD_getsector2(dst, words) == 0; }
int CdDataCallback(int callback) { return DMACallback(3, callback); }
