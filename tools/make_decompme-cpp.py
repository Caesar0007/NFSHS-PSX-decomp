#!/usr/bin/env python3
r"""make_decompme-cpp.py — create a **C++** decomp.me scratch for one function.

C++ twin of make_decompme.py. The game was originally C++ (the symbols are mangled
C++ names like `__FP8Car_tObj`), so a faithful scratch should be REAL C++ on a
C++-capable compiler — NOT C-with-pointer-math. Per Mc-muffin (Ethanol @ Discord,
github.com/Mc-muffin), the canonical NFS4 recipe is:

    compiler  gcc2.8.1-psx
    flags     -O2 -G4 -xc++ -fno-rtti -fno-exceptions -g3 -Wa,--aspsx-version=2.76

(proven on NFS4 `AIDataRecord_CurveSpeedTable_t` ctor scratch AhA20 = 100%, and
HitWallCheck scratch YsDj7 = 99.2%. The `-Wa,--aspsx-version=2.76` pins the real
PsyQ assembler version — Mc-muffin's canonical flag set.)

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
* flags = `-O2 -G4 -xc++ -fno-rtti -fno-exceptions -g3 -Wa,--aspsx-version=2.76`.
  **`-xc++`** mandatory (forces C++); **`-Wa,--aspsx-version=2.76`** pins the PsyQ
  assembler (scheduling/delay-slots); `-fno-exceptions -g3` round it out.
  ⚠️ `gcc2.7.2-psx`+`-xc++` errors `invalid #-line` ("line numbers") — use
  gcc2.8.1-psx (= Silent Hill toolchain). NO `-Xm` (ccpsx driver flag, invalid).

==============================================================================
CAVEATS (same as the C tool)
==============================================================================
* Run the WINDOWS python.exe, NOT MSYS python (an MSYS /tmp path is invisible).
* decomp.me is behind Cloudflare: from a script only POST /api/scratch works; GET/
  PATCH/compile are 403. To verify the diff or change flags, open the URL in a
  browser (or PATCH from a logged-in browser session). Re-POST to change anything.
* POST returns 201 {slug, claim_token}.

==============================================================================
AUTO-CLAIM (set scratch owner = your account, so they aren't anonymous)
==============================================================================
* Every claim_token is ALWAYS appended to build/decompme_claims.jsonl (gitignored)
  so it can never be lost again (the token is one-shot POST output).
* The script AUTO-CLAIMS the new scratch to your account IF a session cookie is
  available — set env DECOMPME_COOKIE or write the gitignored file
  tools/.decompme_cookie with the raw Cookie header copied from the browser while
  logged in as your git user, e.g.:  sessionid=xxxxx; csrftoken=yyyyy
  Then each scratch is owned by you the moment it's created.
* No cookie -> it prints the token + a reminder; claim later from the logged-in
  browser (POST /api/scratch/<slug>/claim {token}) or after setting the cookie,
  using the tokens saved in build/decompme_claims.jsonl.
"""
import argparse, json, os, subprocess, sys, time, urllib.request, urllib.error
from http.cookiejar import CookieJar
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
API = "https://decomp.me/api/scratch"
UA = "Mozilla/5.0 (Windows NT 10.0)"
CLAIMS_LOG = ROOT / "build" / "decompme_claims.jsonl"
# Auto-claim needs YOUR logged-in decomp.me cookie (the headless script can't auth via the
# browser). Provide it via env DECOMPME_COOKIE or the gitignored file tools/.decompme_cookie,
# as the raw Cookie header, e.g.  sessionid=xxxxx; csrftoken=yyyyy
# (copy from the browser devtools while logged in as your git user). Never commit this file.
COOKIE_FILE = ROOT / "tools" / ".decompme_cookie"


def load_cookie():
    c = os.environ.get("DECOMPME_COOKIE", "").strip()
    if not c and COOKIE_FILE.exists():
        c = COOKIE_FILE.read_text().strip()
    return c or None


def claim(slug, token, cookie):
    """Claim an anonymous scratch to the cookie's logged-in user. Returns owner or None."""
    csrf = ""
    for part in cookie.split(";"):
        part = part.strip()
        if part.startswith("csrftoken="):
            csrf = part.split("=", 1)[1]
    req = urllib.request.Request(
        f"{API}/{slug}/claim", data=json.dumps({"token": token}).encode(),
        headers={"Content-Type": "application/json", "User-Agent": UA,
                 "Cookie": cookie, "X-CSRFToken": csrf, "Referer": f"https://decomp.me/scratch/{slug}"})
    try:
        urllib.request.urlopen(req, timeout=40)
    except urllib.error.HTTPError as e:
        return f"FAILED HTTP {e.code} ({e.read().decode()[:120]})"
    # confirm
    try:
        g = urllib.request.Request(f"{API}/{slug}", headers={"User-Agent": UA, "Cookie": cookie})
        j = json.loads(urllib.request.urlopen(g, timeout=40).read().decode())
        return (j.get("owner") or {}).get("username") or "(claimed)"
    except Exception:
        return "(claimed, owner unverified)"


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
    ap.add_argument("--flags", default="-O2 -G4 -xc++ -fno-rtti -fno-exceptions -g3 -Wa,--aspsx-version=2.76", help="cc1plus flags (keep -xc++!)")
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
    token = j.get("claim_token")
    print(f"created  ({r.status})  compiler={a.compiler!r} flags={j.get('compiler_flags')!r}")
    print(f"URL:   https://decomp.me/scratch/{slug}")
    print(f"CLAIM: {token}")

    # ALWAYS persist the claim token so it can never be lost (the token is one-shot output).
    CLAIMS_LOG.parent.mkdir(parents=True, exist_ok=True)
    with open(CLAIMS_LOG, "a") as fh:
        fh.write(json.dumps({"slug": slug, "token": token, "func": a.func, "epoch": int(time.time())}) + "\n")
    print(f"saved token -> {CLAIMS_LOG}")

    # AUTO-CLAIM to your account if a session cookie is available.
    cookie = load_cookie()
    if cookie:
        owner = claim(slug, token, cookie)
        print(f"auto-claim: owner = {owner}")
    else:
        print("auto-claim SKIPPED: no DECOMPME_COOKIE env / tools/.decompme_cookie file. "
              "Set it (raw Cookie header: 'sessionid=...; csrftoken=...') to auto-claim, OR claim "
              "from the logged-in browser: POST /api/scratch/<slug>/claim {token}. "
              "(All tokens are in build/decompme_claims.jsonl for later claiming.)")


if __name__ == "__main__":
    main()
