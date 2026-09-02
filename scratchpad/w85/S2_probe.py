"""W85-S2 probe harness: apply substitutions to a recon file, gate named fns, restore."""
import sys, subprocess, re, os, traceback

CR = chr(13); LF = chr(10); CRLF = CR + LF

def read(p):  return open(p, 'rb').read().decode('latin-1')
def write(p, t): open(p, 'wb').write(t.encode('latin-1'))

def gate(p, fns):
    r = subprocess.run(['python', 'tools/verify_asm.py', p, fns],
                       capture_output=True, text=True)
    out = []
    for l in r.stdout.splitlines():
        m = re.search(r'(\S+):\s+(PASS \(\d+ insns\)|FAIL \d+ diffs \(ours \d+ / oracle \d+\)|NO ORACLE)', l)
        if m:
            out.append(m.group(1) + '=' + m.group(2))
    return '; '.join(out) or ('ERR ' + (r.stdout + r.stderr)[-400:].replace(LF, '|'))

def norm(s, crlf):
    s = s.replace(CRLF, LF)
    return s.replace(LF, CRLF) if crlf else s

def run(path, fns, tests, show=False):
    orig = read(path)
    crlf = CRLF in orig
    try:
        for name, subs in tests:
            t = orig; ok = True
            for a, b in subs:
                a = norm(a, crlf); b = norm(b, crlf)
                if a not in t:
                    print("%-44s -> SKIP (anchor missing)" % name); ok = False; break
                t = t.replace(a, b, 1)
            if not ok:
                continue
            write(path, t)
            if show:
                r = subprocess.run(['python', 'tools/verify_asm.py', path, fns],
                                   capture_output=True, text=True)
                print("%-44s ->" % name); print(r.stdout[-3000:])
            else:
                print("%-44s -> %s" % (name, gate(path, fns)))
    except Exception:
        traceback.print_exc()
    finally:
        write(path, orig)
        print("%-44s -> %s" % ('RESTORED', gate(path, fns)))
