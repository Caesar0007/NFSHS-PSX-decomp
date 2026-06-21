/* syslib/psx/libcd/iso9660.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcd.lib(ISO9660.OBJ): the PsyQ ISO-9660 read-only filesystem on top of the CD driver.
 *
 *   Public entry: CdSearchFile(fp, "\\DIR\\FILE.EXT;1") -- resolve an absolute path to its CdlFILE
 *   (start MSF + size).  Internals (PsyQ names recovered from the embedded debug strings):
 *     cd_read        (@0x800F9984) : CdlSetloc + CdRead + CdReadSync of N sectors into a buffer.
 *     _cd_cmp_name   (@0x800F9360) : strncmp(a,b,12) <= 0.
 *     _cd_find_path  (@0x800F9644) : look a child dir up in the path-table cache by (parent,name).
 *     CD_newmedia    (@0x800F9380) : read the Primary Volume Descriptor (LBA 0x10), verify "CD001",
 *                                    read the path table and build the path-table cache.
 *     CD_cachefile   (@0x800F96E8) : read one directory's extent and cache its file records.
 *
 *   Three fixed .bss tables (they tile exactly: _cd_dir end == _cd_pathtbl start, _cd_pathtbl end ==
 *   _cd_secbuf start, _cd_secbuf end == StEmu_Addr), confirming the 0x18 / 0x2C strides:
 *     _cd_dir[64]      @0x8014487C  -- cached file records of the current directory.
 *     _cd_pathtbl[128] @0x80144E7C  -- cached path table (one entry per directory).
 *     _cd_secbuf[0x800]@0x8014647C  -- single-sector scratch read buffer.
 *
 *   Faithful quirks reproduced with breadcrumbs: CdSearchFile returns &_cd_dir[i] (the cache slot)
 *   rather than fp on a hit (fp is filled too); the "CdSearchFile: disc error" branch is dead
 *   (CD_cachefile only ever returns +/-1); _cd_cmp_name uses strncmp<=0 (exact ISO names give ==0). */

typedef unsigned char u_char;
typedef unsigned long  u_long;

struct CdlLOC  { u_char minute, second, sector, track; };
struct CdlFILE { CdlLOC pos; u_long size; char name[16]; };          /* 0x18 */
struct CdPathEnt { int index; int parent; int lba; char name[0x20]; };/* 0x2C */

/* ---- libc (BIOS) / libcd / driver externs ----------------------------------------------------- */
extern "C" int      strncmp(const char *, const char *, unsigned);  /* BIOS A0:0x18 @0x800EB1D0 */
extern "C" int      strcmp(const char *, const char *);             /* BIOS A0:0x17 @0x800E5D7C */
extern "C" void    *memcpy(void *, const void *, unsigned);         /* BIOS A0:0x2A @0x800EAAC4 */
extern "C" int      printf(const char *, ...);                 /* libc C63 @0x801028AC */
extern "C" CdlLOC  *CdIntToPos(int i, CdlLOC *p);              /* @0x800F7CF4 */
extern "C" int      CdControl(u_char com, u_char *param, u_char *result); /* @0x800F78B4 */
extern "C" int      CdRead(int sectors, u_long *buf, int mode);          /* @0x80108DDC */
extern "C" int      CdReadSync(int mode, u_char *result);                /* @0x80108F78 */
extern "C" int      CD_debug;   /* @0x8013BF50 (DRV) */
extern "C" int      CD_nopen;   /* @0x8013BF5C : media-change counter (CDROM.OBJ) */

/* ---- ISO9660.OBJ .bss -------------------------------------------------------------------------- */
extern "C" {
CdlFILE   _cd_dir[64];          /* @0x8014487C */
CdPathEnt _cd_pathtbl[128];     /* @0x80144E7C */
char      _cd_secbuf[0x800];    /* @0x8014647C */
int       _cd_search_nopen = 0; /* @0x80136C6C : CD_nopen the path table was built for */
int       _cd_cached_dir   = 0; /* @0x80136C68 : index of the directory currently in _cd_dir */
}

/* little-endian unaligned 32-bit load (matches the lwl/lwr pairs in the binary). */
static int rd32le(const u_char *p)
{
    return (int)((u_long)p[0] | ((u_long)p[1] << 8) | ((u_long)p[2] << 16) | ((u_long)p[3] << 24));
}

/* @0x800F9984 : read `nsec` sectors starting at LBA `lba` into `buf`; returns 1 on success. */
static int cd_read(int nsec, int lba, void *buf)
{
    CdlLOC loc;
    CdIntToPos(lba, &loc);
    CdControl(2, (u_char *)&loc, 0);            /* CdlSetloc */
    CdRead(nsec, (u_long *)buf, 0x80);
    return CdReadSync(0, 0) < 1;
}

/* @0x800F9360 : directory-name compare (ISO names are exact, so this is effectively ==). */
static int _cd_cmp_name(char *a, char *b)
{
    return strncmp(a, b, 0xC) < 1;
}

/* @0x800F9644 : find the path-table entry for child (parent, name); returns its 1-based id or -1. */
static int _cd_find_path(int parent, char *name)
{
    int k = 0;
    do {
        if (_cd_pathtbl[k].parent == 0)
            return -1;                          /* end of table */
        if (_cd_pathtbl[k].parent == parent && strcmp(name, _cd_pathtbl[k].name) == 0)
            return k + 1;
        k++;
    } while (k < 0x80);
    return -1;
}

/* @0x800F9380 : mount new media -- read the PVD, verify it, read & cache the whole path table. */
static int CD_newmedia(void)
{
    u_char *rec;
    int     pt_lba, idx;

    if (cd_read(1, 0x10, _cd_secbuf) != 1) {                 /* read PVD at LBA 0x10 */
        if (CD_debug > 0) printf("CD_newmedia: Read error in cd_read(PVD)\n");
        return 0;
    }
    if (strncmp((char *)_cd_secbuf + 1, "CD001", 5) != 0) {  /* standard identifier */
        if (CD_debug > 0) printf("CD_newmedia: Disc format error in cd_read(PVD)\n");
        return 0;
    }

    pt_lba = rd32le((u_char *)_cd_secbuf + 140);             /* type-L path table location */
    if (cd_read(1, pt_lba, _cd_secbuf) != 1) {
        if (CD_debug > 0) printf("CD_newmedia: Read error (PT:%08x)\n", pt_lba);
        return 0;
    }
    if (CD_debug >= 2) printf("CD_newmedia: sarching dir..\n");

    rec = (u_char *)_cd_secbuf;
    idx = 0;
    while (rec < (u_char *)_cd_secbuf + 0x800 && rec[0] != 0 && idx < 0x80) {
        int namelen = rec[0];
        _cd_pathtbl[idx].index  = idx + 1;
        _cd_pathtbl[idx].parent = rec[6];                   /* parent directory number */
        _cd_pathtbl[idx].lba    = rd32le(rec + 2);          /* extent LBA */
        memcpy(_cd_pathtbl[idx].name, rec + 8, namelen);
        _cd_pathtbl[idx].name[namelen] = 0;
        if (CD_debug >= 2)
            printf("\t%08x,%04x,%04x,%s\n", _cd_pathtbl[idx].lba, _cd_pathtbl[idx].index,
                   _cd_pathtbl[idx].parent, _cd_pathtbl[idx].name);
        rec += namelen + 8 + (namelen & 1);                 /* ISO path-table record stride */
        idx++;
    }
    if (idx < 0x80)
        _cd_pathtbl[idx].parent = 0;                        /* terminate the cache */

    _cd_cached_dir = 0;
    if (CD_debug >= 2) printf("CD_newmedia: %d dir entries found\n", idx);
    return 1;
}

/* @0x800F96E8 : read directory `dir` (1-based path-table id) and cache its file records. */
static int CD_cachefile(int dir)
{
    u_char *rec;
    int     i;

    if (dir == _cd_cached_dir)
        return 1;                                           /* already resident */

    if (cd_read(1, _cd_pathtbl[dir - 1].lba, _cd_secbuf) != 1) {
        if (CD_debug > 0) printf("CD_cachefile: dir not found\n");
        return -1;
    }
    if (CD_debug >= 2) printf("CD_cachefile: searching...\n");

    rec = (u_char *)_cd_secbuf;
    i   = 0;
    while (rec < (u_char *)_cd_secbuf + 0x800 && rec[0] != 0 && i < 0x40) {
        CdIntToPos(rd32le(rec + 2), &_cd_dir[i].pos);       /* extent LBA -> MSF */
        _cd_dir[i].size = (u_long)rd32le(rec + 10);         /* data length */
        if (i == 0) {                                       /* first record = "." */
            _cd_dir[0].name[0] = '.';
            _cd_dir[0].name[1] = 0;
        } else if (i == 1) {                                /* second record = ".." */
            _cd_dir[1].name[0] = '.';
            _cd_dir[1].name[1] = '.';
            _cd_dir[1].name[2] = 0;
        } else {
            int namelen = rec[32];
            memcpy(_cd_dir[i].name, rec + 33, namelen);
            _cd_dir[i].name[namelen] = 0;
        }
        if (CD_debug >= 2)
            printf("\t(%02x:%02x:%02x) %8d %s\n", _cd_dir[i].pos.minute, _cd_dir[i].pos.second,
                   _cd_dir[i].pos.sector, (int)_cd_dir[i].size, _cd_dir[i].name);
        rec += rec[0];                                      /* ISO directory-record stride */
        i++;
    }

    _cd_cached_dir = dir;
    if (i < 0x40)
        _cd_dir[i].name[0] = 0;                             /* terminate the cache */
    if (CD_debug >= 2) printf("CD_cachefile: %d files found\n", i);
    return 1;
}

/* @0x800F9088 : resolve an absolute "\\dir\\file" path to its CdlFILE. */
extern "C" CdlFILE *CdSearchFile(CdlFILE *fp, char *name)
{
    char  comp[36];
    int   dir, level, i;
    char *s;
    char *q;

    if (_cd_search_nopen != CD_nopen) {                     /* media changed -> remount */
        if (CD_newmedia() == 0)
            return 0;
        _cd_search_nopen = CD_nopen;
    }
    if (*name != '\\')                                      /* paths must be absolute */
        return 0;

    comp[0] = 0;
    dir   = 1;                                              /* root */
    level = 0;
    s = name;
    /* split on '\\'; descend through each directory component, leaving the filename in `comp`.
     * (the binary threads the parent dir id through $a0 across _cd_find_path calls.) */
    while (level < 8) {
        q = comp;
        while (*s && *s != '\\')
            *q++ = *s++;
        *q = 0;
        if (*s == 0)                                        /* reached the filename */
            break;
        s++;                                                /* skip the separator */
        dir = _cd_find_path(dir, comp);
        if (dir == -1) {                                    /* directory not found */
            comp[0] = 0;
            break;
        }
        level++;
    }

    if (level >= 8) {
        if (CD_debug > 0) printf("%s: path level (%d) error\n", name, level);
        return 0;
    }
    if (comp[0] == 0) {
        if (CD_debug > 0) printf("%s: dir was not found\n", name);
        return 0;
    }

    if (CD_cachefile(dir) != 0) {                           /* (else-branch is dead: returns +/-1) */
        if (CD_debug >= 2) printf("CdSearchFile: searching %s...\n", comp);
        for (i = 0; i < 64 && _cd_dir[i].name[0] != 0; i++) {
            if (_cd_cmp_name(_cd_dir[i].name, comp)) {
                if (CD_debug >= 2) printf("%s:  found\n", comp);
                *fp = _cd_dir[i];                           /* copy the 24-byte record out */
                return &_cd_dir[i];                         /* (binary returns the cache slot) */
            }
        }
    } else if (CD_debug > 0) {
        printf("CdSearchFile: disc error\n");
        return 0;
    }

    if (CD_debug > 0) printf("%s: not found\n", name);
    return 0;
}
