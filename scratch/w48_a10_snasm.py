# -*- coding: utf-8 -*-
"""w48-a10 REAL-ASPSX differential harness.

Assemble a .s with a REAL SN ASPSX.EXE, parse the SN-LNK v2 object, and dump
the resulting machine words (disassembled).  Purpose: answer "does the real
assembler do X?" without ever emulating it.

usage:
    python w48_a10_snasm.py <file.s> [--asm 2.77|2.79|2.81] [--args "-G4"]
                            [--sec N] [--raw]
"""
import os, re, struct, subprocess, sys, tempfile

ASMS = {
    "2.77": r"C:\Temp\psq43\PSSN\ASPSX.EXE",
    "2.79": r"C:\Temp\psq45\BIN\ASPSX.EXE",
    "2.81": r"C:\Temp\psq45\BIN\WIN\ASPSX.EXE",
}
OBJDUMP = r"C:\Tools\mips-ps1\mips\bin\mipsel-none-elf-objdump.exe"


def to_crlf(path):
    d = open(path, "rb").read().replace(b"\r\n", b"\n").replace(b"\n", b"\r\n")
    open(path, "wb").write(d)


def assemble(src, ver="2.77", extra=None, quiet=True):
    """Assemble src (a path) -> obj path.  Returns (objpath, stdout)."""
    to_crlf(src)
    obj = os.path.splitext(src)[0] + "_%s.obj" % ver.replace(".", "")
    cmd = [ASMS[ver]]
    if extra:
        cmd += extra
    cmd += ["-o", obj, src]
    if os.path.exists(obj):
        os.unlink(obj)
    r = subprocess.run(cmd, capture_output=True, text=True)
    if not os.path.exists(obj):
        sys.stderr.write(r.stdout + r.stderr)
        raise SystemExit("aspsx failed: %s" % cmd)
    if r.returncode != 0:
        sys.stderr.write("# (aspsx warnings, object produced)\n")
    return obj, r.stdout


class Obj(object):
    pass


def parse(path):
    """Parse an SN-LNK v2 object.  Returns Obj with .code {sec: bytearray},
    .symbols {name: (sec, off)}, .relocs {sec: {off: type}}, .secnames."""
    d = open(path, "rb").read()
    assert d[:3] == b"LNK", d[:8]
    st = {"p": 4}

    def u8():
        v = d[st["p"]]; st["p"] += 1; return v

    def u16():
        v = struct.unpack_from("<H", d, st["p"])[0]; st["p"] += 2; return v

    def u32():
        v = struct.unpack_from("<I", d, st["p"])[0]; st["p"] += 4; return v

    def name():
        n = u8(); s = d[st["p"]:st["p"] + n].decode("latin1"); st["p"] += n; return s

    def skip_expr():
        t = u8()
        if t == 0:
            u32()
        elif t in (2, 4, 12, 22):
            u16()
        elif t in (44, 50, 54, 46, 36, 38, 40, 42, 32, 34,
                   10, 16, 18, 20, 24, 26, 28, 30):
            skip_expr(); skip_expr()
        else:
            raise SystemExit("unknown expr tag %d @%d" % (t, st["p"] - 1))

    o = Obj()
    o.code = {}
    o.symbols = {}
    o.relocs = {}
    o.secnames = {}
    o.xrefs = {}
    cur = None
    while st["p"] < len(d):
        tag = u8()
        if tag == 0:
            break
        elif tag == 2:
            n = u16(); o.code.setdefault(cur, bytearray()).extend(d[st["p"]:st["p"] + n]); st["p"] += n
        elif tag == 6:
            cur = u16()
        elif tag == 8:
            u32()
        elif tag == 10:
            t = u8(); off = u16(); skip_expr()
            o.relocs.setdefault(cur, {})[off] = t
        elif tag == 12:
            u16(); sec = u16(); off = u32(); nm = name(); o.symbols[nm] = (sec, off)
        elif tag == 14:
            n = u16(); o.xrefs[n] = name()
        elif tag == 16:
            num = u16(); u16(); u8(); o.secnames[num] = name()
        elif tag == 18:
            u16(); u32(); name()
        elif tag == 28:
            u16(); name()
        elif tag == 80:
            pass
        elif tag == 82:
            u8()
        elif tag == 84:
            u16()
        elif tag == 86:
            u32()
        elif tag == 88:
            u16(); u32()
        elif tag == 48:
            u16(); u16(); u32(); name()
        elif tag == 46:
            u8()
        elif tag == 60:
            u16(); u32(); u16(); u32(); u16(); u32(); u16(); u32(); u32(); name()
        elif tag == 62:
            u16(); u32(); u32()
        elif tag in (64, 66):
            u16(); u32(); u32()
        else:
            raise SystemExit("unknown tag %d @%d" % (tag, st["p"] - 1))
    return o


def disasm(words_bytes, base=0):
    """Disassemble raw little-endian MIPS words via objdump -b binary."""
    with tempfile.NamedTemporaryFile(suffix=".bin", delete=False) as f:
        f.write(bytes(words_bytes)); tmp = f.name
    try:
        r = subprocess.run([OBJDUMP, "-b", "binary", "-m", "mips:3000",
                            "-EL", "-D", tmp], capture_output=True, text=True)
        lines = []
        for ln in r.stdout.splitlines():
            m = re.match(r"\s*([0-9a-f]+):\s+([0-9a-f]{8})\s+(.*)$", ln)
            if m:
                lines.append((int(m.group(1), 16), int(m.group(2), 16), m.group(3).strip()))
        return lines
    finally:
        os.unlink(tmp)


def dump(objpath, sec=None, show_reloc=True):
    o = parse(objpath)
    if sec is None:
        sec = max(o.code, key=lambda k: len(o.code[k]))
    rel = o.relocs.get(sec, {})
    print("# section %s (%s)  %d bytes  syms: %s" %
          (sec, o.secnames.get(sec, "?"), len(o.code[sec]),
           sorted([(v[1], k) for k, v in o.symbols.items() if v[0] == sec])))
    for off, w, txt in disasm(o.code[sec]):
        mark = ("  <reloc t%d>" % rel[off]) if (show_reloc and off in rel) else ""
        print("%4d  %04x  %08x  %s%s" % (off // 4, off, w, txt, mark))
    return o


if __name__ == "__main__":
    args = sys.argv[1:]
    src = args[0]
    ver = "2.77"
    extra = []
    if "--asm" in args:
        ver = args[args.index("--asm") + 1]
    if "--args" in args:
        extra = args[args.index("--args") + 1].split()
    obj, out = assemble(src, ver, extra)
    print("# aspsx %s %s -> %s" % (ver, " ".join(extra), obj))
    dump(obj)
