"""static_fix2.py -- retail's LOCAL labels prove the object boundaries:
  * memcpyl / memcpyb / refcpy (0x800F51C0..) are statics at the TOP of unref.obj (callers: refcpy, unrefpack) -- they were
    kept at the end of unhuff.c;
  * chase (0x800F5530) and the five SQV* cursors are statics of unbtree.obj (callers: chase, unbtree) -- chase was kept at
    the end of unref.c and the cursors were commons shared by two files."""
import re

R = 'C:/Temp/nfs4-decomp/recon/eaclib/psx/eacpsxz/'
NL = chr(10)


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


# ---- unhuff.c -> unref.c
u = rd('unhuff.c')
i = u.index('/* memcpyl @0x800F51C0 : copy')
moved = u[i:].rstrip() + NL
u = u[:i].rstrip() + NL
for n, sig in (('memcpyl', 'char *memcpyl('), ('memcpyb', 'unsigned int memcpyb('), ('refcpy', 'unsigned char *refcpy(')):
    assert moved.count(NL + sig) == 1, n
    moved = moved.replace(NL + sig, NL + 'static ' + sig)
wr('unhuff.c', u)
h = rd('unhuff.h')
h, k = re.subn(r'^extern [^\n]*\b(?:memcpyl|memcpyb|refcpy)\([^\n]*\n', '', h, flags=re.M)
assert k == 3
wr('unhuff.h', h)

r = rd('unref.c')
# chase leaves unref.c
i = r.index('/* chase @0x800F5530')
chase = r[i:].rstrip() + NL
r = r[:i].rstrip() + NL
old = ('signed char   *SQVclue;' + NL + 'unsigned char *SQVleft;' + NL + 'unsigned char *SQVright;' + NL +
       'unsigned char *SQVs;' + NL + 'unsigned char *SQVd;' + NL)
assert r.count(old) == 1
r = r.replace(old, '/* file-local copy helpers (retail SYM: local labels right before unrefpack) */' + NL + moved)
wr('unref.c', r)
h = rd('unref.h')
h, k = re.subn(r'^extern void chase\([^\n]*\n', '', h, flags=re.M)
assert k == 1
wr('unref.h', h)

b = rd('unbtree.c')
for t in ('signed char *SQVclue;', 'unsigned char *SQVleft;', 'unsigned char *SQVright;', 'unsigned char *SQVs;', 'unsigned char *SQVd;'):
    assert b.count(NL + t) == 1, t
    b = b.replace(NL + t, NL + 'static ' + t)
assert chase.count(NL + 'void chase(') == 1
chase = chase.replace(NL + 'void chase(', NL + 'static void chase(')
i = b.index('/* unbtree @0x800F55B4')
b = b[:i] + chase + NL + b[i:]
wr('unbtree.c', b)
