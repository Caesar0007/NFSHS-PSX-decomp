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
struct RawWord { u_char bytes[4]; };
typedef struct RawWord RawWord;

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

/* w51-a4 FALSIFIED on CdSearchFile (75 diffs, cc1_272 lane) -- do NOT retry either form:
 *  - the FULL Rage Racer DsSearchFile transplant (C:/Temp/rage-racer-decomp/src/main/PAL/lib/
 *    libds/search_file.c: `while (n < 8)` path split walking `*p` directly + two-pointer final
 *    scan) -> 75 -> 112.  Rage Racer's libds wrapper is NOT the same function shape as NFS4's
 *    ISO9660.OBJ CdSearchFile;
 *  - the two-pointer final scan ALONE (`nm = _cd_dir[0].name; rec = (CdlFILE*)(nm-8); rec++;
 *    nm += 24;`) grafted onto the existing body -> 75 -> 108.
 * The existing `_cd_dir[i]`-indexed scan + cached-`ch` split loop is the better basin. */
/* MATCH (w61-a8): 75 -> 64 diffs, `.frame` regs 7 -> retail's 8.  Three levers, each
 * gated individually on the whole TU (zero PASS->FAIL):
 *  (1) SIGNED-CHAR CURSORS.  Retail loads every path byte with `lb` (sign-extended);
 *      plain `char` is UNSIGNED on this cc1_272 lane (measured: `*name != '\\'` on a
 *      `char *` emits `lbu` where retail has `lb`), so only an explicit `signed char`
 *      changes it.  `unsigned char` also cost a redundant `andi v1,a1,255` per test.
 *  (2) THE TWO LOOP CONSTANTS AS NAMED PREHEADER LOCALS (`sep` / `notfound`).  Retail
 *      materialises BOTH into callee-saved registers in the outer preheader
 *      (`addiu s5,zero,0x5C` / `addiu s4,zero,-1`, live across the `_cd_find_path`
 *      call) and therefore saves EIGHT callee-saved regs; our literals were
 *      rematerialised inside the loop, so we only ever saved seven and every
 *      s-register was one slot off.  Assigned in the preheader, NOT decl-with-init
 *      (a decl-with-init moves the live-range start and demotes the allocno).
 *  (3) THE TWO TESTS RE-READ `*s`; THE STORE KEEPS THE CACHED `ch`.  Retail issues a
 *      fresh `lb`+`lbu` pair per test (the `*q` store may alias `name`), so a cached
 *      `ch` carried across the back-edge cost a `move` + a `sll/sra` sign-extend.
 *      Re-reading the STORE too (`*q++ = *s`) is 4 diffs WORSE.
 * W62-A7 (2026-08-15) 64/60 -> 42.  THE `fp++; fp--;` NO-OP WAS THE ROTATION.  It sits
 * INSIDE the i-loop, so its refs are loop-depth weighted (+2 per operand): qty272 priced
 * fp at refs 11 / live 84 / pri 3928 = FIRST of the four long-lived allocnos, where
 * retail has it LAST ($s6).  fp is live to the `*fp = _cd_dir[i]` copy-out anyway, so the
 * no-op bought nothing but refs; deleting it drops fp to the bottom of the priority list
 * and the prologue save/copy group becomes retail's.  READ-OFF RECIPE (13A/12A: 272
 * priority = floor_log2(refs)*refs/live, NO size term): dump the four call-crossing
 * allocnos with tools/qty272.py, compare their order against the oracle's $s3..$s6
 * handout, and look for a REF-INFLATING artifact before reaching for a dial.
 * FALSIFIED W62-A7 (all gated + reverted): read-only fence operands on `name` (1/2/3)
 * and on `notfound` (2) after the no-op removal -- all 42, the remaining rotation
 * (ours sep/name/notfound = $s3/$s4/$s5, retail name/notfound/sep) does NOT move on a
 * ref dial; an inner-loop copy of the separator (`sep2 = sep;`) 42 inert (cse folds it
 * back, so retail's `li a1,92` inner-preheader copy is NOT source-reachable this way).
 * THE PHANTOM-VARS BLOCKER IS RE-CONFIRMED ON THIS BASIN (13E): `*q++ = *s++` 72 with
 * frame 96 / vars=48 (retail 80 / vars=32) -- measured with the .frame line, not just the
 * diff count; the same walk with the unused `ch` decl dropped 72; a re-reading store with
 * the frame-safe `ch = *++s` increment 45; both tests off the cached `ch` 46; zero test
 * off `ch` + re-reading store 47; an explicit `(int)*s` compare 42 (inert).
 * RESIDUAL 42 = (a) the inner loop still CSEs the compare's load with `ch = *++s`
 *   (same address) and sign-extends by `sll 24/sra 24` instead of retail's second
 *   `lb`, and the loop entry is a `j <bottom test>` where retail PEELS the guard;
 *   (b) the `lb` vs `lbu` split at the three PLAIN-`char` sites (`*name`, `comp[0]`,
 *   `_cd_dir[i].name[0]`) -- a TU FLAG question, see the -fsigned-char note below.
 * FALSIFIED (each measured on this basin, with and without -fsigned-char):
 *   `*q++ = *s++` / a standalone `s++` / a `for(;;)`-with-`break` peeled guard all
 *   reproduce retail's `lb`+`lbu` pair BUT make gcc-2.7.2 reserve 16 bytes of DEAD
 *   `vars` (frame 80 -> 96, `vars= 32` -> `48`, nothing ever stored there), which
 *   costs more than the pair wins (86-96 diffs).  Only the `ch = *++s` increment
 *   form keeps the frame at retail's 80.  NEW NAMED ANGLE (unexplained, reusable):
 *   the phantom 16-byte `vars` reservation is what blocks retail's exact loop here.
 *   Source `(signed char *)` casts at the three plain-`char` sites: 103 (WORSE --
 *   the cast costs a callee-saved reg); -fno-strength-reduce on this TU: 2/6 PASS
 *   (breaks _cd_find_path AND CD_cachefile) -- do not retry.
 * ORCHESTRATOR: a `-fsigned-char` PER_TU flag is worth -4 more here (CdSearchFile
 *   64 -> 60, everything else in the TU unchanged) and is INERT on libmcrd/BIOS.c
 *   17/17, libcd/stcdint.c, libcd/streamhelp.c, libetc/INTR.c and libapi/FIRST.c --
 *   i.e. zero risk on the measured belt.  There is no such key in PER_TU_FLAGS today
 *   (probe harness: scratchpad/w61a8/fprobe.py).   [LANDED since -- the TU carries
 *   {"cc1_272": True, "signed_char": True}.]
 * W63-A6 (2026-08-15) 42 -> 19.  TWO LEVERS, in this order:
 *  (A) THE TRAILING printf ARG WAS WRONG (a real transcription bug, not a dial):
 *      the oracle passes `addiu $a1,$sp,0x10` == &comp[0], NOT `name`
 *      (CdSearchFile.s @0x800F9320); the matched PsyQ-4.0 twin agrees
 *      (C:/Temp/psyz/decomp/src/libcd/iso9660.c:118).  `name` therefore stayed live
 *      across the whole final scan loop (qty272: refs 6 / live 88 / crosses 5 calls)
 *      and CONFLICTED with that loop's `_cd_dir` address givs -- pseudo 154
 *      (`_cd_dir+8`, refs 7 / live 14 / pri 10000) was allocated first and took the
 *      $s3 retail gives `name`.  Fixing the arg killed the conflict outright: 42 -> 37.
 *  (B) then the priced ref dial: with 154 out of the way qty272 read
 *      sep .2000 ($s3) > name .1754 ($s4) > notfound .0517 ($s5), exactly inverted
 *      from retail (name $s3 / notfound $s4 / sep $s5).  ONE in-loop read-only fence
 *      operand = +2 loop-weighted refs; name x1 + notfound x2 lifts both over sep.
 *      37 -> 19, ZERO instructions (181 both sides of the edit), all registers now
 *      retail-exact.  Operand grid (scratchpad/w63a6/probe_iso7.py): x1/x1 = 23,
 *      x1/x2 = x2/x2 = x2/x3 = x3/x3 = x3/x4 = x4/x5 = 19, x2/x4 = 37 (over-dial
 *      re-inverts name/notfound) -- x1/x2 is the minimal operand set.
 * RESIDUAL 19 = the inner split loop ALONE, one shape:
 *      retail  lb v0,0(s0) / beq v0,s5 / li a1,0x5C / beqz v1 / lb v0,0(s0) / bne v0,a1
 *      ours    j T / beqz a1 / sll v0,v1,24 / sra v0,v0,24 / bne v0,s5 / addu a1,v1
 *   i.e. retail PEELS the entry guard, keeps a caller-saved inner-preheader copy of
 *   the separator, and loads the SAME byte TWICE per iteration -- `lb` (signed, feeds
 *   the != sep compare) AND `lbu` (unsigned, feeds the zero test AND the *q store) --
 *   with no sign-extend anywhere.  RE-TESTED ON THIS BASIN (04Z basin law) and all
 *   FALSIFIED, scratchpad/w63a6/probe_iso8.py: `ch` as u_char decl-only 19 (inert);
 *   zero-test off the cached `ch` 23; explicit u_char cache + signed re-read compare
 *   (`ch = *(u_char*)s` ... `while (*s != sep)`) 55 at 177 insns; the same with
 *   `*(u_char*)++s` 55/177; no cache at all (`if(!*(u_char*)s)` + `*q++ = *(u_char*)s`)
 *   55/177 -- every distinct-extension spelling makes cc1-2.7.2 FUSE the lb+lbu pair
 *   into one load and lands 4-5 insns SHORT.  Also falsified on the PRE-fence basin
 *   (probe_iso.py / probe_iso3.py): the whole psyz-4.0 loop transplant (cached-`ch`
 *   test + `fp++;fp--;`) 64-74, and an explicit peeled guard + do-while 82-90.
 *   NAMED ANGLE for the next pass: force cc1 to keep TWO loads of one QImode address
 *   without the phantom-`vars` frame growth (the 13E blocker above) -- i.e. a
 *   zero-insn way to defeat the lb/lbu fusion. */
/* @0x800F9088 : resolve an absolute "\\dir\\file" path to its CdlFILE. */
extern CdlFILE *CdSearchFile(CdlFILE *fp, char *name)
{
    char           comp[0x20];
    int            dir;                                     /* current parent dir number */
    int            i, sep, notfound;
    signed char   *s;                                       /* cursor into `name` */
    signed char   *q;                                       /* cursor into `comp` */
    signed char    ch;

    if (_cd_search_nopen != CD_nopen) {                     /* media changed -> remount */
        if (CD_newmedia() == 0)
            return 0;
        _cd_search_nopen = CD_nopen;
    }
    dir = 1;                                                /* root */
    if (*name != '\\')                                     /* paths must be absolute */
        return 0;
    comp[0] = 0;
    s = (signed char *)name;
    /* split on '\\'; descend through each directory component, leaving the filename in `comp`.
     * (the binary threads the parent dir id through $a0 across _cd_find_path calls; fp needs NO
     * liveness no-op -- it is live to the `*fp = _cd_dir[i]` copy-out, and the `fp++;fp--;`
     * pair that used to sit here only inflated its ref count, see the W62-A7 note above.) */
    sep = '\\'; notfound = -1; for (i = 0; i < 8; i++) {
        /* MATCH (w63-a6, reqdelta272-priced, ZERO instructions): retail hands out
         * name=$s3 / notfound=$s4 / sep=$s5; ours priced (after the printf-arg fix)
         * sep .2000 > name .1754 > notfound .0517 = $s3/$s4/$s5 -- exactly inverted.
         * An in-loop read-only fence operand is +2 loop-weighted refs, so ONE `name`
         * operand (5->7 refs) and TWO `notfound` operands (3->7) lift both over sep
         * and restore retail's order.  Minimal operand set: x1/x1 = 23, x1/x2 = 19,
         * and every larger combo measured 19 as well (x2/x4 = 37, an over-dial that
         * re-inverts name/notfound).  See scratchpad/w63a6/probe_iso7.py. */
        __asm__("" : : "r"(name), "r"(notfound), "r"(notfound));
        ch = *s;
        q = (signed char *)comp;
        while (*s != sep) {
            if (!*s)
                goto out;                                   /* reached the filename */
            *q++ = ch;
            ch = *++s;
        }
        if (!*s)
            break;
        s++;                                                /* skip the separator */
        *q = 0;
        dir = _cd_find_path(dir, comp);
        if (dir == notfound) {                                    /* directory not found */
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
    /* BUG FIX (w63-a6): the trailing diagnostic prints the COMPONENT, not the whole path --
     * the oracle's arg is `addiu $a1,$sp,0x10` == &comp[0] (CdSearchFile.s @0x800F9320), and the
     * matched PsyQ-4.0 twin agrees (C:/Temp/psyz/decomp/src/libcd/iso9660.c:118
     * `printf("%s: not found\n", buf)`).  Passing `name` kept the path pointer live across the
     * whole final scan loop (qty272: 73 refs 6 / live 88 / crosses 5 calls), where it conflicted
     * with the loop's `_cd_dir` address givs and lost $s3 to one of them. */
    if (CD_debug > 0) printf("%s: not found\n", comp);
    return 0;
}

/* @0x800F9360 : directory-name compare (ISO names are exact, so this is effectively ==). */
extern int _cd_cmp_name(char *a, char *b)
{
    return (unsigned)strncmp(a, b, 0xC) < 1u;   /* MATCH: sltiu (unsigned < 1) not slti */
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
 *      is a single `sltu v0,p,end` instead of rematerializing the address each iteration.
 * W56: Rage's `CdRawWord` is a four-byte STRUCT, not the earlier union-shaped LBA.  Reinterpreting
 * the raw struct at both call/diagnostic uses makes gcc reload the value from its stack slot rather
 * than retain it in $s0 across `cd_read`: 39 -> 32, with exact 177/177 instruction count. */
/* RESIDUAL 11 (w61-a8), two named clusters:
 *  (a) the misaligned +140 read: retail `lwl 143(s0)/lwr 140(s0)` off the SHARED base
 *      register, ours materialises `la $5,_cd_secbuf+140` first (ours +2 insns).  Root
 *      cause is cse knowing buf == &_cd_secbuf and folding the address.  An IDENTITY
 *      fence (`"=r"(buf) : "0"(buf)`) DOES defeat the fold and produces retail's
 *      lwl/lwr exactly -- but it is cse-opaque for the whole function and costs +8
 *      elsewhere (19).  FALSIFIED for a cheaper local launder: a block-local
 *      `pb = buf` + identity fence at the read only (15), a plain block-local copy
 *      (11, inert), `((RawWord *)buf)[35]` (11, inert), and the older list
 *      ((LBA*)(buf+140), decl reorder, -fforce-addr/-fforce-mem/-fno-schedule-insns).
 *      NEXT DIAL: a zero-insn way to make ONE address opaque to cse.
 *  (b) the loop bound: retail computes it into a guard-block temp (`addiu v1,s1,2048`)
 *      and COPIES it into the callee-saved loop register in the preheader
 *      (`addu s5,v1,zero`); ours computes straight into the callee-saved reg and is
 *      one insn SHORT -- the combine_regs/global-allocno copy device (w60-a1 law 6).
 *      FALSIFIED: `while (rec < buf + 0x800)` with no `end` variable (46),
 *      `end = rec + 0x800` (11, inert), assigning `end` on the `rec = buf` line (11).
 *      FALSIFIED W62-A7: the w48-a7 TWO-VARIABLE zero-trip-guard shape that supplies
 *      exactly this copy in FIRST.c (`lim` tested in the guard, `end = lim` inside it)
 *      does NOT transfer -- with a goto back-edge 64, with the `while` kept 15.  The
 *      multi-exit body (two `break`s) is why: the guard shape changes the whole block
 *      order here, where FIRST.c's single-exit walk keeps it. */
extern int CD_newmedia(void)
{
    u_char *buf;
    RawWord pt_lba;
    u_char *rec;
    u_char *end;
    int     idx;
    int     r;

    buf = (u_char *)_cd_secbuf;
    r = cd_read(1, 0x10, (char *)buf);   /* read PVD at LBA 0x10 */
    /* MATCH (w61-a8): READ-ONLY FENCE on `buf` -- the allocno DEMOTE dial.  32 -> 11
     * diffs.  Lengthening buf's live range past the first cd_read drops its priority
     * so it takes retail's $s0 and `r` takes $s1 (we had them swapped, which shifted
     * every s-register in the function).  PLACEMENT IS THE DIAL: the same fence on
     * the `buf = _cd_secbuf` line scores 15, because an asm at the top of the
     * function is a scheduling barrier and retail sets up the cd_read arguments
     * BEFORE the callee-saved stores.  Operand count is inert here (1/2/3 all 11). */
    __asm__("" : : "r"(buf));
    if (r != 1) {
        if (CD_debug > 0) printf("CD_newmedia: Read error in cd_read(PVD)\n");
        return 0;
    }
    if (strncmp((char *)buf + 1, "CD001", 5) != 0) {         /* standard identifier */
        if (CD_debug > 0) printf("CD_newmedia: Disc format error in cd_read(PVD)\n");
        return 0;
    }

    /* w51-a4/W56 OPEN (32 diffs): the oracle reads this off the SAME base register as every other
     * buf reference (`lwl 143(s0)/lwr 140(s0)`); gcc-2.7.2 const-folds `buf` back to the symbol
     * for the unaligned load and emits its own `la $5,_cd_secbuf+140` + `lwl 3($5)/lwr 0($5)`.
     * FALSIFIED: `(LBA*)(buf+140)`, `((LBA*)buf)[35]`, decl reorder, -fforce-addr, -fforce-mem,
     * -fno-schedule-insns (hand-probed on the .i with CC1PSX 2.7.2 -- none move the base). */
    pt_lba = *(RawWord *)(buf + 140);                        /* type-L path table LBA (misaligned;
                                                              * indexed off buf so the +140 folds into
                                                              * the lwl/lwr displacement, oracle
                                                              * `lwl 143(s0)/lwr 140(s0)`) */
    if (cd_read(1, *(int *)&pt_lba, (char *)buf) != r) {
        if (CD_debug > 0) printf("CD_newmedia: Read error (PT:%08x)\n", *(int *)&pt_lba);
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

/* @0x800F9984 : read `nsec` sectors starting at LBA `lba` into `buf`; returns 1 on success. */
extern int cd_read(int nsec, int lba, void *buf)
{
    CdlLOC loc;
    CdIntToPos(lba, &loc);
    CdControl(2, (u_char *)&loc, 0);            /* CdlSetloc */
    CdRead(nsec, (u_long *)buf, 0x80);
    return (unsigned)CdReadSync(0, 0) < 1u;
}
