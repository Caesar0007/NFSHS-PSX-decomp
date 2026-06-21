/* eaclib/psx/eacpsxz/fileroot.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** WIP 7/9 ***
 *   Source obj : nfs4\eaclib\psx\fileroot.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   9 fns @[0x800F3A34 .. 0x800F4100].  The device backend that nfile's iFILE_ExecCommand dispatches into.
 *   FULL reconstruction (disasm-v3 MIPS); NOT stubs.
 *
 *   A device handle encodes the filesystem in its top byte and the per-fs descriptor in the low 24 bits:
 *       fs  = handle >> 24        (1 == CD-ROM, 2 == PC host/dev link)
 *       dev = handle & 0xFFFFFF
 *   Each op switches on `fs` and forwards to that filesystem's backend (CD_* for the CD, PC* for the PSY-Q
 *   PC host).  CD reads run immediately; PC-host reads are slow over the dev link, so they are deferred:
 *   readfile() parks a {handle,dest,offset,len} command in the single-slot `readcmd` queue and the periodic
 *   readfile_systask() (registered by initfileio) executes the PClseek+PCread and completes the FILE op.
 *
 *   PROGRESS (incremental, like nfile):
 *     [done] initfileio, setdirectory, openfile, closefile, readfile, readfile_systask, writefile,
 *            getfilesize, stopreadfile   *** 9/9 COMPLETE ***
 *
 *   GOTCHA (recurring): a `&lbl_XXXXX()` call decodes to 0x80010000 + 0xXXXXX -- MIND THE CARRY.
 *   lbl_EA65C = 0x80010000+0xEA65C = 0x800FA65C (CD_Close), NOT 0x800EA65C; lbl_F6BE4 = 0x80106BE4 (PCread).
 */
#include <stddef.h>

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
extern "C" { char currentdir[64]; char *fsprefix1; char *fsprefix2; }

/* ---- CD-ROM filesystem backend (fs 1) ---- */
extern "C" int CD_Close(int dev);                                 /* @0x800FA65C */
extern "C" int CD_Read(int dev, int dest, int offset, int len);   /* @0x800FA678 */
extern "C" int CD_Stopread(int dev);                              /* @0x800FA904 */
extern "C" int CD_Getinfo(int dev, int a1, int *outSize);         /* @0x800FA920 */

/* ---- PC host (dev link) filesystem backend (fs 2) ---- */
extern "C" int PCinit(void);                                      /* @0x80106CC4 */
extern "C" int PCread(int fd, int buf, int len);                  /* @0x80106BE4 */
extern "C" int PClseek(int fd, int offset, int whence);           /* @0x80106D1C */
extern "C" int PCwrite(int fd, int buf, int len);                 /* @0x80106D50 */
extern "C" int PCclose(int fd);                                   /* @0x80106D40 */
extern "C" int psxdevelopmentsystem(void);                        /* @0x80106CF0 (dev link present?) */

extern "C" int CD_Open(char *name, int flags, int *outp);         /* @0x800FA554 */
extern "C" int PCopen(char *name, int mode, int a2);              /* @0x80106CA4 */
extern "C" int PCcreat(char *name, int a1);                       /* @0x80106CD0 */

/* ---- system glue + string helpers ---- */
extern "C" void addsystemtask(int (*fn)(void), int a1, int a2);   /* @0x800E6AF4 */
extern "C" int  iFILE_CommandCompleteCallback(int result);        /* @0x800ED020 (nfile) */
extern "C" int  readfile_systask(void);                           /* below */
extern "C" char *strchr(const char *s, int c);                   /* @0x800F6214 */
extern "C" char *strncpy(char *d, const char *s, int n);          /* @0x800F6104 */
extern "C" char *strcpy(char *d, const char *s);                  /* @0x800E5B28 */
extern "C" char *strcat(char *d, const char *s);                  /* @0x800E78E8 */
extern "C" int   strncmp(const char *a, const char *b, int n);    /* @0x800EB1D0 */
extern "C" int   strlen(const char *s);                           /* @0x800E9F74 */
extern "C" void *memset(void *d, int c, int n);                   /* @0x800E4318 */
extern "C" char *fsprefix1;     /* @0x8013DD34 -> "cdrom:" (CD drive prefix, 6-char compare)  */
extern "C" char *fsprefix2;     /* @0x8013DD40 -> "sim:"   (PC-host prefix, 4-char compare)   */
extern "C" char  currentdir[];  /* @0x80140414 cwd, prepended to relative PC paths     */

/* ---- fileroot globals (data-materialization pass owns the addresses) ---- */
extern "C" int disablecd;            /* nonzero == CD backend disabled                    */
extern "C" int availablefilesystems; /* bitmask: 1 == CD present, 2 == PC host present     */
extern "C" int currentfilesystem;    /* the fs selected by initfileio/setdirectory         */

/* the single-slot deferred PC-host read command (executed by readfile_systask).
 * @0x80140400 (.bss, 20B = 5 ints). The `extern` form below was only a DECLARATION
 * (a promise) -> the storage was never defined in any TU (surfaced by the link harness).
 * Defined here, its owning TU, since ReadCmd is a TU-local struct. Zero-init (BSS). */
struct ReadCmd {
    int pending;   /* +0x00 nonzero == a command is queued */
    int handle;    /* +0x04 dev descriptor (fs byte already masked off) */
    int dest;      /* +0x08 destination address */
    int offset;    /* +0x0C file offset */
    int len;       /* +0x10 byte count */
};
ReadCmd readcmd;   /* definition (BSS zero) */

/* cop0 IRQ-disabled critical section guarding the readcmd slot (host no-op). */
#if defined(__mips__)
void FROOT_enterCS(void);
void FROOT_leaveCS(void);
#else
static inline void FROOT_enterCS(void) {}
static inline void FROOT_leaveCS(void) {}
#endif

/* initfileio @0x800F3A34 : advertise the CD (unless disabled), and -- if the PC dev link is present --
 *   bring up PC host I/O, register the deferred-read system task, and select the PC filesystem. */
extern "C" int initfileio(void)
{
    if (disablecd == 0)
        availablefilesystems |= 1;                  /* CD present */
    if (psxdevelopmentsystem() != 0) {              /* dev link present -> use PC host */
        PCinit();
        addsystemtask(readfile_systask, 0, 0);
        currentfilesystem    = 2;
        availablefilesystems |= 2;
    } else {
        currentfilesystem = 0;                      /* no dev link (asm: = psxdevelopmentsystem() == 0) */
    }
    return 0;
}

/* setdirectory @0x800F3ACC : select the current filesystem from a "drive:" prefix and, for the PC host,
 *   remember the directory (prefix stripped) as the cwd, ensuring it ends in a backslash.  CD has no
 *   settable cwd, so a CD prefix only switches the current filesystem. */
extern "C" void setdirectory(char *dir)
{
    int prefixlen = 0;
    if (strncmp(dir, fsprefix1, 6) == 0) {              /* CD prefix */
        if ((availablefilesystems & 3) == 2) return;    /* only the PC host is available */
        if (strlen(dir) >= 7) return;                   /* must be just the prefix */
        prefixlen = 6;
        currentfilesystem = 1;
    } else if (strncmp(dir, fsprefix2, 4) == 0) {       /* PC-host prefix */
        if ((availablefilesystems & 2) == 0) return;
        prefixlen = 4;
        currentfilesystem = 2;
    }
    if (currentfilesystem != 2)                         /* only the PC host stores a cwd */
        return;
    strcpy(currentdir, dir + prefixlen);
    if (currentdir[63] != 0)                            /* path overflowed the 64-byte buffer */
        return;
    {
        int len = strlen(currentdir);
        if (len <= 0)
            return;
        if (currentdir[len] != '\\')                    /* (asm reads currentdir[len]) -> add a separator */
            strcat(currentdir, "\\");
    }
}

/* openfile @0x800F3BE0 : open `name` and write the encoded device handle (fs<<24 | descriptor) to *outp.
 *   A leading "drive:" prefix selects the filesystem (fsprefix1 -> CD, fsprefix2 -> PC host); otherwise the
 *   current filesystem is used.  CD opens go through CD_Open; PC-host opens build a cwd-relative path and
 *   pick a PCopen/PCcreat mode from (flags & 7).  Returns 1 on success, 0 on failure. */
extern "C" int openfile(char *name, int flags, int *outp)
{
    char  namebuf[0x40];
    int   fs = currentfilesystem;
    memset(namebuf, 0, 0x40);

    if (strchr(name, ':') != 0) {                       /* a "drive:"/fs prefix is present */
        if (strncmp(name, fsprefix1, 6) == 0) {         /* CD prefix */
            if ((availablefilesystems & 1) == 0) { *outp = 0; return 0; }
            fs = 1; name += 6;
        } else if (strncmp(name, fsprefix2, 4) == 0) {  /* PC-host prefix */
            if ((availablefilesystems & 2) == 0) { *outp = 0; return 0; }
            fs = 2; name += 4;
        } else if (currentfilesystem == 1 || name[1] != ':') {
            int idx = (int)(strchr(name, ':') - name);  /* unknown prefix -> copy the volume, no open */
            strncpy(namebuf, name, idx + 1);
            namebuf[idx + 2] = 0;
            fs = 0;
        }
        /* else: bare "X:" with currentfilesystem != 1 -> keep the current fs and the whole name */
    }

    if (fs == 1) {                                      /* CD-ROM */
        if (CD_Open(name, flags, outp) == 0) { *outp = 0; return 0; }
        *outp |= 0x1000000;                             /* tag fs byte = 1 */
        return 1;
    }
    if (fs != 2)                                        /* fs 0 -> nothing to open */
        return 1;

    /* fs == 2 : PC host -- prepend the cwd unless the path is absolute */
    if (name[0] != '\\' && name[0] != '/')
        strcpy(namebuf, currentdir);
    strcat(namebuf, name);

    switch (flags & 7) {
    case 0: *outp = PCopen(namebuf, 2, 0); break;       /* read/write */
    case 1: *outp = PCopen(namebuf, 0, 0); break;       /* read */
    case 2:                                             /* read, create if missing */
        *outp = PCopen(namebuf, 0, 0);
        if (*outp < 0) *outp = PCcreat(namebuf, 0);
        break;
    case 4: {                                           /* truncate-create */
        int fd = PCopen(namebuf, 0, 0);
        *outp = fd;
        if (fd < 0) { *outp = 0; return 0; }
        PCclose(fd);
        *outp = PCcreat(namebuf, 0);
        break;
    }
    case 6: *outp = PCcreat(namebuf, 0); break;         /* create */
    default: *outp = -1; break;                         /* modes 3,5,>=7 invalid */
    }

    if (*outp <= 0) { *outp = 0; return 0; }
    *outp = (fs << 0x18) | *outp;                       /* tag fs byte */
    return 1;
}

/* closefile @0x800F3E84 : close `handle` on its filesystem; returns the backend's result. */
extern "C" int closefile(int handle)
{
    int fs  = handle >> 0x18;
    int dev = handle & 0xFFFFFF;
    int r   = 0;
    if (fs == 1)      r = CD_Close(dev);
    else if (fs == 2) r = PCclose(dev);
    return r;
}

/* readfile @0x800F3EE0 : CD reads run now; PC-host reads are queued in `readcmd` for readfile_systask.
 *   Returns 1 if a PC read was queued (0 if the slot was busy), or the CD backend's result. */
extern "C" int readfile(int handle, int dest, int offset, int len)
{
    int fs  = handle >> 0x18;
    int dev = handle & 0xFFFFFF;                    /* asm masks in the delay slot -> applies to all paths */
    int r   = 0;
    if (fs == 1) {
        r = CD_Read(dev, dest, offset, len);
    } else if (fs == 2) {
        FROOT_enterCS();
        if (readcmd.pending == 0) {                 /* one PC read in flight at a time */
            readcmd.pending = 1;
            readcmd.handle  = dev;
            readcmd.dest    = dest;
            readcmd.offset  = offset;
            readcmd.len     = len;
            r = 1;
        }
        FROOT_leaveCS();
    }
    return r;
}

/* readfile_systask @0x800F3F80 : execute a queued PC-host read (PClseek + PCread) and complete the FILE op
 *   (success when the full length was read).  Registered as a periodic task by initfileio. */
extern "C" int readfile_systask(void)
{
    FROOT_enterCS();
    if (readcmd.pending != 0) {
        int n;
        PClseek(readcmd.handle, readcmd.offset, 0);
        n = PCread(readcmd.handle, readcmd.dest, readcmd.len);
        readcmd.pending = 0;
        iFILE_CommandCompleteCallback(((n ^ readcmd.len) < 1) ? 1 : 0);   /* n==len -> success */
    }
    FROOT_leaveCS();
    return 0;
}

/* writefile @0x800F4020 : PC host only -- PClseek + PCwrite, then complete the FILE op. */
extern "C" int writefile(int handle, int buf, int offset, int len)
{
    int fs  = handle >> 0x18;
    int dev = handle & 0xFFFFFF;
    if (fs == 2) {                                  /* only the PC host supports writing */
        int n;
        PClseek(dev, offset, 0);
        n = PCwrite(dev, buf, len);
        iFILE_CommandCompleteCallback(((n ^ len) < 1) ? 1 : 0);
    }
    return 0;
}

/* getfilesize @0x800F409C : size of `handle` -- CD via CD_Getinfo, PC host via lseek-to-end. */
extern "C" int getfilesize(int handle)
{
    int fs   = handle >> 0x18;
    int dev  = handle & 0xFFFFFF;
    int size = 0;
    if (fs == 1)      CD_Getinfo(dev, 0, &size);    /* CD: size returned via out-param */
    else if (fs == 2) size = PClseek(dev, 0, 2);    /* PC: lseek(SEEK_END) == size */
    return size;
}

/* stopreadfile @0x800F4100 : abort an in-flight read.  CD: CD_Stopread; PC host: drop the queued command
 *   (if it is this handle's) and complete it.  Called by FILE_cancelop. */
extern "C" int stopreadfile(int handle)
{
    int fs  = handle >> 0x18;
    int dev = handle & 0xFFFFFF;
    if (fs == 1) {
        CD_Stopread(dev);
    } else if (fs == 2) {
        if (readcmd.pending != 0 && readcmd.handle == dev) {
            readcmd.pending = 0;
            iFILE_CommandCompleteCallback(1);
        }
    }
    return 0;
}
