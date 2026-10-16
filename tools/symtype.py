#!/usr/bin/env python3
"""symtype.py NAME [NAME...] | --all [OUT.txt] -- a type or a variable as the retail SYM describes it.

    python tools/symtype.py tScreen tDialogBase         # struct / union / enum by tag
    python tools/symtype.py frontEnd                    # a global or file-static variable by name
    python tools/symtype.py --all                       # every named type -> build/sym/symtype_all.txt

For a struct / union / enum tag:
  * the definition: size, every member with offset, type and name (bit-fields with bit offset and width;
    enum members with their values);
  * owner: the header the retail SYM names for it -- the `file =` of its inline members' function records
    (a .H), and the .CPP that defines its out-of-line members -- when the type has member functions;
  * objects: every object file whose type block records the definition, in link order (the SYM keeps one
    type block per object, so this is the set of translation units that saw the type);
  * variants: if objects disagree about size or members, each variant with its objects;
  * typedefs that name the tag, and the global / static variables of that type with address and object.
For a variable: its type, address, storage class and the object that defines it.
The dump comes from tools/retail_sym.py (rom/NFS4.SYM)."""
import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))

REC = re.compile(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([0-9a-f]{2}) (.*)$')
DEF = re.compile(r'Def2? class (\w+) type (.+?) size (\d+)(?: dims (\d+(?: \d+)*))?(?: tag (\S*))? name (\S+)$')
KIND = {'STRTAG': 'struct', 'UNTAG': 'union', 'ENTAG': 'enum'}


def typestr(typ, dims, tag):
    if tag:
        typ += ' ' + tag
    if dims and dims.split()[0] != '0':
        typ += ''.join('[%s]' % n for n in dims.split()[1:])
    return typ


class Index:
    def __init__(self, lines):
        self.types = defaultdict(list)       # tag -> [(kind, size, members tuple, object)]
        self.typedefs = defaultdict(set)     # tag -> {typedef names}
        self.vars = []                       # (name, addr, cls, type string, tag, object)
        self.fnfiles = []                    # (mangled name, source file)
        self.objects = []                    # link order
        obj, cur, pend_file = None, None, None
        for i, ln in enumerate(lines):
            s = ln.strip()
            if s.startswith('file = '):
                pend_file = s[7:]
                continue
            if s.startswith('name = ') and pend_file:
                self.fnfiles.append((s[7:], pend_file)); pend_file = None
                continue
            m = REC.match(ln)
            if not m:
                continue
            addr, body = int(m.group(1), 16), m.group(3)
            d = DEF.match(body)
            if not d:
                continue
            cls, typ, size, dims, tag, name = d.groups()
            if cls == 'FILE':                # one pair of FILE records brackets an object's block
                if obj == name:
                    obj = None
                else:
                    obj = name
                    if name not in self.objects:
                        self.objects.append(name)
                continue
            if cls in KIND:
                cur = [KIND[cls], int(size), [], name]
            elif cls in ('MOS', 'MOU', 'FIELD', 'MOE') and cur is not None:
                if cls == 'MOE':
                    cur[2].append(('%d' % (addr - (1 << 32) if addr & 0x80000000 else addr), '', name))
                elif cls == 'FIELD':
                    cur[2].append(('bit %d' % addr, '%s : %s' % (typ, size), name))
                else:
                    cur[2].append(('+0x%02X' % addr, typestr(typ, dims, tag), name))
            elif cls == 'EOS' and cur is not None:
                self.types[cur[3]].append((cur[0], cur[1], tuple(cur[2]), obj))
                cur = None
            elif cls == 'TPDEF':
                if tag:
                    self.typedefs[tag].add(name)
            elif cls in ('EXT', 'STAT') and not typ.startswith('FCN'):
                self.vars.append((name, addr, cls, typestr(typ, dims, tag), tag or '', obj))

    def owner_files(self, tag):
        """source files of the type's member functions: ([headers], [.cpp files]) by number of members"""
        pat = re.compile(r'__(?:Q\d+\w*?)?%d%s(\D|$)' % (len(tag), re.escape(tag)))
        hits = defaultdict(int)
        for name, f in self.fnfiles:
            if pat.search(name) or name.endswith('_%d%s' % (len(tag), tag)):
                hits[f] += 1
        hs = sorted((f for f in hits if f.upper().endswith(('.H', '.HPP'))), key=lambda f: -hits[f])
        cs = sorted((f for f in hits if not f.upper().endswith(('.H', '.HPP'))), key=lambda f: -hits[f])
        return [(f, hits[f]) for f in hs], [(f, hits[f]) for f in cs]


def objs_line(objs, limit=12):
    objs = [o for o in objs if o]
    if len(objs) <= limit:
        return ', '.join(objs)
    return ', '.join(objs[:limit]) + ', ... (+%d)' % (len(objs) - limit)


def show_type(ix, tag, out):
    defs = ix.types[tag]
    variants = defaultdict(list)
    for kind, size, members, obj in defs:
        variants[(kind, size, members)].append(obj)
    order = {o: i for i, o in enumerate(ix.objects)}
    main = max(variants, key=lambda k: len(variants[k]))
    kind, size, members = main
    out('== %s %s   size %d (0x%X)   %d member(s)' % (kind, tag, size, size, len(members)))
    hs, cs = ix.owner_files(tag)
    if hs:
        out('   header   : ' + ', '.join('%s (%d inline member%s)' % (f, n, '' if n == 1 else 's') for f, n in hs))
    if cs:
        out('   source   : ' + ', '.join('%s (%d member%s)' % (f, n, '' if n == 1 else 's') for f, n in cs[:4]))
    if not hs and not cs:
        out('   header   : not recorded (no member functions; see the objects that carry it)')
    seen = sorted({o for v in variants.values() for o in v if o}, key=lambda o: order.get(o, 1 << 30))
    out('   objects  : %d  --  %s' % (len(seen), objs_line(seen)))
    if ix.typedefs.get(tag):
        out('   typedefs : ' + ', '.join(sorted(ix.typedefs[tag])))
    out('-- members')
    for off, typ, name in members:
        out('   %-8s %-40s %s' % (off, typ, name))
    if len(variants) > 1:
        out('-- VARIANTS: the objects do not agree')
        for (k, sz, mem), objs in sorted(variants.items(), key=lambda kv: -len(kv[1])):
            if (k, sz, mem) == main:
                continue
            out('   size %d, %d member(s) in: %s' % (sz, len(mem), objs_line(sorted(set(o for o in objs if o)))))
            for m in mem:
                if m not in members:
                    out('       differs: %-8s %-36s %s' % m)
    vs = [v for v in ix.vars if v[4] == tag]
    if vs:
        out('-- variables of this type')
        for name, addr, cls, typ, _, obj in sorted(set(vs), key=lambda v: v[1])[:40]:
            out('   %08X  %-4s %-36s %-28s %s' % (addr, cls, typ, name, obj or ''))
        if len(set(vs)) > 40:
            out('   ... (+%d)' % (len(set(vs)) - 40))


def show_var(ix, name, out):
    for vname, addr, cls, typ, tag, obj in sorted(set(v for v in ix.vars if v[0] == name), key=lambda v: v[1]):
        out('== variable %s' % vname)
        out('   %08X  %s  %s   object: %s' % (addr, 'global' if cls == 'EXT' else 'static', typ, obj or '?'))


def main():
    import retail_sym
    lines = Path(retail_sym.txt()).read_text(encoding='utf-8', errors='replace').splitlines()
    ix = Index(lines)
    if '--all' in sys.argv:
        i = sys.argv.index('--all')
        path = Path(sys.argv[i + 1]) if len(sys.argv) > i + 1 else ROOT / 'build' / 'sym' / 'symtype_all.txt'
        tags = sorted((t for t in ix.types if not t.startswith('.')), key=str.lower)
        with open(path, 'w', encoding='utf-8', newline='\n') as f:
            f.write('retail NFS4.SYM, every named struct / union / enum, by name -- generated by tools/symtype.py --all\n')
            for t in tags:
                f.write('\n' + '=' * 110 + '\n')
                show_type(ix, t, lambda s: f.write(s + '\n'))
        print('wrote %s: %d types, %d bytes' % (path, len(tags), path.stat().st_size))
        return
    names = [a for a in sys.argv[1:] if not a.startswith('--')]
    if not names:
        sys.exit(__doc__)
    for n in names:
        found = False
        if n in ix.types:
            show_type(ix, n, print); found = True
        if any(v[0] == n for v in ix.vars):
            show_var(ix, n, print); found = True
        if not found:
            print('%s: no such tag or variable in the SYM' % n)
        print()


if __name__ == '__main__':
    main()
