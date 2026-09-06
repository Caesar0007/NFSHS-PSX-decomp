"""Read-only literal/dynamic include census for the P875 public PSX headers."""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
WORK = Path(__file__).with_name('p875_psx')
names = {p.stem.removesuffix('_after') + '.h' for p in WORK.glob('*_after.cpp')}
users = {name: [] for name in sorted(names)}
dynamic = []
count = 0
for tree in ('recon', 'regiondiff/recon', 'src', 'include'):
    for path in (ROOT / tree).rglob('*'):
        if not path.is_file() or path.suffix.lower() not in ('.h', '.c', '.cpp', '.inc', '.inl', '.hpp', '.hh'):
            continue
        count += 1
        text = path.read_text(encoding='utf-8', errors='replace')
        text = re.sub(r'/\*.*?\*/', '', text, flags=re.S)
        for number, line in enumerate(text.splitlines(), 1):
            m = re.match(r'^\s*#\s*include\s+(.+)', line)
            if not m:
                continue
            token = m[1].strip()
            literal = re.match(r'[<"]([^">]+)[">]', token)
            if not literal:
                dynamic.append({'file':path.relative_to(ROOT).as_posix(), 'line':number, 'include':token})
                continue
            name = literal[1].replace('\\', '/').split('/')[-1].lower()
            if name in users:
                users[name].append({'file':path.relative_to(ROOT).as_posix(), 'line':number, 'include':literal[1]})
print(json.dumps({'files_scanned':count, 'literal_users':users, 'dynamic_includes':dynamic}))
