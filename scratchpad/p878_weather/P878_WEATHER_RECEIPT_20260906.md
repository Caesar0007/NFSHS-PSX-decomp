# P878 Weather_Init source correction

Production change is limited to Weather_Init's body: all three weather-type
reads now consistently use the genuine initialized `Weather_gTrackSpec->type`
pointer. No new local, type, assembly, volatile, opcode body or compiler flag was
added. The obsolete body comment claiming that a per-function flag was necessary
was replaced with the measured source receipt. Other Weather functions, private
headers and production tools were not edited by this agent.

## Evidence and result

Native SYM488ba9 records Weather_gTrackSpec at8013dbc4 as PTR STRUCT CWeatherSpec,
size8. The function first assigns it `&TrackSpec_gSpec.weatherspec`. Reading its
type consistently through that pointer is ordinary typed source; no unrelated
field or invented view is involved.

- Current production strict source-only: **25/25 PASS**, zero branch differences.
- Current production normal lane, including its still-present historical flag:
  **25/25 PASS**, zero branch differences.
- Weather_Init: **211/211**, exact debug twin.
- Both production builds produce the same entire object SHA-256:
  `0ddbacb299921c55bccc8e4514a775ab4a2623d42e3e8791a4749c681eb67f0e`.
- The entire corrected source-only isolated .o equals the original source's
  normal mixed-flag .o byte-for-byte:
  `d2faf83be4d96c6a207b497065aef23a8bf4a6ad8ca2ec547d289ebe5c3901a6`.
- Production sections, relocations and symbols independently equal that original
  mixed object after excluding only the diagnostic compiland filename.
- All25 oracle slices were checked against raw rom/nfs4-f.exe:
  **2,035 instruction words, zero discrepancies**.

The exact object comparison includes data, code and relocation identities/addends;
it is stronger than normalized PASS alone. No new global/call reference has been
introduced. The generated initial statement groups agree with native SLD:
pointer assignment415, weather guard418, type load/store425 and rain test426.

The existing PER_FN_FORCE_ADDR entry is **redundant** and can be retired by root.
It need not remain to preserve normal PASS. Root owns protected tool changes and
the user-requested commit/push checkpoint.

## Rejected identity matrix

All tests used the same original full source and established -G8 identity.
The retail compilers were hash-asserted:2.8.0
`61781c2f67b8486281720fdabb1fd7b549cce7f92918cb7b505db1fce54742b7`,
2.8.1 SN `70319c94de27924f5720af361afd2aa7e6de051a7718e0c1a7f07b57fa92109c`.

| Original source configuration | Whole-TU result |
| --- | --- |
| Normal mixed, Init-only force-addr | 25/25 PASS |
| Strict2.8.0 | 24/25; Init12 at211/211 |
| Strict2.8.1 SN | 24/25; same Init12 |
| Whole-TU force-addr, either compiler | 22/25 |

Whole-TU force-addr fixes Init but regresses QuickReOrthogonalize57 differences
at157/160, ProcessParticles22 at251/251 and DoWeather4 at197/197. It is not a safe
TU identity for this source. No such production flag was added.

Sixteen bounded ordinary source probes were evaluated. Consistent pointer reads
and the redundant `*(&field)` spelling both reached PASS; the genuine pointer use
was selected. All unsuccessful probes were confined to scratch. Matrix-destination
carriers and other pre-existing source-restoration debt were not renamed or hidden.

## Durable artifacts

- `identity_results.json`: original five-way matrix and complete branch outcomes.
- `normal_mixed.o` and other unprefixed .o files: original generated matrix
  artifacts; diagnostic, not game source or inputs.
- `baseline.cpp`: frozen original source with anchored include paths.
- `weather.cpp`: isolated winning body, with its historical diagnostic comments.
- `identity_probe.py`: reruns against the frozen baseline, not repaired production;
  writes `rerun_*.o` / `identity_results_rerun.json` so historical comparison
  artifacts are not overwritten. This snapshot-routing adjustment was made only
  after final checks; no additional experiments were initiated after the user's
  finish/commit request.
- `shape_results.json`: all16 probe outcomes.
- `final_probe.py` / `source_corrected_results.json`: whole25, exact debug twin,
  statement mapping, and exact whole-object comparison against old mixed output.

No commit or push was performed by this agent. Source edits and builds stopped
after the requested final normal/strict/raw/relocation checks.
