"""Read-only compiler dependency census for the P876 shared AI declarations."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import json
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools'))
import build as b


def inspect(src):
    cmd=[b.CPP,'-M','-x','c','-D__cplusplus=1','-nostdinc','-undef',
         '-Dmips','-D__mips__','-D__psx__','-I'+str(b.RECON),str(src)]
    proc=subprocess.run(list(map(str,cmd)),cwd=ROOT,capture_output=True,text=True)
    output=proc.stdout.replace('\\\n',' ').replace('\\','/').lower()
    return dict(source=src.relative_to(ROOT).as_posix(),returncode=proc.returncode,
                consumer='nfs4_types.h' in output,dependencies=proc.stdout,
                errors=proc.stderr if proc.returncode else '')


if __name__=='__main__':
    sources=sorted((ROOT/'recon').rglob('*.cpp'))
    with ThreadPoolExecutor(max_workers=4) as pool:
        rows=list(pool.map(inspect,sources))
    report=dict(sources=len(rows),consumers=sum(r['consumer'] for r in rows),
                failures=sum(bool(r['returncode']) for r in rows),rows=rows)
    target=Path(__file__).with_name('consumers_before.json')
    target.write_text(json.dumps(report,indent=2)+'\n')
    print({k:v for k,v in report.items() if k!='rows'})
    for row in rows:
        if row['consumer'] or row['returncode']:
            print(row['source'], 'CONSUMER' if row['consumer'] else 'ERROR',row['errors'])
