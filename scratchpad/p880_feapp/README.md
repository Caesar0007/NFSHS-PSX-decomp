# P880 FEApp native-source carrier cleanup

## Follow-up: both TU-level global array views removed

The final retained CPP also removes ticks_array[] and Draw_gDoVSync_arr[] and
their two asm-label bindings, plus the obsolete ticks preprocessor wrappers.
It now uses the existing public scalar declarations. Qualified ::ticks preserves
the real block-local u_long ticks from native record4b4942, without renaming it.

Draw_gDoVSync is directly typed EXT INT in NFS4 SYM3af4b6, VA8013D7A8.
NFS4 ticks record019199 gives VA8013DCAC but is only a top-level name record;
its scalar storage is the four-byte vars.obj cell, confirmed by the raw gettick
word load and vars.c definition. INT type is independently corroborated by
NFS2 PC beta vars native13bb6c (_ticks EXT INT). No typed NFS4 EXT record for
ticks was found; the receipt does not pretend otherwise.

Each override removal and their combined candidate preserve16/16 PASS and
zero branch differences. The actual same-path19220-byte ELF remains completely
byte-identical to both earlier P880 baselines, with the same SHA256 below.
MainLoop1123, initialization26 and destruction42 have exact debug twins.
The additional68 init/destruction oracle words equal raw ROM. There are no
remaining ticks_array or Draw_gDoVSync_arr occurrences in the CPP.

A final currentTicks/read-fence removal probe under the fully scalar TU remains
6diff/1123 with loop-edge -1027 versus retail-1026. It was not retained; the
remaining carrier comment now accurately records the scalar state. Prior three
local removals are preserved. No shared header or tool edits. Full proof:
views_receipts.json; source backup views_baseline.cpp.

Retained changes only in recon/frontend/common/feapp.cpp:

- Redraw: remove both unrecorded globalMenuDefs locals; access scalar menuDefs
  directly at their actual source statements.
- MainLoop: remove helpDialog; use the existing helpPopup.IsVisible() and
  helpPopup.Hide() members directly. The native caller local dialog remains.

No new identifiers, asm, volatile, helper declarations, header/tool edits,
or instruction rewriting. Failed experiments stayed in isolated candidates.

## Native evidence

Redraw block4b3937 records i/saveFPlayer/height/buffer/drenv/daprim/r, with
emptycommand and JustOneToPass in the two menu-input blocks. There is no native
globalMenuDefs declaration. Those native branch locals and statement ordering
are preserved. The corresponding retail SLD groups begin at298 and309.

MainLoop block4b4270 records dialog at4b4733, register s0, and the IsVisible
inline tDialogBase this at4b4767, register a0, VA80014AF4. Direct member source
expresses that inline receiver without inventing a caller-scope alias. The
predicate and Hide remain distinct source statements, matching retail740/743.

## Strong preservation gate

The actual same-path before/after ELF objects are byte-identical:

aed59b1d17dd6befe6112862e1d2233441c9a484a071c86f50132db2e17ca65a

This protects all code/data bytes, branch displacements, symbols and relocation
targets, not merely normalized matching. The original object is retained at
build/p880/original_feapp.cpp.o; baseline.cpp is the source backup.

- Whole TU:16/16 PASS; zero branch-distance/count divergences.
- Redraw:393/393 instructions, exact -g attribution twin.
- MainLoop:1123/1123 instructions, exact -g attribution twin.
- Both oracle slices checked against rom/nfs4-f.exe:1516/1516 words exact.
- git diff --check is clean.

## Measured remaining targets

memcardDialog direct inherited SetString/Display/Hide remains10diff,1123/1123.
Explicit tDialogMessageString qualification, a base reference, and chaining
existing SetString->Display were also10diff. The latter would merge distinct
SLD statements anyway; it was diagnostic only. None retained.

currentTicks removal plus its existing read fence: direct array-view assignment
is6diff, direct scalar ::ticks is4diff, both1123/1123. Both additionally alter
the loop edge from retail-1026 to-1027. Those experiments are not improvements;
the existing carrier/fence remain unchanged. This is measured current evidence,
not an assertion that a better original-source form cannot be found.

The scalar global and direct help receiver wins demonstrate that the older
array-based failures were stale for those three declarations. Other carriers
and pre-existing devices are not claimed solved. No commits or pushes by agent.
