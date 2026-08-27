# tGlobalMenuDefs `-G0 -g` allocator receipt (2026-08-27)

## Scope and baseline

- Worktree: `C:\Temp\nfs4-frontend-common-sourcepass`
- Source checkpoint before this diagnostic round: `3b221645`
- Function: `__15tGlobalMenuDefs`
- Authoritative production gate, rebuilt twice:
  - `FAIL 1875 diffs`
  - ours `3208` instructions, oracle `3207`
  - ours frame `616`, retail frame `640`
- No tracked source or build-system modification was made in this round.

## Full-debug compiler-identity evidence

The real PsyQ `CC1PLPSX.EXE` was run on the exact preprocessed TU with:

```text
-quiet -O2 -G0 -g -da
```

This basin reproduces two independent retail SYM facts simultaneously:

- frame size `640`
- exactly `105` lexical block starts and `105` block ends

The current source already has the retail 105-block geometry after the
constructor-tail inline helper reconstruction and removal of the eight
artificial statement-expression blocks.  Therefore full debug information is
a serious candidate for the authentic TU compiler setting, not a cosmetic
frame filler.  It is not yet landable: the full-debug instruction gate remains
worse than the production no-debug checkpoint and still needs source-shape
reconstruction.

Generated evidence files (untracked):

- `scratchpad/globalmenu_g0_da.s`
- `scratchpad/globalmenu_g0.i.lreg`
- `scratchpad/globalmenu_g0.i.greg`
- the other `scratchpad/globalmenu_g0.i.*` GCC pass dumps

## Earliest persistent-pointer allocation inversion

The fresh `-G0 -g` `.lreg` dump identifies the two relevant pseudos:

| pseudo | source value | refs | live | calls | current home |
|---|---|---:|---:|---:|---|
| `p573` | `this + 8408` = `&menuCarOptions` | 6 | 134 | 14 | `$fp` |
| `p586` | `this + 4840` = `&itemGarageCar` | 4 | 108 | 11 | spilled |

Retail does the inverse in the first divergent constructor window: it keeps
`itemGarageCar` in `$fp` and spills/reloads `menuCarOptions`.  This accounts for
the missing retail spill and the one-instruction count deficit in the full-
debug basin.

`tools/allocsim.py` reproduced the real allocation order (`96/102`, with the
six known local-allocation eviction mismatches outside this pair).  The model
matches the current homes of both target pseudos.

`tools/reqdelta.py` was then asked for:

```text
p573=spill, p586=fp
```

Minimal single-dial solutions:

```text
p586 refs   4 -> 5      (best: +1 source reference)
p573 refs   6 -> 4      (-2 source references)
p586 live 108 -> 89     (-19 live length)
p573 live 134 -> 163    (+29 live length)
```

The narrowest next source-level angle is therefore one genuine, zero-block,
zero-instruction reference to `itemGarageCar`, or an authentic source shape
that naturally creates that fifth reference.  It must preserve the exact
105-block SYM geometry.  The old statement-expression/read-only-asm devices
did increase references, but they were removed because they were SYM-invalid
or introduced a volatile scheduling barrier.  Do not restore those diagnostic
devices as a landing.

## Falsified in this basin

- Explicit `tMenuItem *` casts on the `itemGarageCar` arguments: neutral.
- Removing explicit `tMenu *` casts from the five `menuCarOptions` uses:
  neutral.
- Comma-duplicated address expressions: optimized to byte-identical output.
- Placement-new conversion of all constructor members: catastrophic block and
  instruction growth; rejects the source hypothesis.
- Adding a new anonymous statement-expression block can recover frame 640 in
  some no-fence diagnostic cells, but makes the block count 106 and is therefore
  strictly SYM-invalid.

## Next action

Search for the source-authentic fifth `itemGarageCar` reference without a new
lexical block or emitted instruction.  Gate candidates under `-G0 -g` first,
then re-evaluate whether the full-debug TU setting plus the corrected source
beats the production checkpoint.  Do not edit `tools/build.py` until a complete
whole-TU/compiler-setting receipt is available.
