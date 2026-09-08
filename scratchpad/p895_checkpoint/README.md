# P895: native AI scope/statement recovery and scalar NewBestLap

Completed 2026-09-08. Three production CPP files change relative to P894:
ai.cpp plus base/USA screentrackrecords.cpp. No header, data owner, build tool,
compiler flag, qualifier, helper, asm instruction or output rewrite is added.

## AI_PushFinishedCarsToSide

The finished-car and eligibility checks now form one short-circuit conditional.
The two actual native INT locals, absDistancePastFinish and totalSortIndex,
are declared in its body, instead of being incorrectly function-wide. The
synthetic PUSH label/gotos are removed. The call result and absolute value
are assigned to the same native local in two separate statements.

Actual production verification proves:

- AI40/40 PASS; every branch count/offset unchanged; complete normal object
  byte-identical to P894, SHA256
  `9189b0c2946f70621dc418f3738dce998bc67f1c96c0980a9e43e1a5d8772677`.
- Native SLD instruction-pair differences improve from **485 splits/9 merges
  to0 splits/0 merges**. Combining the conditional closes the485 splits;
  separating native1997's call from1998's abs operation closes all9 merges.
- All three compiled block address spans and nesting depths match native
  records033a48/033a51/033a5a: roots at8005A724, depths0/1; local-owning block
  at8005A7C0, depth2; all end8005A8B0.
- Native033a63/033a86 local names, INT types and $6/a2 /$3/v1 homes are retained.
  The unsupported label's debug record disappears; no replacement name is added.
- All39 neighboring functions preserve line partitions, ordered local/type/
  storage records and complete instruction/debug-scope contracts. Comparisons
  normalize only absolute .loc numbers and consistent compiler-local label IDs,
  never generated object/assembly instructions or scope placement.
- Full target raw proof: **103/103 words,412 bytes**, including22 relocation
  words resolved only in verifier memory and81 unmodified words. Native bytes
  SHA256 `ac2aadf446c8e4354c58ac454b4a1e7d69e7b83462e6981ecaf203da7ce939cb`.

The intermediate range-only and nested-guard probes remained byte-exact but
emitted five scopes instead of three. Their evidence led to the single guard;
none was accepted as full topology recovery. The first production guard-only
checkpoint is preserved in guard_only/ before the final abs split. Actual
final source hash is
`f887d61567d6987439df6851b4dbd800fa9649333ae731d7e9ef3f79ef3f3265`.

This is exact **instruction-line grouping and lexical address/depth ownership**,
not proof of literal original text. Current physical block-relative lines remain
6..30 versus native4..28 because of expanded condition formatting. Original
macro/operator spellings and whole-file physical line positions are not sealed;
no #line spoofing was used. The project-wide goal is not called complete.

Detailed original/final native scope, per-pair, neighbor and raw receipts:
../p894_ai_single_guard and ../p895_ai_abs_split, especially the latter's
landed.json, landed_scope_verification.json and landed_raw_target_receipt.json.

## NewBestLap source shape

Both TrackRecords sources now read the existing scalar bool NewBestLap.
Two unsupported NewBestLapA[] asm views and their obsolete comments are removed.
Native71dba4 explicitly declares EXT BOOL NewBestLap at80052998; the distinct
NewRecords[8] array, scalar owner, private header, function locals and region
text ids remain untouched.

Actual base7/7,37 branch checks and USA3/3 manifest gates pass. Both production
whole objects are unchanged. All14 function-instance local/line partitions
remain identical; existing DrawRecords3 merge/144 split pairs remain open.
USA native-relative metrics are labeled base-SYM projections; the156-word USA
DrawOneRecord versus154 base has no unjustified same-index native projection.

All240 raw DrawRecords words, including28 relocated words, are exact. The four
NewBestLap HI/LO words resolve to80052998 base and80052E28 USA. Preassembly
debug-label uniqueness141/157 is asserted; zero label or instruction rewrites.
See ../p895_newbestlap/README.md and verification.json for actual-path receipts.

## Coordinated regression

Fresh detailed source/branch gates recompile **705/705 functions in32 base TUs**.
Every complete affected TU, including USA TrackRecords, also has the isolated
actual-production proof above. All **518 normal source objects are literally
identical to P894**, as is the newly generated diagnostic linked ELF:
`bf66bf489f36b0c7236bbcff855ed2480f36f1fe4a889c20b22bb3e033e0592e`.
There is zero source-receipt hash drift. Both relink lanes, linker checks,
vtable indexing and source policy pass with unchanged standing counts.

P894 already completed all three full build lanes. Since P895 changes only
three CPPs, with no header/tool/data change, this round recompiled the complete
protected TU set and checked exact identity of every prior518-object artifact;
it does not falsely claim another three whole-tree rebuilds. Expected/oracle
sources are unchanged. CI-style build/p895_report.binpb generated successfully,
321195 bytes, SHA256
`2f64da5ebcadf1b920d8668e8a02ffed87abf40a1621fd45bfa97b3805ab19c3`.

Strict totals remain frontend/common780clean/48extra/438source-only carriers,
game/common1228clean/6extra/478carriers, zero missing names in both, with prior
type/storage/mapping queues unchanged. Declaration-clean counts do not prove
source scopes or exempt all remaining carriers; this round demonstrates why
actual debug records and SLD were required beyond that audit.

Prior851 blob duplicates,1433 wrong native GP targets, link overlaps/overrun
and other source/header/data-provenance debts remain. The permissive diagnostic
link is not a final-image or whole-source seal. The user scratch hash remains
`d433425b806fc8abd1fa60c9f72a09f4c022bfd64a7fecf4df496931169e9546`.
No staging, commit, push, external-task message or UI file opening occurred.

Primary receipts: before.json, source_receipts.json, command_receipts.json,
final_receipts.json, relink.json and both strict reports. The full original-
source/SYM/SLD objective remains active; remaining native AI scopes and the
Newton/AIPhysic/AIState/AudioTrk slice graphs are concrete next work.
