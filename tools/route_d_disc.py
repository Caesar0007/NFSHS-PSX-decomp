#!/usr/bin/env python3
"""route_d_disc.py -- build the route D disc image.

  python tools/route_d_disc.py [--name nfs4-route-d] <track dir> [<track dir> ...]

Stages build/route_d/disc/NFS4.EXE + FRONT.BIN and every file of the given track directories into the
dumpsxiso tree build/cd/nfs4-route-d, adds XML entries for file names the retail disc does not have
(root directory, kept alphabetical), and runs mkpsxiso -> build/cd/<name>.bin + .cue.

One-time setup of the tree:
  tools/psxiso/dumpsxiso.exe -x build/cd/nfs4-route-d -s build/cd/nfs4-route-d.xml C:/Temp/nfs4iso/NFS4.IMG
"""
import os, shutil, subprocess, sys
import xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'build/route_d'
CD = ROOT / 'build/cd'
CD_TREE = CD / 'nfs4-route-d'
CD_XML = CD / 'nfs4-route-d.xml'
MKPSXISO = ROOT / 'tools/psxiso/mkpsxiso.exe'
ENV = dict(os.environ, MSYS2_ARG_CONV_EXCL='*', MSYS_NO_PATHCONV='1')


def main():
    args = sys.argv[1:]
    name = 'nfs4-route-d'
    if '--name' in args:
        name = args[args.index('--name') + 1]
        del args[args.index('--name'):args.index('--name') + 2]
    if not CD_TREE.is_dir() or not CD_XML.is_file():
        sys.exit('disc tree missing; see the docstring for the dumpsxiso command')
    shutil.copyfile(OUT / 'disc/NFS4.EXE', CD_TREE / 'NFS4.EXE')
    shutil.copyfile(OUT / 'disc/FRONT.BIN', CD_TREE / 'FRONT.BIN')
    tree = ET.parse(CD_XML)
    root_dir = tree.getroot().find('.//directory_tree')
    names = {e.get('name') for e in root_dir.findall('file')}
    added = []
    for d in args:
        for f in sorted(Path(d).iterdir()):
            if not f.is_file():
                continue
            up = f.name.upper()
            shutil.copyfile(f, CD_TREE / up)
            if up in names:
                continue
            e = ET.Element('file', name=up, source='%s/%s' % (CD_TREE.name, up), type='data')
            kids = list(root_dir)
            pos = next((i for i, k in enumerate(kids) if k.tag == 'file' and k.get('name') > up), None)
            if pos is None:
                pos = next((i for i, k in enumerate(kids) if k.tag == 'dir'), len(kids))
            e.tail = kids[pos].tail if pos < len(kids) else kids[-1].tail
            root_dir.insert(pos, e)
            names.add(up)
            added.append(up)
    xml_out = CD / (name + '.xml')
    tree.write(xml_out, encoding='utf-8', xml_declaration=False)
    out_bin, out_cue = CD / (name + '.bin'), CD / (name + '.cue')
    for old in (out_bin, out_cue):
        if old.exists():
            try:
                old.unlink()
            except OSError as e:
                sys.exit('cannot replace %s (is DuckStation still running it?): %s' % (old, e))
    r = subprocess.run([str(MKPSXISO), '-y', '-o', str(out_bin), '-c', str(out_cue), str(xml_out)],
                       cwd=CD, capture_output=True, text=True, env=ENV)
    if r.returncode != 0 or not out_bin.exists():
        print((r.stdout + r.stderr)[-2000:])
        sys.exit('mkpsxiso failed (exit %d)' % r.returncode)
    print('disc: %s  %d bytes  new entries: %s' % (out_bin, out_bin.stat().st_size, added))
    print('cue :', out_cue)


if __name__ == '__main__':
    main()
