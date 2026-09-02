/* libcd.lib(C_003.obj): StUnSetRing and its private CD-register pointers. */
#include "stream_internal.h"

extern int CdDataCallback(int func);
extern int CdReadyCallback(int func);
extern int EnterCriticalSection(void);
extern void ExitCriticalSection(void);
extern int DS_active;
extern int DsReadyCallback(int func);
extern int DsDataCallback(int func);

/* SYM-GLOBAL-CARRIER: _un_cd_idx
 * SYM-GLOBAL-CARRIER: _un_cd_reg3
 * These exact initialized MMIO pointers are relocation- and section-proven;
 * the stripped C_003 object contributes no private data declaration rows. */
/* These initialized pointers are absolute-addressed retail .data, not -G4
 * small data.  Their order and section reproduce C_003.obj's data member. */
static volatile u_char *_un_cd_idx __attribute__((section(".data"))) =
    (volatile u_char *)0x1F801800;
static volatile u_char *_un_cd_reg3 __attribute__((section(".data"))) =
    (volatile u_char *)0x1F801803;

extern void StUnSetRing(void)
{
    EnterCriticalSection();
    if (DS_active == 1) {
        DsDataCallback(0);
        DsReadyCallback(0);
    } else {
        CdDataCallback(0);
        CdReadyCallback(0);
    }
    *_un_cd_idx = 0;
    *_un_cd_reg3 = 0;
    ExitCriticalSection();
}
