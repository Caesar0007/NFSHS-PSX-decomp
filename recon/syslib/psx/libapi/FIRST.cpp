/* syslib/psx/libapi/FIRST.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj FIRST.obj ; libapi.lib.  firstfile + _first_patch -- the libapi "first-file" wrapper that
 *   works around a retail-BIOS bug.  firstfile() strips the device prefix off `name`, walks the BIOS
 *   Device Control Block (DCB) table (kernel globals: base @0x150, byte-count @0x154; 0x50-byte
 *   entries), saves the matching device's first-file handler and swaps in _first_patch, then calls
 *   the BIOS firstfile2().  When the BIOS later invokes the device handler it hits _first_patch,
 *   which restores the original handler in the DCB and forwards the call -- a one-shot, self-removing
 *   patch.  NOTE: firstfile() returns firstfile2()'s DIRENTRY* result (Ghidra typed firstfile2 void
 *   and mis-attributed the return to the patch pointer; the disasm returns $v0 from firstfile2).
 *
 *   The 0x150/0x154 kernel globals and the 0x50-byte DCB layout are part of the PSX BIOS ABI (fixed
 *   addresses), represented here as literal volatile pointers per the HW/BIOS-global rule. */

extern "C" int   strcmp(const char *a, const char *b);     /* libc C23 @0x800E5D7C */
extern "C" void *firstfile2(const char *name, void *dir);  /* A66.OBJ : BIOS B0:0x42 */

/* PSX BIOS Device Control Block: 0x50 bytes.  Only the name pointer (+0x00) and the per-device
 * first-file handler slot (+0x34) are touched here. */
struct DCB {
    char  *name;        /* +0x00 */
    int    _r1[12];     /* +0x04 .. +0x30 */
    void  *firstfile;   /* +0x34 : first-file handler (patch target) */
    int    _r2[6];      /* +0x38 .. +0x4C */
};                      /* sizeof == 0x50 */

/* BIOS device-table kernel globals (fixed ABI addresses). */
#define BIOS_DCB_BASE   (*(DCB *volatile *)0x150)   /* @kernel 0x150 : DCB table base pointer */
#define BIOS_DCB_BYTES  (*(volatile int  *)0x154)   /* @kernel 0x154 : DCB table size in bytes */

typedef int (*FirstFn)(int *state, int arg, int arg2);

static FirstFn _first_save;          /* @0x80148A7C : saved original device handler */
static char    _first_devname[16];   /* @0x80148A84 : device prefix extracted from `name` */

/* @0x80109F5C : _first_patch -- restore the device's real handler, then forward the call. */
static int _first_patch(int *state, int arg, int arg2)
{
    DCB *e, *end;

    if (*state == 0)
        *state = 1;
    e   = BIOS_DCB_BASE;
    end = e + BIOS_DCB_BYTES / (int)sizeof(DCB);
    for (; e < end; e++) {
        if (e->name != 0 && strcmp(e->name, _first_devname) == 0) {
            e->firstfile = (void *)_first_save;   /* un-patch (one-shot) */
            break;
        }
    }
    return (*_first_save)(state, arg, arg2);   /* forward $a2=$s5 too (oracle @0x8010a034) */
}

/* @0x80109DC0 : firstfile */
extern "C" void *firstfile(char *name, void *dir)
{
    DCB  *e, *end;
    char *p;
    int   found;

    /* extract the device prefix (characters before ':') into _first_devname */
    p = _first_devname;
    while (*name > ':')
        *p++ = *name++;
    *p = '\0';

    /* pass 1: locate the device, remember its current first-file handler */
    found = 0;
    e   = BIOS_DCB_BASE;
    end = e + BIOS_DCB_BYTES / (int)sizeof(DCB);
    for (; e < end; e++) {
        if (e->name != 0 && strcmp(e->name, _first_devname) == 0) {
            _first_save = (FirstFn)e->firstfile;
            found = 1;
            break;
        }
    }
    if (!found)
        return 0;

    /* pass 2: install the self-removing patch into that device */
    e   = BIOS_DCB_BASE;
    end = e + BIOS_DCB_BYTES / (int)sizeof(DCB);
    for (; e < end; e++) {
        if (e->name != 0 && strcmp(e->name, _first_devname) == 0) {
            e->firstfile = (void *)_first_patch;
            break;
        }
    }
    return firstfile2(name, dir);
}
