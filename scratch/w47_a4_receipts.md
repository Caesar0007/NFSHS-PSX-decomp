# WAVE-47 agent a4 — sndpsxz part B (C lane) receipts

Base ba09f774. Worktree C:/Temp/nfs4-wt47-a4, branch w47-a4.

## 0. RE-GATED BASELINES (worklist fuzzy% was wrong again — one row was already PASS)

| fn | TU | worklist% | re-gated | ours/oracle |
|---|---|---|---|---|
| iSND100hzserver | sserver.c | 99.97% | **PASS** (stale row) | 184 |
| iSNDserverremove100hzclient | sserver.c | 93.02% | 3 diffs | 44/43 |
| iSNDserverremoveclient | ssysserv.c | 93.02% | 3 diffs | 44/43 |
| iSNDpsxmemconstrain | sdmemman.c | 91.94% | 14 diffs | 31/31 |
| iSNDpsxmalloc | sdmemman.c | 79.20% | 59 diffs | 120/127 |
| iSNDplatformresolve | sdresolv.c | 99.17% | 3 diffs | 126/127 |
| iSNDmalloc | smemman.c | 91.09% | 48 diffs | 137/135 |
| iSNDdownloadbank | sbdload.c | 88.35% | 23 diffs | 85/84 |
| iSNDdmcallback | sdma.c | 99.91% | 4 diffs | 111/111 |
