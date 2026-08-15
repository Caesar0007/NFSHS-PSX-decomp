"""w65a3: make a class's dtor IMPLICIT and supply its standalone symbol.

Retail's dtor graph (read off every asm/nonmatchings/**/___*.s) has exactly two
shapes: a 10-insn body that stores `_vt_<class>` into the object = the class
that really OWNS a declared dtor, and a plain 8-insn `jal <ancestor>; nop` =
a dtor gcc SYNTHESISED, which therefore chains to the nearest ancestor that
owns one.  Our recon declared a dtor on every class, so each derived dtor
jal'd its DIRECT base instead of that ancestor.

For each (class, target-dtor-symbol, source file) this:
  1. deletes `~Class();` from recon/nfs4_types.h (non-virtual: ZERO layout change);
  2. replaces the trivial `Class::~Class() {...return;}` definition, IN PLACE so
     the object's symbol ORDER is preserved, with
     `extern "C" void ___<len><Class>(void *thisp) { <target>(thisp); }`
     -- the ___18tDialogInteractive / ___31tDialogMessageStringWithTimeout
     device already in fedialog.cpp.  The body must be trivial (comments +
     `return;` only); anything else aborts.
Byte-level throughout, so mixed-EOL TUs are never normalised.

usage: python implicit_dtor.py <spec.tsv>  [--dry]
spec:  Class <TAB> targetDtorSymbol <TAB> recon-relative-source-path
"""
import os
import re
import sys
from pathlib import Path

ROOT = Path(r'C:\Temp\nfs4-decomp')
HDR = ROOT / 'recon' / 'nfs4_types.h'


def strip_decl(txt, cls):
    pat = re.compile(r'[ \t]*~' + re.escape(cls) + r'\(\);[^\r\n]*\r?\n')
    hits = pat.findall(txt)
    assert len(hits) == 1, f'{cls}: {len(hits)} `~{cls}();` declarations'
    return pat.sub('', txt, count=1)


def swap_def(txt, cls, target):
    sym = f'___{len(cls)}{cls}'
    pat = re.compile(re.escape(f'{cls}::~{cls}()') + r'\s*\{(.*?)\n\}', re.S)
    m = pat.search(txt)
    assert m, f'{cls}: no `{cls}::~{cls}()` definition found'
    body = re.sub(r'/\*.*?\*/', '', m.group(1), flags=re.S)
    assert re.fullmatch(r'\s*(return\s*;)?\s*', body), \
        f'{cls}: dtor body is NOT trivial:\n{m.group(1)}'
    rep = (f'/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from\n'
           f' * nfs4_types.h) so every derived dtor and every scope-exit collapses to\n'
           f' * {target} the way retail does; the standalone symbol gcc then stops\n'
           f' * emitting is supplied here, in place, with C linkage. */\n'
           f'extern "C" void {target}(void *);\n'
           f'extern "C" void {sym}(void *thisp) {{ {target}(thisp); }}')
    return txt[:m.start()] + rep + txt[m.end():], sym


def main():
    dry = '--dry' in sys.argv
    spec = [l.split('\t') for l in Path(sys.argv[1]).read_text().split('\n')
            if l.strip() and not l.startswith('#')]
    hdr = HDR.read_bytes().decode('latin-1')
    for cls, target, src in spec:
        hdr = strip_decl(hdr, cls)
    per_file = {}
    for cls, target, src in spec:
        per_file.setdefault(src, []).append((cls, target))
    for src, items in per_file.items():
        p = ROOT / src
        txt = p.read_bytes().decode('latin-1')
        for cls, target in items:
            txt, sym = swap_def(txt, cls, target)
            print(f'  {src}: {cls} -> {sym} calls {target}')
        if not dry:
            out = txt.encode('latin-1')
            tmp = p.with_suffix(p.suffix + '.w65tmp')
            tmp.write_bytes(out)
            assert tmp.stat().st_size == len(out) > 0
            os.replace(tmp, p)
    if not dry:
        out = hdr.encode('latin-1')
        tmp = HDR.with_suffix('.w65tmp')
        tmp.write_bytes(out)
        assert tmp.stat().st_size == len(out) > 0
        os.replace(tmp, HDR)
    print(f'{"DRY " if dry else ""}{len(spec)} classes converted')


main()
