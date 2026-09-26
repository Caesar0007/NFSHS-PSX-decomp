"""header_groups.py [--json OUT] [--show N] -- reconstruct retail's header groups from its per-object type blocks.

Every object's SYM type block lists the tags (STRTAG/UNTAG/ENTAG) its translation unit defined, in definition order.
Types that came from one original header therefore (a) are recorded by exactly the same set of objects and
(b) appear contiguously and in the same order in each of them.  This tool orders all tags by a global precedence
(the order they appear in across objects), then cuts that order into groups of consecutive tags with identical
object sets.  Each group is a candidate original header; its object set is who included it.
"""
import json, sys, collections
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import tagset_cmp as T  # noqa: E402

KINDS = ('STRTAG', 'UNTAG', 'ENTAG')


def tag_runs():
    runs = T.runs(T.RETAIL)
    out = {}
    for k, tags in runs.items():
        seq = []
        seen = set()
        for kind, name in tags:
            # keep first occurrence of each named tag (re-emissions and doubled objects repeat them)
            if kind in KINDS and name != '._N' and name not in seen:
                seen.add(name)
                seq.append(name)
        out[k] = seq
    return out


def global_order(runs):
    """Topological-ish merge: average relative position of each tag, weighted by occurrences."""
    pos = collections.defaultdict(list)
    for seq in runs.values():
        n = len(seq)
        for i, t in enumerate(seq):
            pos[t].append(i)
    # a precedence graph from adjacent pairs gives a better order than averages; use pair votes
    before = collections.Counter()
    for seq in runs.values():
        idx = {t: i for i, t in enumerate(seq)}
        for a in seq:
            for b in seq:
                if idx[a] < idx[b]:
                    before[(a, b)] += 1
    tags = list(pos)
    # insertion sort by pairwise majority (stable, O(n^2) fine for ~1000 tags)
    order = []
    for t in sorted(tags, key=lambda x: sum(pos[x]) / len(pos[x])):
        i = len(order)
        while i > 0 and before[(t, order[i - 1])] > before[(order[i - 1], t)]:
            i -= 1
        order.insert(i, t)
    return order


def groups(runs, order):
    objs = collections.defaultdict(frozenset)
    tmp = collections.defaultdict(set)
    for k, seq in runs.items():
        for t in seq:
            tmp[t].add(k)
    objs = {t: frozenset(v) for t, v in tmp.items()}
    out = []
    for t in order:
        if out and objs[t] == out[-1]['objects']:
            out[-1]['tags'].append(t)
        else:
            out.append({'tags': [t], 'objects': objs[t]})
    return out


def main():
    runs = tag_runs()
    order = global_order(runs)
    gs = groups(runs, order)
    print('retail objects %d | distinct tags %d | groups %d' % (len(runs), len(order), len(gs)))
    sizes = collections.Counter(len(g['tags']) for g in gs)
    print('group sizes:', sorted(sizes.items())[:20])
    show = int(sys.argv[sys.argv.index('--show') + 1]) if '--show' in sys.argv else 40
    for g in sorted(gs, key=lambda g: -len(g['objects']))[:show]:
        print('%3d objs  %2d tags  %s' % (len(g['objects']), len(g['tags']), ' '.join(g['tags'][:12]) + (' ...' if len(g['tags']) > 12 else '')))
    if '--json' in sys.argv:
        Path(sys.argv[sys.argv.index('--json') + 1]).write_text(json.dumps(
            [{'tags': g['tags'], 'objects': sorted(g['objects'])} for g in gs], indent=1))


if __name__ == '__main__':
    main()
