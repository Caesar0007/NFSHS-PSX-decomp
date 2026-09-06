# P875 PSX public-header restoration

Restored **384 public prototypes across25 headers** to source names and native signatures. Removed2 declarations for functions proven file-static in SYM and the actual object (`Font_textbsearch`, `uppercase`). Corrected9 public return types and parameter/arity drift, including callbacks, narrow integers, bool, missing trailing arguments and Night's pointer-to-array shape.

The original headers compiled but emitted **386/386 wrong double-mangled references**; none matched the expected native symbols. Repaired typed-reference probes compile25/25 and emit **384/384 exact native symbols**, all present as freshly built function symbols in their owning objects. Frozen before-probes reproduce the original emitted names. A combined include of all25 repaired headers also compiles.

Both before/after and combined probes retain the pre-existing nfs4_types.h CurrentPlayer char-to-tPlayer warning. There are no header compile failures and no unresolved candidate in this bounded queue.

A literal/dynamic include census over1677 files in `recon`, `regiondiff/recon`, `src`, and `include` found zero consumers of these public headers and zero dynamic includes. No .cpp, private type/extern header, production build tool, asm, volatile, or source identifier outside the public prototype surface was modified.

Fresh owning-TU gates: **384/386 PASS**. Existing misses are `Night_CreateNightTableElement__FiliPUc` (56diffs) and `Weather_Init__Fv` (12diffs); their source bodies and build lanes were not changed. This is not a claim of full-project SYM/source/byte exactness.

Special cases:

- `Font_SetBlitter` explicitly declares its seven-argument callback. Native mangling and the owning `font_obj_types.h` prove the signature; the monolithic public `fontblit` typedef remains under-specified and was not edited.
- `DrawObjectSimple` keeps native `offset` rather than copying the implementation's compatibility spelling `offsetArg` into the public declaration.
- `Font_textbsearch` is native STAT3f4e3b /800cb6a0; `uppercase` is native STAT42036e /800d2a44. Both are local symbols in the current objects, not public exports.

| Header | Public corrected | Private removed | Return fixes | Current owning TU |
| --- | ---: | ---: | ---: | --- |
| [audio.h](audio.md) | 6 | 0 | 0 | 6/6 PASS |
| [cario.h](cario.md) | 11 | 0 | 0 | 11/11 PASS |
| [device.h](device.md) | 10 | 0 | 1 | 10/10 PASS |
| [draw.h](draw.md) | 25 | 0 | 1 | 25/25 PASS |
| [drawc.h](drawc.md) | 20 | 0 | 0 | 20/20 PASS |
| [draww.h](draww.md) | 35 | 0 | 1 | 35/35 PASS |
| [fe3dmenu.h](fe3dmenu.md) | 3 | 0 | 0 | 3/3 PASS |
| [flare.h](flare.md) | 27 | 0 | 0 | 27/27 PASS |
| [font.h](font.md) | 14 | 1 | 1 | 15/15 PASS |
| [force.h](force.md) | 9 | 0 | 0 | 9/9 PASS |
| [hrzsku.h](hrzsku.md) | 22 | 0 | 0 | 22/22 PASS |
| [hud.h](hud.md) | 61 | 1 | 1 | 62/62 PASS |
| [loading.h](loading.md) | 3 | 0 | 0 | 3/3 PASS |
| [night.h](night.md) | 19 | 0 | 0 | 18/19 PASS |
| [overlays.h](overlays.md) | 5 | 0 | 0 | 5/5 PASS |
| [platform.h](platform.md) | 8 | 0 | 0 | 8/8 PASS |
| [psxcontroller.h](psxcontroller.md) | 4 | 0 | 0 | 4/4 PASS |
| [rpause.h](rpause.md) | 3 | 0 | 0 | 3/3 PASS |
| [sfx.h](sfx.md) | 7 | 0 | 0 | 7/7 PASS |
| [skidmark.h](skidmark.md) | 11 | 0 | 1 | 11/11 PASS |
| [texture.h](texture.md) | 24 | 0 | 0 | 24/24 PASS |
| [textureprocess.h](textureprocess.md) | 16 | 0 | 3 | 16/16 PASS |
| [trackspec.h](trackspec.md) | 5 | 0 | 0 | 5/5 PASS |
| [trsproj.h](trsproj.md) | 11 | 0 | 0 | 11/11 PASS |
| [weather.h](weather.md) | 25 | 0 | 0 | 24/25 PASS |

Reproduction from `C:/Temp/nfs4-decomp`:

```powershell
python scratchpad/root_sym_audit/p875_psx_compile.py before
python scratchpad/root_sym_audit/p875_psx_compile.py after
python scratchpad/root_sym_audit/p875_psx_compile.py owners
python scratchpad/root_sym_audit/p875_psx_consumers.py
```

The compiler helper emits JSON to stdout and leaves only compiler intermediates beside the probes. Per-header JSON records retain original/final declarations, native record IDs/VAs/return types, real source-definition locations, emitted references, owner-symbol checks, compiler diagnostics/commands, and hashes. Do not commit generated `.i`/`.s` intermediates; retain the `.cpp` probes and JSON/Markdown receipts.
