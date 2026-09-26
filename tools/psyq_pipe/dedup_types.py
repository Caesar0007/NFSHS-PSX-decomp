"""dedup_types.py [--apply] [--min N] [--only NAME,...] -- one definition per duplicated game type.

For every struct/class/union defined at file scope in two or more recon headers whose copies are identical once
comments and whitespace are ignored, move the first copy verbatim into recon/shared/<Name>.h (include-guarded) and
replace every copy with `#include "shared/<Name>.h"` at the same position, padded with blank lines so each header
keeps its line count (later inline functions keep their line numbers).  Each translation unit therefore sees
the same token stream in the same order, so its object bytes and its SYM type block cannot change; the only
effect is that each type has one definition.  Types whose copies differ are listed, not touched.
--canon also accepts copies that differ only in spelling (tools/psyq_pipe/type_canon.py: same members, member types
and order); an alias-free spelling (unsigned short, not u_short) becomes the definition when one exists, since the
aliases are not yet typedef'd everywhere a copy stood; otherwise the most common spelling.

Classes with inline member-function bodies are skipped: the code they emit carries the defining file in its line
records, so they belong in their retail module header.

Dependencies: a type is converted only after every type its body names that is itself converted in this run
precedes it in the file (the copies already compile in place, so no new includes are added inside owner headers).
"""
import re, glob, sys, collections
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SHARED = ROOT / 'recon' / 'shared'
BS = chr(92)
apply = '--apply' in sys.argv
min_copies = int(sys.argv[sys.argv.index('--min') + 1]) if '--min' in sys.argv else 2
only = set(sys.argv[sys.argv.index('--only') + 1].split(',')) if '--only' in sys.argv else None


def mask_comments(t):
    """Same length as t, comments replaced by spaces (so offsets stay valid)."""
    out = list(t)
    for m in re.finditer(r'/\*.*?\*/|//[^\n]*', t, flags=re.S):
        for i in range(m.start(), m.end()):
            if out[i] != '\n':
                out[i] = ' '
    return ''.join(out)


def top_level_defs(path):
    raw = open(path, encoding='utf-8', errors='surrogateescape').read()
    t = mask_comments(raw)
    defs = []
    depth = 0
    i = 0
    n = len(t)
    pat = re.compile(r'\b(struct|class|union)\s+([A-Za-z_]\w*)\s*(:[^{;]*)?\{')
    while i < n:
        c = t[i]
        if c == '{':
            depth += 1
        elif c == '}':
            depth -= 1
        elif depth == 0 and t[i].isalpha() and (i == 0 or not (t[i - 1].isalnum() or t[i - 1] == '_')):
            m = pat.match(t, i)
            if m:
                # find matching close brace, then the terminating ';'
                j = m.end() - 1
                d = 0
                for k in range(j, n):
                    if t[k] == '{':
                        d += 1
                    elif t[k] == '}':
                        d -= 1
                        if d == 0:
                            break
                semi = t.find(';', k)
                between = t[k + 1:semi]
                if semi < 0 or between.strip():      # `struct X {...} var;` or typedef-struct: leave alone
                    i = k + 1
                    continue
                # extend start to line start (keep indentation) and end to end of line
                s = raw.rfind('\n', 0, m.start()) + 1
                if raw[s:m.start()].strip():         # something else precedes on the line (e.g. typedef)
                    i = k + 1
                    continue
                e = raw.find('\n', semi)
                e = n if e < 0 else e + 1
                body = raw[s:e]
                defs.append(dict(name=m.group(2), start=s, end=e, text=body,
                                 norm=' '.join(mask_comments(body).split())))
                i = e
                continue
        i += 1
    return raw, defs


def main():
    files = sorted(glob.glob(str(ROOT / 'recon' / '**' / '*.h'), recursive=True))
    files = [f for f in files if BS + 'shared' + BS not in f and '/shared/' not in f]
    per = collections.defaultdict(list)
    cache = {}
    for f in files:
        raw, defs = top_level_defs(f)
        cache[f] = (raw, defs)
        for d in defs:
            per[d['name']].append((f, d))
    eligible, differing, inline_bodies = [], [], []
    canon_mode = '--canon' in sys.argv
    if canon_mode:
        sys.path.insert(0, str(Path(__file__).resolve().parent))
        import type_canon
    for name, v in per.items():
        if len(v) < min_copies or (only and name not in only):
            continue
        same = len({d['norm'] for _, d in v}) == 1
        if not same and canon_mode and len({type_canon.canon(d['text']) for _, d in v}) == 1:
            # same members, types and order in every copy, spelled differently.  The definition keeps a spelling
            # without the SYS/TYPES.H aliases when one exists: some headers define the type before u_short & co.
            # are typedef'd, and cc1 then silently drops those members (font_obj_types.h: kernpair shrank 8 -> 4).
            # Among equals the most common spelling wins.
            freq = collections.Counter(d['norm'] for _, d in v)
            alias = re.compile(r'\b(u_char|u_short|u_int|u_long|ushort)\b')
            v.sort(key=lambda fd: (bool(alias.search(fd[1]['norm'])), -freq[fd[1]['norm']]))
            same = True
        if same:
            # classes with inline member-function bodies emit code whose line records name the defining file:
            # they belong in their retail module header (AIHIGH.H, SPEECH.H, ...), not in a per-type file
            # (also any derived or virtual class: its compiler-generated members -- implicit destructors etc. -- carry
            #  the class definition's own file and line)
            nb = v[0][1]['norm']
            if re.search(r'\)[^;{}]*\{', nb) or re.match(r'(struct|class)\s+\w+\s*:', nb) or re.search(r'\bvirtual\b', nb):
                inline_bodies.append(name)
                continue
            eligible.append(name)
        else:
            differing.append((name, len(v), len({d['norm'] for _, d in v})))
    print('duplicated types: %d eligible (identical copies), %d with differing copies' % (len(eligible), len(differing)))
    print('copies to replace: %d' % sum(len(per[n]) for n in eligible))
    print('skipped (inline member bodies, left for module headers): %d %s' % (len(inline_bodies), inline_bodies[:12]))
    for name, c, dcount in sorted(differing, key=lambda x: -x[1])[:25]:
        print('  differing: %-26s %2d copies, %d bodies' % (name, c, dcount))
    if not apply:
        return
    SHARED.mkdir(exist_ok=True)
    # rewrite files from the end so offsets stay valid
    edits = collections.defaultdict(list)
    for name in eligible:
        first_f, first_d = per[name][0]
        guard = 'NFS4_SHARED_' + re.sub(r'\W', '_', name).upper() + '_H'
        owner = SHARED / (name + '.h')
        owner.write_text('/* %s -- the one definition of this type, shared by %d headers (moved verbatim by\n'
                         '   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */\n'
                         '#ifndef %s\n#define %s\n\n%s\n#endif\n' % (name, len(per[name]), guard, guard, first_d['text'].rstrip('\n')),
                         encoding='utf-8', newline='\n')
        for f, d in per[name]:
            # keep the header's line count: later inline functions keep their line numbers (SLD records)
            pad = d['text'].count('\n') - 1
            edits[f].append((d['start'], d['end'], '#include "shared/%s.h"\n' % name + '\n' * pad))
    for f, es in edits.items():
        raw = cache[f][0]
        for s, e, rep in sorted(es, reverse=True):
            raw = raw[:s] + rep + raw[e:]
        open(f, 'w', encoding='utf-8', errors='surrogateescape', newline='\n').write(raw)
    print('wrote %d owner headers, edited %d headers' % (len(eligible), len(edits)))


if __name__ == '__main__':
    main()
