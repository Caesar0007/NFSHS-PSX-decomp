/* syslib/psx/libcd/iso9660.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcd.lib(ISO9660.OBJ): the PsyQ ISO-9660 read-only filesystem on top of the CD driver.
 *
 *   COMPILED AS C by USER RULING (2026-07-25, uniformity over diff count): cc1plus (C++) measured
 *   strictly better per-fn diff counts than cc1 (C) on this TU -- CD_newmedia 125->146 (w26-a1
 *   dual-compile audit). Migrated anyway for source-uniformity across syslib/eaclib. Do NOT revert
 *   to .cpp without a user decision; see recon/syslib/psx/libcd/cdread.c,
 *   recon/eaclib/psx/eacpsxz/cdfs.c and recon/syslib/psx/libgpu/FONT.c for the sibling KEEP-CPP-
 *   turned-uniform TUs (same ruling, same date).
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
typedef struct CdlLOC CdlLOC;
struct CdlFILE { CdlLOC pos; u_long size; char name[16]; };          /* 0x18 */
typedef struct CdlFILE CdlFILE;
struct CdPathEnt { int index; int parent; int lba; char name[0x20]; };/* 0x2C */
typedef struct CdPathEnt CdPathEnt;
/* ISO9660 32-bit fields are MISALIGNED LE ints (record offset +2/+8C); the original reads them
 * through this CdlLOC-shaped union (misaligned load) -- byte-assembly rd32le diverges. */
union LBA { int addr; CdlLOC i; };
typedef union LBA LBA;

/* ---- libc (BIOS) / libcd / driver externs ----------------------------------------------------- */
extern int      strncmp(const char *, const char *, unsigned);  /* BIOS A0:0x18 @0x800EB1D0 */
extern int      strcmp(const char *, const char *);             /* BIOS A0:0x17 @0x800E5D7C */
extern void    *memcpy(void *, const void *, unsigned);         /* BIOS A0:0x2A @0x800EAAC4 */
extern int      printf(const char *, ...);                 /* libc C63 @0x801028AC */
extern CdlLOC  *CdIntToPos(int i, CdlLOC *p);              /* @0x800F7CF4 */
extern int      CdControl(u_char com, u_char *param, u_char *result); /* @0x800F78B4 */
extern int      CdRead(int sectors, u_long *buf, int mode);          /* @0x80108DDC */
extern int      CdReadSync(int mode, u_char *result);                /* @0x80108F78 */
extern int      CD_debug;   /* @0x8013BF50 (DRV) */
extern int      CD_nopen;   /* @0x8013BF5C : media-change counter (CDROM.OBJ) */

/* ---- ISO9660.OBJ .bss -------------------------------------------------------------------------- */
CdlFILE   _cd_dir[64];          /* @0x8014487C */
CdPathEnt _cd_pathtbl[128];     /* @0x80144E7C */
char      _cd_secbuf[0x800];    /* @0x8014647C */
/* _cd_search_nopen / _cd_cached_dir live in regular .bss (absolute addressing in the oracle,
 * NOT %gp_rel under -G4) -- declared extern so cc1plus emits `lui/%hi` not a gp-relative load.
 * Their definitions are part of the linked image's .bss (see asm/data D_80136C6C / D_80136C68). */
extern int _cd_search_nopen;    /* @0x80136C6C : CD_nopen the path table was built for */
extern int _cd_cached_dir;      /* @0x80136C68 : index of the directory currently in _cd_dir */

/* little-endian unaligned 32-bit load (matches the lwl/lwr pairs in the binary). */
static int rd32le(const u_char *p)
{
    return (int)((u_long)p[0] | ((u_long)p[1] << 8) | ((u_long)p[2] << 16) | ((u_long)p[3] << 24));
}

/* @0x800F9984 : read `nsec` sectors starting at LBA `lba` into `buf`; returns 1 on success. */
extern int cd_read(int nsec, int lba, void *buf)
{
    CdlLOC loc;
    CdIntToPos(lba, &loc);
    CdControl(2, (u_char *)&loc, 0);            /* CdlSetloc */
    CdRead(nsec, (u_long *)buf, 0x80);
    return (unsigned)CdReadSync(0, 0) < 1u;
}

/* @0x800F9360 : directory-name compare (ISO names are exact, so this is effectively ==). */
extern int _cd_cmp_name(char *a, char *b)
{
    return (unsigned)strncmp(a, b, 0xC) < 1u;   /* MATCH: sltiu (unsigned < 1) not slti */
}

/* @0x800F9644 : find the path-table entry for child (parent, name); returns its 1-based id or -1. */
extern int _cd_find_path(int parent, char *name)
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

/* @0x800F9380 : mount new media -- read the PVD, verify it, read & cache the whole path table.
 * MATCH (w51-a4): structure TRANSPLANTED from the byte-exact Rage Racer libcd decomp,
 * C:/Temp/rage-racer-decomp/src/main/PAL/lib/libcd/iso_media.c :: CD_newmedia.  Three levers:
 *  (1) ONE local `buf` holds &_cd_secbuf and is used for EVERY reference (both cd_read calls,
 *      the strncmp, the +140 path-table-LBA read and the walk bounds) -- the oracle keeps that
 *      base in $s0 and reads the misaligned LBA as `lwl 143(s0)/lwr 140(s0)`, where a fresh
 *      `_cd_secbuf + 140` constant address emits its own lui/addiu pair;
 *  (2) the first cd_read's result is kept in a named `r` and the SECOND read is compared
 *      against `r`, not against a literal 1 (oracle `beq v0,s1`);
 *  (3) the sector-buffer END pointer is hoisted into a local before the walk, so the loop test
 *      is a single `sltu v0,p,end` instead of rematerializing the address each iteration. */
extern int CD_newmedia(void)
{
    u_char *buf;
    LBA     pt_lba;
    u_char *rec;
    u_char *end;
    int     idx;
    int     r;

    buf = (u_char *)_cd_secbuf;
    r = cd_read(1, 0x10, (char *)buf);                       /* read PVD at LBA 0x10 */
    if (r != 1) {
        if (CD_debug > 0) printf("CD_newmedia: Read error in cd_read(PVD)\n");
        return 0;
    }
    if (strncmp((char *)buf + 1, "CD001", 5) != 0) {         /* standard identifier */
        if (CD_debug > 0) printf("CD_newmedia: Disc format error in cd_read(PVD)\n");
        return 0;
    }

    /* w51-a4 OPEN (39 diffs): the oracle reads this off the SAME base register as every other
     * buf reference (`lwl 143(s0)/lwr 140(s0)`); gcc-2.7.2 const-folds `buf` back to the symbol
     * for the unaligned load and emits its own `la $5,_cd_secbuf+140` + `lwl 3($5)/lwr 0($5)`.
     * FALSIFIED: `(LBA*)(buf+140)`, `((LBA*)buf)[35]`, decl reorder, -fforce-addr, -fforce-mem,
     * -fno-schedule-insns (hand-probed on the .i with CC1PSX 2.7.2 -- none move the base). */
    pt_lba.i = ((LBA *)buf)[140 / 4].i;                      /* type-L path table LBA (misaligned;
                                                              * indexed off buf so the +140 folds into
                                                              * the lwl/lwr displacement, oracle
                                                              * `lwl 143(s0)/lwr 140(s0)`) */
    if (cd_read(1, pt_lba.addr, (char *)buf) != r) {
        if (CD_debug > 0) printf("CD_newmedia: Read error (PT:%08x)\n", pt_lba.addr);
        return 0;
    }
    if (CD_debug > 1) printf("CD_newmedia: sarching dir..\n");

    idx = 0;
    rec = buf;
    end = buf + 0x800;
    while (rec < end) {
        if (rec[0] == 0)
            break;
        ((LBA *)&_cd_pathtbl[idx].lba)->i = ((LBA *)&rec[2])->i;  /* extent LBA (misaligned) */
        _cd_pathtbl[idx].parent = rec[6];               /* parent directory number */
        _cd_pathtbl[idx].index  = idx + 1;
        memcpy(_cd_pathtbl[idx].name, &rec[8], rec[0]);
        _cd_pathtbl[idx].name[rec[0]] = '\0';
        rec += 8 + rec[0] + rec[0] % 2;                 /* ISO path-table record stride */
        if (CD_debug > 1)
            printf("\t%08x,%04x,%04x,%s\n", _cd_pathtbl[idx].lba, _cd_pathtbl[idx].index,
                   _cd_pathtbl[idx].parent, _cd_pathtbl[idx].name);
        if (++idx >= 0x80)
            break;
    }
    if (idx < 0x80)
        _cd_pathtbl[idx].parent = 0;                    /* sentinel: no more entries */

    _cd_cached_dir = 0;
    if (CD_debug > 1) printf("CD_newmedia: %d dir entries found\n", idx);
    return 1;
}

/* @0x800F96E8 : read directory `dir` (1-based path-table id) and cache its file records. */
extern int CD_cachefile(int dir)
{
    LBA     entryLba;
    u_char *rec;
    int     i;
    short  *namePtr;

    if (dir == _cd_cached_dir)
        return 1;                                           /* already resident */

    /* MATCH (w51-a4): the oracle scales the RAW `dir` by the 0x2C stride off a base that sits
     * one entry BELOW _cd_pathtbl (`sll;addu;sll;subu;sll` on $s6 == dir*44, no `addiu -1`), i.e.
     * the original indexed a 1-BASED view of the table -- the byte-exact Rage Racer libcd decomp
     * spells it as its own symbol `g_CdPathEntryLbaByDirNum[dir]`
     * (C:/Temp/rage-racer-decomp/src/main/PAL/lib/libcd/iso_cache_file.c).  `(_cd_pathtbl - 1)[dir]`
     * is the same view without inventing a second symbol (the -0x2C folds into the %lo addend);
     * `_cd_pathtbl[dir - 1]` instead emits an extra `addiu v0,s6,-1` and scales the decremented
     * index. 13 -> PASS. */
    if (cd_read(1, (_cd_pathtbl - 1)[dir].lba, _cd_secbuf) != 1) {
        if (CD_debug > 0) printf("CD_cachefile: dir not found\n");
        return -1;
    }
    if (CD_debug > 1) printf("CD_cachefile: searching...\n");

    rec = (u_char *)_cd_secbuf;
    i   = 0;
    while (rec < (u_char *)_cd_secbuf + 0x800) {
        if (rec[0] == 0)                                    /* zero reclen -> end of records */
            break;
        entryLba.i = ((LBA *)&rec[2])->i;                   /* extent LBA (misaligned -> lwl/lwr) */
        CdIntToPos(entryLba.addr, &_cd_dir[i].pos);
        ((LBA *)&_cd_dir[i].size)->i = ((LBA *)&rec[0xA])->i; /* data length (misaligned copy) */
        switch (i) {
        case 0:                                             /* first record = "." */
            namePtr = (short *)_cd_dir[i].name;
            __builtin_memcpy(namePtr, ".", 2);              /* halfword store (oracle: sh) */
            break;
        case 1:                                             /* second record = ".." */
            namePtr = (short *)_cd_dir[i].name;
            __builtin_memcpy(namePtr, "..", 3);             /* sh + sb (oracle) */
            break;
        default:
            memcpy(_cd_dir[i].name, &rec[0x21], rec[0x20]); /* namelen re-read (oracle: 2x lbu 0x20) */
            _cd_dir[i].name[rec[0x20]] = '\0';
            break;
        }
        if (CD_debug > 1)
            printf("\t(%02x:%02x:%02x) %8d %s\n", _cd_dir[i].pos.minute, _cd_dir[i].pos.second,
                   _cd_dir[i].pos.sector, (int)_cd_dir[i].size, _cd_dir[i].name);
        rec += rec[0];                                      /* ISO directory-record stride */
        if (++i >= 0x40)
            break;
    }

    _cd_cached_dir = dir;
    if (i < 0x40)
        _cd_dir[i].name[0] = 0;                             /* terminate the cache */
    if (CD_debug > 1) printf("CD_cachefile: %d files found\n", i);
    return 1;
}

/* w51-a4 FALSIFIED on CdSearchFile (75 diffs, cc1_272 lane) -- do NOT retry either form:
 *  - the FULL Rage Racer DsSearchFile transplant (C:/Temp/rage-racer-decomp/src/main/PAL/lib/
 *    libds/search_file.c: `while (n < 8)` path split walking `*p` directly + two-pointer final
 *    scan) -> 75 -> 112.  Rage Racer's libds wrapper is NOT the same function shape as NFS4's
 *    ISO9660.OBJ CdSearchFile;
 *  - the two-pointer final scan ALONE (`nm = _cd_dir[0].name; rec = (CdlFILE*)(nm-8); rec++;
 *    nm += 24;`) grafted onto the existing body -> 75 -> 108.
 * The existing `_cd_dir[i]`-indexed scan + cached-`ch` split loop is the better basin. */
/* @0x800F9088 : resolve an absolute "\\dir\\file" path to its CdlFILE. */
extern CdlFILE *CdSearchFile(CdlFILE *fp, char *name)
{
    char           comp[0x20];
    int            dir;                                     /* current parent dir number */
    int            i;
    unsigned char *s;                                       /* cursor into `name` */
    unsigned char *q;                                       /* cursor into `comp` */
    unsigned char  ch;

    if (_cd_search_nopen != CD_nopen) {                     /* media changed -> remount */
        if (CD_newmedia() == 0)
            return 0;
        _cd_search_nopen = CD_nopen;
    }
    dir = 1;                                                /* root */
    if (*name != '\\')                                     /* paths must be absolute */
        return 0;
    comp[0] = 0;
    s = (unsigned char *)name;
    /* split on '\\'; descend through each directory component, leaving the filename in `comp`.
     * (the binary threads the parent dir id through $a0 across _cd_find_path calls, and keeps fp
     * live across the loop -- reproduced with the `fp++;fp--;` no-op.) */
    for (i = 0; i < 8; i++) {
        fp++;
        fp--;
        ch = *s;
        q = (unsigned char *)comp;
        while (ch != '\\') {
            if (!ch)
                goto out;                                   /* reached the filename */
            *q++ = ch;
            ch = *++s;
        }
        if (!*s)
            break;
        s++;                                                /* skip the separator */
        *q = 0;
        dir = _cd_find_path(dir, comp);
        if (dir == -1) {                                    /* directory not found */
            comp[0] = 0;
            break;
        }
    }
out:
    if (i >= 8) {
        if (CD_debug > 0) printf("%s: path level (%d) error\n", name, i);
        return 0;
    }
    if (comp[0] == 0) {
        if (CD_debug > 0) printf("%s: dir was not found\n", name);
        return 0;
    }

    *q = 0;                                                 /* terminate the filename component */
    if (CD_cachefile(dir) == 0) {                           /* disc error (else-arm dead: +/-1) */
        if (CD_debug > 0) printf("CdSearchFile: disc error\n");
        return 0;
    }
    if (CD_debug >= 2) printf("CdSearchFile: searching %s...\n", comp);
    for (i = 0; i < 64; i++) {
        if (_cd_dir[i].name[0] == 0)
            break;
        if (_cd_cmp_name(_cd_dir[i].name, comp)) {
            if (CD_debug >= 2) printf("%s:  found\n", comp);
            *fp = _cd_dir[i];                               /* copy the 24-byte record out */
            return &_cd_dir[i];                             /* (binary returns the cache slot) */
        }
    }
    if (CD_debug > 0) printf("%s: not found\n", name);
    return 0;
}
