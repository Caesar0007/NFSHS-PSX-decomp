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
/* ======================== W65-A6 DATA-MAT: iso9660.obj's BSS run @0x8014487C ==============
 * BEFORE: three C tentative definitions.  This TU compiles on the cc1_272 lane (macro cc1 +
 * direct GNU as, NO maspsx), so each stayed a real `.comm` = a COMMON symbol -- and ld places
 * COMMONs, not the object, so none of them could reach the retail VA in its own breadcrumb
 * (W62-A18 T6 / W64-A19 sec.3.4).  These three are 3 of the 37 tree-wide COMMONs.
 * AFTER: one file-scope asm `.section .bss` block owns the run at exact retail offsets.
 * The run is EXACTLY accounted and independently confirmed: 0x8014487C is StFunc2+4 (libcd
 * stream.c's run A) and 1536 + 5632 + 2048 = 9216 lands precisely on StEmu_Addr @0x80146C7C
 * (stream.c's run B) -- i.e. these buffers are the whole gap between the two St* runs, which is
 * also why the SYM has no record for them (PSYLINK gave COMMONs no symbol entries).
 *      _cd_dir     @0x8014487C 1536 = sizeof(CdlFILE)*64
 *      _cd_pathtbl @0x80144E7C 5632 = sizeof(CdPathEnt)*128
 *      _cd_secbuf  @0x8014647C 2048 = one CD sector buffer
 * ORDER: declaration order is preserved from the previous tentative-definition list; the run's
 * total is pinned by both endpoints, the internal order is the one already recorded here.
 * The C view is demoted to `extern` so cc1's addressing is unchanged -- byte-neutral by
 * construction (TU re-gates 4/6, both residuals pre-existing).
 * Receipts: scratchpad/w65a6/RECEIPTS.md */
__asm__("\t.globl\t_cd_dir\n\t.globl\t_cd_pathtbl\n\t.globl\t_cd_secbuf\n"
        "\t.section\t.bss\n\t.align\t2\n"
        "_cd_dir:\n\t.space\t1536\n"
        "_cd_pathtbl:\n\t.space\t5632\n"
        "_cd_secbuf:\n\t.space\t2048\n\t.text");
extern CdlFILE   _cd_dir[64];          /* @0x8014487C */
extern CdPathEnt _cd_pathtbl[128];     /* @0x80144E7C */
extern char      _cd_secbuf[0x800];    /* @0x8014647C */
/* _cd_search_nopen / _cd_cached_dir live in regular .bss (absolute addressing in the oracle,
 * NOT %gp_rel under -G4) -- declared extern so cc1plus emits `lui/%hi` not a gp-relative load.
 * Their definitions are part of the linked image's .bss (see asm/data D_80136C6C / D_80136C68). */
/* W65-A6: these two were reloc-referenced UNDEFINED symbols (4 + 6 sites) -- but NOT missing
 * data.  Both VAs are inside the initialised image (< t_addr+t_size 0x8013E000) and the splat
 * blob already defines them, as `D_80136C6C` / `D_80136C68`
 * (asm/data/data_8010CCD4_r17.data.s, both `.word 0x00000000`).  `_cd_search_nopen` /
 * `_cd_cached_dir` are PsyQ-sourced names for the same storage, so the fix is the project's
 * established asm-label alias device (W64-A19 sec.2.1) rather than a second definition: the
 * readable name is kept in the C, only the emitted relocation NAME changes, so it is
 * byte-neutral by construction AND creates no blob-vs-TU duplicate (W62-A18 class M1). */
extern int _cd_search_nopen __asm__("D_80136C6C"); /* @0x80136C6C : CD_nopen the path table was built for */
extern int _cd_cached_dir   __asm__("D_80136C68"); /* @0x80136C68 : index of the dir currently in _cd_dir */

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
    int            sep2;                                    /* inner-loop copy of `sep` (W71-A9) */
    signed char   *s;                                       /* cursor into `name` */
    signed char   *q;                                       /* cursor into `comp` */
    unsigned char  ch;

    if (_cd_search_nopen != CD_nopen) {                     /* media changed -> remount */
        if (CD_newmedia() == 0)
            return 0;
        _cd_search_nopen = CD_nopen;
    }
    if (*name != '\\')                                     /* paths must be absolute */
        return 0;
    /* 🏆 W72-A16 (7 -> PASS 182/182).  The two "TEXT_MOVES class" emission-order items
     * named in the W71-A9 residual are BOTH source-reachable; they need two DIFFERENT
     * devices and the `i = 0` one had to be RE-PRICED (21E-1) before the other appeared.
     *  (1) THE `beq` DELAY SLOT = A THREAD CHOICE, and the target thread's head insn
     *      decides it.  Retail fills the `beq $v1,$v0` slot from the FALL-THROUGH thread
     *      (`addu $v0,$zero,$zero`, the `return 0` value) and leaves the following `j`'s
     *      slot `nop`; ours filled it from the TARGET thread with `li $a0,1` (`dir = 1`).
     *      Reason: retail's ok-block STARTS with the `sb $zero,16($sp)` store (`comp[0] = 0`)
     *      and reorg will not steal a MEM store out of a thread it does not own, so it
     *      falls back to the fall-through; ours started with a plain `li`, which it takes.
     *      CURE = two halves, BOTH required: write `comp[0] = 0;` BEFORE `dir = 1;` so the
     *      store is the block's first statement, AND put a zero-insn VOID BARRIER at the
     *      head of the block so sched1 cannot hoist the `li` back above the store
     *      (reorg.c stop_search_p also stops the thread scan at the asm).  MEASURED, all
     *      gated + reverted: barrier alone (dir still first) 5 - `comp` before `dir`
     *      without the barrier 5 - barrier + dir + comp (old order) 2 (the store/li pair
     *      inverted) - barrier before the `*name` test 7 - `dir = 1` written after
     *      `s = name`, in the for-init, or last in the preheader all 5-7 (sched hoists it
     *      to the block head wherever it is written, so POSITION alone never sufficed --
     *      which is why the W71-A9 note recorded this half as inert).
     *  (2) `i = 0` HOISTED AHEAD OF `sep`/`notfound` (7 -> 5 on its own).  W71-A9 measured
     *      every `i = 0` hoist at 23 and filed it closed; that was the PRE-peel basin.
     *      Re-priced here it is a clean -2 (21E-1: re-price a documented-exhausted cluster
     *      after ANY sibling cluster in the same fn changes basin).  The `for (; i < 8; i++)`
     *      spelling is load-bearing -- moving the init into a separate statement above
     *      `sep` measures the same 5, but leaving it in the `for` header is 7. */
    __asm__("" : : "i"(0));
    comp[0] = 0;
    dir = 1;                                                /* root */
    s = (signed char *)name;
    /* split on '\\'; descend through each directory component, leaving the filename in `comp`.
     * (the binary threads the parent dir id through $a0 across _cd_find_path calls; fp needs NO
     * liveness no-op -- it is live to the `*fp = _cd_dir[i]` copy-out, and the `fp++;fp--;`
     * pair that used to sit here only inflated its ref count, see the W62-A7 note above.) */
    i = 0; sep = '\\'; notfound = -1; for (; i < 8; i++) {
        /* MATCH (w63-a6, reqdelta272-priced, ZERO instructions): retail hands out
         * name=$s3 / notfound=$s4 / sep=$s5; ours priced (after the printf-arg fix)
         * sep .2000 > name .1754 > notfound .0517 = $s3/$s4/$s5 -- exactly inverted.
         * An in-loop read-only fence operand is +2 loop-weighted refs, so ONE `name`
         * operand (5->7 refs) and TWO `notfound` operands (3->7) lift both over sep
         * and restore retail's order.  Minimal operand set: x1/x1 = 23, x1/x2 = 19,
         * and every larger combo measured 19 as well (x2/x4 = 37, an over-dial that
         * re-inverts name/notfound).  See scratchpad/w63a6/probe_iso7.py. */
        /* W64-A5: the 09I DISTINCT-EXTENSION device (which is what the named angle asked
         * for) is FALSIFIED here, per-use as well as cached.  Retail loads `*s` TWICE with
         * `lb` (an entry peel plus the back-edge test) and keeps a separate unsigned copy in
         * $v1 for the zero test and the store; ours sign-extends one cached byte
         * (`sll 24; sra 24`).  Measured (all count 181/182 unless noted): zero test through
         * `!*(u_char *)s` 19 (INERT) · that plus an explicit `*(signed char *)s` sep compare
         * 19 · the sep compare itself through `*(u_char *)s` 42 @180 · the u_char zero test
         * plus a signed re-read at the advance 19 · storing `*(signed char *)s` and advancing
         * separately 55 @177.  The two reads are the SAME MEM in the SAME block, so cse
         * merges them whatever mode each use asks for.
         * ALSO FALSIFIED: the CD_newmedia cure transplanted -- an IDENTITY LAUNDER on the
         * cursor `s` at the loop head (which is exactly what defeated the const-fold there)
         * costs 3 insns and 58 diffs, with or without the u_char zero test.  Laundering
         * splits a pointer from a SYMBOL, not one MEM from another. */
        /* W71-A9: the W63-A6 priced ref dial that used to sit here
         * (`__asm__("" : : "r"(name), "r"(notfound), "r"(notfound));`, 37 -> 19, bought
         * retail's name=$s3 / notfound=$s4 / sep=$s5 handout) is RETIRED -- in the
         * post-peel basin it is INERT (7 with and without, diff lists identical, all
         * three registers still retail-exact), so the loop's real shape was carrying the
         * allocation all along.  Re-measured with 1, 2, 3 and 5 operands: 1/2/5 all 7,
         * three `notfound` operands over-dials to 25.  Removed per floor hygiene. */
        /* MATCH (W71-A9, 19 -> 7): the "RESIDUAL 19 = the inner split loop ALONE" named
         * angle above is SOLVED.  Retail's loop is
         *      lb v0,0(s0) / lbu v1,0(s0) / beq v0,s5 (PEELED entry test)
         *      li a1,0x5C                            (caller-saved copy of the separator)
         *  L:  beqz v1 / addiu s0,s0,1 / sb v1,0(s1) / lb v0,0(s0) / lbu v1,0(s0)
         *      bne v0,a1,L / addiu s1,s1,1
         * i.e. TWO loads of the same byte per iteration (signed for the `!= sep` test,
         * unsigned for the zero test AND the store), no sign-extend, and an entry peel.
         * FOUR cooperating pieces -- every earlier wave had at most one, which is why the
         * whole family read as "cc1-2.7.2 FUSES the lb+lbu pair whatever you spell":
         *  (1) THE VALUE READ MUST BE VOLATILE (`*(volatile unsigned char *)s`).  cse does
         *      not merge two reads of one QImode MEM by mode; what it does is keep the
         *      first loaded REGISTER and rewrite the second read as a sign-extend of it
         *      (our `sll 24; sra 24`).  A volatile MEM is never recorded in cse's table,
         *      so both loads survive -- the plain `*(unsigned char *)s` spelling of the
         *      same shape is 43.  (This is the 05E volatile-on-the-read lever; the reads
         *      really are of a caller-supplied buffer, so it is honest.)
         *  (2) THE PEEL MUST BE WRITTEN OUT (`if (*s != sep) { do { ... } while (...); }`).
         *      jump.c's duplicate_loop_exit_test copies the exit test ahead of the loop,
         *      but post-reload cross_jump then merges the copy back because both tests are
         *      rtx-identical -- so no `while` spelling can keep a peel.
         *  (3) ...UNLESS THE TWO TESTS USE DIFFERENT REGISTERS.  Retail's `li a1,0x5C` IS
         *      that: a second, caller-saved copy of the separator that keeps the peeled
         *      `beq v0,s5` and the loop's `bne v0,a1` un-mergeable.  Spelled as its own
         *      literal `sep2` + a zero-insn read-only fence (the 15B fenced-named-constant
         *      lever; without the fence cse folds sep2 back onto sep and the peel is lost
         *      again -- measured 25).
         *  (4) `++s` BEFORE the store (retail: `addiu s0,s0,1; sb v1,0(s1)`), and `q++` as
         *      its own trailing statement so it lands in the back-branch's delay slot.
         * Ladder (each measured on the previous winner): 19 -> 37 (volatile value read
         * alone, loop body byte-exact but no peel) -> 11 (+ explicit peel + fenced sep2)
         * -> 9 (+ `++s` first) -> 7 (+ sep2 from a fresh literal instead of a copy of
         * `sep`, which is what makes it `li a1,92` and not `addu a1,s5,zero`).
         * `unsigned char ch` and the old `signed char ch` both gate 7; the unsigned
         * declaration is kept because that is what the `lbu` + zero-test + byte store are.
         * RESIDUAL 7 = two emission-order items only: retail materialises `dir = 1`
         * (`li a0,1`) in the block AFTER the `*name != '\\'` test where ours eager-steals
         * it into that test's delay slot, and it emits `i = 0` before `sep`/`notfound`
         * where ours emits it after.  Both are TEXT_MOVES class: moving `dir = 1` below
         * `comp[0] = 0` or below `s = name` is inert (7), and every `i = 0` hoist
         * (before `sep`, before the `for`, as its own statement) measures 23. */
        ch = *(volatile unsigned char *)s;
        q = (signed char *)comp;
        if (*s != sep) {
            sep2 = '\\';                                    /* retail's `li a1,0x5C` */
            __asm__("" : : "r"(sep2));                      /* keep it a distinct pseudo */
            do {
                if (!ch)
                    goto out;                               /* reached the filename */
                ++s;
                *q = ch;
                ch = *(volatile unsigned char *)s;
                q++;
            } while (*s != sep2);
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
/* W72-A16 re-gate: 2 @177/177.  Cluster (b) is ALL that is left and it is now PROVEN
 * TEXT_MOVES-class rather than merely suspected -- retail emits the loop-bound copy
 * `addu $s5,$v1,$zero` AFTER loop.c's two hoisted address constants
 * (`la $s4,_cd_pathtbl+8` / `addiu $s6,$s4,4`), ours before them.  21B-3 says why it is
 * not source-reachable: a guard-block assignment is an ENTRY-block insn, while loop.c
 * emits its movables immediately before loop_start, and C has no preheader to write in.
 * THE ONE-ROW SPEC IS DERIVED AND PROVEN (not proposed): scratchpad/W72_A16/
 * tm_cd_newmedia.json --
 *     take  \taddu\t\$21,\$3,\$0\n
 *     after \taddu\t\$22,\$20,4\n
 * both anchors unique in the TU .s, no `slot`, no `drop_nop`.  The lane's own .s was
 * edited by exactly that pair, assembled with the lane's `mipsel-none-elf-as -EL
 * -march=r3000 -mtune=r3000 -G0`, and gated: CD_newmedia PASS 177/177 with the WHOLE TU
 * 6/6 PASS (artefacts scratchpad/W72_A16/iso_tm.s / .o).  Needs only the orchestrator
 * PER_FN_TEXT_MOVES entry.
 * FALSIFIED at this basin (all gated + reverted, on top of the CdSearchFile seal so the
 * whole cluster was RE-PRICED per 21E-1): loop test on `buf + 0x800` 33 - on `lim` 15 -
 * `end` computed from `buf + 0x800` inside the guard 2 (inert) - `end = lim` repeated in
 * the body 2 (inert) - a void barrier before or after `end = lim` 2/2 (inert) -
 * `idx`/`rec` moved inside the guard 36 - a `CdPathEnt *tbl` local + `tbl[idx]` body to
 * force the address constants earlier 25 - an `LBA *lbap` addr-of local 21 - a dummy
 * `__asm__("" : : "r"(_cd_pathtbl[0].lba))` before `end = lim` 8 - a read-only fence on
 * `end` after the loop 12 - do-while with `end = lim` LAST in the body (the 21B-3
 * "born in the loop" shape, so LICM would hoist it after the address constants) 22 -
 * the same as a `while` 15 - do-while with it first 34 - `end` assigned before the
 * guard 22. */
extern int CD_newmedia(void)
{
    u_char *buf;
    RawWord pt_lba;
    u_char *rec;
    u_char *end;
    u_char *lim;
    int     idx;
    int     r;

    /* MATCH (W71-A9, 6 -> 2): the FIRST cd_read takes the SYMBOL, and `buf` is bound
     * AFTER the call.  Retail issues the two integer args (`li $a0,1; li $a1,16`) at the
     * very head of the function, BEFORE the first callee-saved store and before the
     * `la _cd_secbuf`; with `buf = &_cd_secbuf;` written first, that `la` is a lower-luid
     * RTL insn and sched2 issues it ahead of the arg constants (ours had them 3 slots
     * late).  Binding `buf` after the call puts the address materialization where retail
     * has it and costs nothing: `buf == &_cd_secbuf` either way, and the identity launder
     * below still owns the pseudo (the allocno demote that gives buf $s0 / r $s1 is
     * unchanged -- whole-TU re-gate 4/6 -> 5/6, zero PASS->FAIL). */
    r = cd_read(1, 0x10, (char *)_cd_secbuf);   /* read PVD at LBA 0x10 */
    buf = (u_char *)_cd_secbuf;
    /* MATCH (w61-a8): READ-ONLY FENCE on `buf` -- the allocno DEMOTE dial.  32 -> 11
     * diffs.  Lengthening buf's live range past the first cd_read drops its priority
     * so it takes retail's $s0 and `r` takes $s1 (we had them swapped, which shifted
     * every s-register in the function).  PLACEMENT IS THE DIAL: the same fence on
     * the `buf = _cd_secbuf` line scores 15, because an asm at the top of the
     * function is a scheduling barrier and retail sets up the cd_read arguments
     * BEFORE the callee-saved stores.  Operand count is inert here (1/2/3 all 11). */
    __asm__("" : "=r"(buf) : "0"(buf));
    if (r != 1) {
        if (CD_debug > 0) printf("CD_newmedia: Read error in cd_read(PVD)\n");
        return 0;
    }
    if (strncmp((char *)buf + 1, "CD001", 5) != 0) {         /* standard identifier */
        if (CD_debug > 0) printf("CD_newmedia: Disc format error in cd_read(PVD)\n");
        return 0;
    }

    /* W64-A5 -- SOLVED (11 -> 6, count-EXACT 177/177) BY THE IDENTITY LAUNDER, and the
     * w51-a4/W56/W63-A6 verdict below ("the base-fold is not reachable") is RETIRED.
     * SYMPTOM was: the oracle reads the misaligned path-table LBA off the SAME base
     * register as every other buf reference (`lwl 143(s0)/lwr 140(s0)`), while gcc-2.7.2
     * CONST-FOLDS `buf` back to the symbol for the unaligned load and emits its own
     * `la $5,_cd_secbuf+140` + `lwl 3($5)/lwr 0($5)` (+2 insns).  Every previous angle
     * attacked the ACCESS (casts, a real PVD struct + COMPONENT_REF from the psyz/sotn
     * matched twins, -fforce-addr/-fforce-mem, decl order, a whole-function void-barrier
     * position sweep).  All of those leave `buf` PROVABLY EQUAL to &_cd_secbuf, so cse
     * substitutes the symbol no matter how the load is spelled.  The cure is to attack the
     * POINTER instead: 13B's IDENTITY LAUNDER `__asm__("" : "=r"(buf) : "0"(buf))` makes
     * the pseudo die twice, so cse can no longer prove the equality and the load must go
     * through the register -- the two `la` insns vanish (178 -> 176).  It REPLACES the
     * w61-a8 read-only fence on the same line and keeps that fence's allocno-demote effect
     * (buf still takes retail's $s0 and `r` $s1).
     * The launder alone left us 1 SHORT (176/177) with a clean 19-diff residual, which
     * exposed the second, independent item below.  ⇒ ALWAYS GATE THE UNLAUNDERED CONTROL
     * (13B): the read-only fence had been masking a reachable fold for three waves. */

    pt_lba = *(RawWord *)(buf + 140);                        /* type-L path table LBA (misaligned;
                                                              * indexed off buf so the +140 folds into
                                                              * the lwl/lwr displacement, oracle
                                                              * `lwl 143(s0)/lwr 140(s0)`) */
    if (cd_read(1, *(int *)&pt_lba, (char *)buf) != r) {
        if (CD_debug > 0) printf("CD_newmedia: Read error (PT:%08x)\n", *(int *)&pt_lba);
        return 0;
    }
    if (CD_debug > 1) printf("CD_newmedia: sarching dir..\n");

    /* MATCH (W64-A5): the W48-A7 TWO-VARIABLE ZERO-TRIP-GUARD -- compute the limit into a
     * caller-saved temp, TEST that temp in the guard, and copy it into the callee-saved loop
     * bound INSIDE the guard.  The copy survives (make_regs_eqv: the destination outlives its
     * source) and IS the oracle's `addiu v1,s1,2048; sltu v0,s1,v1; ... addu s5,v1,zero`;
     * computing straight into `end` coalesces it away.  W62-A7 had FALSIFIED this shape here
     * (goto back-edge 64, while-kept 15) and blamed the two `break`s -- 04Z: that was measured
     * in the pre-launder basin.  In the laundered basin the WHILE-KEPT form is the winner
     * (19 -> 6, count EXACT), the do-while form is 18 @181 and the goto form does not compile
     * (label before the block's declarations); without the launder it is 24 @183.
     * RESIDUAL 6 = pure CODE MOTION of instructions we already emit: retail issues the
     * `li a0,1; li a1,16` cd_read arg pair BEFORE the first callee-saved store (ours after the
     * `la _cd_secbuf`), and places the `addu s5,v1,zero` copy 3 slots later.  Both are prologue/
     * block emission-order ties (11B arg-emission), i.e. TEXT_MOVES class, not allocation. */
    idx = 0;
    rec = buf;
    lim = buf + 0x800;
    if (rec < lim) {
        end = lim;
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
