#!/usr/bin/env python3
"""w64-a20 mission-1 acceptance: prove a converted TU moved NEITHER lane.

For a TU with a `<tu>.w64a20.bak` (the pre-conversion original) it measures both
states and compares:

  A. GATE LANE   build.py compile_c/compile_cpp object sha256
                 BEFORE == AFTER  => byte-identical object => zero PASS->FAIL by
                 construction (strictly stronger than re-running the diff).
  B. PROD LANE   the psq43-cc1 + ASPSX-2.77 object's code sections, hashed:
                 BEFORE(shim ON) == AFTER(shim ON)   => no production regression
                 AFTER(shim OFF) == AFTER(shim ON)   => the source is now
                 dialect-clean and the shim is a NO-OP on it
                 BEFORE(shim OFF) is reported too -- it is the defect being
                 fixed (an ASPSX error on every un-converted TU).

🔴 ORDER IS LOAD-BEARING: build/<tu>.i is produced by build.py's preprocess step,
so the gate compile MUST run before the production build in each state or the
production lane silently measures a STALE .i (a 12H-class vacuity).

Usage: python verify_tu.py <tu-rel> [--json]
"""
import hashlib, importlib.util, json, os, subprocess, sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
sys.path.insert(0, str(ROOT / "tools"))
SP = ROOT / "scratchpad" / "w64a20"
OBJD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"

_s = importlib.util.spec_from_file_location("prodobj", SP / "prodobj.py")
prodobj = importlib.util.module_from_spec(_s)
_s.loader.exec_module(prodobj)


def gate_build(rel):
    spec = importlib.util.spec_from_file_location("bld", ROOT / "tools" / "build.py")
    bld = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(bld)
    bld.OUT = bld.BUILD
    p = ROOT / rel
    try:
        obj = bld.compile_c(p, skip_asm=False) if p.suffix == ".c" else bld.compile_cpp(p)
    except SystemExit as e:
        return {"ok": False, "err": f"gate compile failed ({e.code})"}
    dis = subprocess.run([OBJD, "-d", "-r", "-z", str(obj)],
                         capture_output=True, text=True).stdout
    tab = subprocess.run([OBJD, "-t", str(obj)], capture_output=True, text=True).stdout
    # (addr, size, name) as a SET -- ELF symtab ORDER is not semantic; verify_asm
    # resolves by address, objdiff and the linker key by symbol.
    syms = sorted(" ".join([l.split()[0], l.split()[-2], l.split()[-1]])
                  for l in tab.splitlines() if len(l.split()) >= 3 and
                  ("F .text" in l or " O " in l))
    return {"ok": True, "obj": hashlib.sha256(Path(obj).read_bytes()).hexdigest(),
            "dis": hashlib.sha256(dis.encode()).hexdigest(), "syms": syms}


def tugate(rel):
    r = subprocess.run([sys.executable, str(ROOT / "tools" / "tugate.py"), rel],
                       capture_output=True, text=True, cwd=ROOT)
    import re
    m = re.search(r": (\d+)/(\d+) PASS", r.stdout)
    return (int(m.group(1)), int(m.group(2))) if m else (None, None)


def measure(rel):
    """gate FIRST (it regenerates build/<tu>.i), then both production configs."""
    g = gate_build(rel)
    tg = tugate(rel)
    return {"gate": g, "tugate": tg,
            "prod_on": prodobj.build(rel, True),
            "prod_off": prodobj.build(rel, False)}


def main():
    rel = sys.argv[1].replace("\\", "/")
    src = ROOT / rel
    bak = Path(str(src) + ".w64a20.bak")
    if not bak.exists():
        sys.exit(f"no {bak.name} -- nothing to compare against")
    cur = src.read_bytes()
    orig = bak.read_bytes()
    if cur == orig:
        print(f"{rel}: UNCHANGED vs .bak")
        return
    try:
        src.write_bytes(orig)
        before = measure(rel)
        src.write_bytes(cur)
        after = measure(rel)
    finally:
        if src.read_bytes() != cur:
            src.write_bytes(cur)
    ok, prob, notes = True, [], []
    if not (before["gate"]["ok"] and after["gate"]["ok"]):
        prob.append("gate compile failed")
    elif before["gate"]["obj"] != after["gate"]["obj"]:
        # a moved whole-object hash is only OK when the CODE and the symbol SET
        # are both unchanged -- i.e. nothing but ELF symtab ordering moved.
        if (before["gate"]["dis"] == after["gate"]["dis"]
                and before["gate"]["syms"] == after["gate"]["syms"]):
            notes.append("gate object hash moved but disassembly+relocs AND the "
                         "(addr,size,name) symbol set are identical -- ELF symtab "
                         "ORDER only, which is not semantic")
        else:
            prob.append(f"GATE OBJECT MOVED {before['gate']['obj'][:12]} -> "
                        f"{after['gate']['obj'][:12]} (disasm "
                        f"{'same' if before['gate']['dis']==after['gate']['dis'] else 'ALSO DIFFERS'}"
                        f", symbols "
                        f"{'same' if before['gate']['syms']==after['gate']['syms'] else 'ALSO DIFFER'})")
    if before["tugate"] != after["tugate"]:
        prob.append(f"tugate {before['tugate']} -> {after['tugate']}")
    bo, ao, af = before["prod_on"], after["prod_on"], after["prod_off"]
    if not bo["ok"]:
        prob.append(f"BEFORE prod(shim ON) failed: {bo['err']}")
    elif not ao["ok"]:
        prob.append(f"AFTER prod(shim ON) failed: {ao['err']}")
    elif bo["sha"] != ao["sha"]:
        prob.append(f"PROD OBJECT MOVED {bo['sha'][:12]} -> {ao['sha'][:12]}")
    if not af["ok"]:
        prob.append(f"AFTER prod(shim OFF) STILL FAILS: {af['err']}")
    elif ao["ok"] and af["sha"] != ao["sha"]:
        prob.append(f"shim is NOT a no-op after conversion "
                    f"({ao['sha'][:12]} vs {af['sha'][:12]})")
    ok = not prob
    bf = before["prod_off"]
    res = {"tu": rel, "ok": ok, "problems": prob,
           "gate_obj": after["gate"]["obj"][:16], "tugate": after["tugate"],
           "prod_sha": ao.get("sha", "")[:16],
           "before_nodialect": "OK" if bf["ok"] else bf["err"][:120],
           "after_nodialect": "OK" if af["ok"] else af["err"][:120],
           "notes": notes}
    if "--json" in sys.argv:
        print(json.dumps(res))
    else:
        v = "ACCEPT" if ok else "REJECT"
        print(f"{v}  {rel}")
        print(f"   gate obj {res['gate_obj']} (identical), tugate "
              f"{after['tugate'][0]}/{after['tugate'][1]} PASS")
        print(f"   prod obj {res['prod_sha']} (identical, shim ON==OFF)")
        print(f"   no-shim: BEFORE {res['before_nodialect'][:70]}")
        print(f"            AFTER  {res['after_nodialect'][:70]}")
        for n in notes:
            print("   note:", n)
        for p in prob:
            print("   !!", p)
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
