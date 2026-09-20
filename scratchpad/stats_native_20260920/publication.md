# Stats publication verification

The Stats-only change was independently reapplied to remote main at
`d1093fface6da0a28b7d61c469bdca5d05740a46` in an isolated publication checkout.
This avoids publishing the 35 unrelated local commits present during this task.

Both the unchanged remote baseline and the edited source passed all seven
Stats functions using the remote branch's own `tools/verify_asm.py` with
`NFS4_SOURCE_ONLY=1`. Its own `tools/brdist.py` checked all seven functions with
zero branch-offset/count divergence.

Before/after whole-object SHA-256 in that checkout is identical:
`c32765e0f2f8e8da6c7f7671b9fffa130e9ed48aa33c79b755a5e1b12e80793a`.
The different absolute compilation path explains the difference from the
original workspace's FILE-path-bearing object hash. No binary is committed.

Only `recon/game/common/stats.cpp` and the selected Stats receipts are in this
publication. Unrelated commits, user edits, compiler outputs and rejected
experiments are excluded. Remaining empty-scope and SLD recovery limitations
are documented in README.md and final_receipts.json; this is not a claim of
complete source/SYM/SLD restoration.
