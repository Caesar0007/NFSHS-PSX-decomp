/* Exact source-visible type surface retained by retail pad.obj.
 *
 * The original PAD.C included the PsyQ kernel/GTE/GPU declarations and EA's
 * shape/CD-stream declarations before the pad types.  Their order matters to
 * CC1PSX's MIPS SDB writer: it assigns anonymous tags from the complete type
 * stream, which is why the retail pad union and module state are named
 * .59fake, .62fake, and .63fake.  Keep this header owner-local so those debug
 * records do not leak into unrelated eaclib objects.
 */
#ifndef NFS4_EACLIB_PSX_PAD_TYPES_H
#define NFS4_EACLIB_PSX_PAD_TYPES_H

typedef unsigned char  u_char;
typedef unsigned short u_short;
typedef unsigned int   u_int;
typedef unsigned long  u_long;
typedef unsigned short ushort;

struct TCB {
    long status, mode;
    u_long reg[40];
    long system[6];
};

struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size;
    u_long b_addr, b_size, s_addr, s_size, sp, fp, gp, ret, base;
};

struct DIRENTRY {
    u_char name[20];
    long attr, size;
    struct DIRENTRY *next;
    long head;
    u_char system[4];
};

typedef struct VECTOR {
    long vx, vy, vz, pad;
} VECTOR;

typedef struct SVECTOR {
    short vx, vy, vz, pad;
} SVECTOR;

typedef struct CVECTOR {
    u_char r, g, b, cd;
} CVECTOR;

typedef struct DVECTOR {
    short vx, vy;
} DVECTOR;

typedef struct RVECTOR {
    SVECTOR v;
    u_char uv[2];
    u_short pad;
    CVECTOR c;
    DVECTOR sxy;
    u_long sz;
} RVECTOR;

typedef struct CRVECTOR3 {
    RVECTOR r01, r12, r20;
    RVECTOR *r0, *r1, *r2;
    u_long *rtn;
} CRVECTOR3;

typedef struct CRVECTOR4 {
    RVECTOR r01, r02, r31, r32, rc;
    RVECTOR *r0, *r1, *r2, *r3;
    u_long *rtn;
} CRVECTOR4;

typedef struct RECT {
    short x, y, w, h;
} RECT;

typedef struct DR_ENV {
    u_long tag;
    u_long code[15];
} DR_ENV;

typedef struct DRAWENV {
    RECT clip;
    short ofs[2];
    RECT tw;
    u_short tpage;
    u_char dtd, dfe, isbg, r0, g0, b0;
    DR_ENV dr_env;
} DRAWENV;

typedef struct DISPENV {
    RECT disp, screen;
    u_char isinter, isrgb24, pad0, pad1;
} DISPENV;

typedef struct shapetbl {
    unsigned int type : 8;
    int next : 24;
    short width, height, centerx, centery;
    int shapex : 12;
    int reserved : 2;
    int transposed : 1;
    int rotated : 1;
    int shapey : 12;
    int mipmaps : 4;
    u_char data;
} SHAPE;

typedef struct PSXCDFILEINFO_def {
    u_char name[12];
    int sector;
    int length;
} PSXCDFILEINFO;

typedef struct cdstreamstruct {
    long id;
    u_char *start, *end, *write, *header, *get, *release;
    int handle, state, control, status, abort, datahascrc;
    int crcerrors, crcretries, buffersize;
    long blocksize;
    int readsize, chunksize, relocationsize;
    long fileoffset;
    int fileend;
    long filesize;
    int dataoffset, seekposition, seekoffset, idtype, idmask;
    struct cdstreamstruct *nextstream;
    void *emptyblock, *head, *tail, *block;
    int timer, blocktime, streamfull, getable, releaseable;
} CDSTREAM;

typedef struct PAD_PSX {
    u_short state;
    u_short unused[2];
} PAD_PSX;

typedef struct PAD_ANALOG {
    u_short state;
    u_char rightx, righty, leftx, lefty;
} PAD_ANALOG;

typedef struct PAD_COMMON {
    u_char nopad, ID;
    union {
        PAD_PSX standard;
        PAD_ANALOG analog;
    } data;
} PAD_COMMON;

typedef unsigned int size_t;
struct _physadr;
typedef struct _physadr *physadr;
typedef long daddr_t;
typedef u_char *caddr_t;
typedef long *qaddr_t;
typedef u_long ino_t;
typedef long swblk_t;
typedef long time_t;
typedef short dev_t;
typedef long off_t;
typedef u_short uid_t;
typedef u_short gid_t;
typedef void (*VOIDFN)();
typedef int FILEOP;
typedef void FILE_CALLBACK();
typedef int FILE_ATOM();
typedef void THREADPROC();
typedef int SYSTEMTASK();
typedef int THREAD;

#endif
