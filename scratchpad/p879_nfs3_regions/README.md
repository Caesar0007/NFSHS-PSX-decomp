# P879 regional nfs3 startup declaration repair

## Later AU LoadPerps closure (separate minimal patch)

AU_loadperps.patch preserves the parent's startup edits and changes only two
source expressions in AU LoadPerps. It restores the existing USA representative
trafficDensity <=0 filename-selection condition (the shared code variant in
MANIFEST.tsv133), plus the raw-proven AU filename fecarsb.car.

The direct representative-body copy initially reached normalized REGION-PASS
but its stale fecars.car literal disagreed with AU raw800567C4. Correcting that
literal retains all172 instructions and makes all71 .rodata bytes exact against
the AU image at800567AC. This demonstrates why a code-variant manifest is not
proof that every region shares the same referenced data.

Final isolated AU gates: LoadPerps172, LoadingIcon73 and main237 all PASS (3/3).
Raw LoadPerps proof:145 nonrelocated words including exact conditional-branch
offsets;27 relocated words with opcode/register and target fields checked;
all six external calls and two local jump targets agree. GameSetup_gData is
801144D0, Paths_Paths is8011774C; trafficDensity is read at+0x18 before the
extra bgtz. Both mission strings, the format string and fecarsb.car are checked
at their actual raw addresses. No instruction/object rewriting is used.

All10 other AU function payloads are unchanged, allowing only the necessary
local .text relocation rebasing after LoadPerps gains its four missing retail
instructions. The startup's100 bytes are completely unchanged. .data6666 and
.sdata88 bytes remain unchanged; five .rodata byte changes restore the true
filename. Existing local names/scopes are copied from the already-reconstructed
representative; no new names, asm, volatile or helper declarations.

Qualification: this establishes the3 manifest-relevant AU variant functions and
protects their10 compiled neighbors; it is not a claim of a fully linked regional
image or globally exact owner section placement. In particular the format
literal's raw reference is proven independently of the whole small-data layout.

Durable proof: AU_loadperps_receipts.json, loadperps_raw_check.py,
check_neighbors.py, and AU_perps.cpp. No production files changed by this agent.
The earlier failure/12diff history below is intentionally retained.

Verified isolated repair for AU and USA copies; production remains untouched.
candidate.patch replaces only their obsolete flattened startup allocation with
the same ordinary source body already present in base nfs3.cpp:

```cpp
if (Speech_fgUndefined == 0) {
    Speech_fgUndefined = new Speaker;
}
```

The shared nfs3_externs.h already exposes Speech_fgUndefined with its recovered
ABI binding. copspeak_types.h already provides Speaker's80-byte layout and
inline constructor, which installs the existing vtable before clearing fSub.
The regional copies were never updated when these declarations were restored:
both still referenced undeclared _6Speech_fgUndefined and Speaker_vtable, using
an int p carrier and a hand-expanded constructor. Their compilation failures
were reproduced before the candidate. No new headers, aliases, or names needed.

Native SYM startup block2c6aa2 has no named locals; its frame is24 and its body
spans800A3DEC-800A3E50. The old p is not original-source evidence. Native symbols
record _6Speech.fgUndefined at8013CD88 and _vt.Q26Speech7Speaker at80055DC4.

## Gates

Current per-TU stock PsyQ -O2 -G8 inputs, no per-function interventions:

- AU manifest-owned functions: LoadingIcon73 and main237 both REGION-PASS.
- USA manifest-owned function: LoadPerps172 REGION-PASS.
- Thus all3 owned manifest rows remain green after both TUs compile again.
- Additional check: AU LoadPerps is a pre-existing stale168-instruction copied
  body against regional172 (12diff). It is unchanged by this patch, independently
  reproduced in the compatibility control. This round does not claim all AU
  functions match and does not repair that separate variant omission.
- USA LoadingIcon/main have no separate regional oracle; do not count as PASS.

The original source cannot build, so whole-object identity is checked against
an isolated compatibility-only control retaining the old allocation/body but
using current existing symbol spellings and the necessary typed publication
cast. Candidate and control have identical text, data, sdata, rodata, frame/ABI
sections and relocation payloads. AU text3320 bytes/.rel.text2168;
USA text3336/.rel.text2176. Filename symbol metadata differs; this is section
payload identity, not a false claim that original broken source yielded an ELF.

## Regional startup raw-byte and relocation-reference proof

Full region correspondence maps identify startup as the25-word LO16-only variant
at AU800A4954 / USA800A4950. It is not a separate manifest/oracle row.
raw_check.py reads these slices directly from their own regional EXEs. For each
candidate it checks all15 nonrelocated words exactly, all10 relocated words'
opcode/register bits, zero object addends, and each resolved raw target against
the regional symbol/function maps. No object or emitted instruction is rewritten.

Both allocate0x50, install vtable80056574 at+0x4C and zero fSub+0x48 before
publication. fgUndefined is AU8013E0A8 / USA8013E07C. All25 words' meaningful
fields and all four call targets agree with their regional retail image.

Both source patches remove one unrecorded local plus the obsolete flattening
comment. No new asm/volatile, aliases, helpers, or invented identifiers. No
production source/header/tool changes or commits by this agent.
