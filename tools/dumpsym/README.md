# tools/dumpsym

`dumpsym.exe` — dumps an SN Systems `.SYM` file (the `MND` debug format PSYLINK writes) as text: labels, FILE records,
function / block / line records, type and variable definitions.

`main.c` is its source: <https://github.com/lab313ru/dumpsym_src> plus the bool/NULL disambiguation fix (commit `f7f659d`,
"Add bool/NULL disambiguation for PsyQ SYM", ported from diabpsx/divination). The output of this build is what the project
calls the **v3** dump. The upstream repository carries no licence file.

```bash
tools/dumpsym/dumpsym.exe rom/NFS4.SYM > build/sym/nfs4-f-v3.txt
```

You normally do not run it by hand. `tools/retail_sym.py` produces `build/sym/nfs4-f-v3.txt` from `rom/NFS4.SYM` on first
use (and again when the SYM or the dumper is newer), and every tool asks it for the path:

```python
SYM = __import__('retail_sym').txt()          # str path of the retail dump
DUMPSYM = __import__('retail_sym').dumpsym()  # str path of this executable
```

`rom/NFS4.SYM` is the retail file from the disc (7,881,225 bytes). Like `rom/nfs4-f.exe` and `rom/NFS4.MAP` it is **not
committed** — you supply it. The text dump is 24.6 MB of the same retail debug data and is not committed either; it lives
under the git-ignored `build/`.

The PSYLINK lane uses the same executable to dump the `.SYM` our own link produces (`tools/psyq_pipe/psylink_lane.py`).
