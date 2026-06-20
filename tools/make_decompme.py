#!/usr/bin/env python3
r"""make_decompme.py — create a decomp.me scratch for one function, via the API.

For handing a near-miss / hard-wall function to the decomp.me community. Generates the
Target assembly from the EXPECTED object, bundles a Context + Source, and POSTs a new
scratch. Prints the URL + claim token.

    py -3.12 tools/make_decompme.py <MANGLED_FUNC> \
        --obj expected/src/<module>.c.o \
        --src path/to/source.c \
        [--ctx path/to/context.c] [--name NAME] [--flags "-O2 -G4"]

==============================================================================
THE PROCESS (the record — read this before/instead of guessing)
==============================================================================
1. TARGET ASSEMBLY  = the oracle, $-prefixed, GAS-ready. Produced by
   tools/gen_target_asm.py <FUNC> --obj expected/src/<mod>.c.o (this script calls it).
   Build the expected object first:  py -3.12 tools/build.py --out expected --no-link

2. SOURCE  = the function in C, named with its FULL MANGLED SYMBOL, because the
   decomp.me **PSYQ4.3 preset compiles with cc1 (C), NOT cc1plus (C++)** (methodology
   §3.22). So:
     - a free function `int Foo(Car_tObj*)`  ->  name it `int Foo__FP8Car_tObj(...)`
     - call callees by their mangled names (`Bar__FP8Car_tObj6Gear_t(...)`)
     - a C++ METHOD -> rewrite as a plain C fn named with the mangled symbol, `this`
       -> explicit first arg, `class`->`struct`, method calls -> mangled-name calls.
     - 🔴 NO register-asm pins (rule). Ship the pin-free near-miss source.

3. CONTEXT  = minimal C the source needs: opaque `typedef struct Car_tObj Car_tObj;`
   (raw `*(int*)((char*)p+off)` access needs no struct body), `typedef int Gear_t;`,
   and `extern` decls for every callee (mangled names). Keep it tiny.

4. COMPILER / PLATFORM / FLAGS:
     compiler="psyq4.3"  platform="ps1"  compiler_flags="-O2 -G4"
   ⚠️ **`-Xm` is a ccpsx DRIVER flag and is INVALID for cc1** — decomp.me reports
   `CC1PSX.EXE: Invalid option -Xm`. Use `-O2 -G4` ONLY (the preset handles the driver
   layer). Our local build uses `-Xm -O2 -G4` via the ccpsx driver; decomp.me does not.

==============================================================================
CAVEATS (cost real time — don't relearn them)
==============================================================================
* Run the WINDOWS python.exe, NOT MSYS/git-bash python: an MSYS `/tmp/...` path is
  invisible to the Windows interpreter (FileNotFoundError). Put scratch files under
  C:\Temp\ and pass Windows paths.
* decomp.me is behind Cloudflare. From a headless/script context **only POST
  /api/scratch works**; GET /api/scratch/<slug>, the /compile endpoint, and PATCH all
  return HTTP 403 "Just a moment..." So you CANNOT verify the diff or edit flags after
  the fact from here — to change anything, just POST a NEW scratch with the fix
  (re-POST is the reliable path; that's how a stuck `-Xm` got corrected -> a fresh slug).
* POST returns 201 with {slug, claim_token}. The claim_token lets a logged-in user
  adopt the anonymous scratch. The user should open the URL in a browser to confirm
  the preset/diff (Cloudflare lets the browser through).

History: first NFS4 scratch = CalculateGear's abs-coalescing wall (slug VPtCI, after
3DmxL had the bad -Xm). API recipe proven 2026-06-20.
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
    ap = argparse.ArgumentParser(description="Create a decomp.me scratch via the API.")
    ap.add_argument("func", help="mangled symbol, e.g. AIPhysic_CalculateGear__FP8Car_tObj")
    ap.add_argument("--obj", help="expected object to disasm for the target asm "
                                  "(e.g. expected/src/aiphysic.c.o)")
    ap.add_argument("--dis", default=str(ROOT / "build" / "exp.dis"),
                    help="fallback disasm file if --obj not given")
    ap.add_argument("--src", required=True, help="C source file (mangled-name form)")
    ap.add_argument("--ctx", help="context C file (typedefs + extern callees)")
    ap.add_argument("--name", help="display name (default: func)")
    ap.add_argument("--flags", default="-O2 -G4", help="cc1 flags (NO -Xm!)")
    ap.add_argument("--compiler", default="psyq4.3")
    ap.add_argument("--platform", default="ps1")
    a = ap.parse_args()

    if "-Xm" in a.flags:
        sys.exit("refusing: '-Xm' is a ccpsx DRIVER flag, invalid for decomp.me cc1. "
                 "Use '-O2 -G4'.")

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
        sys.exit(f"POST failed HTTP {e.code} (Cloudflare often 403s GET/PATCH but not "
                 f"POST; retry):\n{e.read().decode()[:400]}")
    slug = j.get("slug")
    print(f"created  ({r.status})  flags={j.get('compiler_flags')!r}")
    print(f"URL:   https://decomp.me/scratch/{slug}")
    print(f"CLAIM: {j.get('claim_token')}")
    print("NOTE: GET/PATCH are Cloudflare-blocked headlessly — open the URL in a browser "
          "to verify the diff. To change anything, re-run this (POSTs a fresh slug).")


if __name__ == "__main__":
    main()
