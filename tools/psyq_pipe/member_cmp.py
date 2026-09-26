"""member_cmp.py [NAME ...] [--summary] -- compare struct/union MEMBER records (offset, type, size, dims, tag, name)
between retail's SYM and ours, per source file.

For each tag it lists every distinct member signature retail records and the source files that record it, then
the same for our build/psyq_g/nfs4_sym.txt.  A type whose header copies differ in recon is safe to share when all
our signatures are one retail signature; a copy whose signature is not retail's is a wrong copy to fix first.
--summary classifies every tag defined in two or more of our files:
  SAME      ours has one signature and it is retail's
  FIXABLE   retail has one signature, ours has several or another
  RETAILN   retail itself records more than one signature (legitimately different definitions per object)
  NORETAIL  retail never records the tag
"""
import re, sys, collections
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import tagset_cmp as T  # noqa: E402

REC = re.compile(r'^\w+: \$([0-9a-f]{8}) \w+ Def2? class (\w+) type (.*?) size (\d+)(?: dims ([\d ]+?))?(?: tag (\S*))? name (\S+)$')


def records(path):
    """{file_key: {tag: signature}} -- the FIRST full definition of each tag per source file."""
    out = collections.defaultdict(dict)
    pending = []          # (tag, sig) not yet attributed to a file
    cur = None
    want_file = False
    for l in open(path, errors='replace'):
        l = l.rstrip('\n')
        m = REC.match(l)
        if m:
            off, cls, typ, size, dims, tag, name = m.groups()
            if cls in ('STRTAG', 'UNTAG'):
                cur = [name, [('size', size)]]
                continue
            if cur is not None:
                if cls in ('MOS', 'MOU', 'FIELD'):
                    tg = '._N' if (tag or '').startswith('._') else (tag or '')   # anonymous tags are numbered per object
                    cur[1].append((int(off, 16), cls, typ, size, (dims or '').strip(), tg, name))
                    continue
                if cls == 'EOS':
                    nm = cur[0]
                    if nm.startswith('._'):
                        nm = '._N'
                    pending.append((nm, tuple(cur[1])))
                    cur = None
                    continue
            continue
        if T.FN.search(l):
            want_file = bool(pending)
            continue
        if want_file:
            h = T.FILE_HDR.match(l)
            if h:
                key = h.group(1).strip().replace(T.BS, '/').upper().split('/')[-1]
                for nm, sig in pending:
                    out[key].setdefault(nm, sig)
                pending = []
                want_file = False
    return out


def by_tag(recs):
    d = collections.defaultdict(lambda: collections.defaultdict(list))
    for f, tags in recs.items():
        for nm, sig in tags.items():
            d[nm][sig].append(f)
    return d


def fmt(sig):
    return ' '.join('%s:%s%s%s' % (m[6], m[2].replace(' ', '_'), ('[' + m[4] + ']') if m[4] else '', ('<' + m[5] + '>') if m[5] else '')
                    for m in sig[1:]) + '  (size %s)' % sig[0][1]


def main():
    r = by_tag(records(T.RETAIL))
    o = by_tag(records(T.OURS))
    names = [a for a in sys.argv[1:] if not a.startswith('--')]
    if '--summary' in sys.argv:
        cls = collections.defaultdict(list)
        for nm, sigs in o.items():
            nfiles = sum(len(v) for v in sigs.values())
            if nfiles < 2 or nm == '._N':
                continue
            rs = r.get(nm)
            if not rs:
                k = 'NORETAIL'
            elif len(rs) > 1:
                k = 'RETAILN'
            elif len(sigs) == 1 and set(sigs) == set(rs):
                k = 'SAME'
            else:
                k = 'FIXABLE'
            cls[k].append(nm)
        for k in ('SAME', 'FIXABLE', 'RETAILN', 'NORETAIL'):
            print('%-9s %4d  %s' % (k, len(cls[k]), ' '.join(sorted(cls[k])[:40]) if k != 'SAME' else ''))
        if names:
            print()
    for nm in names:
        print('== %s' % nm)
        for label, src in (('retail', r), ('ours', o)):
            for sig, fs in sorted(src.get(nm, {}).items(), key=lambda kv: -len(kv[1])):
                print('  %-6s %3d files  %s' % (label, len(fs), fmt(sig)))
                print('         e.g. %s' % ' '.join(sorted(fs)[:6]))


if __name__ == '__main__':
    main()
