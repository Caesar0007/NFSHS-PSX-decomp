# P908 independent linked-reference proof

`reference_proof.json`: **462/462 current relocation records have exact linked
target + addend + complete encoded word; zero errors.** The census is independently
read from all 698 actual `recon_link.rsp` input objects and exactly reproduces the
selected inventory multiset. There are 20 distinct consumer objects. No build,
source/tool edit, normal-output write, staging or commit was performed here.

| Native owner | Public cells | Reference records |
|---|---:|---:|
| r3dcar.sdata | 15 | 226 |
| copspeak.sdata | 16 | 174 |
| nfs3.sdata | 16 | 62 |

The encoding census is 222 R_MIPS_GPREL16, 115 R_MIPS_HI16,
124 R_MIPS_LO16 and one R_MIPS_32. Each record retains the input relocation,
input/linked instruction word, actual input placement and output section,
native symbol base, signed addend and resulting address. No reloc field or
instruction was blanked for comparison. Native addresses/types are re-read
from `C:/Temp/nfs4-clean/nfs4-f-v3.txt` and `NFS4.MAP`; bytes are independently
checked against `rom/nfs4-f.exe` and `NFS4.CPE`.

GP is 8013C54C, matching the native `__sdata_org` anchor; each GPREL record has
input GP0=0 and encoded base register28. All 115 HI16 entries have an explicit
following same-symbol LO16 receipt and signed low-half carry. LO16 entries retain
their own addends; three have no preceding same-symbol HI16 and are explicitly
qualified as low-relocation-only checks, not alleged dataflow producer pairs.
All high addends are zero in this selected set. The one R32 is FEI's native
`gUseFrontend` pointer and matches the raw table word exactly.

All explicit addends are in range. There are 358 zero addends, six CVECTOR byte
component accesses (+1/+2), and 98 local `.sdata` literal/pool records (49 HI/LO
pairs). No negative, one-past, past-end or width-overrun access was found. Full
addend distribution and section-pool classification are in the JSON.

## Raw-code qualification

259 individual references also have strict raw-word equality: 258 in 41
whole-function byte-identical linked bodies and the FEI data pointer. Another
195 references reside in 30 functions whose complete linked bodies are not raw
byte-identical; they receive **no positional raw-word claim**. Eight references
are in three functions whose current symbol names lack a unique native MAP
entry: `FECheat_HandleActivation__F10tCheatCode`,
`Front_InitMissions__FR9tFEStream`, and `NFS4_LoadPerps__Fv`.
Their actual linked relocation encodings and native data targets are still
verified, but source-name/retail-function alignment is not asserted here.
This audit is not a whole-function matching score or original-token proof.

## Payload and image qualification

All 47 native EXT globals have their exact public/default-visible linked
addresses and native storage widths. PTR STRUCT sizes36/12 are pointee sizes,
not pointer cell sizes; those cells are four bytes. All 370 source-section bytes
match ROM, CPE loads and linked `.sdata`, including the 204 bytes outside named
cells (literal/alignment spans). CopSpeak's final two zeros at8013D0FA..8013D0FC
are outside its126-byte source section: ROM/linked equality is established,
but **CPE does not load these two bytes**. No invented storage is proposed.

The current ELF has pre-existing overlapping `.data` and `.sdata` address
ranges. Reads therefore use the actual GLOBAL's section or the map's precise
input/output-section identity. A VA-only ELF read is ambiguous and was rejected.
This proof does not claim a collision-free or completely retail-exact image.

- ELF: `8ecfcdd06de59e1138efb5c946b5c2dc59f6df1bc5ddcef86b44e3f2b0d8a521`
- Frozen map: `6b5d838af99302b3c64158f17f8c90080dc4db93f71a78963093a7c76e19ac23`
- Current map: `ecc5bd9dace8ac2e376020066e21e7f5b313cb002fa9d23bdf5bc7d39e50e9ad`

The current map differs from the frozen checkpoint only by47 successful
native-symbol ASSERT lines, covering exactly these47 globals. All placements
and other map text are unchanged. All watched inputs were rehashed unchanged
after the proof. The three source-owned object hashes also equal `selected.json`.

## Reproduction dependencies

Run `python -B scratchpad/p908_owner_contracts/references/audit.py` from the repo.
This read-only diagnostic writes only its JSON receipt in this directory.
It imports the existing strict ELF reader
`scratchpad/p892_checkpoint/metadata_audit.py` and CPE reader
`scratchpad/root_sym_audit/probe_cpe_data_map_p867.py`; it also needs the selected
inventory JSON, frozen P908 map, actual current objects/image/map and local
primary SYM/MAP/CPE/ROM inputs. It is an evidence script, not a self-contained
published build dependency. Parent owns production validation and publication.
