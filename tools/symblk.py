"""symblk.py <mangled-fn> -- print the trusted SYM's 8c Function-start block
(locals + REG/AUTO homes + fsize/mask) and the retail frame map (sp + fsize - |off|).
"""
import re
import sys

SYM = r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt"
NAME = ['zero', 'at', 'v0', 'v1', 'a0', 'a1', 'a2', 'a3', 't0', 't1', 't2', 't3',
        't4', 't5', 't6', 't7', 's0', 's1', 's2', 's3', 's4', 's5', 's6', 's7',
        't8', 't9', 'k0', 'k1', 'gp', 'sp', 'fp', 'ra']


def main(fn):
    txt = open(SYM, errors="replace").read().splitlines()
    starts = [i for i, l in enumerate(txt) if "8c Function start" in l]
    for k, i in enumerate(starts):
        end = starts[k + 1] if k + 1 < len(starts) else len(txt)
        blk = txt[i:end]
        if any(l.strip() == "name = " + fn for l in blk[:12]):
            fsize = 0
            for l in blk:
                m = re.match(r"\s*fsize = (\d+)", l)
                if m:
                    fsize = int(m.group(1))
            for l in blk:
                m = re.match(r"^[0-9a-f]+: \$([0-9a-f]{8}) 9[46] Def2? class (\w+) "
                             r"type ([^\n]*?) name (\S+)$", l.strip())
                if m:
                    v = int(m.group(1), 16)
                    cls, typ, nm = m.group(2), m.group(3), m.group(4)
                    if cls in ("REG", "REGPARM"):
                        home = NAME[v] if v < 32 else "?%d" % v
                        print("  %-10s %-8s $%-3d %-6s %s" % (cls, nm, v, home, typ))
                    elif cls == "AUTO":
                        off = v - (1 << 32) if v > 0x7fffffff else v
                        print("  %-10s %-8s %-4d sp+%-4d %s"
                              % (cls, nm, off, fsize + off, typ))
                    else:
                        print("  %-10s %-8s $%08x %s" % (cls, nm, v, typ))
                elif "Block start" in l or "Block end" in l or "fsize" in l \
                        or "mask" in l or "8e Function end" in l or "line =" in l:
                    print(" ", l.strip())
            return
    print("NOT FOUND", fn)


if __name__ == "__main__":
    main(sys.argv[1])
