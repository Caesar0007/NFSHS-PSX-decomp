# Data-only object payload audit

| member | reconstructed section | retail VA | bytes | differing bytes |
|---|---|---:|---:|---:|
| `FEColor.obj` | `.data` | `0x800516C8` | `0x70` | 0 |
| `TABLE.obj` | `.data` | `0x80123838` | `0x11000` | 0 |
| `SNDEF.obj` | `.data` | `0x80136CD0` | `0x8` | 0 |
| `atantbl.obj` | `.data` | `0x80136CE8` | `0x101` | 0 |
| `CTYPE0.obj` | `.data` | `0x801371D0` | `0x81` | 0 |
| `asintbl.obj` | `.data` | `0x80137260` | `0x200` | 0 |
| `sintbl.obj` | `.data` | `0x80137464` | `0x404` | 0 |
| `fatantbl.obj` | `.data` | `0x80137868` | `0x404` | 0 |
| `CSTBL.obj` | `.data` | `0x80137D20` | `0x4000` | 0 |
| `isqrttbl.obj` | `.data` | `0x8013BE10` | `0x100` | 0 |
| `vars.obj` | `.sdata` | `0x8013DC64` | `0xA0` | 0 |

Result: PASS (0 failing members)
