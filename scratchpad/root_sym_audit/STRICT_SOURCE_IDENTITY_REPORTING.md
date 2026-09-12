# Strict source-identity review reports

P914 adds an opt-in mode to the tracked, read-only declaration auditor:

```powershell
python scratchpad/root_sym_audit/audit_sym_source.py recon/game/psx --strict-native-bool --strict-source-identities --output scratchpad/review_game_psx.md
```

Use this mode when reviewing original-source identity. A matching compiler result
does not prove that a reconstructed temporary, split global or name existed in
the original source. The legacy default remains available for compatibility;
its declaration-clean count excludes certain documented matching carriers.

Strict mode no longer suppresses:

- Missing native locals annotated only `SYM-CARRIER`.
- Extra locals annotated `SYM-CODEGEN-CARRIER`, including unknown register-asm
  locals that the old classifier treated as codegen carriers.
- Extra source-only globals annotated `SYM-GLOBAL-CARRIER`.
- Missing native aggregates and extra scalar components hidden by split-array
  carrier annotations.
- Same-name scalar/array type mismatches accepted only as matching carriers.

The annotations remain observable in the report, but do not establish original
identity. No source is renamed or automatically rewritten by the auditor.

## Boundaries

`SYM-OPTIMIZED`, explicit inline/macro recovery, ABI, canonical-source, compact
static, host-only, shared-common and primary type/storage override categories
retain their existing distinct rules. Each still needs its own real evidence;
neither a marker nor this report is a complete proof of original source.

In particular, this is not a foreign-header-bound audit, source-value/lifetime
analysis, SLD scope/statement proof, initializer-value audit or runtime-layout
seal. Horizon's former product variable named `p` illustrated the limitation:
the identifier existed in SYM, but it held the wrong value in the wrong scope.
Raw/SYM/SLD plus the matched NFS2 twin recovered its actual cached-percentage role.

## Verification and provenance

P914 backs up the previous tool under `../p914_checkpoint/backups/`. Independent
tests cover 33 policy assertions and four real historical/current `pv` and
`pmx_height` cases. Legacy default report bytes and stdout are identical to the
backup across all four frontend/game common/psx directories. Reusing the same
module through default -> strict -> default also preserves the default output.

See `../p914_identity_review/EXECUTED_RESULTS.md` and
`../p914_checkpoint/audit_reports.json`. Reports are review queues, not counts of
confirmed runtime bugs. More exposed identity findings are not PASS regressions.

The earlier search limited to `tools/*.py` did not cover this scratch auditor.
It does recognize the old carrier marker: changing GenericPMX's comment to an
explicit unresolved-source annotation exposes `pmx_height` in both report modes.
The recovered Horizon body removes `pv` entirely, rather than renaming it or
moving it into another exemption category.
