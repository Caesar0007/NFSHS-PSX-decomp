#!/usr/bin/env python3
"""w64-a20 mission-1 prover: for ONE TU, capture the state that must not move.

  gate lane      : build.py's own compile_c/compile_cpp -> the .o, hashed
                   (a byte-identical object is a CONSTRUCTIVE zero-PASS->FAIL
                   proof, strictly stronger than re-running the diff)
  production lane: tools/psyqproof.py per oracle-known fn, shim ON (as shipped)
                   AND shim OFF (--no-dialect) -- the latter is the mission's
                   actual acceptance test: OFF must go from "aspsx failed" to
                   the same REAL/RELOP as ON.

Usage:  python prove.py <tu-rel> [--tag before|after]
Writes  scratchpad/w64a20/proof_<safe-tu>_<tag>.json
"""
import hashlib, importlib.util, json, re, subprocess, sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
OBJD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
sys.path.insert(0, str(ROOT / "tools"))   # build.py does a bare `import fix_symsizes`


def gate_object(rel):
    """-> (sha256 of the whole .o, sha256 of .text bytes, path)"""
    spec = importlib.util.spec_from_file_location("bld", ROOT / "tools" / "build.py")
    bld = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(bld)
    bld.OUT = bld.BUILD
    p = ROOT / rel
    obj = bld.compile_c(p, skip_asm=False) if p.suffix == ".c" else bld.compile_cpp(p)
    data = Path(obj).read_bytes()
    dis = subprocess.run([OBJD, "-d", "-r", "-z", str(obj)],
                         capture_output=True, text=True).stdout
    return hashlib.sha256(data).hexdigest(), hashlib.sha256(dis.encode()).hexdigest(), str(obj)


def oracle_fns(rel):
    """the TU's gate-visible symbols that have an oracle (same set tugate uses)"""
    r = subprocess.run([sys.executable, str(ROOT / "tools" / "tugate.py"), rel],
                       capture_output=True, text=True, cwd=ROOT)
    names, fails = [], {}
    for ln in r.stdout.splitlines():
        m = re.match(r"^\s+(\d+)\s+(\S+)$", ln)
        if m:
            fails[m.group(2)] = int(m.group(1))
    m = re.search(r": (\d+)/(\d+) PASS", r.stdout)
    return (int(m.group(1)), int(m.group(2))) if m else (None, None), fails, r.stdout


def psyq(rel, fn, dialect=True):
    cmd = [sys.executable, str(ROOT / "tools" / "psyqproof.py"), rel, fn]
    if not dialect:
        cmd.append("--no-dialect")
    r = subprocess.run(cmd, capture_output=True, text=True, cwd=ROOT)
    out = r.stdout + r.stderr
    m = re.search(r"REAL=(\d+) RELOP=(\d+) reloc-site diffs=(\d+)", out)
    if m:
        return {"ok": True, "real": int(m.group(1)), "relop": int(m.group(2)),
                "reloc": int(m.group(3))}
    return {"ok": False, "err": out.strip().split("\n")[0][:160]}


def main():
    rel = sys.argv[1].replace("\\", "/")
    tag = sys.argv[sys.argv.index("--tag") + 1] if "--tag" in sys.argv else "x"
    only = None
    if "--fns" in sys.argv:
        only = sys.argv[sys.argv.index("--fns") + 1].split(",")
    osha, dsha, opath = gate_object(rel)
    (npass, ntot), fails, raw = oracle_fns(rel)
    # symbol list for the production lane: everything tugate gated
    names = []
    for ln in raw.splitlines():
        m = re.match(r"^\s+\d+\s+(\S+)$", ln)
        if m:
            names.append(m.group(1))
    # tugate only prints FAILs; get the full set from the object's symtab n oracle
    syms = subprocess.run([OBJD, "-t", opath], capture_output=True, text=True).stdout
    cand = set()
    for ln in syms.splitlines():
        t = ln.split()
        if len(t) >= 2 and re.match(r"^[0-9a-f]{8}$", t[0]) and "*UND*" not in ln \
           and "*ABS*" not in ln and t[-1] and not t[-1].startswith((".", "$")):
            cand.add(t[-1])
    spec = importlib.util.spec_from_file_location("pq", ROOT / "tools" / "psyqproof.py")
    pq = importlib.util.module_from_spec(spec)
    sys.modules["pq"] = pq
    spec.loader.exec_module(pq)
    fns = sorted(n for n in cand if pq._find_oracle_path(n))
    if only:
        fns = [f for f in fns if f in only]
    res = {"tu": rel, "tag": tag, "obj_sha": osha, "dis_sha": dsha,
           "gate": {"pass": npass, "total": ntot, "fails": fails},
           "prod": {}, "prod_nodialect": {}}
    for fn in fns:
        res["prod"][fn] = psyq(rel, fn, True)
        res["prod_nodialect"][fn] = psyq(rel, fn, False)
    safe = rel.replace("/", "_").replace(".", "_")
    out = ROOT / "scratchpad" / "w64a20" / f"proof_{safe}_{tag}.json"
    out.write_text(json.dumps(res, indent=1))
    nz = sum(1 for v in res["prod"].values() if v.get("ok") and v["real"] + v["relop"])
    bad = sum(1 for v in res["prod"].values() if not v.get("ok"))
    ndz = sum(1 for v in res["prod_nodialect"].values() if not v.get("ok"))
    print(f"{rel} [{tag}] gate {npass}/{ntot} PASS | obj {osha[:12]} | "
          f"prod fns={len(fns)} nonzero={nz} failed={bad} | noDialect failed={ndz}")
    print(f"  -> {out.name}")


if __name__ == "__main__":
    main()
