# `ScreenUserName.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `ScreenUserName.obj`

Source TU: `recon/frontend/common/screenusername.cpp`

`screenusername_types.h` layers the owner's four unique completed records on
ScreenDisplay's already proven shared frontend graph: `FE3d_zUV`,
`FE3d_zFacet`, `FE3d_zObj`, and the 204-byte `tScreenUserName`.  The retained
SYM aliases `FE3d_zVertex`, `FE3d_zColor`, and `FE3d_zNormal` are restored as
the exact `COORD16`, `CVECTOR`, and `SVECTOR` typedefs.  ScreenDisplay's class
and foreign-global view are excluded through an owner-record guard; its normal
translation unit remains independently graph-exact and 3/3 PASS.

The retail `DrawBackground` instructions contain an alignment-one, two-byte
copy corresponding to `strcpy(output, " ")`, while the reconstructed string
pool assigns that literal alignment two and otherwise emits `lhu`/`sh`.
`ScreenUserName_Align1Copy2CodegenCarrier` preserves the bytewise retail copy
and the 6/6 PASS result.  Because SYM contains no such source type, the
canonical audit suppresses it only as an exact two-byte tag/typedef pair with
one `char b[2]` member from `screenusername.cpp`; any name, layout, or origin
drift becomes visible.  The audit tool's pre-change backup is pushed commit
`1d20af1e`.

Strict compiler-emitted comparison:

- named records: 116/116 exact
- anonymous records: 2/2 exact
- source-only named records: 0 after the exact carrier pair-lock
- source-only anonymous records: 0
- source-only typedef semantics: 0 after the exact carrier pair-lock
- result: `OK`

Verification:

- two successive
  `python tools/tugate.py recon/frontend/common/screenusername.cpp` runs:
  6/6 PASS
- focused graph: `screenusername_type_graph_p273_20260828.tsv`
- full frontend/common sweep: 23 exact owners, 18 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit and repository-wide regression gates:
  green
