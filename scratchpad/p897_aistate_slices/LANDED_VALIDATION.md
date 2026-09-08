# P897 actual-production AIState validation

2026-09-09. Root applied the verified three-file proposal. This follow-up
compiled the **actual base/USA source paths and actual private headers**, writing
only isolated landed outputs here. No production edit, normal build output,
shared tool change, instruction rewrite, or debug-label rewrite occurred.
Every earlier baseline, rejected variant and proposal receipt remains unchanged.

## Gates and complete source contracts

- Actual base **52/52 PASS**, **316 branch checks**, zero differences.
- Actual USA **2/2 available regional oracles PASS** (StartUp/Restart16 each).
  This is not misreported as52 USA oracle matches.
- Complete normal-object header/schema, code/data/storage payload, full symbol
  multiset and ordered relocation entities are unchanged in five direct pairs:
  accepted candidate -> landed for each image; original base -> landed;
  historical-header USA -> landed; dependency-repaired USA -> landed.
- These are **260 function comparisons**, covering all104 actual base/USA
  function instances. Every parameter/local/storage declaration, source-line
  partition and compiler scope location is preserved.
- Strong scope check: complete debug function bodies agree after excluding only
  absolute `.loc` directives. Instructions, labels, begin/end positions and
  relative block lines remain identical. Complete debug `.text` is exact against
  normal `.text` for both actual sources.
- Exactly expected FILE paths differ between staged/historical and actual
  source objects. Each full FILE row and exact path is asserted; the verifier
  does not blanket-ignore arbitrary FILE or local-symbol changes.

## Actual graph, layout and raw references

Preprocessor file markers record all **11 unique actual source/header inputs**
(two CPPs plus nine shared/private headers). Each is hashed and rechecked;
no source/header drift occurred and no scratch header entered either compile.
The actual private header's emitted Trk_NewSlice definition proves all native
offsets/types and32-byte size. The foreign body stays at that private boundary;
original AIState header visibility remains unproved.

**90/90 own-image raw reference words remain exact**:

- 44 BWorldSm_slices words (22 per image).
- 42 simGlobal words (21 per image).
- 4 GameSetup_gData materialization words (2 per image).

The explicitly accounted USA simGlobal interior-field anchor remains important:
native global8011E0AC, map field anchor8011E0B0 -> USA8011F368; actual USA global
is8011F364, so gameTicks+4 correctly reaches8011F368. Every resolved instruction
is compared with that image's raw executable, not inferred from label spelling.

Debug label uniqueness is checked before assembly:1026 base /1141 USA labels,
**zero rewrites**. Existing unsupported local names, fences and unresolved native
scope questions are preserved, not implicitly validated by the field correction.
This does not claim complete original-source or full native SLD recovery.

## Actual hashes and artifacts

| Artifact | Bytes | SHA256 |
|---|---:|---|
| Landed base object |22828 |bb9661a33fb059d35c28e388a84cce18b6b7ff4741c43a5d770095f46dbbd207 |
| Landed USA object |22980 |82b830f5e953db3041ff9f564d1239fb6bf01235aaa852c63cd506c7ee774436 |

Actual source/private header hashes:

- Base CPP: `e96787f5c8739b40f023e21d1e0744b99f27cc51039e5bcb1e37684ddcb1b61b`.
- USA CPP: `727f1eac4c342fa8486d50c8d320dcba4109e1584f15750742a238ce0c053763`.
- Private extern: `64e3ccd89efcc153daeed74ad6ec1e748b120828c0179cb6c15a7f116018e943`.
- Unchanged private types: `27920c9d8fab55a1f9aecdc2058ea9bd06166179674807f82812dae67bf00946`.

`landed_base.json`, `landed_USA.json` retain gate output, all input hashes,
preprocessed hashes, object/debug paths and label assertions.
`landed_verification.json` retains every direct function/object comparison,
actual header layout and raw references. `landed_gate.py landed base|USA` and
`verify_landed.py` operate only in this scratch output namespace.

Validation completed; no next probe was started. Root owns the coordinated
full-project regression and checkpoint.
