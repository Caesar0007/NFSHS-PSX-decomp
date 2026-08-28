# PsyQ 4.3 RECT owner classification (2026-08-28)

## Owners

- `recon/eaclib/psx/eacpsxz/fastmovf.c`
- `recon/eaclib/psx/eacpsxz/movf.c`
- `recon/eaclib/psx/eacpsxz/vramfxya.c`

The linked EA library members retain no type graph, but each reconstruction
uses the canonical PsyQ graphics SDK surface. PsyQ 4.3 `LIBGPU.H` defines
`RECT` as four consecutive `short` members (`x`, `y`, `w`, `h`) and declares
`SetDrawMove(DR_MOVE *, RECT *, int, int)`. The same header family defines
`u_long` as the unsigned-long SDK alias used by `movf.c` and `vramfxya.c`.

The audit now classifies only the exact owner-local SDK carriers:

- anonymous 8-byte structure with `short x@0`, `y@2`, `w@4`, and `h@6`
- its linked `RECT` structure typedef
- the exact `u_long: ULONG` typedef in the two owners that emit it

The anonymous body and `RECT` typedef are pair-locked by owner and compiler tag.
Any name, size, member, offset, leaf type, linkage, or owner drift becomes a
visible finding. This is not a general type-name allowlist. The pre-change
audit tool is backed up by Git commit `d4558d8f`.

Canonical references checked:

- `C:/Temp/ps1-decomp-refs/glover/Include.43/LIBGPU.H`
- `C:/Temp/ps1-decomp-refs/glover/Include.43/SYS/TYPES.H`
- `C:/Temp/ps1-decomp-refs/glover/Include.43/STDDEF.H`
- `C:/Temp/psq44/psx/include/LIBGPU.H` (same definition and prototype)

## Focused proof

All three focused p306 sweeps report `OK`, with zero residual named,
anonymous, or typedef records:

- `fastmovf_type_graph_p306_20260828.tsv`
- `movf_type_graph_p306_20260828.tsv`
- `vramfxya_type_graph_p306_20260828.tsv`

## Whole-project proof

`project_type_graph_p307_20260828.tsv` reports:

- OK: 348
- DIFF: 69
- COMPILE_FAIL: 30
- OWNER_MAP: 11

Compared with p305, exactly the three owners above changed `DIFF -> OK`; no
other owner changed status. No reconstructed source, compiler setting, object,
linked image, matching rule, or post-compiler rewrite was changed.
