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
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
RECON = ROOT / "recon"
INCLUDE = ROOT / "include"
NFS4_NEW_H = RECON / "lib" / "nfs4_new.h"   # real placement `operator new` decl
MIPS = Path(os.environ.get("NFS4_MIPS_BIN", r"C:/Tools/mips-ps1/mips/bin"))
CPP = MIPS / "mipsel-none-elf-cpp.exe"
AS = MIPS / "mipsel-none-elf-as.exe"
CC1PL = Path(os.environ.get("NFS4_CC1PL", r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE"))
# CC1PSX -- the C-lane compiler (src/**/*.c and the recon/**/*.c modules EA's
# retail toolchain built with the plain C compiler, e.g. eacpsxz/sndpsxz/
# spchpsxz). Same env var name as build.py's NFS4_CC1 so one override covers
# both drivers.
CC1 = Path(os.environ.get("NFS4_CC1", r"C:/Temp/psq43/COMPILER/CC1PSX.EXE"))
MASPSX = Path(os.environ.get("NFS4_MASPSX", r"C:/Temp/maspsx-master/maspsx.py"))


def _lang_for(module_rel: str) -> str:
    """.c source -> the CC1PSX (C) lane; anything else (.cpp) -> CC1PLPSX (C++).
    Mirrors build.py's dispatch: compile_c() for src/**/*.c AND recon/**/*.c,
    compile_cpp() for recon/**/*.cpp."""
    return "c" if module_rel.endswith(".c") else "cpp"


def do_compile(args):
    # permuter passes e.g.  -c <in.c> -o <out.o>  (plus PERMUTER defines).
    # tools/run_permuter.py bakes an optional leading `--lang c|cpp` and
    # `--newtypes T1,T2,...` into the NFS4_COMPILE_DRIVER argv prefix (one
    # job = one language/one fixed set of placement-new types, decided at
    # `setup` time and recorded in permuter_work/<sym>/lang and .../new_types)
    # so this can pick the matching compiler lane / macro set without any
    # info in the (randomly-named, tempdir-located) .c file itself.
    lang, newtypes = "cpp", []
    while args[:1] in (["--lang"], ["--newtypes"]):
        if args[0] == "--lang":
            lang = args[1]
        else:
            newtypes = [t for t in args[1].split(",") if t]
        args = args[2:]
    in_c = next(a for a in args if a.endswith(".c"))
    out_o = args[args.index("-o") + 1]
    i_file, s_file = out_o + ".i", out_o + ".s"
    if lang == "c":
        # Exactly build.py's compile_c() CPP_FLAGS/CC1_FLAGS/maspsx include
        # set (the real toolchain lane for EA's plain-C library modules), plus
        # -DPERMUTER=1 for parity with the C++ lane's define.
        subprocess.run([str(CPP), "-nostdinc", "-undef",
                        "-D__GNUC__=2", "-D__OPTIMIZE__", "-DPERMUTER=1",
                        "-Dmips", "-D__mips__", "-D__psx__", "-DPSX",
                        f"-I{INCLUDE}", in_c, "-o", i_file], check=True)
        subprocess.run([str(CC1), "-quiet", "-O2", "-G4", "-g1", "-mgpOPT",
                        "-fgnu-linker", i_file, "-o", s_file], check=True)
        maspsx_extra = ["-I", str(INCLUDE), "-I", str(ROOT)]
    else:
        # The op_new/op_delete/new_<TYPE> -D's are the inverse of
        # permuter_sanitize.py's _wrap_new_expressions transform 5: expand
        # the plain-looking calls it wrote (so pycparser could parse them --
        # it has zero grammar for C++ `new`) back into the literal original
        # `operator new/delete(...)` / placement `new(P) T(args)` text BEFORE
        # CC1PLPSX ever sees it, so codegen is byte-identical to never having
        # rewritten anything. One macro PER TYPE (`newtypes`, from this job's
        # new_types file) because a bare type name isn't a valid C expression
        # -- pycparser needs TYPE folded into the macro's own NAME, not passed
        # as an argument (see the sanitizer's docstring for the full
        # reasoning + the failed argument-based design this replaced).
        # `args...` (not ISO `__VA_ARGS__`) is required for the zero-ctor-arg
        # case (`new(p) T()`) -- verified directly against this cpp binary.
        new_defs = [f"-D__nfs4_new_{t}(P,args...)=new(P) {t}(args)" for t in newtypes]
        # reduce_to_fn() drops every function DEFINITION except the target
        # (that's how it gets pycparser-sized TUs at all) -- but the
        # placement `operator new(unsigned, void*)` this project's own
        # nfs4_new.h declares is `inline`, i.e. a definition, so it gets
        # dropped as a "sibling" like anything else, silently leaving
        # placement-new with only the single-arg heap `operator new(unsigned)`
        # in scope (CC1PLPSX: "too many arguments to function `operator
        # new(unsigned int)'" -- found compiling HighExecute__18AIHigh_BTC_
        # Wingman, 2026-07-20). `-include` re-adds it INVISIBLY to pycparser
        # (base.c's own text never changes -- pycparser only ever sees what
        # do_setup wrote) via cpp's own include-guard, so it's added exactly
        # once regardless of whether the original TU already had it before
        # reduction. Gated on newtypes so jobs using no placement-new see no
        # behavior change at all.
        new_incl = ["-include", str(NFS4_NEW_H)] if newtypes else []
        subprocess.run([str(CPP), "-x", "c", "-D__cplusplus=1", "-DPERMUTER=1",
                        "-nostdinc", "-undef", "-Dmips", "-D__mips__", "-D__psx__",
                        "-D__nfs4_op_new(n)=operator new(n)",
                        "-D__nfs4_op_delete(p)=operator delete(p)",
                        *new_defs, *new_incl,
                        f"-I{RECON}", in_c, "-o", i_file], check=True)
        subprocess.run([str(CC1PL), "-quiet", "-O2", "-G4", i_file, "-o", s_file], check=True)
        maspsx_extra = ["-I", str(RECON)]
    p = subprocess.run([sys.executable, str(MASPSX), "--aspsx-version=2.77",
                        "--run-assembler", f"--gnu-as-path={AS}", "-EL",
                        "-march=r3000", "-G4", *maspsx_extra, "-o", out_o, s_file],
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


def _redirect_base_fields(text, body, root_cls, accessor):
    """Rewrite `accessor->field` -> `accessor->_vbase_[._vbase_...].field` for
    every field declared somewhere in root_cls's flattened base chain (see
    _lower_method's "real-inheritance field access" comment for the full
    mechanism/history -- this is that walk, extracted so it can run once per
    ACCESSOR/HIERARCHY-ROOT pair instead of being hardwired to `this`/cls's
    own class). `permuter_sanitize.sanitize()` flattens `struct D : public B
    {...}` to `struct D { B _vbase_; ...}` for EVERY class in the TU, not
    just whichever one is `this`'s type, so a method's OTHER pointer
    parameters of some other flattened class need the identical treatment
    off their own name and their own hierarchy root."""
    import re
    prefix = ""
    cur_cls = root_cls
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
            own_fields.discard("_vbase_")             # exclude the sentinel itself
            for fld in own_fields:
                # Ghidra-derived recon text commonly wraps a plain pointer VARIABLE
                # in redundant parens before `->` (e.g. `(humanCop)->carObj_`), unlike
                # the `this` keyword, which is never parenthesized -- tolerate an
                # optional `( ... )` around the accessor and preserve it verbatim via
                # a captured group (2026-07-20, SetupWingman: bare `\bthis`-style
                # matching missed `(humanCop)->carObj_` entirely, silently leaving it
                # unredirected instead of erroring, which is why this needs its own
                # regression check, not just "did it compile").
                pat = re.compile(r"(\(?\s*\b" + re.escape(accessor) + r"\b\s*\)?\s*->\s*)"
                                  + re.escape(fld) + r"\b(?!\s*\()")
                body = pat.sub(lambda mm: mm.group(1) + prefix + fld, body)
        cur_cls = base_cls
        seen_levels += 1
    return body


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
    #
    # 🔴 THIRD BUG (2026-07-20, SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_
    # BTC_HumanCop, reported via a6): this walk only ever rewrote `this->fld`.
    # A method taking a POINTER PARAMETER of some other flattened class (e.g.
    # `AIHigh_BTC_HumanCop *humanCop`) has the exact same problem for
    # `humanCop->carObj_` -- `sanitize()` flattens EVERY class uniformly, not
    # just `this`'s own -- and previously nothing rewrote it, so CC1PLPSX
    # failed with `struct AIHigh_BTC_HumanCop' has no member named 'carObj_'`
    # (a compile-time error, not a parse error -- `ptr->field` is valid C
    # syntax; pycparser parsed it fine and only CC1PLPSX, resolving the
    # *flattened* struct's actual members, rejected it). Fix: extracted the
    # walk into _redirect_base_fields (below) so it can run once per accessor
    # -- `this` off `cls`'s own hierarchy as before, PLUS once per pointer
    # parameter `Type *name` off `Type`'s hierarchy.
    #
    # 🔴 FOURTH BUG (2026-07-20, CheckForWipeOut__10AIHigh_Cop, reported via
    # a15): same gap, a THIRD accessor shape -- a LOCAL VARIABLE of some
    # other flattened class's pointer type, declared inside the function
    # body rather than in the parameter list (`AIHigh_Player *pAVar3; ...
    # pAVar3 = thiz->perpTarget_; ... (pAVar3)->carObj_`). Not covered by
    # either the `this` or the parameter-list case above. Generalized: build
    # ONE list of every (type, accessor) pair needing redirection -- `this`
    # off cls, each pointer PARAMETER off its own type, each pointer LOCAL
    # DECLARATION found anywhere in the body off its own type -- and run
    # _redirect_base_fields once per pair. `_redirect_base_fields` is a
    # no-op if `type` doesn't turn out to head a flattened hierarchy (no
    # `struct type { Base _vbase_; ...}` match), so being liberal about what
    # counts as a "local pointer declaration" here is safe -- a false
    # positive (e.g. `int *p;`) just costs one wasted, harmless lookup.
    accessor_pairs = [(cls, "this")]
    for raw_param in params.split(","):
        pm = re.match(r"^\s*(?:const\s+)?(\w+)\s*\*+\s*(\w+)\s*$", raw_param)
        if pm and pm.group(1) != cls:      # cls's own type already covered via this->
            accessor_pairs.append((pm.group(1), pm.group(2)))
    for dm in re.finditer(r"^[ \t]*(\w+)\s+((?:\*\s*\w+\s*,\s*)*\*\s*\w+)\s*;\s*$",
                           body, re.MULTILINE):
        dtype = dm.group(1)
        if dtype == cls:
            continue                       # cls's own type already covered via this->
        for nm in re.findall(r"\*\s*(\w+)", dm.group(2)):
            accessor_pairs.append((dtype, nm))
    for dtype, accessor in accessor_pairs:
        body = _redirect_base_fields(text, body, dtype, accessor)

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

    # 1. preprocess the recon module to flat C/C++ (includes resolved); strip
    #    comments + line markers the way the permuter's own cpp will. Include
    #    dirs + macros mirror whichever real lane build.py would use for this
    #    module (compile_c's -I include vs compile_cpp's -I recon; the C lane
    #    also needs __GNUC__/__OPTIMIZE__/PSX since those TUs are EA's plain-C
    #    lib modules, not the vendored C++ reconstruction).
    mod = RECON / module
    lang = _lang_for(module)
    if lang == "c":
        cpp_cmd = [str(SYSCPP), "-P", "-nostdinc", "-DPERMUTER",
                   "-D__GNUC__=2", "-D__OPTIMIZE__", "-DPSX",
                   "-Dmips", "-D__mips__", "-D__psx__",
                   "-I", str(mod.parent), "-I", str(INCLUDE), str(mod)]
    else:
        cpp_cmd = [str(SYSCPP), "-P", "-nostdinc", "-DPERMUTER",
                   "-D__mips__", "-D__psx__",
                   "-I", str(mod.parent), "-I", str(RECON), str(mod)]
    pp = subprocess.run(cpp_cmd, capture_output=True, text=True)
    if pp.returncode:
        sys.exit(f"[setup cpp] {pp.stderr}")

    # 2. sanitize C++ -> pycparser-clean C, then reduce to the one function.
    base_c = san.reduce_to_fn(san.sanitize(pp.stdout), src_name)
    if src_name not in base_c:
        sys.exit(f"[setup] target function {src_name} not found after reduce")
    base_c = _lower_method(base_c, src_name)   # C++ method -> plain-C (explicit thiz)
    (work / "base.c").write_text(base_c)
    # every distinct __nfs4_new_<TYPE> permuter_sanitize.sanitize() emitted
    # (placement-new rewrite -- see its docstring). do_compile needs one
    # inverse -D macro PER TYPE, and only this job knows which types its
    # target function actually uses -- run_permuter.py reads this file back
    # to build them (there's no other channel: do_compile only ever sees a
    # randomly-named tempdir .c file, same reason `lang` is threaded this way).
    new_types = sorted(set(re.findall(r"__nfs4_new_(\w+)\(", base_c)))
    (work / "new_types").write_text("\n".join(new_types))

    # 3. target.o = original bytes from the single nonmatching .s.
    wrap = work / "_target.s"
    wrap.write_text('.include "macro.inc"\n' + (ROOT / asm_rel).read_text())
    r = subprocess.run([str(AS), "-EL", "-march=r3000", "-mtune=r3000", "-G0",
                        "-I", str(ROOT / "include"), str(wrap),
                        "-o", str(work / "target.o")], capture_output=True, text=True)
    if r.returncode:
        sys.exit(f"[setup as] {r.stderr}")

    newtypes_arg = ",".join(new_types)
    (work / "compile.sh").write_text(
        "#!/bin/bash\n"
        f'"{sys.executable}" "{Path(__file__).as_posix()}" compile '
        f'--lang {lang} --newtypes {newtypes_arg} "$@"\n')
    (work / "settings.toml").write_text(
        f'func_name = "{src_name}"\ncompiler_type = "gcc"\n'
        f'# lang = "{lang}" (see ./lang); new_types = {new_types} (see ./new_types)\n')
    # tools/run_permuter.py reads these to build NFS4_COMPILE_DRIVER with the
    # right --lang/--newtypes, since the compiler receives only a randomly-
    # named tempdir .c file (no clue which lane/types it came from) -- see
    # do_compile's docstring.
    (work / "lang").write_text(lang)
    print(f"created {work}  (func_name={src_name}, lang={lang}"
          f"{', new_types=' + str(new_types) if new_types else ''})")
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
