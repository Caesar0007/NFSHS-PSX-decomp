# P882: five byte-proven native .sdata ownership windows

This subtask changed only four relevant raw residual files, added five
oracle-only raw owner files and one intermediate residual, and updated
`linkers/nfs4.ld` plus `linkers/nfs4_recon.sdata_8013C54C.ldfrag`.
Production code, headers, tools and object bytes were not edited. No full
production build or project-linker regeneration was run by this subtask.
Root owns the registry/generator updates and final production/exhaustive gates.
The P881 credits ownership seam was not touched.

Exact before-file backups are in `ownership_backups/`. They include the four
raw originals and both linker inputs, captured before any edit.

## Typed source and oracle-only reservation metadata

All source sections are ordinary existing `.sdata`, with zero data relocations.
The five new raw files are `asm/data/sdata_<module>_legacy.sdata.s`; their
`.sdata` sections retain every original label, directive and byte in the owned
reservation. These files belong only to the src/oracle lane; reconstruction
selects the existing typed section through the native-order fragment.

| Module | Native base | Typed bytes | Oracle reservation | Following boundary |
|---|---|---:|---:|---|
| hudpmx | 8013c84c | 0x535 | 0x538 | 8013cd84 |
| copspeak | 8013d07c | 0x7e | 0x80 | 8013d0fc |
| nfs3 | 8013d270 | 0x58 | 0x58 | 8013d2c8 |
| r3dcar | 8013d324 | 0x9c | 0x9c | 8013d3c0 |
| sim | 8013d40c | 0x28 | 0x28 | 8013d434 |

Source payload SHA256 values (also in `ownership_window_receipts.json`):

```text
hudpmx  3351804d144ffcc98ae338b917cea61b12696514f5f521a41548423b16ec36af
copspeak 9916e2deea22d489a0ca65a78ff2ed67c7beb13ff564c1b52beea4cbe70767f1
nfs3    2d87c1156c33b9e238babab757c4501968dbe30f9d5b9a645429665ea21c068a
r3dcar  8e3a0d3cbd549fdabdaf42d3c37494688098efef57ecf6410d273f468b77c9ca
sim     58eec09fc902fa59a719ff705a371adb51f37cf5bd2342194f9ff25f778af04d
```

Padded oracle SHA256 values differ only for:

```text
hudpmx  1a420a5f66eefef0cbd25fe007c583c21e06046fc2ee2aa31761fa6c3e997e57
copspeak b2d7d035cf339742d810f03f3c17de317ffc1150d517396599cbd22209485f50
```

These are `placement='fragment'` owner entries for root's registry. They must
not also generate separate explicit output placements, which would select a
section twice or leave a reservation hole in the fragment.

## Padding is measured, not invented

Hudpmx's last literal is the existing `D_8013CD7C: .asciz "a229"`. Its zero
terminator ends the typed payload at8013cd81. The original following `.align 2`
produces **three zero bytes**, and `_6Speech_fgSpeech` begins at8013cd84.
That directive and padded raw span remain in the oracle-only file.

CopSpeak's final source field is the two-byte `CopSpeak_gStaticPatch`. The
original raw word at8013d0f8 includes its two zero bytes and **two zero alignment
bytes** before the next owner's8013d0fc boundary. The raw word is unchanged.

In the reconstruction lane the typed input sections remain0x535/0x7e bytes,
not artificially enlarged. The next `SUBALIGN(4)` input supplies exactly the
same gaps. The isolated strict recon map explicitly contains:

```text
*fill* 0x8013cd81 0x3
*fill* 0x8013d0fa 0x2
```

No odd-address residual input was created. The intermediate r09 residual
starts at aligned8013cd84, and the next input after CopSpeak is aligned8013d0fc.
No source padding variable, asm shim or binary patch was introduced.

## Residual files and ordering

* `sdata_8013C54C_r09.sdata.s` now retains the unchanged32-byte prefix
  [8013c82c,8013c84c).
* New `sdata_8013C54C_r09_between_hudpmx_copspeak.sdata.s` retains the unchanged
  [8013cd84,8013d07c) residual. The Speech-related data was not reconstructed
  or reassigned.
* r10 retains its original pre-New and New-legacy subsections. Its NFS3 tail
  moved intact to the separate oracle file; recon uses nfs3.cpp.o(.sdata).
* r13 retains the unchanged [8013d3c0,8013d3ec) rendering-state suffix.
* r15 retains the unchanged SimQueue-legacy and after-SimQueue subsections.
  Only the preceding40-byte Sim run moved to an oracle-only file.

Both supplied linker inputs preserve this order. The src ordering chooses
the five raw reservations; the recon fragment chooses the five typed sections.
The other five unproved omitted sections from the baseline audit—Textsys,
Track, snddata, AIH_Cop and Anim—were not altered.

## Completed isolated verification

`verify_owner_windows.py` runs ordinary GAS and strict GNU ld only into
`ownership_isolated/`, using the real typed objects read-only. It does not use
`--allow-multiple-definition`, `--no-check-sections` or `--noinhibit-exec`.

Three independently linked lanes were compared with merged raw retail:

1. Original raw backups.
2. New src/oracle pieces.
3. New recon typed replacements.

All three produce **2,692/2,692 exact bytes**, across four windows including
unchanged Fastrand/Object neighbors and existing New/SimQueue controls:

```text
8013c82c..8013d10c  0x8e0 bytes
8013d240..8013d2e0  0x0a0 bytes
8013d324..8013d3ec  0x0c8 bytes
8013d40c..8013d448  0x03c bytes
```

All checked neighbor addresses are exact, including Speech start8013cd84,
CopSpeak start8013d07c, New heap8013d26c, NFS3 start8013d270, R3DCar start8013d324,
render suffix8013d3c0, Sim start8013d40c and SimQueue ticker8013d434. Typed
input object hashes were unchanged during the tests.

`verify_owner_labels.py` additionally compares every exported raw label:
**406/406 src labels retain identical addresses**. All **200 shared recon
labels** retain identical addresses. Every label absent from recon is from
one of the deliberately excluded raw owner pieces; no residual label was
lost. Full label lists are in `ownership_label_receipts.json`.

`git diff --check` on the edited production files reported no errors; only
normal LF-to-CRLF informational warnings appeared.

## Handoff / limits

Files are ready for root's coordinated production assembly/regeneration/link.
Root has been given exact source sizes/hashes and padded oracle sizes and will
validate/exclude the five oracle pieces in the actual reconstruction input list.
The isolated data tests do not substitute for those final production gates,
the exhaustive after-target comparison, or complete source/SYM/SLD restoration.
The previous accounting-only fix's zero overflows was not misrepresented as
native ownership; these five transfers provide a separate byte/label/placement
proof. No commit or push was performed.
