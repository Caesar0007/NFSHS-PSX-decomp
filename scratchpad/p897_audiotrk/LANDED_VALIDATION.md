# P897 AudioTrk: actual-source validation

The reviewed candidate is now applied to the actual three production files.
`gate.py landed` uses their real include paths, with no staged header search.

- All **6/6 functions PASS**, with unchanged branch counts and offsets.
- All six instruction-line partitions are unchanged; no new native SLD
  merge/split pair is introduced.
- `AudioTrk_PreLoad` now places `se`, `i`, and `x/z/d` in their five native
  owning address ranges and depths. The missing CAudioList receiver and its
  two empty inline blocks remain explicitly unresolved.
- All **116 PreLoad instruction words** compare exactly to raw retail after
  resolving 23 relocation words in verification memory only.
- Both slice-pointer reference words target the native `8013C7C0` cell.
- All **13 layout assertions** compile against the actual production headers.

Actual normal object SHA256:
`d57d2dcfda69e37d673af8256b7b2823778956967d09a72db500a3d0e6036bb2`.
The only difference from the same-code scratch baseline is its explicitly
asserted STT_FILE path. Every other ordered symbol row, payload, section schema
and ordered relocation entity agrees. The coordinated parent checkpoint checks
the ordinary production object against its ordinary pre-edit object separately.

The pre-existing `se` in Reset is not renamed or removed. Its old claim to be
an exact recovered original name is reopened: Reset's own SYM lists only two
`i` locals. The sibling name and a rejected indexed-loop trial do not establish
an original Reset pointer variable. No generic audit exemption replaces that
claim. This is source-provenance correction, not a PASS regression.

Receipts: `landed.json`, `landed_verification.json`,
`landed_raw_target_receipt.json`, `landed_layout_receipt.json`, and the landed
entry in `debug_labels_receipt.json`. Candidate/baseline receipts remain intact.
No normal instruction, source debug label, compiler flag or object is rewritten.
This does not establish whole-function or whole-project source/SLD exactness.
