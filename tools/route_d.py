#!/usr/bin/env python3
"""route_d.py -- build route D: route C's object set with the recon/mod overrides spliced in.

  python tools/route_d.py --stage A|B|C|F [--no-compile] [--no-assemble] [--no-cpe] [--adds-after-libs] [--manifest J]

Inputs : build/psyq_off/        the route C (official lane) objects + nfs4.lnk + front_objs.json
         recon/mod/manifest.json which objects to override / add / link ahead of the Sony LIBs
Outputs: build/route_d/         a private copy of the lane (the main lane is never written),
                                nfs4_d.lnk / .cpe / .sym / .map, off_front.bin, disc/NFS4.EXE + FRONT.BIN,
                                report.json (section sizes, endofcode, heap size, slink messages)

Steps  : 1. assemble the mod TUs with the official lane (psylink_lane.py --assemble, NFS4_LANE_ONLY=recon/mod)
            into build/route_d (the lane needs build/recon/mod/**.s from tools/build.py first);
         2. copy the route C objects into build/route_d and rewrite the include list per the manifest;
         3. pack EA libraries and link with SN slink /strip (same script shape as slink_lane.py);
         4. CPE2X -> NFS4.EXE, off_front.bin -> FRONT.BIN.
"""
import json, os, re, shutil, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SRC_LANE = ROOT / 'build/psyq_off'
OUT = ROOT / 'build/route_d'
MANIFEST = Path(sys.argv[sys.argv.index('--manifest') + 1]) if '--manifest' in sys.argv else ROOT / 'recon/mod/manifest.json'
SDK = Path('C:/Temp/psq43')
SDKLIB = SDK / 'PSX' / 'LIB'
PSYLIB = str(SDK / 'PSSN' / 'PSYLIB2.EXE')
SLINK = str(ROOT / 'build/tmp/slink3b/slink.exe')
LIBCD44 = Path('C:/Temp/psq44/psx/lib/patches/LIBCD.LIB')     # retail's libcd (slink_lane.py)
CPE2X = 'C:/Temp/psq43/PSX/BIN/CPE2X.EXE'
MSDOS = str(ROOT / 'tools/msdos-player/msdos.exe')
ENV = dict(os.environ, MSYS2_ARG_CONV_EXCL='*', MSYS_NO_PATHCONV='1')
BS = chr(92)
FRONT_SIZE = 0x44548
HEAP_TOP = 0x801FC000


def objname(rel):
    return rel.replace('/', '__') + '.obj'


def run(cmd, **kw):
    r = subprocess.run(cmd, capture_output=True, text=True, env=ENV, **kw)
    return r.stdout + r.stderr


def compile_mod():
    """Compile every recon/mod TU with tools/build.py (gcc 2.8 cc1 -> build/recon/mod/**.s + .o).  The main build
    skips the recon/ side trees, so they are passed explicitly as --only object paths."""
    srcs = sorted([*(ROOT / 'recon/mod').rglob('*.cpp'), *(ROOT / 'recon/mod').rglob('*.c')])
    targets = ','.join('build/%s.o' % s.relative_to(ROOT).as_posix() for s in srcs)
    r = subprocess.run([sys.executable, 'tools/build.py', '--no-link', '--only', targets], cwd=ROOT,
                       capture_output=True, text=True)
    out = r.stdout + r.stderr
    bad = [l for l in out.splitlines() if l.startswith('FAIL') or 'error' in l.lower()]
    print('compile: %d OK, %d problem lines' % (out.count(chr(10) + 'OK '), len(bad)))
    for l in bad[:30]:
        print('   ', l[:200])
    if bad or r.returncode:
        print(out[-3000:])
        sys.exit('mod TUs did not compile')


def assemble_mod():
    """Assemble every recon/mod TU (build/recon/mod/**.s from tools/build.py) with ASPSX into OUT.

    The main lane (psylink_lane.py --assemble) deliberately skips the recon/ side trees since a26eced3, so route D
    drives the same converter itself: import the lane with a no-op step under the OFFICIAL environment and reuse
    its crlf()/sn_text() (dtor-prefix convention, OFFICIAL .lcomm handling) + the same ASPSX command line."""
    os.environ.update(NFS4_LANE_OFFICIAL='1', NFS4_LANE_OUT=str(OUT.relative_to(ROOT)).replace(BS, '/'))
    saved_argv, sys.argv = sys.argv, ['psylink_lane.py', '--noop']
    sys.path.insert(0, str(ROOT / 'tools/psyq_pipe')); sys.path.insert(0, str(ROOT / 'tools'))
    try:
        import psylink_lane as lane
        import build
    finally:
        sys.argv = saved_argv
    srcs = sorted([*(ROOT / 'recon/mod').rglob('*.cpp'), *(ROOT / 'recon/mod').rglob('*.c')])
    ok, fails = 0, []
    for src in srcs:
        rel = src.relative_to(ROOT).as_posix()
        sfile = ROOT / 'build' / (rel + '.s')
        if not sfile.is_file():
            fails.append((rel, ['no build/%s.s -- run tools/build.py for this TU first' % rel]))
            continue
        g = str(build.per_tu_flags(src.resolve()).get('g_value', build.G_VALUE))
        tmp = OUT / (rel.replace('/', '__') + '.s')
        lane.crlf(sfile, tmp, front=False, pads=None, g=int(g))
        obj = OUT / objname(rel)
        if obj.exists():
            obj.unlink()
        r = subprocess.run([lane.ASPSX, '-q', '-G%s' % g, str(tmp), '-o', str(obj)], capture_output=True, text=True,
                           timeout=120, cwd=str(ROOT))
        if obj.is_file():
            ok += 1
        else:
            fails.append((rel, (r.stdout + r.stderr).strip().splitlines()[:2]))
    (OUT / 'work').mkdir(exist_ok=True)
    (OUT / 'work' / 'assemble_fails.json').write_text(json.dumps(fails, indent=1))
    print('assemble: %d mod objects OK, %d failed' % (ok, len(fails)))
    for f in fails:
        print('  ASPSX FAIL', f[0], f[1])
    if fails:
        sys.exit('mod objects did not assemble')


def copy_lane():
    OUT.mkdir(parents=True, exist_ok=True)
    for p in SRC_LANE.glob('*.obj'):
        if not p.name.startswith('recon__mod__'):
            shutil.copyfile(p, OUT / p.name)
    for n in ('nfs4.lnk', 'front_objs.json'):
        shutil.copyfile(SRC_LANE / n, OUT / n)


def build_script(stage):
    """off.lnk (route C's proven script) verbatim, with: the front overlay file renamed, the manifest's
    overrides swapped in place, its game additions after the last main game include, and (stage B) the
    syslib replacements just before the first inclib."""
    man = json.load(open(MANIFEST))
    lines = (SRC_LANE / 'off.lnk').read_text(encoding='latin-1').splitlines()
    for p in SRC_LANE.glob('*.lib'):
        shutil.copyfile(p, OUT / p.name)
    out = []
    over = {k: objname(v) for k, v in man['override'].items()}
    replaced = set()
    for ln in lines:
        s = ln.strip()
        if s.startswith('front') and 'group' in s:
            ln = 'front	group	over(text),file("nfs4_d_front.bin")'
        m = re.match(r'\s*include\s+([^\s,;]+)', ln)
        if m and m.group(1) in over:
            ln = '	include	%s	; route D override of %s' % (over[m.group(1)], m.group(1))
            replaced.add(m.group(1))
        ln = ln.replace(str(SRC_LANE).replace('/', BS), str(OUT).replace('/', BS))
        out.append(ln)
    missing = set(over) - replaced
    if missing:
        sys.exit('override targets not in the route C link: %s' % sorted(missing))
    last_main = max(i for i, ln in enumerate(out) if re.match(r'\s*include\s', ln) and ',front' not in ln
                    and 'bigbuf' not in ln and 'address.c' not in ln and 'endcode' not in ln)
    adds = ['	include	%s	; route D' % objname(v) for v in man['add_game']]
    if '--adds-after-libs' in sys.argv:
        # keep every retail object at its retail address: new game code goes after the last inclib (end of .text)
        last_lib = max(i for i, ln in enumerate(out) if ln.strip().startswith('inclib'))
        out = out[:last_lib + 1] + adds + out[last_lib + 1:]
    else:
        out = out[:last_main + 1] + adds + out[last_main + 1:]
    first_lib = next(i for i, ln in enumerate(out) if ln.strip().startswith('inclib'))
    fixes = ['	include	%s	; route D relink fix (preempts the library member)' % objname(v) for v in man.get('fixes_before_libs', [])]
    out = out[:first_lib] + fixes + out[first_lib:]
    if stage == 'F':
        # Sony library members that only the front end uses (movie decoder, memory card) go INTO the front
        # overlay: they vanish from the resident image (endofcode moves down, the EA heap grows) and come back
        # with front.bin.  Members are listed explicitly so the dead-stripping linker never pulls the
        # resident copies from the .LIB files.
        last_front = max(i for i, ln in enumerate(out) if re.match(r'\s*include\s', ln) and ',front' in ln)
        libs = ['	include	%s,front	; route F: front-only library member' % str((ROOT / v).resolve()).replace('/', BS)
                for v in man.get('front_libs', [])]
        out = out[:last_front + 1] + libs + out[last_front + 1:]
    if stage in ('B', 'C', 'F'):
        first_lib = next(i for i, ln in enumerate(out) if ln.strip().startswith('inclib'))
        repl = man['add_before_libs'] + (man.get('add_before_libs_stage_c', []) if stage == 'C' else [])
        pre = ['	include	%s	; route D syslib replacement' % objname(v) for v in repl]
        out = out[:first_lib] + pre + out[first_lib:]
    (OUT / 'nfs4_d.lnk').write_text('\r\n'.join(out) + '\r\n', encoding='latin-1')


def link():
    for f in ('nfs4_d.cpe', 'nfs4_d.sym', 'nfs4_d.map', 'nfs4_d_front.bin', 'statcov.txt'):
        if (OUT / f).exists():
            (OUT / f).unlink()
    cmd = [SLINK, '/psx', '/c', '/strip', '-nostrip', 'stup1', '-nostrip', '@nfs4_d.lnk,nfs4_d.cpe,nfs4_d.sym,nfs4_d.map']
    log = run(cmd, cwd=OUT, timeout=900)
    (OUT / 'nfs4_d.log').write_text(log)
    errs = [l for l in log.splitlines() if 'rror' in l or 'not defined' in l or 'uplicate' in l]
    print('slink:', log.strip().splitlines()[-1] if log.strip() else '?')
    for e in errs[:40]:
        print('   ', e[:160])
    if not (OUT / 'nfs4_d.map').exists():
        sys.exit('link failed')
    return errs


def report(errs):
    mp = (OUT / 'nfs4_d.map').read_text(encoding='latin-1')
    secs = {m.group(5): (int(m.group(1), 16), int(m.group(3), 16))
            for m in re.finditer(r'^ ([0-9A-F]{8}) ([0-9A-F]{8}) ([0-9A-F]{8}) [0-9A-F]{8} (\S+)\s+(\S+)\s*$', mp, re.M)}
    syms = {m.group(2): int(m.group(1), 16) for m in re.finditer(r'^ ([0-9A-F]{8}) (\S+)\s*$', mp, re.M)}
    eoc = syms.get('endofcode')
    rep = dict(sections={k: dict(addr=hex(v[0]), size=v[1]) for k, v in secs.items()},
               endofcode=hex(eoc) if eoc else None,
               heap_bytes=(HEAP_TOP - (eoc + 8)) if eoc else None, retail_heap_bytes=734452,
               link_messages=errs)
    (OUT / 'report.json').write_text(json.dumps(rep, indent=1))
    print('endofcode', rep['endofcode'], 'heap', rep['heap_bytes'], '(retail 734452, gain %s)' % ((rep['heap_bytes'] or 0) - 734452))
    for n in ('.rdata', '.text', '.data', '.sdata', '.sbss', '.bss', 'front.text', 'front.bss'):
        if n in secs:
            print('   %-11s %7X' % (n, secs[n][1]))


def cpe():
    shutil.copy(CPE2X, OUT / 'CPE2X.EXE')
    shutil.copy(OUT / 'nfs4_d.cpe', OUT / 'NFS4.CPE')
    log = run([MSDOS, 'CPE2X.EXE', '/CA', 'NFS4.CPE'], cwd=OUT, timeout=600)
    print('CPE2X:', (log.strip().splitlines() or ['?'])[-1])
    disc = OUT / 'disc'
    disc.mkdir(exist_ok=True)
    shutil.copy(OUT / 'NFS4.EXE', disc / 'NFS4.EXE')
    shutil.copy(OUT / 'nfs4_d_front.bin', disc / 'FRONT.BIN')
    print('disc files:', (disc / 'NFS4.EXE').stat().st_size, (disc / 'FRONT.BIN').stat().st_size, '(retail 1239040 / 279880)')


def main():
    stage = sys.argv[sys.argv.index('--stage') + 1] if '--stage' in sys.argv else 'A'
    copy_lane()
    if '--no-assemble' not in sys.argv:
        if '--no-compile' not in sys.argv:
            compile_mod()
        assemble_mod()
    build_script(stage)
    errs = link()
    report(errs)
    if '--no-cpe' not in sys.argv:
        cpe()


if __name__ == '__main__':
    main()
