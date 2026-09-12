# P903 peer review: SoundCar static and switch-table identity

Read-only review, 2026-09-12. Inputs are frozen `candidate_source.cpp`,
`candidate.json`, compiler debug assembly, existing normal before/candidate
objects, native SYM/CPE reports and the raw EXE. No builds, candidate edits,
link changes or production writes were performed. Only this receipt was added.

## cobbleCount

`C:/Temp/nfs4-clean/nfs4-f-v3.txt` record `192fe4`, inside
`AudioCmn_SoundCar__FP8Car_tObjiiiiiii` (`192e19`) root block (`192f38`), is
STAT CHAR, value `0x88`, primitive size field0, name `cobbleCount`.
The record is in the native audiocmn.obj record region (FILE `181fc9`).
Primitive size0 in this format does not mean zero storage; CHAR is one byte.

Native raw code accesses that byte through gp displacement `0x164`:
load `80078BCC`, stores `80078BD8` and `80078C10`. It performs the
increment/store and modulo/store separately, with byte truncation at each
store. Native SLD lines2052 and2053 distinguish the two statements.
The raw address is `8013C6B0`; the corresponding audiocmn small-data base
is `8013C628`, and `8013C628 + 0x88 == 8013C6B0`.

Direct reading of `rom/nfs4-f.exe` at offset `0x12CEB0` returned byte00.
The CPE-derived report `C:/Temp/nfs4-clean/nfs4_data.txt:1636` identifies
0803-CPE as one zero byte at `8013C6B0` in .sdata; 0804-CPE separately
contains three padding bytes at `8013C6B1`. The existing donor scaffold
`asm/data/sdata_8013C54C_r05.sdata.s` wraps all four bytes in a .word0;
that scaffold does not turn the source CHAR into INT.

Candidate source declares `static char cobbleCount = 0;` inside SoundCar.
Saved debug assembly reports `.def cobbleCount; .val cobbleCount.66;
.scl3; .type0x2` in its root block, and emits `.sdata`, label
`cobbleCount.66`, `.byte0`. The normal object symbol is LOCAL/NOTYPE,
.sdata+0x88, with symbol-table size0. Its actual one-byte extent is supported
by the compiler directive, CHAR debug type and CPE record, not by an invented
ELF OBJECT size. The `.66` suffix is a compiler-generated internal identity,
not an original source name.

This confirms name, function-local static storage class, primitive type,
initial byte, object-relative placement and owning function/TU. It does not
prove the current complete linker places the source static at the native VA.

## Native switch table: exactly 12 entries

Raw dispatch `80078B80..80078BA8` computes `roadSurface - 2`, checks that
index unsigned<12, and otherwise jumps to `80078C84`. The indexed load uses
table base `8005573C`; the indirect jump is at `80078BA4`.

The reviewer read all48 bytes directly from EXE offset `0x45F3C`. In index
order for source values2..13, targets are:

```text
2  -> 80078BAC    3  -> 80078C84    4  -> 80078BCC
5  -> 80078C84    6  -> 80078C84    7  -> 80078BCC
8  -> 80078C84    9  -> 80078C84   10  -> 80078BAC
11 -> 80078BAC   12  -> 80078BCC   13  -> 80078BAC
```

These agree with `asm/data/rdata_80054548_j06.rodata.s` and the candidate
source switch: values2/10/11/13 increase roadNoiseAmp by its signed quarter
and set roadNoiseFreq24; values4/7/12 run the cobble counter/playback block;
default values do neither and continue at `80078C84`.

Native SLD record `19029f` begins switch line2040 at `80078B80`;
`1902a5` begins case-body line2046 at `80078BAC`; `1902c1` begins the
cobble body line2052 at `80078BCC`. The compiler-generated table itself is
not an original named C declaration: `jtbl_8005573C` is the oracle label.

CPE0080 starts at `80055738` and spans52 bytes /13 words because it includes
one preceding zero word. That coarse CPE extent must not be confused with
the 12-entry table established by the raw indexed base and bounds check.

## Candidate table payload and remaining placement qualification

The candidate emits one SoundCar switch table in its compiler .rdata,
label `$L562`, aligned with `.align3`, containing12 local-label entries.
Its normal object uses .rodata+0x68..0x94, all R_MIPS_32 against .text.
SoundCar begins at .text+0x249c. Its three table addends are:

- 0x278c = SoundCar+0x2f0 -> native80078BAC.
- 0x2864 = SoundCar+0x3c8 -> native80078C84.
- 0x27ac = SoundCar+0x310 -> native80078BCC.

The complete .rodata hex dumps in `before` and `candidate` objects are
identical, including these addends and their12-entry order. Therefore this
source candidate does not introduce a table packing or target regression.

However, placing the whole object .rodata at the earlier literal base
`800556D0` would put offset0x68 at `80055738`, four bytes before the native
table. A target-specific table-fragment base would instead be `800556D4`;
that cannot simultaneously be used as the whole literal-section base.
The old donor comment claiming table offset0x50 belongs to an earlier
object state and is not the candidate's offset.

Existing `build/nfs4_recon.map` is dated2026-08-24, not a P903 candidate
link receipt. It shows audiocmn .rodata at `800556D0`, but source .sdata
at `8013DDE4` while the raw donor .sdata still occupies `8013C628` and
exports `D_8013C6B0`. This corroborates historical packing/owner placement
debt; it must not be presented as current source-backed native linking.
Parent separately handles the exact in-memory table-fragment relocation
and530-word code proof. No whole-linked-image exactness is claimed here.
