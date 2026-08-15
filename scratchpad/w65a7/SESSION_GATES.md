# W65-A7 — THE LINK LANE'S ACCEPTANCE SHEET (session end)

All numbers measured by me on `C:\Temp\nfs4-decomp`, 2026-08-15. `build/**`
churned continuously under peers (A5's jump-table cut landed mid-session and a
peer left the tree in a `--skip-asm` state at the end); each row records the
tree state it was taken on.

---

## 1. `tools/relink.py` — THE SYMBOL GATE  (run 2x, identical)

| lane | objects | DUP total | DUP blob-class | **DUP REAL** | **HIDDEN PHANTOMS** | UNRESOLVED (reloc) | benign (symtab-only) |
|---|---|---|---|---|---|---|---|
| recon | 741 | 796 | 796 | **0** ✅ | **2** ❌ | 66 | 0 |
| src | 694 | 5 | 0 | **5** ❌ | **0** ✅ | 202 | 3486 |

* excluded subtrees, printed every run and never assumed:
  `diffsrc=111  scratch=26  scratchpad=4  pbuild=0`.
* **GATE: RED — 7 blocking rows**, all pre-existing, none in my scope:
  * recon, 2 hidden phantoms — `DAT_80134a6c` / `DAT_8013bd50` are referenced
    under the `DAT_` spelling but DEFINED at the same VA as `D_80134A6C` /
    `D_8013BD50`. Exactly the class a VA-keyed check calls "frontier". Two of
    the 7 `DAT_` names W64-A19 §3.2 already listed as data-mat debt, and also
    seal-criterion #3 violations (a Ghidra-ism left in code). Fix = one rename
    at each reference site (owner: A6 / the owning belts).
  * src, 5 REAL duplicates — the RETAIL-STATIC-COPY class, full spec in
    `RECEIPTS.md` §3.2 (owner: A5/A6, asm lane).
* Re-run after the final peer landing gave recon 680 objects / DUP REAL 0 /
  PHANTOMS 2 / UNRESOLVED 71 — the churn moves the object count and the
  frontier by a few, never the two gating classes.

## 2. `tools/probe_link.py` — THE LAYOUT PROBE  (run 2x)

| run | placed | dropped (interleaved) | no-base | bytes compared | identical | % | byte-EXACT objects |
|---|---|---|---|---|---|---|---|
| 1 | 442 | 18 | 10 | 920108 | 764304 | **83.07 %** | **202 / 442** |
| 2 | 442 | 18 | 10 | 920108 | 764355 | **83.07 %** | **202 / 442** |

Briefed 83.29 % (W64). The 0.2 % delta is peer churn inside the same session,
not a regression: the two back-to-back runs differ by 51 bytes with the object
set moving under them. `exact_objs = 202` reproduces 16E's "202 byte-exact"
exactly. Linked `.text` image 1024996 B spanning 0x800128F0..0x8010CCD4.

## 3. `tools/tu_order_audit.py` — INTRA-TU ORDER

```
508 objects audited, 0 inversions
(5 multi-VA names excluded: VoxEvent_GetFilterLengthFlag
 VoxSentence_GetNumPhrases _bzero_w iSPCH_GetOffset16 iSPCH_GetOffset8)
```
**GREEN.** Note the 5 excluded names are precisely the src lane's 5 REAL
duplicates (§1) — the same retail-static-copy population seen from the other
side.

## 4. `tools/ownmap.py` — DATA OWNERSHIP

🔴 **It was UNRUNNABLE at HEAD** (`ModuleNotFoundError: No module named
'vamap'` on the first line of work) — three promotion defects, all repaired
this session (see `RECEIPTS.md` §4.3 / catalog 16F). After the repair:

```
python tools/ownmap.py --blob asm/data/tail.data.s --end 0x8013E000 ...
  blob labels inside owned windows: 0
  E3 intra-TU drift 2 | E1 un-migrated inside 1 | E2 own label outside 1
  E4 0 | E5 0 | E5? 0
```
`tools/vamap.py` (promoted) builds **6794** names — 4740 from
`symbol_addrs.txt` + the asm dlabels — matching 16E's "6788-name VA map".

⚠️ **The ownership axis has no monolithic input left.** All three data regions
plus BOTH rodata blobs are now cut (`asm/data/*.s` = 232 files; the only
un-sliced ones are `bss`, `sbss`, `front_bss`, `tail`, `sn_lnk_blobs`, none of
which carry an ownership question). ownmap's `--blob` contract is "a PRE-SPLIT
blob", so as a standing gate it is now only meaningful on a residual `_rNN`
piece or on the next region someone decides to re-cut.

## 5. `linkers/nfs4.ld` — THE SRC-LANE LINK

| tree state | control (`*(*)`) | landed (W65-A7) |
|---|---|---|
| before A5's blob re-cut (137 asm objs) | 1985 lines / 1975 discarded | **14 lines** |
| after A5's blob re-cut (233 asm objs) | 1985 lines / 1975 discarded | **14 lines** |

Reproduced across two independent tree states. `-G` overflow 1→0, GPREL16
truncations 18→0, "defined in discarded section" 1975→0. Residual 14 lines =
2 undefined + 5 REAL duplicates (§1, specs in `RECEIPTS.md` §3).

🔴 **A third measurement is NOT possible on the tree as I leave it:** a peer
ran `build.py --skip-asm`, so **0 of 461** `build/src/*.o` carry any `.text`.
Both `srclink.py` and `tools/relink.py --lane src` now REFUSE rather than
report the resulting ~1000 phantom undefined `.L<VA>` labels. To re-measure:
`python tools/build.py --no-link && python scratchpad/w65a7/srclink.py linkers/nfs4.ld check`.

## 6. GATE SUMMARY

| gate | state | blocking rows |
|---|---|---|
| `relink.py` recon | RED | 2 hidden phantoms (`DAT_` vs `D_` spelling) |
| `relink.py` src | RED | 5 REAL dups (retail static copies) |
| `probe_link.py` | 83.07 %, 202/442 exact | — (tracked, no floor set yet) |
| `tu_order_audit.py` | GREEN | 0 |
| `ownmap.py` | RUNNABLE (was broken) | no monolithic blob left to audit |
| `nfs4.ld` src link | 14 lines (was 1985) | the same 7 rows as above |

Every blocking row is pre-existing, outside `linkers/`+`tools/`, and carries an
exact recipe in `RECEIPTS.md` §3.
