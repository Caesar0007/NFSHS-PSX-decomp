"""w66-a2: add the OPT-IN `--nop-before-label` option to BOTH maspsx copies.

Default OFF => byte-inert (proven separately by a tree-wide brdist sweep).
Byte-mode, LF-preserving, count==1 asserted per anchor, ast.parse-validated,
atomic os.replace, per-file .bak in this scratchpad.
"""
import ast
import os
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BAK = os.path.join(HERE, "bak")

COPIES = [
    (r"C:/Temp/maspsx-master/maspsx/__init__.py", r"C:/Temp/maspsx-master/maspsx.py"),
    (r"C:/Temp/nfs4-decomp/tools/maspsx/maspsx/__init__.py",
     r"C:/Temp/nfs4-decomp/tools/maspsx/maspsx.py"),
]

# ---------------------------------------------------------------- __init__.py
INIT_A_OLD = b"        jtbl_at_fusion=False,\n    ):\n"
INIT_A_NEW = b"        jtbl_at_fusion=False,\n        nop_before_label=False,\n    ):\n"

INIT_B_OLD = b"        self.jtbl_at_fusion = jtbl_at_fusion\n"
INIT_B_NEW = (b"        self.jtbl_at_fusion = jtbl_at_fusion\n"
              b"        self.nop_before_label = nop_before_label\n")

INIT_C_OLD = b"""            if nop_required:
                label = self.get_next_instruction(
                    skip=0, ignore_nop=True, ignore_set=True
                )
                if is_label(label):
                    res.append(label)
                    self.skip_instructions = 1
                res.append(f"nop # DEBUG: Reuse of '{r_dest}'. {reason}")
"""

INIT_C_NEW = """            if nop_required:
                label = self.get_next_instruction(
                    skip=0, ignore_nop=True, ignore_set=True
                )
                nop = f"nop # DEBUG: Reuse of '{r_dest}'. {reason}"
                if is_label(label):
                    self.skip_instructions = 1
                    if self.nop_before_label:
                        # OPT-IN (--nop-before-label): keep the inserted
                        # load-delay nop BEFORE the following label, so the
                        # label denotes the instruction after the nop.
                        res.append(nop)
                        res.append(label)
                        return res
                    res.append(label)
                res.append(nop)
""".encode("ascii")

# ----------------------------------------------------------------- maspsx.py
CLI_A_OLD = b'    parser.add_argument("--jtbl-at-fusion", action="store_true")\n'
CLI_A_NEW = (b'    parser.add_argument("--jtbl-at-fusion", action="store_true")\n'
             b'    parser.add_argument("--nop-before-label", action="store_true")\n')

CLI_B_OLD = b"        jtbl_at_fusion=args.jtbl_at_fusion,\n    )\n"
CLI_B_NEW = (b"        jtbl_at_fusion=args.jtbl_at_fusion,\n"
             b"        nop_before_label=args.nop_before_label,\n    )\n")


def patch(path, edits):
    with open(path, "rb") as f:
        data = f.read()
    assert b"\r" not in data, "%s: CR found, LF-only expected" % path
    orig_len = len(data)
    for old, new in edits:
        n = data.count(old)
        assert n == 1, "%s: anchor count %d != 1 for %r" % (path, n, old[:60])
        data = data.replace(old, new, 1)
    assert len(data) > orig_len
    assert b"\r" not in data and b"\0" not in data
    ast.parse(data.decode("utf-8"))
    os.makedirs(BAK, exist_ok=True)
    tag = path.replace(":", "").replace("/", "_").replace("\\", "_")
    shutil.copyfile(path, os.path.join(BAK, tag + ".bak"))
    tmp = path + ".w66a2tmp"
    with open(tmp, "wb") as f:
        f.write(data)
    assert os.path.getsize(tmp) == len(data)
    os.replace(tmp, path)
    print("patched %s  (%d -> %d bytes)" % (path, orig_len, len(data)))


def main():
    for init_py, cli_py in COPIES:
        patch(init_py, [(INIT_A_OLD, INIT_A_NEW),
                        (INIT_B_OLD, INIT_B_NEW),
                        (INIT_C_OLD, INIT_C_NEW)])
        patch(cli_py, [(CLI_A_OLD, CLI_A_NEW), (CLI_B_OLD, CLI_B_NEW)])


if __name__ == "__main__":
    main()
