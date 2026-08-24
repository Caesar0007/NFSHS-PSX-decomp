# Full-link backlog re-audit — 2026-08-24

The historical jump-table, vtable, and library-reference backlog remains
closed.  This re-audit was performed from the current dirty working tree while
preserving all unrelated user edits.

## Authoritative gates

- `python tools/relink.py --lane both -v`
  - recon lane: `REAL=0`, hidden phantoms `0`, relocation-referenced unresolved
    names `0`;
  - src lane: `REAL=0`, hidden phantoms `0`, relocation-referenced unresolved
    names `0`;
  - result: `GATE: GREEN`.
- `python tools/audit_vtable_indexing.py`
  - no unsafe vtable-row indexing in 926 source files.
- `python tools/build.py`
  - all TUs compile and the final link succeeds;
  - output size 1,239,008 bytes versus retail 1,239,040 bytes;
  - the remaining `-32` byte size delta and 21.14% image identity are the
    independent section-layout/order backlog, not unresolved references.

## False ownership findings removed

`tools/phantom_audit.py` previously used each oracle assembly filename stem as
the symbol name.  Eight files deliberately have a different filesystem key:
address suffixes distinguish same-named file-local helper/destructor copies,
while `func_800F9984.s` and `_bzero_w_800F2E70.s` are filename aliases for
`cd_read` and `_bzero_w`.  Every file already declares its actual oracle name
on the `nonmatching` line.  One suffixed destructor carrier already had an
exact compiled filesystem-key symbol, so seven of the eight aliases appeared
in the former ownership-gap report.

The audit now consumes that declaration and retains the filename-to-symbol
mapping in its report.  The normalized result is:

- oracle files: 3,491;
- distinct declared oracle names: 3,484;
- normalized filename aliases: 8;
- exact compiled owners: 3,484;
- hidden signature phantoms: 0;
- unmatched ownership gaps: 0;
- reconstruction TUs compiled: 513/513.

The pre-change tool is backed up at
`scratchpad/root_sym_audit/phantom_audit_before_oracle_label_20260824.py`.
This is an audit-only correction; it performs no post-recompile rewriting and
changes no reconstructed code or linked bytes.
