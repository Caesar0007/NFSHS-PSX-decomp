#!/usr/bin/env python3
"""w63a17 probe: byte-exact substring replace in a recon TU, gate, restore.

Usage: python probe.py <relpath> <fn> <variantsfile.json>
variants json: {"name": [[old, new], ...], ...}   (strings are LF-normalised in
the JSON; the probe resolves CR-optional per anchor against the real bytes).
Never pipe this into head/sed (SIGPIPE hazard).
"""
import json
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


def cr_optional(s):
    # build a regex that matches the literal text with optional CR before each LF
    parts = s.split('\n')
    return b''.join(
        (re.escape(p.encode()) + (b'\r?\n' if i < len(parts) - 1 else b''))
        for i, p in enumerate(parts))


def apply_edits(data, edits):
    for old, new in edits:
        rx = re.compile(cr_optional(old))
        hits = rx.findall(data)
        if len(hits) != 1:
            raise SystemExit('ANCHOR %d hits for %r' % (len(hits), old[:60]))
        m = rx.search(data)
        # mimic the matched text's line endings in the replacement
        crlf = b'\r\n' in m.group(0)
        rep = new.replace('\n', '\r\n' if crlf else '\n').encode()
        data = data[:m.start()] + rep + data[m.end():]
    return data


def gate(rel, fn):
    r = subprocess.run([sys.executable, 'tools/vprobe.py', rel, fn],
                       capture_output=True, text=True, cwd=ROOT)
    for ln in r.stdout.splitlines():
        if ln.strip().startswith(fn + ':'):
            return ln.strip()
    return 'ERR ' + (r.stdout[-200:] + r.stderr[-300:]).replace('\n', ' | ')


def main():
    rel, fn, vfile = sys.argv[1], sys.argv[2], sys.argv[3]
    only = sys.argv[4] if len(sys.argv) > 4 else None
    path = os.path.join(ROOT, rel)
    orig = open(path, 'rb').read()
    variants = json.load(open(vfile))
    log = []
    try:
        for name, edits in variants.items():
            if only and name != only:
                continue
            if not edits:
                data = orig
            else:
                data = apply_edits(orig, edits)
            assert len(data) > 0
            tmp = path + '.w63a17tmp'
            with open(tmp, 'wb') as f:
                f.write(data)
            os.replace(tmp, path)
            res = gate(rel, fn)
            log.append('%-28s %s' % (name, res))
            with open(os.path.join(ROOT, 'scratchpad/w63a17/probe.log'), 'a') as f:
                f.write(log[-1] + '\n')
    finally:
        with open(path, 'wb') as f:
            f.write(orig)
    for l in log:
        sys.stdout.write(l + '\n')


main()
