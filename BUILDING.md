# Building `NFS4.EXE` and `FRONT.BIN`

How to go from this repository's source to the two executable files on the *Need for Speed: High Stakes* (PSX) disc,
and how to check that they are byte-identical to retail.

State on 2026-09-20: both files build **byte-identical to the retail disc** through Route A below.

| File | Size | sha1 (first 12) |
|---|---|---|
| `NFS4.EXE` | 1,239,040 bytes | `c5c60d450bac` |
| `FRONT.BIN` | 279,880 bytes | `d6c5b5d16e55` |

## What the two files are

The game is one program linked as three groups:

```
        org     $80010000
text    group                   ; .rdata .text .data .sdata  -> NFS4.EXE
bss     group   bss             ; .sbss .bss
front   group   over(text)      ; front.rdata front.text front.data front.bss -> FRONT.BIN
```

- **`FRONT.BIN`** is the front end (menus, car select, tournament, memory card). It is an **overlay**: raw bytes, no header,
  loaded at `0x80010000`, 0x44548 bytes long. The file includes the zeros of `front.bss`.
- **`NFS4.EXE`** is a PS-X EXE (0x800-byte header + load image from `0x80010000`, size `0x12E000`, entry
  `0x800E402C`). Its first 282,000 bytes of `.rdata` are **`bigBuf`**, a zero-filled reservation made by `bigbuf.obj`
  (`recon/frontend/psx/bigbuf.c`). The overlay is linked over that same address.
- At run time `nfs3.cpp` loads the overlay with `asyncloadfileat("front.bin", bigBuf)`. `address.obj`
  (`recon/frontend/psx/address.c`) holds the overlay's start and end address.
- The disc has no `SYSTEM.CNF`; the console boots `PSX.EXE`, which loads `cdrom:nfs4.exe`.

Change front-end code and only `FRONT.BIN` changes; change game code and only `NFS4.EXE` does.

`rom/nfs4-f.exe`, the file every gate compares against, is a **merge** of the two: `NFS4.EXE` with `FRONT.BIN` written
into the `bigBuf` hole. Cutting it at `0x80010000..0x80054548` gives exactly the two disc files.

## Prerequisites

Nothing copyrighted is in the repository. You supply:

| What | Where it goes | Notes |
|---|---|---|
| The merged target | `rom/nfs4-f.exe` | sha1 `b48ea3452e64…`. Needed by every comparison, not by the build itself. |
| The retail link map | `rom/NFS4.MAP` | From the disc. The linker-script generator reads symbol addresses from it. |
| The retail symbol file | `rom/NFS4.SYM` | From the disc, 7,881,225 bytes. Only the comparison tools and Route B need it; `tools/retail_sym.py` dumps it to `build/sym/nfs4-f-v3.txt` with the vendored `tools/dumpsym/dumpsym.exe` on first use. |
| PsyQ 4.3 compilers | `C:/Temp/psq43/COMPILER/CC1PSX.EXE`, `CC1PLPSX.EXE` | The real SN compilers (GNU C 2.8.0). Override with `NFS4_CC1`, `NFS4_CC1PL`. |
| PsyQ 4.0 `CC1PSX` | next to `CC1PSX.EXE` as `CC1PSX272.EXE` | gcc 2.7.2 lane used by some Sony library files. Without it those files fall back with a warning. |
| PsyQ 4.4 `CC1PLPSX` | next to `CC1PSX.EXE` as `CC1PLPSX44.EXE` | One per-function splice (`Night_CreateNightTableElement`). |
| PsyQ 4.3 libraries, extracted | `C:/Temp/nfs4-clean/psyq43/extracted/` | Made once from the SDK's `PSX/LIB` folder with `python tools/psyq_extract.py [LIBDIR [OUTDIR]]`: every library member as an `.obj`, every function as a `.bin`, plus `INDEX.tsv`. `tools/gen_ld.py` runs `tools/link_stripped_check.py`, which compares the link-stripped functions with these blobs. |
| MIPS binutils 2.43 | `C:/Tools/mips-ps1/mips/bin/` | `mipsel-none-elf-{cpp,as,ld,objcopy,objdump,nm}`. Override with `NFS4_MIPS_BIN`. |
| Python 3.12+ | | Standard library only for the build tools. |

`maspsx` (the ASPSX 2.77 stand-in that lets GNU `as` assemble the compiler output) is vendored in `tools/maspsx/`.
The exact toolchain zip layout CI expects is described at the top of `.github/workflows/report.yml`.

The source the build compiles is `recon/` (the reconstructed C and C++), plus the residual data pieces in `asm/data/`
and the PS-X EXE header `asm/header.s`. `src/` and `asm/nonmatchings/` belong to the older split lane and are not part
of this build.

## Route A — the byte-identical build

### One command

```bash
python tools/build_iso.py --no-iso
```

This compiles everything (strict: any failing file aborts), runs the production link, and cuts the two files into
`build/full_link/disc/`. Use `--skip-compile` to reuse the objects already in `build/`.

### Step by step

**1. Compile** every translation unit to an ELF object in `build/recon/…`:

```bash
python tools/build.py --skip-asm
```

Per file: `cpp` → `CC1PSX` / `CC1PLPSX` (`-O2`, per-file `-G`) → `maspsx` → GNU `as`. Per-file flags live in
`PER_TU_FLAGS` in `tools/build.py`. To rebuild only some files:

```bash
python tools/build.py --skip-asm --only game/common/stats,frontend/psx/psxfront
```

Set `NFS4_STRICT=1` to make a single failure abort; by default the build keeps going and lists failures at the end.

**2. Regenerate the linker script** — only when you added or removed a file, or changed where data lives:

```bash
python tools/gen_ld.py --link
```

`linkers/nfs4_recon.ld` is generated and committed; do not edit it by hand. It places every object's sections at their
retail addresses. Inputs you may need to touch when data moves between files:
`linkers/nfs4_recon.data_extra.json`, `nfs4_recon.bss_extra.json`, `nfs4_recon.rodata_extra.json`, the
`*.ldfrag` files, and `linkers/link_stripped.json` (functions retail's link removed as unreferenced).
`--link` also links a measurement ELF to `build/gen_ld/recon_multdef-ok.elf` and writes
`build/gen_ld/genld_report.txt`; check that it says `DROPPED (interleaved) : 0`.

**3. Production link** and whole-image compare:

```bash
python tools/full_link.py
```

Links the 749 recon-lane objects with `linkers/nfs4_recon.ld` into `build/full_link/full.elf` and compares the load
image with `rom/nfs4-f.exe`. Expected last lines: `covered words 309036  identical 309036  (100.000%)  diff words 0`.

**4. Cut the two disc files:**

```bash
python tools/elf_to_exe.py --split
```

Writes `build/full_link/nfs4.exe` (the merged image) and `build/full_link/disc/NFS4.EXE` + `FRONT.BIN`, and compares
all three with retail:

```
[split] …\disc\NFS4.EXE   1239040 bytes  sha1 c5c60d450bac == retail disc
[split] …\disc\FRONT.BIN   279880 bytes  sha1 d6c5b5d16e55 == retail disc
[cmp] MATCH (byte-identical)
```

`elf_to_exe.py` does not use `objcopy -O binary`: the header sits at load address 0 and the code at `0x8001xxxx`, so a
flat binary would span 2 GB. It takes the 0x800-byte header from the ELF's own `.header` section (assembled from
`asm/header.s`) and copies every loadable section to its address; where sections overlap, the later one wins — which is
how the overlay ends up over `bigBuf`, exactly as in the retail EXE. It also warns if a `.text` section has grown past
its slot (an edit that costs an instruction silently loses its tail to the next object otherwise).

It can also cut any other ELF, for example the measurement link:

```bash
python tools/elf_to_exe.py build/gen_ld/recon_multdef-ok.elf build/full_link/nfs4.exe --split
```

### Checks to run after a change

```bash
python tools/honest_measure.py
```

Prints the honest match (`299710/299710 = 100.000% (0 diff words)` today) plus two guards: `OVERLAP AUDIT` (a
reconstructed byte hidden behind an overlapping retail blob) and `FOREIGN LABELS` (a reconstructed object covering a
retail label it does not define, or data with no retail address). All three must be clean.

```bash
python tools/relink.py --lane recon
```

The standing link gate: real duplicate definitions and hidden phantoms must be 0 (`GATE: GREEN`).

Pitfall: both links use whatever objects are in `build/`. After reverting a source file, rebuild it before linking, or a
stale object shows up as diff words.

### A bootable disc image

`tools/build_iso.py` without `--no-iso` also stages the two files into an extracted disc tree and rebuilds the image
with `mkpsxiso` (`tools/psxiso/`). One-time setup — extract your own disc image:

```bash
tools/psxiso/dumpsxiso.exe -x "build/cd/Need For Speed 4 v9.0" -s "build/cd/Need For Speed 4 v9.0.xml" path/to/NFS4.bin
```

Then:

```bash
python tools/build_iso.py
```

The retail `NFS4.EXE` / `FRONT.BIN` are saved once to `build/cd/orig/`; `--restore` puts them back. The script reads the
finished image back and confirms both files are really on it. `--name` changes the disc folder / XML base name.

## Route B — the original SN tools (PSYLINK + CPE2X)

This route uses the retail assembler and linker themselves. It produces both files natively, but it is **not
byte-identical yet**; it exists to measure layout and to compare our `.SYM` with retail's.

Extra prerequisites: `C:/Temp/psq43/PSSN/ASPSX.EXE` (2.77) and `PSYLINK.EXE` (2.73), Sony's `CPE2X.EXE`
(`C:/Temp/psq43/PSX/BIN/`, a 16-bit DOS program — it runs under the vendored `tools/msdos-player/msdos.exe`), and the
retail `rom/NFS4.SYM` (its dump gives the link order; `tools/dumpsym/` and `tools/retail_sym.py` handle it).

```bash
python tools/build.py --skip-asm
```

```bash
python tools/gen_ld.py --link
```

```bash
python tools/psyq_pipe/psylink_lane.py
```

```bash
python tools/psyq_pipe/psylink_disc.py
```

- `psylink_lane.py` takes the compiler output (`build/**/*.s`), assembles every file with ASPSX 2.77, and links with
  PSYLINK in the **retail link order** (the order of the FILE records in `NFS4.SYM`), writing
  `build/psyq/nfs4.{cpe,sym,map}`. Today: 518 of 518 files assemble, 0 link errors, no drift point inside any section.
- `psylink_disc.py` adds two lines to that link script and relinks:

  ```
          regs    pc=__SN_ENTRY_POINT
  front   group   over(text),file("front.bin")
  ```

  `file()` makes PSYLINK write the overlay group to its own raw file and leave it out of the CPE; `CPE2X /CA` then turns
  the CPE into `NFS4.EXE`. Output: `build/psyq/disc/NFS4.EXE` and `FRONT.BIN`.

Where it stands: `NFS4.EXE` has the retail size and an identical header except the entry point (`0x800E3E1C` against
`0x800E402C`); the `bigBuf` hole is all zeros like retail; `FRONT.BIN` is 0x98 bytes short.

### Why Route B is not byte-identical

The SN linker lays every section out object by object in link order and cannot pin an object to an address, so any byte
an object gains or loses shifts everything after it. `python tools/psyq_pipe/layout_delta.py` shows where that happens,
using every retail label (libraries included) and the honest link map. Section sizes, ours against retail (2026-09-21):
`.rdata` -532, `.text` +432, `.data` -48, `.sdata` -28, `.sbss` +64, `.bss` -156, `front.rdata` -128, `front.text` 0,
`front.data` 0, `front.bss` -24. The game code itself has **no** size difference: `front.text` is exact and the game part
of `.text` has no change point. The differences are:

1. **Sony's library code is not ASPSX 2.77 output (about +810 bytes of `.text`).** EA linked Sony's prebuilt `LIB*.LIB`
   members; Route B recompiles our reconstructions of them and assembles them with ASPSX 2.77. Those objects were built
   by Sony with gcc 2.7.2 and an assembler that fills branch delay slots by reordering; ASPSX 2.77 never reorders and
   pads each unfilled slot with a `nop`. Route A reproduces them with GNU `as` in reorder mode (the `cc1_272` lane in
   `tools/build.py`); real ASPSX 2.77 cannot. Typical: +16..+24 per function in libmcrd, +72 in `StCdInterrupt`, +44 in
   libgpu `SYS` and libetc `INTR`.
   Swapping the assembler version does not help: `python tools/psyq_pipe/aspsx_ladder.py` assembles the same gcc 2.7.2
   output with every real ASPSX on this machine, and 2.34, 2.56, 2.77 and 2.79 all produce the **same** code, larger than
   the retail-identical GNU-assembled object by the same amount (libetc `INTR` +44, libcd `C_011` +72, libgpu `SYS` +56,
   libpad `PADMAIN` +48, libcd `BIOS` +156, `LIBMCRD` +164 bytes). ASPSX has no reorder mode at all; Sony did not build
   these objects with it. The compiler side is already gcc 2.7.2 (PsyQ 4.0 `CC1PSX`) per file in both routes.
2. **Sony's objects round every section up to 16 bytes (about -380 bytes of `.text`, more in `.data` / `.bss`).** In the
   SDK objects every section size is a multiple of 16 (`SPRINTF.obj` `.text` 0x890, ours 0x888; `FONT.obj` `.bss`
   0x4410, ours 0x4404), so retail has 8 or 12 pad bytes after each small library function (`SetPolyF4`, `SetFogNear`,
   `__gtdf2` ...). Our objects do not carry that padding. `tools/psyq_pipe/obj_align.py` prints it per object.
3. **Read-only data no source owns yet (-532 in `.rdata`, -128 in `front.rdata`).** The residual blob pieces: literal
   strings and pads between objects' read-only data, including the unreferenced `"SimpleMem"` tag at the head of 55
   objects. Route A fills them with retail bytes; Route B has nothing to put there.
4. **Small-data ordering (`.sbss` +64, `.bss` -156).** The linker allocates uninitialised globals per symbol; several
   EA library files (`primate`, `locatbig`, `unbtree` / `stream`) come out in a different order, some variables land in
   `.sbss` where retail has them in `.bss`, and Sony's `.bss` sections carry the same 16-byte rounding as above.
5. **Dead stripping.** Retail's link removed unreferenced functions; stock PSYLINK 2.73 / 2.74 does not. The lane models
   it by not assembling the functions tagged `LINK_STRIPPED`. Linking Sony's own library members instead of our
   reconstructions would solve points 1 and 2 at once but bring the unstripped functions back, so an exact Route B needs
   the linker EA actually used. That linker is now identified (SN's SLINK) and tested: see Route C.

The modules that still have no source file (`sdasync`, `unitvect`, `textsubs`, `hypot3d`, `hypot`) are **not** a cause:
all their functions were stripped, so they add no text.

A lane bug was found and fixed by this analysis on 2026-09-21: a directive with a trailing comment
(`.text # maspsx-keep`, used by the certificate blocks) was not recognised after a `LINK_STRIPPED` function, which
dropped libgpu `FntFlush` (796 bytes) from the native link.

The original retail `NFS4.CPE` confirms this is how EA built it: one register record `pc = 0x800E402C`, a first load
chunk of exactly 282,000 bytes at `0x80010000` (`bigbuf.obj`), and no overlay bytes in the CPE at all.

A full-debug variant of this lane (compiler `-g`, ASPSX `-g`) emits a complete `.SYM` from our source for comparison
with retail's; see `sym-match.md`.

## Route C — the way the original was linked (SLINK + Sony's prebuilt libraries)

A test lane that links the project the way EA's makefile did. It is the answer to "what is the official way to build
this": with it, **`.text`, `front.text` and `front.data` come out at exactly the retail size, every one of the 3,167
functions both maps name is identical to retail's, and the linker removes the same dead functions retail removed.**

What the original build was (each point is measured, 2026-09-21):

- **Compile**: `ccpsx -O2 -g` per file = cc1 / cc1plus + ASPSX, as in Route B.
- **Linker: SN's SLINK, not PSYLINK.** The retail `NFS4.MAP` is in slink's map format (no `Program entry point` line,
  one space between address and name; PSYLINK writes both differently). SLINK is "the new SN linker" of 1998/99; SN
  shipped Beta 3.0 (1999-01-05, six weeks before the retail link of 1999-02-22) on the PsyQ 4.4 CD as
  `pssn/Slink/slink3b.zip`, manual included. It needs `.ctors` / `.dtors` sections in the script, which is where the
  `__ctors_*`, `__dtors_*` and `_front_ctors_*` symbols in the retail MAP come from.
- **`/strip`** = "strip dead code based on static coverage": slink removes every function nothing reaches from the entry
  point, libraries included (EA did not pass `/nostriplib`). This is the dead stripping Routes A and B model by hand with
  `LINK_STRIPPED`. Sony's startup object has to be protected, exactly as the slink manual says (`-nostrip stup1`);
  without it slink removes `stup1`, `main` and half the game.
- **Sony's libraries prebuilt**: `inclib` of the PsyQ **4.3** `LIB*.LIB` files plus `2MBYTE.OBJ` — except **`LIBCD.LIB`,
  which is the PsyQ 4.4 one** (retail `CdRead` is 39 words longer than 4.3's; with the 4.4 libcd every Sony function
  matches, with all-4.4 or all-4.5 libraries 43 / 50 functions differ).
- **None of our reconstructed Sony code (`recon/syslib`) is linked.** The lane drops all 174 of those objects and
  asserts that none is left; every Sony function in the output comes from Sony's own `LIB` files. Of the 38 address
  equates the PSYLINK lane needs, only 24 remain (game data labels no source owns yet); the other 14 were holes inside
  Sony's data, which Sony's libraries now define themselves.
- **EA's own libraries** (`eacpsxz`, `sndpsxz`, `spchpsxz`) were `.lib` files too, pulled on demand. The lane packs ours
  with SN's librarian (`PSYLIB2 /a`) under the retail member names.
- **The overlay objects are prefixed by the linker, not by the assembler**: `include x.obj,front` in the script. slink then
  renames their sections to `front.*` and puts their uninitialised globals into `front.bss` with its own layout (exact that
  way; a hand-made layout was 24 bytes short). The retail MAP's section symbols give EA's whole section list, which the
  lane's script mirrors: `.rdata .text .data .sdata .ctors .dtors textpsx.text textpsx.rdata textpsx.data textpsx.sdata`
  in `text`, `.sbss .bss` in `bss`, a `last` group with `.last` (its `__last_obj` is the start of free memory), and
  `front.rdata front.text front.data front.sdata front.sbss front.bss front.ctors front.dtors` in `front`.
- **The front-end overlay sections are declared with 8-byte alignment** (`section.8 front.text,front` ...): slink then
  aligns every object's chunk to 8, which is the 4-byte pad after every front-end object that no assembler produced.

```bash
NFS4_LANE_OFFICIAL=1 NFS4_LANE_OUT=build/psyq_off python tools/psyq_pipe/psylink_lane.py --assemble --link
```

```bash
python tools/psyq_pipe/slink_lane.py
```

The first command assembles the objects as the original build had them: functions tagged `LINK_STRIPPED` are **kept**
(the linker has to remove them, not us) and no retail-derived pads are added. The second builds the three EA libraries,
writes `build/psyq_off/off.lnk`, runs slink and reports. Result:

| section | ours | retail | |
|---|---|---|---|
| `.text` | 0xB5358 | 0xB5358 | **exact** |
| `front.text` | 0x3E970 | 0x3E970 | **exact** |
| `.rdata` | 0x4797C | 0x4797C | **exact** |
| `front.rdata` | 0x28F0 | 0x28F0 | **exact** |
| `.data` | 0x2F878 | 0x2F878 | **exact** |
| `front.data` | 0x18D8 | 0x18D8 | **exact** |
| `.sbss` | 0x164 | 0x164 | **exact** |
| `.sdata` | 0x1830 | 0x1830 | **exact** |
| `.bss` | 0xAC28 | 0xAC24 | +4 |
| `front.bss` | 0x1A10 | 0x1A10 | **exact** |

(2026-09-21, after the data-ownership pass. Before it: `.rdata` -468, `front.rdata` -128, `.data` -84, `.sdata` -44,
`.sbss` +28, `.bss` -36. With `.rdata` exact, `.text` starts at the retail address and 2,183 of the 3,167 functions are
byte-identical outright; after the pull-order work 2,848 are, and the main image behind the overlay differs from retail in
947 bytes of 956,468 (`FRONT.BIN`: 29 of 279,880) -- addresses of `.bss` variables, which is still 4 bytes too big.)

What the pass found -- every item was something Route A's address-pinned placement had been hiding:

- The unreferenced 12-byte `"SimpleMem"` literal opens the read-only data of **118** retail objects. Which ones is a fact
  the retail SYM records: it keeps each object's block of type definitions, and an object has the tag exactly when that
  block contains the track / Group header family (`Trk_NewSimQuad`) or the `SimpleMem` class -- 35 overlay + 83 main
  objects, 1:1 with the 35 + 83 tags in link order (`sym_saw_type.py`, `sym_tag_header.py`, `simplemem_bysym.py`).
- Wrong storage class: `identitymatrix` and `coef` (matrix.c) were `const` but live in retail `.data`; seven EA library
  globals (`tickset`, `tickval`, `joy_inited`, `g_currentthread`, `systemtasklock`, `lastsystemtasktick`, `gFileOpSeq`)
  live in retail `.sdata`, i.e. were written `= 0` -- ours were tentative definitions whose `.sbss` the linker fragments
  steered into the `.sdata` range.
- Tables one entry short, the last entry supplied by filler bytes: `coef[10]`, `asintbl[513]`, `fatantbl[258]`.
- Unreferenced literals with an owner by link order: `"install.psx"` (paths.obj), `"%c"` (textcrnt.obj).
- Phantom literals our sources claimed but retail has once: `"%s%s.viv"` (Feaudio.obj's, not fecars'), `"unpacked"`
  (FETexture.obj's, not PSXFront's) -- identical bytes had overlapped in Route A.
- Lane: only `.text.strip` functions are kept for slink to remove (`.rodata.strip` / `.bss.strip` are data retail never
  had); `.comm` / `.lcomm` go to ASPSX and the linker untouched.

Reports: `slink_datadiff.py` (section contents aligned against retail, addresses masked), `slink_labels.py LO HI`,
`ro_view.py LO HI`, `unowned_data.py`.

- `/strip` removed 82 functions (7,944 bytes; without `/strip` `.text` is exactly that much too big). 76 are on our
  hand-made list `linkers/link_stripped.json`; the other 6 (`StopCallback`, `RestartCallback`, `GetIntrMask`,
  `CdReadBreak`, `CdReadCallback`, `CdReadMode`) are absent from the retail MAP as well — retail removed them too, we
  never listed them because our reconstruction never contained them. Nothing retail keeps is removed.
- `python tools/psyq_pipe/slink_bytes.py off`: 3,167 functions compared, all identical to retail apart from the
  addresses they contain (4 are reported only because a neighbouring library member sits elsewhere).
- `python tools/psyq_pipe/slink_order.py off`: slink pulls the library members **on demand in retail's order** -- all 460
  objects with code are in the same relative order, including the way Sony's and EA's members interleave.
  How the order comes about (`slink_pullsim.py` models it, `slink_pullsolve.py` searches it): slink pulls BEFORE it strips;
  unresolved names are served in the order they are met -- objects in script order, inside an object ASPSX's reference-record
  order, which is its symbol-HASH order (names in one hash chain come out in first-use order); a pulled member's own
  references join the end of the queue. That makes the retail order evidence about the objects themselves:
  - a member retail has EARLIER than we do was asked for by a function the final link later removed. Five such references
    are in the sources as `LINK_STRIPPED` stubs (name and body not retained): audiomus -> `iSNDstreamcreate`,
    mathnfs -> `fixedatan`, quatern -> `intsin`, font -> `puti`, async -> `addexit`;
  - a member pair in the "wrong" order means a function filed under the wrong member: `initmemadr` is meminit.obj's (not
    inittmr's), the mutex pool is threads.obj's (not callback's), `iSNDcalcvol`..`iSNDstartvoice` open slib.obj (not
    spatkey's), `iSNDplatformfxmasterlevel` closes sdfx.obj (not sfxlevel's); and MathNfs.obj asks for `fixedinverse`, the
    other exported name of `rinverse`;
  - the members the final link left no code of are in the link as well, and the pull order gives their dependency chain:
    sbremove -> sdasync -> sdmemman, sdma; matrix -> unitvect -> hypot3d -> hypot; window -> pageflip -> vsync;
    textfor -> textsubs; meminit -> libc `C52.obj` (`free`). `iSNDplatformfree` turned out to be sdasync.obj's one surviving
    function (it had been filed under sdata.obj, which is data only). The new members and the asker stubs are
    `LINK_STRIPPED`; their function names and bodies are inferred and say so -- the reference chain is the evidence.
  Result: all 337 library members enter the link, in retail's order; 460 of 460 objects with code are in retail's order and
  the `.text` function order is identical to the retail MAP.
- `python tools/psyq_pipe/slink_delta.py off`: where a section's layout drifts, step by step with the owning object.

So Route C is not byte-identical yet either, but for a different reason than Route B: the link recipe is right, the
code is exact and seven of the ten sections have the retail size; what is left is the library member pull order, the
modules without a source, and the uninitialised-data layout of the overlay objects. Points 1, 2 and 5 of the Route B list disappear.

Not vendored (SN's / Sony's copyright): `slink.exe` (the lane unpacks it from `C:/Temp/psq44/pssn/Slink/slink3b.zip`),
`PSYLIB2.EXE`, and the SDK libraries.

## Where things end up

| Path | What |
|---|---|
| `build/recon/**/*.o` | compiled objects (`.i`, `.s` next to them) |
| `build/asm/**` | assembled header and residual data pieces |
| `linkers/nfs4_recon.ld` | generated placement script (committed) |
| `build/gen_ld/recon_multdef-ok.elf`, `.map` | measurement link used by `honest_measure.py` and the guards |
| `build/full_link/full.elf` | production link |
| `build/full_link/nfs4.exe` | merged image, equals `rom/nfs4-f.exe` |
| `build/full_link/disc/NFS4.EXE`, `FRONT.BIN` | **the two disc files** |
| `build/cd/<name>.bin`, `.cue` | rebuilt disc image |
| `build/psyq/`, `build/psyq/disc/` | Route B outputs |
