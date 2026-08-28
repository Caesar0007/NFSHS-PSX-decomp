# EAC library matrixtdef consumer classification (2026-08-28)

## Owners

- `recon/eaclib/psx/eacpsxz/trnspos.c`
- `recon/eaclib/psx/eacpsxz/xform.c`

Both linked EA library members omit their common/foreign type graph. Their
source uses the shared NFS4 `matrixtdef`, which is independently recovered in
`recon/nfs4_types.h` as a 36-byte structure containing `int m[9]` at offset 0.
The retail functions' direct member offsets agree with that shared layout.

The canonical audit now accepts each owner-local carrier only when its named
`matrixtdef` tag and typedef form a complete pair with the exact owner, compiler
tag link, 36-byte size, member name, array bound, leaf type, and offset. This is
not a name-only allowlist; any drift reappears as a finding. The pre-change
audit tool is backed up by Git commit `cdba8752`.

## Proof

- focused p311 sweeps: both owners `OK`, zero residual named, anonymous, or
  typedef records
- authoritative p312 project sweep: 353 OK / 64 DIFF / 30 COMPILE_FAIL /
  11 OWNER_MAP
- comparison with p310: exactly `trnspos.c` and `xform.c` changed
  `DIFF -> OK`; no other owner changed status
- reconstructed sources, compiler settings, objects, linked image, and
  matching rules were untouched
- existing matching baselines remain `trnspos.c` 1/1 PASS and `xform.c` 4/4
  PASS
