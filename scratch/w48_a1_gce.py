#!/usr/bin/env python3
"""w48_a1_gce.py -- variant harness for BIOS.c _get_card_event / _get_card_event_x.

Patches the two function BODIES in place, gates them (under whatever PER_TU flags are given),
restores the TU in a finally block.  usage: python scratch/w48_a1_gce.py <variant> [flag=val ...]
"""
import subprocess, sys, re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TU = ROOT / 'recon' / 'syslib' / 'psx' / 'libmcrd' / 'BIOS.c'
BUILD = ROOT / 'tools' / 'build.py'
REL = 'recon/syslib/psx/libmcrd/BIOS.c'

BASE = """    int sum;
    do {
        sum = _card_evflag%d + _card_evflag%d * 2 + _card_evflag%d * 4 + _card_evflag%d * 8;
    } while (sum == 0);
    TestEvent(_card_evhandle%d);
    TestEvent(_card_evhandle%d);
    TestEvent(_card_evhandle%d);
    TestEvent(_card_evhandle%d);
"""

VARIANTS = {
    # v0 = the in-tree body (chained clear + plain return)
    'v0': """    _card_evflag%d = _card_evflag%d = _card_evflag%d = _card_evflag%d = 0;
    return sum >> 1;
""",
    # v1 = zero-insn immediate fence before the return
    'v1': """    _card_evflag%d = _card_evflag%d = _card_evflag%d = _card_evflag%d = 0;
    __asm__("" : : "i"(0));
    return sum >> 1;
""",
    # v2 = value fence on the result (pins the sra + blocks the epilogue hoist)
    'v2': """    _card_evflag%d = _card_evflag%d = _card_evflag%d = _card_evflag%d = 0;
    {
        int r = sum >> 1;
        __asm__("" : : "r"(r));
        return r;
    }
""",
    # v3 = un-chained clear, result computed before the LAST store, fence between
    'v3': """    {
        int r;
        _card_evflag%4$d = 0;
        _card_evflag%3$d = _card_evflag%4$d;
        _card_evflag%2$d = _card_evflag%3$d;
        r = sum >> 1;
        __asm__("" : : "r"(r));
        _card_evflag%1$d = _card_evflag%2$d;
        return r;
    }
""",
    # v4 = v3 + the last store split into load-temp / store with a fence between,
    #      so the sra can be scheduled into the load's delay slot (the oracle shape)
    'v4': """    {
        int r, t;
        _card_evflag%4$d = 0;
        _card_evflag%3$d = _card_evflag%4$d;
        _card_evflag%2$d = _card_evflag%3$d;
        r = sum >> 1;
        t = _card_evflag%2$d;
        __asm__("" : : "r"(t));
        _card_evflag%1$d = t;
        __asm__("" : : "r"(r));
        return r;
    }
""",
    # v5 = as v4 but the result is computed AFTER the last load (source order = oracle order)
    'v5': """    {
        int r, t;
        _card_evflag%4$d = 0;
        _card_evflag%3$d = _card_evflag%4$d;
        _card_evflag%2$d = _card_evflag%3$d;
        t = _card_evflag%2$d;
        r = sum >> 1;
        __asm__("" : : "r"(t), "r"(r));
        _card_evflag%1$d = t;
        __asm__("" : : "r"(r));
        return r;
    }
""",
    # v6 = fence BETWEEN the last load and the result shift, so the shift cannot float
    #      above the load and lands in its load-delay slot (= the oracle)
    'v6': """    {
        int r, t;
        _card_evflag%4$d = 0;
        _card_evflag%3$d = _card_evflag%4$d;
        _card_evflag%2$d = _card_evflag%3$d;
        t = _card_evflag%2$d;
        __asm__("" : : "r"(t));
        r = sum >> 1;
        _card_evflag%1$d = t;
        __asm__("" : : "r"(r));
        return r;
    }
""",
    # v7 = v6 without the trailing result fence
    'v7': """    {
        int r, t;
        _card_evflag%4$d = 0;
        _card_evflag%3$d = _card_evflag%4$d;
        _card_evflag%2$d = _card_evflag%3$d;
        t = _card_evflag%2$d;
        __asm__("" : : "r"(t));
        r = sum >> 1;
        _card_evflag%1$d = t;
        __asm__("" : : "i"(0));
        return r;
    }
""",
}


def body(v, base):
    """base = 0 for _get_card_event (flags 0..3), 4 for _get_card_event_x."""
    f = [base + i for i in range(4)]
    h = [(4 - base) + i for i in range(4)]      # the OTHER slot's handles
    txt = BASE % (f[0], f[1], f[2], f[3], h[0], h[1], h[2], h[3])
    tail = VARIANTS[v]
    if '%1$d' in tail:
        tail = tail.replace('%1$d', str(f[0])).replace('%2$d', str(f[1]))
        tail = tail.replace('%3$d', str(f[2])).replace('%4$d', str(f[3]))
    else:
        tail = tail % (f[0], f[1], f[2], f[3])
    return txt + tail


def replace_fn(src, name, new_body):
    m = re.search(r'(extern int ' + name + r'\(void\)\r?\n\{\r?\n)(.*?)(\r?\n\}\r?\n)', src, re.S)
    assert m, name
    return src[:m.start(2)] + new_body.rstrip('\n') + src[m.end(2):]


v = sys.argv[1]
kvs = sys.argv[2:]
orig_tu = TU.read_bytes()
orig_b = BUILD.read_bytes()
try:
    s = orig_tu.decode('utf-8')
    nl = '\r\n' if '\r\n' in s else '\n'
    s = replace_fn(s, '_get_card_event', body(v, 0).replace('\n', nl))
    s = replace_fn(s, '_get_card_event_x', body(v, 4).replace('\n', nl))
    TU.write_bytes(s.encode('utf-8'))
    if kvs:
        d = dict(kv.split('=', 1) for kv in kvs)
        d = {k: (True if x == 'True' else x) for k, x in d.items()}
        t = orig_b.decode('utf-8')
        nlb = '\r\n' if '\r\n' in t else '\n'
        t = t.replace('PER_TU_FLAGS = {' + nlb,
                      'PER_TU_FLAGS = {' + nlb + ('    %r: %r,' % (REL, d)) + nlb, 1)
        BUILD.write_bytes(t.encode('utf-8'))
    for p in (ROOT / 'tools' / '__pycache__').glob('build*.pyc'):
        p.unlink()
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', REL,
                        '_get_card_event,_get_card_event_x'],
                       cwd=str(ROOT), capture_output=True, text=True)
    print(v, ' '.join(kvs) or 'BASE', '::', (r.stdout + r.stderr).strip()[-800:])
finally:
    TU.write_bytes(orig_tu)
    BUILD.write_bytes(orig_b)
    for p in (ROOT / 'tools' / '__pycache__').glob('build*.pyc'):
        p.unlink()
