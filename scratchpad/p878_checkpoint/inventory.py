"""Read-only inventory for the explicitly authorized P869-P878 checkpoint.

Does not stage, commit, push, delete or rewrite source. Generated compiler
intermediates and unrelated working-tree files are excluded from candidates.
"""
from pathlib import Path
from collections import Counter
import json
import re
import subprocess

ROOT=Path(__file__).resolve().parents[2]
def git(*args):
    return subprocess.run(['git','-c','core.safecrlf=false',*args],cwd=ROOT,
                          capture_output=True,text=True,check=True).stdout.splitlines()
tracked=git('diff','--name-only')
production=[p for p in tracked if p.startswith(('recon/','regiondiff/recon/'))]
production += [p for p in tracked if p in ('tools/build.py','tools/diffsrc.py')]
documents=[p for p in tracked if p=='scratchpad/root_sym_audit/ORIGINAL_SOURCE_NAME_BACKLOG_20260903.md']
wave=re.compile(r'(?:^|[_/])p(?:869|87[0-8])(?:[_/.]|$)',re.I)
allowed={'.md','.json','.py','.h','.cpp','.c','.tsv','.csv'}
artifacts=[]
for name in git('ls-files','--others','--exclude-standard','scratchpad'):
    p=Path(name)
    if not wave.search(name):
        continue
    if p.suffix in allowed or p.name in ('build.py.before','diffsrc.py.before'):
        artifacts.append(name)
paths=sorted(set(production+documents+artifacts))
groups=Counter('/'.join(p.split('/')[:3]) for p in artifacts)
sizes={p:(ROOT/p).stat().st_size for p in paths}
report=dict(production_count=len(production),artifacts_count=len(artifacts),
            total_count=len(paths),total_bytes=sum(sizes.values()),
            excluded_tracked=[p for p in tracked if p not in paths],
            artifact_groups=dict(groups),paths=paths,
            largest=sorted(sizes.items(),key=lambda x:x[1],reverse=True)[:16])
print(json.dumps(report,indent=2))
