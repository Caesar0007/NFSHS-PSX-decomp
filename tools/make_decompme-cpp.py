#!/usr/bin/env python3
r"""make_decompme-cpp.py — create a **C++** decomp.me scratch for one function.

C++ twin of make_decompme.py. The game was originally C++ (the symbols are mangled
C++ names like `__FP8Car_tObj`), so a faithful scratch should be REAL C++ on a
C++-capable compiler — NOT C-with-pointer-math. Per Mc-muffin (Ethanol @ Discord,
github.com/Mc-muffin), the canonical NFS4 recipe is:

    compiler  gcc2.8.1-psx
    flags     -O2 -G4 -xc++ -fno-rtti

(proven 100% on NFS4 `AIDataRecord_CurveSpeedTable_t` ctor, scratch AhA20.)

    py -3.12 tools/make_decompme-cpp.py <MANGLED_FUNC> \
        --obj expected/src/<module>.c.o \
        --src path/to/source.cpp \
        [--ctx ctx.cpp] [--name NAME] [--compiler gcc2.8.1-psx] [--flags "..."]

==============================================================================
THE C++ SOURCE FORM (what --src should contain)
==============================================================================
* Name the function NORMALLY (`int AIPhysic_GetRearEndDamageFactor(Car_tObj*)`),
  NOT with the mangled symbol — the C++ compiler RE-MANGLES it to the canonical
  symbol (which must equal the diff_label / the <MANGLED_FUNC> arg).
* Use REAL classes/structs with member access — DROP the pointer math. Lay fields
  at their true offsets (use `char _padN[...]` fillers); a class needs `public:`.
  An array-of-struct table indexes by `base[idx].field` (the element struct's
  sizeof must equal the real stride, e.g. 0x20 → `<<5`).
* C++ method  -> real `Class::method(...)` def (`this` implicit); inheritance via
  `class D : public B`; ctor member-init list `D::D(...) : B(...){...}`.
* C-linkage callees (`sprintf`, `fixedmult`, …) -> wrap in `extern "C" { ... }`.
  File-scope extern VARIABLES (globals like `BWorldSm_slices`) are NOT mangled in
  gcc-2.x C++, so a plain `extern T *g;` is fine (extern "C" optional/harmless).
* The UNSIZED-ARRAY lever still applies: `extern char *D_x[]; … D_x[0]` (methodology
  §3.12#5) — Mc-muffin's AhA20 uses it too.
* Structs may live in the SOURCE (AhA20 keeps context empty) or in --ctx.

==============================================================================
COMPILER / FLAGS
==============================================================================
* compiler = gcc2.8.1-psx  (a GCC-psx variant routes C++ to cc1plus; the `psyq*`
  presets are cc1/C-ONLY and will parse-error on `extern "C"`/class types).
* flags = `-O2 -G4 -xc++ -fno-rtti`. The **`-xc++`** is mandatory (forces C++).
  ⚠️ `gcc2.7.2-psx`+`-xc++` errors `invalid #-line` ("line numbers" issue) — use
  gcc2.8.1-psx (= Silent Hill toolchain). NO `-Xm` (ccpsx driver flag, invalid).

==============================================================================
CAVEATS (same as the C tool)
==============================================================================
* Run the WINDOWS python.exe, NOT MSYS python (an MSYS /tmp path is invisible).
* decomp.me is behind Cloudflare: from a script only POST /api/scratch works; GET/
  PATCH/compile are 403. To verify the diff or change flags, open the URL in a
  browser (or PATCH from a logged-in browser session). Re-POST to change anything.
* POST returns 201 {slug, claim_token}.
"""
import argparse, json, subprocess, sys, urllib.request, urllib.error
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
API = "https://decomp.me/api/scratch"
UA = "Mozilla/5.0 (Windows NT 10.0)"


def gen_target(func, obj, dis):
    cmd = [sys.executable, str(ROOT / "tools" / "gen_target_asm.py"), func]
    if obj:
        cmd += ["--obj", obj]
    elif dis:
        cmd += ["--dis", dis]
    out = subprocess.run(cmd, capture_output=True, text=True)
    if out.returncode != 0 or not out.stdout.strip():
        sys.exit(f"gen_target_asm failed:\n{out.stdout}\n{out.stderr}")
    return out.stdout


def main():
    ap = argparse.ArgumentParser(description="Create a C++ decomp.me scratch via the API.")
    ap.add_argument("func", help="mangled symbol = diff_label, e.g. AIPhysic_HitWallCheck__FP8Car_tObj")
    ap.add_argument("--obj", help="expected object to disasm for the target asm "
                                  "(e.g. expected/src/aiphysic.c.o)")
    ap.add_argument("--dis", default=str(ROOT / "build" / "exp.dis"),
                    help="fallback disasm file if --obj not given")
    ap.add_argument("--src", required=True, help="C++ source file (normal fn name; real classes)")
    ap.add_argument("--ctx", help="context C++ file (classes/typedefs + extern callees)")
    ap.add_argument("--name", help="display name (default: func)")
    ap.add_argument("--flags", default="-O2 -G4 -xc++ -fno-rtti", help="cc1plus flags (keep -xc++!)")
    ap.add_argument("--compiler", default="gcc2.8.1-psx")
    ap.add_argument("--platform", default="ps1")
    a = ap.parse_args()

    if "-Xm" in a.flags:
        sys.exit("refusing: '-Xm' is a ccpsx DRIVER flag, invalid for decomp.me.")
    if "-xc++" not in a.flags and "-x c++" not in a.flags:
        sys.exit("refusing: C++ scratch needs '-xc++' in --flags (else the GCC-psx "
                 "compiler treats the source as C and class/extern\"C\" parse-error).")

    asm = gen_target(a.func, a.obj, a.dis)
    src = Path(a.src).read_text()
    ctx = Path(a.ctx).read_text() if a.ctx else ""

    payload = {
        "target_asm": asm,
        "context": ctx,
        "source_code": src,
        "compiler": a.compiler,
        "platform": a.platform,
        "compiler_flags": a.flags,
        "diff_label": a.func,
        "name": a.name or a.func.split("__")[0],
    }
    req = urllib.request.Request(API, data=json.dumps(payload).encode(),
                                 headers={"Content-Type": "application/json", "User-Agent": UA})
    try:
        r = urllib.request.urlopen(req, timeout=40)
        j = json.loads(r.read().decode())
    except urllib.error.HTTPError as e:
        sys.exit(f"POST failed HTTP {e.code}:\n{e.read().decode()[:400]}")
    slug = j.get("slug")
    print(f"created  ({r.status})  compiler={a.compiler!r} flags={j.get('compiler_flags')!r}")
    print(f"URL:   https://decomp.me/scratch/{slug}")
    print(f"CLAIM: {j.get('claim_token')}")
    print("NOTE: open the URL in a browser to verify the diff (GET/compile are "
          "Cloudflare-blocked headlessly). Re-run to change anything.")


if __name__ == "__main__":
    main()
