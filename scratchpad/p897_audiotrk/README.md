# P897 AudioTrk source contracts and native local ownership

2026-09-09. The isolated candidate retains all6/6 PASS functions and every
branch count/offset. The complete normal object is byte-identical to its
same-input-path baseline. No production edits are implied by this candidate
receipt; actual landed receipts and the parent checkpoint supersede it later.

## Source corrections

- The invented AudioTrk_BWorldSmSlices alias is removed. The two reads use
  native BWorldSm_slices[0].center[0/2]. The32-byte Trk_NewSlice projection
  comes from owner SYM1cec71..1cedc3/global1d937e at8013C7C0, and stays at
  the AudioTrk-only extern boundary. No other TU includes that header.
- Existing AudioCmn_GetAsyncSfx calls use bool false rather than a null void
  pointer for the third argument. Native191b70 is BOOL checkonly; the private
  prototype names bank/patch/checkonly now match191b4b/191b5d/191b70. Types,
  linkage, arguments and instructions are otherwise unchanged.
- PreLoad se moves to its native while-body scope, and i to its for-init
  scope. The redundant nested compound block is removed. The five inner
  native names now have their actual owning address spans/depths:
  se@8007D3D8..8007D4DC/depth1; i@8007D410..8007D4DC/depth2;
  x/z/d@8007D424..8007D4CC/depth3. The prior source placed se and x/z/d one
  level too deep. All names, types and register homes remain unchanged.
- The unrelated copied header description of bworld.obj/20 functions is
  corrected to AudioTrk's six-function ambient-audio role. The private type
  header no longer overclaims exact original foreign-header visibility.

## Corrected provenance claim, not a rename

Reset's existing semantic se name was labeled ORIGINAL-NAME-RECOVERED because
SoundTrack and PreLoad use that same name. Reset's own SYM1be94f..1bea5c lists
only two i locals; a name in neighboring functions does not prove Reset's
original name or even a distinct source pointer object. The old claim is
replaced by SOURCE-RECOVERY-OPEN, preserving current code and the existing
name while making the unresolved source identity visible again.

A fresh no-pointer indexed Reset trial reached58/56 instructions with32differences
and branch changes. It was rejected and frozen in index_reset_failed. That
failure proves only this source form failed, not that the pointer is original
or unavoidable. The retained field/provenance form returns6/6 with literal
object equality. The strict declaration review may therefore grow by this
reopened name; no audit parser or generic exemption is added.

## Independent validation

- All six complete functions are re-gated under the current production profile;
  normal/debug text is exact. Entire same-path normal SHA256:
  c21f51b93fcc8d3f7aa48de2eaca4adf734f9b94ed362790e0dadc8ca967634f.
- All source-line partitions remain unchanged. PreLoad's five declared local
  scope owners above are explicitly compared to native1bf4cd/1bf535/1bf54d/
  1bf55c/1bf56b. All other functions preserve complete instruction/scope marker
  placement and declaration sequences. Comment/format changes to physical
  relative line counts are recorded, not misreported as literal spacing equality.
- PreLoad's **116/116 raw words**,464 bytes, match retail.23 relocation words
  are resolved only in verifier memory;93 words compare unmodified. Native
  raw SHA25651e6b41c1a663ec04f8aa9169b352244833a6ba1095c0900e54c6aa6d45e36f2.
- The two slice-pointer HI/LO words at8007D3AC/B0 target8013C7C0 exactly.
-13 actual-compiler assertions verify slice/center offsets, AudioElem24 and
  relevant members, CAudioList16/count+4, and the target's four-byte bool ABI.
- Existing compiler scope labels are retained with diagnostic GAS-L only.
  The compiler assembly is unchanged and every code/data byte matches; no
  label or instruction is inserted/rewritten. Normal flags are unchanged.

## Remaining source/SLD work

PreLoad still lacks the native CAudioList inline receiver this at1bf4f2 and
its two zero-width blocks at8007D410. The surviving record does not identify
the accessor's original name. No guessed GetData/GetElements method is added.
Named scope ownership is now correct, but the full native tree is not sealed.

SLD pair counts remain explicit: Reset20merges/60splits; StartUp0/3;
AddCustomObject1/174; SoundTrack115/132; PreLoad178/43; CleanUp0/9. No new bad
pair is introduced. Reset se, existing curBack, other source scopes, original
macros and foreign type-header visibility remain open. This is not a whole
original-source or SLD seal.

## Preserved stages and artifacts

field_candidate contains the first alias-only success; index_reset_failed
the rejected no-pointer Reset form; qualified_field_candidate the restored
code with corrected provenance; for_i_intermediate records the first scope
step before the enclosing se scope was corrected. All normal/debug outputs
and source backups are separate. No failed form was proposed for production.

gate.py, keep_debug_labels.py, verify.py, raw_target.py and check_layout.py
produce the candidate receipts. propose.py checks exact production/backups
and compiled source/header hashes before printing an apply_patch proposal.
All compiler/gate algorithms are reused from the existing tools; outputs are
isolated. Root owns landing and full project regression. No commits or pushes.
