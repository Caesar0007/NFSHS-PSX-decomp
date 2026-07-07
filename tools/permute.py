#!/usr/bin/env python3
"""decomp-permuter glue for this project.

The permuter randomly mutates a near-matching C function and recompiles it
thousands of times, hunting for the byte-exact form. Ideal for the 90-99%
reconstruction near-misses (objdiff fuzzy_match_percent < 100).

Two subcommands:

  setup <recon_module.cpp> <symbol> <target.o>
        Creates permuter_work/<symbol>/ with base.c (the module, includes made
        -I-resolvable), compile.sh, settings.toml, and target.o. Then run:
            python C:/Temp/decomp-permuter/permuter.py permuter_work/<symbol>/ -j
        When it prints "found a match!", copy the matching function body back
        into the recon module and re-run the objdiff report.

  compile <args...>
        Compile wrapper invoked by compile.sh: parses the input .c and `-o out`
        from the permuter's argv and runs cpp(-x c -D__cplusplus) -> CC1PLPSX
        -> maspsx -> as, exactly like build.py's compile_cpp.
"""
import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
RECON = ROOT / "recon"
MIPS = Path(os.environ.get("NFS4_MIPS_BIN", r"C:/Tools/mips-ps1/mips/bin"))
CPP = MIPS / "mipsel-none-elf-cpp.exe"
AS = MIPS / "mipsel-none-elf-as.exe"
CC1PL = Path(os.environ.get("NFS4_CC1PL", r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE"))
MASPSX = Path(os.environ.get("NFS4_MASPSX", r"C:/Temp/maspsx-master/maspsx.py"))


def do_compile(args):
    # permuter passes e.g.  -c <in.c> -o <out.o>  (plus PERMUTER defines)
    in_c = next(a for a in args if a.endswith(".c"))
    out_o = args[args.index("-o") + 1]
    i_file, s_file = out_o + ".i", out_o + ".s"
    subprocess.run([str(CPP), "-x", "c", "-D__cplusplus=1", "-DPERMUTER=1",
                    "-nostdinc", "-undef", "-Dmips", "-D__mips__", "-D__psx__",
                    f"-I{RECON}", in_c, "-o", i_file], check=True)
    subprocess.run([str(CC1PL), "-quiet", "-O2", "-G4", i_file, "-o", s_file], check=True)
    p = subprocess.run([sys.executable, str(MASPSX), "--aspsx-version=2.77",
                        "--run-assembler", f"--gnu-as-path={AS}", "-EL",
                        "-march=r3000", "-G4", "-I", str(RECON), "-o", out_o, s_file],
                       input="", text=True)
    sys.exit(p.returncode)


SYSCPP = Path(os.environ.get("NFS4_SYS_CPP", "cpp"))  # plain cpp on PATH


def _demangle(symbol):
    """cfront symbol -> the bare name `_fn_name()` extracts from the source header.

      free fn      name__F<params>          -> name
      method       name__<len><Class><...>  -> name        (src: Class::name(...))
      ctor         __<len><Class><...>       -> Class       (src: Class::Class(...))
      dtor         ___<len><Class>           -> Class       (src: Class::~Class())
    For ctor/dtor the source declarator's last identifier is the class name
    (`Class` for the ctor, `Class` after the `~` for the dtor), so returning the
    class name lets reduce_to_fn match either."""
    import re
    if "__F" in symbol:
        return symbol.split("__F")[0]                       # free function
    m = re.match(r"^(.*?)__(_?)(\d+)(.*)$", symbol)
    if not m:
        return symbol
    method, _dtor, length, rest = m.group(1), m.group(2), int(m.group(3)), m.group(4)
    cls = rest[:length]
    # sanitize() rewrites `::`->`__`, so the source declarator _fn_name() sees is
    # `Class__method` / `Class__Class` (ctor). Return that post-sanitize name.
    return f"{cls}__{method}" if method else f"{cls}__{cls}"


def _lower_method(text, fnname):
    """Lower a kept C++ method `Ret Class__method(params){...this...}` to plain C
    `Ret Class__method(Class *thiz, params){...thiz...}` so pycparser + CC1PLPSX
    accept it. objdiff is whole-object/positional + reloc-name-lenient, so the
    renamed self-param and the `Class__m(thiz,...)` call names are harmless.
    Only fires when the body uses `this` (free functions pass through)."""
    import re
    cls = fnname.rsplit("__", 1)[0]
    m = re.search(r"\b" + re.escape(fnname) + r"\s*\(", text)
    if not m:
        return text

    def _match(s, i, op, cl):                  # index of `cl` closing the `op` at i
        d = 0
        while i < len(s):
            if s[i] == op: d += 1
            elif s[i] == cl:
                d -= 1
                if d == 0: return i
            i += 1
        return -1

    popen = m.end() - 1
    pclose = _match(text, popen, "(", ")")
    b = text.find("{", pclose)
    bend = _match(text, b, "{", "}")
    if pclose < 0 or b < 0 or bend < 0:
        return text
    body = text[b:bend + 1]
    if not re.search(r"\bthis\b", body):
        return text                            # free function — leave alone

    params = text[popen + 1:pclose].strip()
    newparams = cls + " *thiz" + ("" if not params else ", " + params)

    # ctor: a `: _base_X(baseargs)` initializer list between ) and { — lower it to
    # an explicit base-ctor call at the top of the body, and give the (return-
    # type-less) ctor a `void` return type.
    init_m = re.search(r":\s*(_base_\w+)\s*\(", text[pclose + 1:b])
    initstmt, ret, base_proto = "", "", ""
    if init_m:
        base_member = init_m.group(1)                  # _base_AIDataRecord_t
        base_cls = base_member[len("_base_"):]         # AIDataRecord_t
        ap = pclose + 1 + init_m.end() - 1             # '(' of the init list
        baseargs = text[ap + 1:_match(text, ap, "(", ")")].strip()
        initstmt = "  %s__%s(&thiz->%s%s);\n" % (
            base_cls, base_cls, base_member, (", " + baseargs if baseargs else ""))
        ret, base_proto = "void ", "extern int %s__%s(...);\n" % (base_cls, base_cls)

    # real-inheritance field access: `permuter_sanitize.sanitize()` flattens
    # `struct D : public B { ... }` to `struct D { B _vbase_; ... };` (layout-
    # neutral) but does NOT rewrite call sites, so a method body's transparent
    # `this->baseField` (valid in real C++, since D IS-A B) no longer resolves
    # in the lowered plain-C struct. Walk D's base chain (D -> B -> B's own
    # base -> ...) collecting each level's OWN field names, and redirect
    # `this->baseField` -> `this->_vbase_[._vbase_...].baseField` with the
    # right number of `_vbase_` hops for whichever level actually declares it
    # (never touching D's own fields or method calls, which the existing
    # rules below already handle).
    #
    # 🔴 TWO BUGS FIXED HERE (2026-07-07, found on tMenuItemSlidingActivated::
    # TransitionOn -- a 2-level chain, tMenuItemSlidingActivated->
    # tMenuItemSlidingMenu->tMenuItem, where tMenuItemSlidingMenu declares 13
    # fields across multi-declarator lines):
    #   (a) UNDERCAPTURE — `(\w+)\s*(?:\[...\])?\s*;` only grabs the LAST name
    #       before each `;`, so a comma-list declarator line like
    #       `short fWidth, fHeight, fOpenHeight, fSlideOffset, fFadeVal,
    #       fFadeDir;` yielded ONLY `fFadeDir`, silently dropping the other 5
    #       (and `tInsideBoxMenu *currMenu, *nextMenu;` dropped `currMenu`).
    #       Symptom: most inherited-field accesses in the method body were
    #       left as bare `this->field` — invalid C after flattening, and
    #       pycparser/cc1 rejects the whole base.c ("has no member named").
    #   (b) OVERCAPTURE — the synthetic `_vbase_` member name of a base-of-
    #       base (e.g. `tMenuItem _vbase_;` inside `tMenuItemSlidingMenu`'s
    #       own flattened body) matched the SAME generic `(\w+)\s*;` pattern
    #       and got treated as a real field to rewrite. Applying its rewrite
    #       rule AFTER a field that ALREADY got correctly rewritten to
    #       `this->_vbase_.fFadeDir` re-matched the literal `_vbase_` inside
    #       that result and prefixed it AGAIN -> `this->_vbase_._vbase_.
    #       fFadeDir` (wrong: double-hop for a field that's only 1 level up).
    # Fix: split multi-declarator lines on `,` before extracting names, strip
    # any leading `*`/array suffix per name, and explicitly exclude the
    # `_vbase_` sentinel itself from the field set at each level.
    prefix = ""
    cur_cls = cls
    seen_levels = 0
    while seen_levels < 8:                       # generous depth guard, not a real limit
        vbase_m = re.search(r"\bstruct\s+" + re.escape(cur_cls) + r"\s*\{\s*(\w+)\s+_vbase_\s*;", text)
        if not vbase_m:
            break
        base_cls = vbase_m.group(1)
        prefix += "_vbase_."
        base_body_m = re.search(r"\bstruct\s+" + re.escape(base_cls) + r"\s*\{([^}]*)\}", text)
        if base_body_m:
            raw_body = base_body_m.group(1)
            own_fields = set()
            for decl in raw_body.split(";"):
                # each `;`-terminated declarator list, e.g. " short fWidth, fHeight"
                # or " tInsideBoxMenu *currMenu, *nextMenu" or " tMenuItem _vbase_"
                for part in decl.split(","):
                    nm = re.findall(r"(\w+)\s*(?:\[[^\]]*\])?\s*$", part.strip())
                    if nm:
                        own_fields.add(nm[-1])
                # field-pointer decl `T (*name)[N]` (e.g. the vtable `_vf`) needs its
                # own pattern (the generic split-on-comma above misparses the `(*name)`).
                own_fields |= set(re.findall(r"\(\s*\*\s*(\w+)\s*\)", decl))
            own_fields.discard("_vbase_")             # exclude the sentinel itself (bug b)
            for fld in own_fields:
                body = re.sub(r"\bthis\s*->\s*" + re.escape(fld) + r"\b(?!\s*\()",
                               "this->" + prefix + fld, body)
        cur_cls = base_cls
        seen_levels += 1

    called = set(re.findall(r"this\s*->\s*(\w+)\s*\(", body))
    body = re.sub(r"this\s*->\s*(\w+)\s*\(\s*\)", cls + r"__\1(thiz)", body)
    body = re.sub(r"this\s*->\s*(\w+)\s*\(", cls + r"__\1(thiz, ", body)
    body = re.sub(r"\bthis\b", "thiz", body)
    if initstmt:
        body = "{\n" + initstmt + body[1:]
    protos = base_proto + "".join(
        "extern int %s__%s(...);\n" % (cls, n) for n in sorted(called))
    header = ret + fnname + "(" + newparams + ")"
    return protos + text[:m.start()] + header + " " + body + text[bend + 1:]


def do_setup(module, symbol, asm_rel):
    """Build a single-function permuter job:
        base.c    = sanitized, pycparser-clean, ONLY the target function +
                    its (method-stripped, layout-exact) type context;
        target.o  = the original bytes, assembled from the one nonmatching .s;
        settings  = func_name is the C source name (the object is whole-diffed,
                    so the mangled symbol need not match)."""
    import permuter_sanitize as san

    src_name = _demangle(symbol)
    work = ROOT / "permuter_work" / symbol
    work.mkdir(parents=True, exist_ok=True)

    # 1. preprocess the recon module to flat C++ (includes resolved); strip
    #    comments + line markers the way the permuter's own cpp will.
    mod = RECON / module
    pp = subprocess.run(
        [str(SYSCPP), "-P", "-nostdinc", "-DPERMUTER",
         "-D__mips__", "-D__psx__",
         "-I", str(mod.parent), "-I", str(RECON), str(mod)],
        capture_output=True, text=True)
    if pp.returncode:
        sys.exit(f"[setup cpp] {pp.stderr}")

    # 2. sanitize C++ -> pycparser-clean C, then reduce to the one function.
    base_c = san.reduce_to_fn(san.sanitize(pp.stdout), src_name)
    if src_name not in base_c:
        sys.exit(f"[setup] target function {src_name} not found after reduce")
    base_c = _lower_method(base_c, src_name)   # C++ method -> plain-C (explicit thiz)
    (work / "base.c").write_text(base_c)

    # 3. target.o = original bytes from the single nonmatching .s.
    wrap = work / "_target.s"
    wrap.write_text('.include "macro.inc"\n' + (ROOT / asm_rel).read_text())
    r = subprocess.run([str(AS), "-EL", "-march=r3000", "-mtune=r3000", "-G0",
                        "-I", str(ROOT / "include"), str(wrap),
                        "-o", str(work / "target.o")], capture_output=True, text=True)
    if r.returncode:
        sys.exit(f"[setup as] {r.stderr}")

    (work / "compile.sh").write_text(
        "#!/bin/bash\n"
        f'"{sys.executable}" "{Path(__file__).as_posix()}" compile "$@"\n')
    (work / "settings.toml").write_text(
        f'func_name = "{src_name}"\ncompiler_type = "gcc"\n')
    print(f"created {work}  (func_name={src_name})")
    print(f"run: python tools/run_permuter.py {work.as_posix()} -j")


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    if sys.argv[1] == "compile":
        do_compile(sys.argv[2:])
    elif sys.argv[1] == "setup":
        do_setup(*sys.argv[2:5])
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main()
