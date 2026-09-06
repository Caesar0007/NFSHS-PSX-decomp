# P882 exhaustive baseline GP-relocation audit

This audits the **P881 generated diagnostic link before the section-qualified
bookkeeping repair**, not the later regenerated output. Production source,
objects, headers, tools and link scripts were not modified by this subtask.
Only isolated diagnostic scripts/JSON and copies of the baseline ELF/map/error
log were written here.

## Exhaustive counts — replace the misleading "ten truncations"

| Measure | Count |
|---|---:|
| Live reconstructed C/C++ sources and present objects | 518/518 |
| Objects containing GP relocations | 78 |
| **R_MIPS_GPREL16 relocation sites** | **2,381** |
| GP relocations resolved against actual link | 2,381 |
| **True signed-16 displacement overflows** | **324** |
| Objects with overflows | 7 |
| **Linked target addresses different from retail** | **1,696** |
| Wrong retail addresses still within signed-16 GP range | **1,372** |
| Correct retail target addresses | 685 |
| Unknown expected addresses after independent follow-up | 0 |

All GP relocations are type7; there are **no** R_MIPS_LITERAL/GPREL32 or PIC
GOT-family relocations in this current live input set. Every GP input object's
reginfo GP0 is zero. Each actual target was resolved using the final ELF's
selected global symbol or the actual map's object/section placement for a
local/section symbol. All2,381 final encoded immediates were examined; there
are **zero in-range calculation-versus-encoding discrepancies**.

The generated linker chose `_gp=8013c54c`. This value is independently
confirmed by **1,867 raw GP-load/store sites** with native MAP symbol addresses;
all derive the same GP. Do not change GP to conceal the placement failures.

The old diagnostic emits ten explicit R_MIPS_GPREL16 lines and then
`additional relocation overflows omitted from the output`. Ten is a logging
limit, not a relocation or failure census. `--noinhibit-exec` also permits an
ELF/rc0 despite such errors, so an output file does not establish link success.

### Complete overflow distribution

| Owning input TU | Overflow sites |
|---|---:|
| game/common/copspeak.cpp | 124 |
| game/common/r3dcar.cpp | 97 |
| game/common/track.cpp | 82 |
| game/common/sim.cpp | 10 |
| game/common/textsys.cpp | 8 |
| game/common/hudpmx.cpp | 2 |
| game/common/nfs3.cpp | 1 |
| **Total** | **324** |

All324 resolve into misplaced `.sdata`:322 named/global references and2 local
section references. This is not a change to compiler register allocation.

## First concrete cause and minimal generator repair

The baseline `tools/gen_ld.py` records `in_frag` by **object pathname**, then
tests both `.data` and `.sdata` against that one set. A TU whose `.data` is
explicitly selected is incorrectly considered to have its `.sdata` selected
too. Ten real `.sdata` sections consequently miss `extra_sdata` and fall into
the final `.data_rest` after `.bss`:

* Hudpmx .sdata:801522b4, size0x535;
* CopSpeak .sdata:801527ec, size0x7e (SpchHandle resolves80152840, retail8013d0d0);
* NFS3, R3DCar, AIH_Cop, Anim, Sim, Textsys, Track and snddata follow it.

The bounded repair is **(object, section)** bookkeeping for fragment membership
and SOURCE_DATA_OWNERS. The validated P881 pair is
`(build/recon/frontend/common/fecredits.cpp.o, .data)`; its explicit80051aa0
placement and oracle-only raw exclusion must remain intact. Do not weaken
source-owner validation or alter any compiler/assembly output.

This repair stops accidentally dropping actual input sections from the intended
section group. It does **not** prove native data order/ownership or make a
merely in-range address correct. The1,372 in-range retail-address mismatches
are why a zero-overflow result must not be reported as a native-exact link.
Other pre-existing raw/source duplicate and section-overlap/catch-all debt
remains separately visible in the generated map.

## Which omitted sections are already ready for native-owner placement?

`omitted_sections.json` contains every omitted section, all native/raw anchor
receipts and payload comparisons. These five have one consistent native base
and complete byte-exact payloads; **none has a data relocation** requiring an
unresolved pointer guess:

| Source section | Native base | Size | Independent agreeing anchors | Payload |
|---|---|---:|---:|---|
| hudpmx.cpp .sdata | **8013c84c** | **0x535** | 2 raw GP sites | exact1,333 bytes |
| copspeak.cpp .sdata | **8013d07c** | **0x7e** | 140 MAP/raw observations | exact126 bytes |
| nfs3.cpp .sdata | **8013d270** | **0x58** | 17 | exact88 bytes |
| r3dcar.cpp .sdata | **8013d324** | **0x9c** | 112 | exact156 bytes |
| sim.cpp .sdata | **8013d40c** | **0x28** | 14 | exact40 bytes |

Anchor observations are supporting sites/symbols, not distinct variables.
These justify a next **owner-window** restoration, retiring/excluding each raw
duplicate and preserving alignment gaps, rather than appending copies at a
convenient GP-range address. CopSpeak alone accounts for124 current overflow
sites. No source change is needed to make its current126-byte section payload
native. A placement task must still prove one backing run and unchanged peers.

Do not blanket-mark the other five as native-ready:

* Textsys .sdata8: wordFile/raw references imply base8013d454, but the leading
  compiled `p\0` literal occupies a retail zero word (one differing byte).
  This base overlaps the preceding owner's extent; investigate original
  initializer/encounter order instead of planting the section there.
* Track .sdata72: native symbols/GP sites imply **twelve different bases**.
  A single placement cannot repair that internal order/packing mismatch.
* snddata .sdata32: one MAP anchor implies801234d4; six payload bytes differ,
  and this address is not in the native small-data pool. Not a proved owner run.
* AIH_Cop .sdata4 and Anim .sdata3: no proved native base from these GP/native
  anchor records. Their source is not authorized to change in this task.

## Expected-address proof and remaining interpretation cautions

For2,374 sites, the source function and oracle have equal instruction lengths
and match every opcode/register/literal bit after masking only actual input
relocation fields and branch offsets. The exact corresponding raw ROM word
then supplies the expected GP address. Each oracle comment word was checked
against the executable. Four further sites have native symbol addresses but
two same-value store-order ambiguities (falseLapCounter/intensityFalseLapCounter
in AudioCmn_Init and the two TrackSpec pointer stores). The current addresses
match **neither** candidate retail address, so they are unambiguously misplaced;
the literal source store order still deserves separate review.

The remaining three sites are FIRST.c's local `.sbss+0` handler slot. Its
functions are not instruction-aligned with the oracle. Raw LUI/memory pairs
at **80109ea4/80109ea8, 80109fb0/80109fb4 and 8010a024/8010a028** independently
resolve the retained D_80148A7C slot to **80148a7c**. The generated source link
instead reaches8013eea4 through GP. The retail uses **absolute addressing**,
and80148a7c is outside the signed16 range of native GP. These three are
explicit **addressing-form/source-storage debt**, not a reason to move the
native slot into GP range or count a placement-only patch as a complete fix.

"1,696 wrong addresses" counts relocation sites differing from retail, not
1,696 independent runtime bugs. Same-value store ordering, source layout and
inlined compiler transformations must be interpreted independently. The full
per-site fields preserve both raw and native-symbol expectations where they
differ, rather than hiding the discrepancy.

## Frozen evidence and reproduction

* **baseline_complete.json**: complete2,381-site final census and native table.
* baseline_audit.json: initial automatic pass (three FIRST sites unclassified).
* omitted_sections.json: ten section inventories and five exact owner windows.
* baseline_recon_multdef-ok.elf/map/err: original generated artifacts copied
  before root was released to regenerate.
* `audit.py`: live-input ELF relocation, map/ELF resolution, oracle comparisons.
* `finalize_baseline.py`: independent GP derivation and FIRST absolute-slot proof.
* `sections.py`: omitted-section anchors and full initialized payload checks.

Frozen ELF SHA256:
`bf7f45ce98484149f0085aa9d6363af6767b0ccb2c77151dd4e65c1508773faa`.
Frozen map SHA256:
`8b135a1a2b56ba245b8bb1d7329903777a1183d266f39c87dfd068a0f4feb317`.
The audit checked ELF/map and every GP-input object for changes during its run.
It reported no missing live object, unresolved relocation or changed input.

For a later link, run `audit.py` again and retain a distinctly named after
receipt; do not overwrite or relabel the frozen baseline as the new result.
Re-check P881's source cell and oracle-only exclusion, all code gates, native
target addresses, overlapping output sections and strict diagnostics before
calling the tool change successful. No commit or production mutation here.
