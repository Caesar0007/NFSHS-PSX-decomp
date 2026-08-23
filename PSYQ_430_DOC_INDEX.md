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

## Evidence workflow

1. Find the API or macro in the relevant manual and inspect the complete page.
2. Confirm exact spelling and expansion in the canonical 4.3 headers when
   available.
3. Confirm ownership/export names in the canonical extracted object index.
4. Apply only source-level corrections supported by that evidence.
5. Re-run `tools\verify_asm.py` or `tools\tugate.py`; the retail oracle remains
   authoritative for matching.
