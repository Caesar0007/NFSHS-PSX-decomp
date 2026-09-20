# tools/psyq_pipe

Tools built around the original SN toolchain (ASPSX 2.77, PSYLINK 2.73) and the retail `NFS4.SYM`.
They were developed in `scratchpad/psyq_pipe/`; that folder is now a local, git-ignored work area, and these are the
versioned copies. Generated outputs (`nfs4_sym.txt`, `compare_rows.json`, `gdebug_report.json`, `symfix_skip.json`, logs)
still go to `scratchpad/psyq_pipe/`, which the tools create when missing.

`sym_obj_order.json` is an input, not an output: the retail link order (the FILE records of `NFS4.SYM`).

| Group | Tools | Documented in |
|---|---|---|
| Native link: `NFS4.CPE` / `.SYM` / `.MAP`, then `NFS4.EXE` + `FRONT.BIN` | `psylink_lane.py`, `psylink_disc.py`, `cpe_dump.py`, `drift.py`, `drift_vt.py` | `BUILDING.md`, Route B |
| Source against the retail SYM | `gdebug_compile.py`, `symtree_cmp.py`, `symtree_parse.py`, `symfn_cmp.py`, `symlocals.py`, `scope_probe.py`, `g_codecmp.py`, `g_codediff_fn.py`, `stat_small.py` | `sym-match.md` |
| Edit loop and automatic fixers | `symloop.py`, `symfix_order_drive.py`, `symfix_order.py`, `symfix_fordecl.py`, `symfix_rename.py`, `symfix_spchevnt.py` | `sym-match.md` |
| Data ownership by link order | `linkorder_outliers.py`, `linkorder_window.py`, `linkorder_slot.py`, `data_owner_by_linkorder.py`, `bss_holes.py`, `sdk_bss.py`, `blob_only_ranges.py`, `ownership_audit2.py`, `honest_diffs.py` | |
| SYM censuses | `sym_obj_census.py`, `sym_linkage.py`, `static_census.py`, `vf_live_census.py`, `text_hashes.py` | |
| Link-stripped functions against the PsyQ 4.3 objects | `strip_candidates.py`, `strip_headtail.py`, `strip_worddiff.py`, `strip_asm_gen.py`, `sdkfn.py`, `fn_sxs.py` | `recon/link_stripped.h` |

Most of these have absolute paths to this machine's toolchain near the top (`C:/Temp/psq43/...`,
`C:/Temp/claud/dumpsym_clean/...`); adjust them for another machine.
