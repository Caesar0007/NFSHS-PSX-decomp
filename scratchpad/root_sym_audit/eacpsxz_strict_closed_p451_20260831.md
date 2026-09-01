# SYM-to-source declaration audit

Target: `C:\Temp\nfs4-sym-next-20260825\recon\eaclib\psx\eacpsxz`
Trusted SYM: `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`

This is a review queue, not an auto-fix list. Missing retail names are
strong evidence; extra source names can be matching carriers or decompiler
temporaries and must be tested against the function oracle before removal.
GCC-v2-mangled function/EXT names are used only as linkage keys; source
functions are mapped to their demangled C++ names and class scopes.

## Summary

- SYM functions in target TUs: 0
- Mapped to reconstructed definitions: 0 (0 demangled class/name maps)
- Source definitions still using mangled linkage identifiers: 0
- Explicit deleting-destructor ABI carriers: 0
- Explicit cross-TU ownership closures: 0
- Declaration-clean mapped functions: 0
- Missing SYM names: 0
- Extra source-local names: 0
- Type-comparison findings: 0
- Recognized ABI/debug-equivalent type encodings: 0
  ()
- Function storage-class findings: 0
- Implicit aggregate special members (source body correctly absent): 0
- Explicit oracle-receipted carrier mappings: 0
- Explicit restored inline-local mappings: 0
- Explicit restored macro-local mappings: 0
- Explicit linkage-proven ABI parameters omitted from SYM: 0
- Explicit source-only codegen carriers: 0
- Explicit oracle-proven function type overrides: 0
- Functions needing mapping review: 0
- SYM object-owned data records in target TUs: 0
- Compact address-only data records mapped by exact name+VA: 89
- Mapped source global definitions: 89
- Special SYM vtable records mapped: 0/0
- Blob-backed object globals: 0
- Missing/extra global definitions: 0/0
- Global storage-class findings: 0
- Explicit oracle-proven global storage overrides: 0
- Global type findings: 0
- Recognized global debug-equivalent types: 0
  (none)
- Explicit measured global array carriers: 0
- Explicit source-only global/data-layout carriers: 14
- Explicit host-only fallback globals: 2
- Explicit linker-folded shared common globals: 4
- Explicit oracle-proven global type overrides: 0

## Review queue

## Implicit aggregate special members

## Explicit SYM carrier/optimization mappings


## Explicit restored inline-local mappings


## Explicit restored macro-local mappings


## Explicit linkage-proven ABI parameters omitted from SYM


## Explicit source-only codegen carriers


## Explicit oracle-proven function type overrides


## Object-owned global/storage review

- `addtimer.c` compact address-only definitions: `tmrsub`
- `asintbl.c` compact address-only definitions: `asintbl`
- `atantbl.c` compact address-only definitions: `atantbl`
- `cdfs.c` compact address-only definitions: `Cdinfo`
- `fatantbl.c` compact address-only definitions: `fatantbl`
- `fileroot.c` compact address-only definitions: `currentdirectory`, `readcmd`
- `inittmr.c` compact address-only definitions: `reentryflag`, `timerevent`, `timerflag`
- `isqrttbl.c` compact address-only definitions: `isqrttbl`
- `joystkn.c` compact address-only definitions: `joy_inited`
- `loadshp.c` compact address-only definitions: `shapeext`
- `locatbig.c` compact address-only definitions: `biglen`
- `memstd.c` compact address-only definitions: `memclass`
- `nasync.c` compact address-only definitions: `asyncfilehandle`, `asyncfileoffset`, `callqueue`, `freequeue`, `mutex`, `numrequests`, `readblocksize`, `request`, `requestidcounter`
- `nfile.c` compact address-only definitions: `gFileDevice`
- `primate.c` compact address-only definitions: `drawpending`, `linkmodeflag`, `maxot`, `maxprim`, `nextprim`, `otbl`, `otbuf`, `oti`, `otp`, `primbase`, `primbuf`, `primptr`, `semitrans`
- `random.c` compact address-only definitions: `seed`
- `sintbl.c` compact address-only definitions: `sintbl`
- `stream.c` compact address-only definitions: `requestidcounter`
- `threads.c` compact address-only definitions: `g_currentthread`
- `timer.c` compact address-only definitions: `tickset`, `tickval`
- `unbtree.c` compact address-only definitions: `SQVclue`, `SQVd`, `SQVleft`, `SQVright`, `SQVs`
- `vars.c` compact address-only definitions: `abortflag`, `aspectratio`, `centerx`, `centery`, `cenxpix`, `cenypix`, `debugexit`, `grmode`, `kanjiwidth`, `libticks`, `loadfilesize`, `mb_default`, `mbuttons`, `mouseflag`, `mouseratio`, `mouseshown`, `mx`, `my`, `numjoy`, `originx`, `originy`, `pageflipflag`, `screenbpp`, `screenheight`, `screenvisibleh`, `screenvisiblew`, `screenvisiblex`, `screenvisibley`, `screenwidth`, `sendtoprintmem`, `ticks`, `timerhz`, `vblflag`, `vblticks`, `xbangle`, `xscale`, `ybangle`, `yscale`, `zclipflag`, `zclipvalue`
- `exit.c` explicit source-only global/data-layout carriers: `gExitFuncs`
- `fileroot.c` explicit source-only global/data-layout carriers: `D_8013DD2C`, `D_8013DD34`, `D_8013DD38`, `D_8013DD40`
- `matrix.c` explicit source-only global/data-layout carriers: `coef`
- `memstd.c` explicit source-only global/data-layout carriers: `MAGIC_FREE`, `MAGIC_HEAD`, `MAGIC_USED`
- `nfile.c` explicit source-only global/data-layout carriers: `gFileOpSeq`
- `primate.c` explicit source-only global/data-layout carriers: `otbl2`, `primbuf2`
- `systask.c` explicit source-only global/data-layout carriers: `lastsystemtasktick`, `systemtasklock`
- `fixdsqrt.c` host-only fallback globals (absent from retail object): `kSqrtOffset`, `kSqrtScale`
- `unref.c` linker-folded shared common definitions: `SQVclue`, `SQVd`, `SQVleft`, `SQVright`
- No ownership, storage-class, or type findings.
