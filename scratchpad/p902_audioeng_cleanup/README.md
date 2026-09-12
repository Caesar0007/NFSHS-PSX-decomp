# P902 AudioEng_CleanUp: bounded original-source investigation

2026-09-12. **No production proposal retained.** The original `player` identifier
remains unproved; no alternate invented name, pointer alias, helper, macro,
qualifier, asm, tuning flag or compiler-output rewrite was introduced.
All matching work stayed inside this scratch directory.

## Fresh baseline and neutral paired probe

- Current actual source: SHA
  `188394fd5b6a6cbfce810d53fda5d2dd56c0b62a2852d618a036b164725defdc`.
- Fresh baseline: **9/9 PASS**, exact branch distances, Cleanup **56/56 raw
  words**, seven reference words exact.
- All four native lexical spans/depths and both local homes are **already exact**:
  native g record1b434d = AudioEng_t* / s2, size880;
  native i record1b4372 = int / s1.
- The outer source `player` variable has **no emitted debug declaration**.
  GCC strength-reduces its two-slot traversal to s3 advancing by4, while s5
  retains the table base. Those machine pointers do not establish another
  original pointer-variable name.
- Moving only the existing player declaration into the for initializer was
  tested as `player_for`. It preserves 9/9 PASS, every branch, the entire object,
  all four scopes, both native homes and the same SLD1/2. This is neutral and
  gives no original-name evidence, so it was reverted, not proposed.

The reverted private input text equals the frozen baseline after newline
decoding; patch rollback leaves only line-ending representation differences in
that private input. Production and its exact-byte backup remain unchanged.
`before_source.cpp` and `player_for_source.cpp` and both build/debug/raw receipts
remain frozen. No earlier failed index/source experiment was replayed.

## Exact remaining SLD conflict is one NOP

All current native SLD differences are caused by the load-delay NOP at
**8007C578**, instruction17:

- Native line711 owns only the preceding g load (index16).
- Native line713 owns the NOP plus null-test branch and delay slot (17,18,19).
- Current assembled debug line581 owns load+NOP (16,17), while line582 owns
  branch+slot (18,19): one false merge and two splits.
- The unchanged compiler `.g.s` **already puts `.loc 1 582; LM349:` before
  `#nop` and the null-test branch**. In the assembled debug object, LM349 is
  atC57C, after the inserted NOP. This is the same exact assembler/debug marker
  placement question seen in the separately recorded SoundTrack NOP cases.

`final_receipt.json` records the native SLD record, exact marker addresses and
three bad pairs. Do not modify source statement order or move output labels just
to hide this discrepancy. The next investigation for these pairs is authentic
assembler/debug attribution with unchanged compiler output, not a fabricated
source declaration or a claim of impossibility.

## Source-identity limit and useful next evidence

Native SYM records1b42e3..1b43a5 contain only g and i and establish:

| Block | Span | Depth |
|---|---|---:|
| 1b4332 | 8007C534..8007C5F0 | 0 |
| 1b433b | 8007C534..8007C5F0 | 1 |
| 1b4344, g | 8007C564..8007C5D0 | 2 |
| 1b4369, i | 8007C584..8007C5D0 | 3 |

The raw loop walks two AudioEng_g pointer slots, breaks on the first null,
conditionally stops left then right handles, frees tables and g, then clears the
same slot. The split M2C body agrees and exposes its mechanical s3/s0 induction
pointers, but supplies no original outer-loop name.

The inspected PC twin `nfs4-pc.c` sub_430130 (line51652; locator from pcmap) takes
one explicit player argument; callers invoke it separately for0 and1. It also
contains PC-only callback/table cleanup. It supports per-player teardown logic,
**not** an original PSX loop-variable spelling. Searches of the NFS2 matched
source and nfs2-v1.txt found no AudioEng_CleanUp counterpart to transfer a name.

A player-to-i rename would merely reuse a known spelling for a different,
unrecorded declaration and is not a recovery. Likewise an explicit table-current
pointer would add another unproved name. What is needed is an actual source or
macro definition for **AUDIOENG.CPP line709's outer traversal** (and line730's
back edge), or a related debug build retaining its source induction name.
The optimized native record list alone cannot distinguish the two measured
declaration placements; neither proves that player was original or absent.

`receipt.py` rechecks the frozen inputs, scope/SLD evidence and full object/raw
receipts. It changes only `final_receipt.json`. Current exact code is preserved;
the original-source identity remains a specific open question, not a floor.
