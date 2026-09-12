# P903 incoming EACPSXZ source/ownership audit

Read-only review on 2026-09-12 by the P893 slice/auditing subagent. No production
edits, compilation, normal build-output writes, or publication were performed by
this audit. Mandatory guides, full ISA reference and full reconstruction
methodology were personally reloaded after context reset.

Compared revisions:

- Before: `b36aebd025c217956a40ed448d173111ff7f9e7c`.
- Incoming: `df4e6e0a58934686ea3b424bcde666af5a306f92`, comprising `2ee63940`,
  `3b616348`, and `df4e6e0a`.
- Exactly 159 changed files: 74 modified C TUs and 85 new headers, all within
  `recon/eaclib/psx/eacpsxz`. They are disjoint from the parent's game source work.

## Publication findings

The uncorrected incoming revision is **not an entirely byte-neutral header-only
change**. Two object differences and seven host-only regressions require explicit
disposition. Parent/peer builds are separate receipts, not work performed here.

### 1. Primate: real declaration-order/storage-address change

`primate.h` first declares `extern int drawpending`, ahead of all definitions in
`primate.c`. GCC emits the tentative/common cells by their first declaration:
`drawpending` moves from `.sbss+48` to `.sbss+0`, and twelve earlier cells move
forward four bytes. `linkmodeflag` and `semitrans` remain at +52 and +56.

All fifteen cells are **LOCAL** symbols in the generated object, and references
target the `.sbss` section with embedded addends. Therefore this is not an
external-symbol name change which a linker could automatically resolve back to
the same native address. The actual before/after objects have 22 changed
instruction words among 25 GP references, despite unchanged normalized gates.

`semantic_bindings.py` / `semantic_bindings.json` independently read both objects
and the raw executable. For every one of the 25 GP references they record exact
instruction index, VA, before/after addend and intended native cell. Twenty-three
references have a matching native MAP name; the `otbl2` and `primbuf2` stores have
raw-address evidence only, and these two source carrier names remain unproved.
Non-immediate instruction bits agree with all corresponding native instructions.

The native MAP/SYM/CPE-derived data inventory splits this owner's state:

| Native region | Native objects |
| --- | --- |
| `.sdata` 8013DD04..8013DD14 | otbuf, primbuf, linkmodeflag, drawpending, semitrans |
| `.sbss` 8013DE68..8013DE8C | oti, otp, otbl, gap at DE74, nextprim, maxot, primptr, primbase, gap at DE88, maxprim |

The read-only premerge strict map currently puts the local primate `.sbss` at
`8013ED70`, separate from the raw **GLOBAL** copies at their native addresses.
`vramfxya` imports external `drawpending`, binding that raw global, whereas
`waitdraw` reads the primate-local cell. This duplicate/local-versus-global
ownership mismatch is **pre-existing**, but the incoming order shift changes
actual addresses again. `PROVIDE` entries do not override local section-relative
references. Matching names to VAs for an isolated raw proof must not be described
as proof that the current full link has those bindings.

Small safe publication direction: preserve the new owner header while placing
its include after the existing owning definitions, then verify literal object
identity to the before receipt. A full source-owned split-region storage repair
is a separate larger task and must cover both primate and vramfxya. Neither repair
was made by this reviewer.

### 2. Callback: input alignment guarantee changed

The incoming C `short mutexbuf[32 * 2]` replaces a file-scope `.bss/.align 2/
.space 128` assembly reservation, with the old assembly retained only as a
comment. `allocmutex` changes from indexed `while` to indexed `for`, keeping the
same 32 slots, four-byte stride, short taken flag and returned slot address.
`freemutex` still clears the four-byte slot.

Both objects have identical `.text`, complete symbol entities and resolved
relocation entities, but `.bss` alignment changes from four to one byte. Its
extent remains 128 bytes. SYMTAB order also changes: the global `mutexbuf` entry
moves from before the two function entries to after them. The strict read-only
receipt preserves both exact orders; it does not silently discard this metadata.

Native `mutexbuf` is `801477E0`, with 128-byte extent up to `sndgs` at `80147860`.
The existing generated linker's `.bss : SUBALIGN(4)` overrides the new input
alignment for the current project link. This can make the current linked address
and bytes neutral, but the input object itself no longer carries its former
four-byte alignment guarantee. `freemutex`'s word store makes alignment a real
contract. Native placement is also already debt: the inspected premerge map puts
the source-owned buffer at `80140DCC`, not at the native address. Do not call this
fully native data placement solely because a function gate passes.

### 3. Host fallback regressions invisible to all MIPS gates

These deletions are in non-`__mips__` branches and do not affect the PSX object
comparison. They are nevertheless real source behavior or linkage regressions:

| File | Deleted prior behavior/definition |
| --- | --- |
| `blkfill.c` | `blockclear` lost `blockfill(dst, n, 0);` and became empty |
| `sinfunc.c` | `intcos` lost `return intsin(a + 0x100);` and became an empty non-void function |
| `sinfunc.c` | host aliases `fastintcos` and `fastintsin` removed |
| `fixddiv.c` | host alias `rdiv` removed |
| `fixdinv.c` | host alias `rinverse` removed |
| `fixdmult.c` | host alias `rmult` removed |

The five new alias declarations in the headers are not definitions and do not
restore the missing non-MIPS symbols. Restore the two existing fallback bodies
and all five existing alias definitions, then separately check the host branch.
No new assembly is necessary. These findings were sent to the parent before
publication; correction/validation is parent-owned.

## Exact consumer closure

`inventory.py` reads source bytes from both Git revisions, not the mutable
worktree, and computes the literal include graph using the actual C preprocessor
search roots: quoted local directory, `include/`, then `recon/`. It conservatively
unions conditional includes. `inventory.json` lists every changed file and the
full changed-header closure for each affected TU.

Result: exactly the 74 changed C TUs are affected. There are **no additional
external `recon` or `regiondiff/recon` include consumers** of these new headers.
This static closure is not a replacement for the actual `.i` path/hash census
recorded by the independent before/after compiler runner.

The new headers comprise 74 owner headers and eleven shared/group headers:
`eac_types`, `eac_externs`, and nine groups. The umbrella groups cover 74 owner
headers: math18, matrix7, memory5, file10, shape11, text4, system10, codec4,
utility5. The six data-only TUs are `asintbl`, `atantbl`, `fatantbl`, `isqrttbl`,
`sintbl`, and `vars`; these require complete storage/payload/symbol checks and
must not be counted as function PASSes.

No current external C++ TU includes these headers. The new plain-C prototypes
have no `extern "C"` wrapper and `eac_types.h` defines C-lane types such as RECT
and matrixtdef. Future use from the C++ shared-type graph needs a deliberate
linkage/type-visibility review; current compile neutrality does not prove those
headers can be included arbitrarily throughout the game.

## Ticks/libticks and other owner declarations

`vars.c` already defined both `int ticks = 0` and `int libticks = 0` before these
commits. The incoming revision changes these definitions to `volatile int` and
centralizes extern declarations in `vars.h`; it does **not** move their storage
from `timer.c` or `inittmr.c`. Existing inittmr/timer/systask declarations were
already volatile. Expected addresses are `8013DCAC` and `8013DCB0`; the independent
before/after full-object receipt reports vars, timer, inittmr and systask literal
identity, including initialized data and relocation metadata.

This does not create one project-wide type view: untouched game/frontend
consumers still contain plain-int, volatile-int, and unsized-array views of
`ticks`, including regional files and assembly-name aliases. No new header flows
to those consumers. Existing type-view inconsistencies remain a source-identity
backlog; global storage ownership and cross-TU declaration exactness are different
claims. The symbol-only stripped library records also do not establish the
historical `volatile` token merely from its necessity in the current compile.

Other storage definitions remain in their owning C files: tmrsub, gExitFuncs,
g_currentthread, currentdirectory/read command, text dispatch/state, allocator
state, and all six data-only tables. Moved types retain their old fields and
32-bit layout: RECT8, TransformResult12, matrixtdef/mtx36, MemBlock24, MemClass64,
ReadCmd20, LoadArgs16, StreamFilter12, and SyncCtrl36. Existing `recon/lib/nfile.h`
and `recon/lib/nasync.h` still supply FileOp/FileHandle/AsyncReq/AsyncQueue through
the new owner headers. This is a layout-preserving transcription review, not a
new claim that every descriptive field name was recovered from SYM.

## Nontrivial body and ABI adjustments

The conservative token census finds sixteen function body changes, including
the two host bodies above. Fourteen are active in the PSX C route:

- `allocmutex`: indexed for/while source and typed reservation change, discussed
  above.
- `crossproduct`: splits products into `tmp0`, `tmp1`, `tmp2`, replacing the old
  block-local `t` plus two inline products. Code is byte-neutral in the separate
  object receipt, but these three new local spellings have no source-name
  authority supplied by these commits. They must not be counted as recovered
  original locals. No full local/SLD proof was run for this stripped member.
- `reorthogonalize`: replaces the local `multiplymatrix` macro alias with its
  existing expansion `transmult`; keeps whole-struct copies and moved mtx type.
- `checkrect`/`vramimage`: integer address becomes RECT pointer and w/h members;
  w's bit0 test is unchanged for all 16-bit patterns, h retains unsigned-short
  read/write. Offsets stay +4/+6. The ordinary object is literal-identical.
- `tmrint`: removes an int cast from the saved-GP word passed to the canonical
  restoregp declaration.
- `inittimer`: changes `return addexit((int)restoretimer);` to a call of canonical
  `void addexit(void (*)(void))`, followed by falling off the still-int function.
  This preserves the original compiler's incidental v0, not a portable explicit
  return contract. The separate whole-object identity proves current target code
  and callback relocation neutrality; no new `return 0` should be invented.
- `CD_Read`, `CD_timerfunc`, `CdReadyHandler`: local function-pointer casts retain
  prior addtimer/deltimer callsite register setup while including their canonical
  one-callback owner declarations. CD_Read's dead second addtimer argument is
  retained only at that call. Do not infer canonical callback arity from stale
  caller registers.
- `FILE_initwithmem`: callback cast changes from `void (*)(void)` to
  `void (*)(int)` with canonical CD_Init's callback declaration. Same pointer,
  argument transfer and target relocation in the full object.
- `startnextrequest`/`restartstream`: three FILE_callbackop sites locally preserve
  the old unsigned return view and callback cast; the central owner declaration
  is now void with a three-argument callback. Incidental return use is preserved,
  not newly defined as canonical API semantics.
- `STREAM_destroy`: yieldthread owner now says void(void), with an isolated
  void(int) call cast preserving the real dead zero argument at this one site.

The inventory's one apparent `queueadd` signature change is a known census
false-positive: a multiline CP0 macro was adjacent after header movement and
entered the lightweight tokenizer's signature prefix. Actual queueadd signatures
are identical; its emitted object and CP0 sequence are unchanged. An inactive
`#if 0` transmult alternative was removed; no emitted function disappeared there.

## Required final checks / claim boundary

The independent integration runner's frozen `comparison.json` records 72 literal
identical objects, with callback and primate as the two exceptions. Its broader
full object/manifest proof also reports 248 available function gates and 1139
branches unchanged. Existing fxform/scaffold missing-oracle inventory remains
explicit and must not be counted green.

Before publication:

1. Re-gate actual corrected primate and all actual changed C inputs with original
   flags; demand the expected full object comparison, not normalized PASS alone.
2. Preserve callback's exact alignment/symbol-order qualification and verify its
   final linked four-byte alignment and neutral neighboring section placement.
3. Restore/check the seven non-MIPS fallback behaviors/definitions separately;
   PSX gates cannot test them.
4. Re-link using unmodified production tools and compare against the frozen
   premerge image/map, including data/GP symbol bindings, all relocation addends,
   code and referenced string/table bytes. Do not substitute source-name-to-VA
   normalization for actual linker-binding proof.
5. Carry forward the pre-existing primate duplicate-state/native-placement debt,
   callback native-placement debt, ticks type-view inconsistencies, unproved
   crossproduct local names, and missing fxform scaffold evidence honestly.

This audit found real integration issues; it does not establish full source or
SYM exactness for the incoming library. Source organization improvements can be
accepted independently of those stronger claims once regressions are addressed.
