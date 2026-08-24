# PsyQ 4.3 Documentation Reference

The complete local PsyQ 4.3 documentation corpus is at:

`C:\Temp\PSYQ\psyq-430-doc`

Use this corpus as the primary semantic authority for PsyQ-owned API names,
signatures, structures, macros, tool behavior, and intended source usage.  Use
the canonical kit at `C:\Temp\nfs4-clean\psyq43` for exact header spellings,
and its extracted objects plus the NFS4 retail oracle for byte/codegen truth.

## Primary manual routing

| Question | Manual |
|---|---|
| Public library API name, signature, argument meaning | `Devrefs\Libref.pdf` |
| Library organization and programming model | `Devrefs\Libovr.pdf` |
| GTE/DMPSX inline macro name, composition, or pipeline rule | `Devrefs\Inlinref.pdf` |
| PlayStation kernel and operating-system behavior | `Devrefs\os.pdf` |
| GPU/GTE/CD/SPU hardware behavior | `Devrefs\Hardware.pdf` |
| TMD, TIM, CPE, object, and other file formats | `Devrefs\Filefrmt.pdf` |
| 3D graphics converters and related tools | `Devrefs\3dgraph.pdf` |
| CD-ROM image generation | `Devrefs\Cdgen.pdf` |
| Data-conversion utilities | `Devrefs\Dataconv.pdf` |
| SDevTC compiler/debugger environment | `Devrefs\sdevtc.pdf` |
| PsyQ GCC optimization levels, ABI/register conventions, and short-data rules | `CONF\SCEE\96April\optimize.pdf` |

The corpus also contains conference material, technical notes, training
material, samples, tools, videos, and hardware-specific manuals.  Search the
whole root when the primary manuals do not settle a question.

## Confirmed reconstruction evidence

- `Libref.pdf`, PDF pages 283-284 (manual pages 7-37 and 7-38), defines
  `AddPrim`/`addPrim` and `AddPrims`/`addPrims`; the lowercase forms are macros.
  This corroborates reconstructing ordering-table links as PsyQ macro source
  rather than as hand-written 24-bit mask arithmetic.
- `Inlinref.pdf`, PDF pages 17-20 (manual pages 1-5 through 1-8), distinguishes
  basic lowercase `gte_*` operations from capitalized replaceable functions,
  documents the load/execute/store composition model, and defines the `_b`
  suffix as the no-leading-nop Type-2 form in `inline_c.h`.
- Canonical `COFF\INCLUDE\INLINE_C.H` settles exact basic macro spellings such
  as `gte_stsxy0`, `gte_stsxy1`, `gte_stsxy2`, `gte_stotz`, and `gte_stopz`.
- `Libref.pdf`, PDF page 375 (manual page 7-129), documents the public
  `VSyncCallback` boundary as a callback-function-pointer API.  The canonical
  archive index separately identifies the private `INTR_VB.obj` and
  `INTR_DMA.obj` members; their internal source names must therefore be
  recovered from matching member/source evidence rather than confused with
  the public `VSyncCallback` symbol.
- `Libref.pdf`, PDF pages 859, 895, 897, and 904 (manual pages 12-3, 12-39,
  12-41, and 12-48), documents `CheckCallback`, `ResetCallback`,
  `RestartCallback`, and `StopCallback`.  `libetc.h` in the canonical 4.3 kit
  uses legacy `int` declarations for several of these routines while the
  manual describes some as `void`; return types must therefore be reconciled
  with the matching member/source and retail call behavior, not copied from
  either document in isolation.
- Canonical `setjmp.h` defines `JB_SIZE` as 12 and `jmp_buf` as 12 integers.
  Together with the matched PsyQ `intr.c` layout, this proves the private
  callback environment as a 12-word `buf` followed by `stack[1024]`; the
  installed interrupt SP is `&stack[1004]`, the exact retail `+0x1018`
  address.
- `CONF\SCEE\96April\optimize.pdf`, PDF pages 14-17, confirms that `-O1`
  performs compiler-selected local register allocation, delay-slot filling,
  repeated-expression elimination, and unused-local elimination; `-O2` adds
  more aggressive register allocation and frame-pointer elimination, while
  `-O3` adds heuristic inlining and known-trip-count loop unrolling.  This is
  direct SDK-era evidence that a SYM-absent source temporary may disappear or
  reshape allocation, but it does not make an unmatched carrier an original
  source identity.
- The same optimization deck, PDF pages 20-25 and 38-42, records the PsyQ ABI
  register roles, first-four-arguments-in-`a0`-`a3` convention, saved-register
  treatment across calls, 16-bit base+offset addressing, `sdata`/`sbss`
  `gp`-relative model, and `-G<num>` size threshold.  It also states that under
  optimized builds GCC chooses register placement itself; the C `register`
  keyword only affects debug (`-g`) builds unless an explicit hard-register
  declaration is used.
- `Devrefs\sdevtc.pdf`, PDF pages 21-24, confirms the retail tool pipeline:
  `.C` uses the C front end, `.CPP` uses the C++ front end, both proceed through
  assembler and linker, and `-O0`/`-O1`/`-O2`/`-O3` select no, standard, full,
  and full-plus-inlining optimization respectively.  It explicitly redirects
  detailed compiler behavior to the separate GNU compiler documentation;
  therefore `C:\Temp\gcc-2.8.1-src` and measured cc1 traces remain the authority
  for allocator internals that these PsyQ manuals do not specify.

## Evidence workflow

1. Find the API or macro in the relevant manual and inspect the complete page.
2. Confirm exact spelling and expansion in the canonical 4.3 headers when
   available.
3. Confirm ownership/export names in the canonical extracted object index.
4. Apply only source-level corrections supported by that evidence.
5. Re-run `tools\verify_asm.py` or `tools\tugate.py`; the retail oracle remains
   authoritative for matching.
