#!/usr/bin/env python3
"""Header-truth counters (docs/HEADER_TRUTH_PLAN.md, phase 5).

Counts the constructs the header-truth work removes.  None of them may rise:
  python tools/header_truth_counters.py            # print
  python tools/header_truth_counters.py --check    # compare with docs/header_truth_counters.json, exit 1 on a rise
  python tools/header_truth_counters.py --save     # re-baseline after a counter went down
"""
import json, re, sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DIRS = ['recon/game', 'recon/frontend', 'recon/shared']
BASE = ROOT / 'docs' / 'header_truth_counters.json'
CLASS = re.compile(r'^\s*(?:NFS4_TD_\w+ +)?(?:typedef +)?(?:struct|class) +([A-Za-z_]\w*) *(?::[^;{]*)?\{', re.M)
COND = re.compile(r'^\s*#\s*(?:if|ifdef|ifndef|elif).*(?:NFS4_TU_|_TYPES_H\b|_FE_SCREENS_)', re.M)
GUARD = re.compile(r'^\s*#\s*ifndef .*_H *$', re.M)


def sources(exts):
    for d in DIRS:
        for p in (ROOT / d).rglob('*'):
            if p.suffix in exts and p.is_file():
                yield p, p.read_text(encoding='latin-1')


def count():
    c = Counter()
    names = Counter()
    for p, s in sources({'.h', '.inc', '.cpp', '.c'}):
        c['inferred_markers'] += s.count('INFERRED')
        c['fake_inferred_ops'] += len(re.findall(r'\b\w*Inferred\w*Op\d*\(', s))
        c['codegen_views'] += len(re.findall(r'struct \w*CodegenView\b', s))
        c['opaque_storage_views'] += len(re.findall(r'char _storage\[', s))
        c['asm_label_aliases'] += len(re.findall(r'\)\s*(?:__asm__|asm)\("', s))
        c['enum_macro_fakes'] += len(re.findall(r'^#define t[A-Z]\w* (?:int|short|char)\b', s, re.M))
        c['variadic_only_prototypes'] += len(re.findall(r'\w\s*\(\s*\.\.\.\s*\)\s*;', s))
        c['device_exact_only'] += s.count('DEVICE (exact-only)')
        c['sym_codegen_carriers'] += s.count('SYM-CODEGEN-CARRIER')
        c['typeof_uses'] += s.count('__typeof__')
        if p.suffix in ('.cpp', '.c'):
            c['goto_statements'] += len(re.findall(r'\bgoto\s+\w+;', s))
            c['volatile_uses'] += len(re.findall(r'\bvolatile\b', s))
            c['decompiler_names'] += len(re.findall(r'\b(?:param_\d+|local_[0-9a-f]+|[a-z]+Var\d+|in_\w+|unaff_\w+)\b', s))
        if p.suffix in ('.h', '.inc'):
            for m in re.finditer(r'^\s*#\s*(?:if|ifdef|ifndef|elif)\b(.*)$', s, re.M):
                l = m.group(1)
                if re.match(r'\s*!?(?:defined\()?\w+_H_?\)?\s*$', l):
                    continue
                c['header_conditionals_all'] += 1
                if re.search(r'SURFACE|METHODS|INLINES|_INLINE\b', l):
                    c['header_conditionals_member_visibility'] += 1
                elif re.search(r'OMIT|_NO_', l) and not re.search(r'HOOK|_PASS|TYPE_PART', l):
                    c['header_conditionals_omit_type'] += 1
        if p.suffix in ('.h', '.inc'):
            c['per_object_conditionals'] += len(COND.findall(s)) - len([g for g in GUARD.findall(s) if COND.search(g)])
            for n in CLASS.findall(s):
                names[n] += 1
    c['classes_defined_more_than_once'] = sum(1 for n, k in names.items() if k > 1)
    rows = json.loads((ROOT / 'linkers' / 'link_stripped.json').read_text(encoding='utf-8'))['functions']
    c['link_stripped_rows_non_sdk'] = sum(1 for r in rows if 'source' in r)
    return dict(sorted(c.items()))


def main():
    now = count()
    if '--save' in sys.argv:
        BASE.write_text(json.dumps(now, indent=1) + '\n', encoding='utf-8')
    base = json.loads(BASE.read_text(encoding='utf-8')) if BASE.exists() else {}
    bad = 0
    for k, v in now.items():
        b = base.get(k)
        flag = ''
        if b is not None and v > b:
            flag = '   <-- ROSE (baseline %d)' % b
            bad += 1
        elif b is not None and v < b:
            flag = '   (down from %d; --save to re-baseline)' % b
        print('%-34s %5d%s' % (k, v, flag))
    if '--check' in sys.argv and bad:
        sys.exit('header-truth counters rose: %d' % bad)


if __name__ == '__main__':
    main()
