"""P877 isolated whole-TU source/flag matrix, using the authoritative verifier.

Only diagnostic input compiler flags differ. Production source/configuration,
verifier logic, emitted instructions and object contents are never rewritten.
"""
from pathlib import Path
from contextlib import redirect_stdout, redirect_stderr
import hashlib
import argparse
import io
import json
import os
import re
import sys

ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'tools'))
tool=(ROOT/'tools/verify_asm.py').read_text()
hook='bld.OUT = bld.BUILD'
assert tool.count(hook)==1
native_source=ROOT/'recon/game/common/replay.cpp'
functions=re.findall(r'/\* ---- (Replay_\S+)\s+\[',native_source.read_text())
assert len(functions)==16
os.environ['NFS4_SOURCE_ONLY']='1'
branches=(ROOT/'tools/brdist.py').read_text()
branch_defs=branches[branches.index('def ours_branches'):branches.index('fns = sorted')]
results=[]
parser=argparse.ArgumentParser()
parser.add_argument('--extra-flags',action='store_true')
parser.add_argument('--retail-rung',action='store_true')
args=parser.parse_args()
options=([('force_addr',['-fforce-addr']),('no_cse_after_loop',['-fno-rerun-cse-after-loop'])]
         if args.extra_flags else [('default',[]),('no_split',['-mno-split-addresses'])])
if args.retail_rung:
    options=[('cc1pl281',[])]
for stem in ('baseline','canonical'):
    for option,extra in options:
        source=HERE/(stem+'.cpp')
        # Freeze the pre-P877 default settings; the production replay owner
        # now selects2.8.1 for the whole TU. Historical diagnostics must not
        # silently inherit that later correction and relabel it as2.8.0.
        injected="bld.PER_TU_FLAGS[cpp.relative_to(ROOT).as_posix()] = {}\n"
        if option=='cc1pl281':
            injected+="bld.CC1PL=bld._resolve_cc1plus_rung('2.8.1-sn')\nassert bld.CC1PL is not None\n"
        if option=='no_split':
            injected+="bld.PER_TU_FLAGS[cpp.relative_to(ROOT).as_posix()]['no_split_addresses'] = True\n"
        elif extra:
            injected+=("_p877_run=bld.run\n"
                       "def _p877_flag_run(command,*args,**kwargs):\n"
                       "    if str(command[0])==str(bld.CC1PL):\n"
                       "        command=list(command)\n"
                       "        command[1:1]="+repr(extra)+"\n"
                       "    return _p877_run(command,*args,**kwargs)\n"
                       "bld.run=_p877_flag_run\n")
        ns={'__name__':'p877_verify','__file__':str(ROOT/'tools/verify_asm.py')}
        sys.argv=['verify_asm.py',source.relative_to(ROOT).as_posix(),','.join(functions)]
        output=io.StringIO();errors=io.StringIO();rc=0
        with redirect_stdout(output),redirect_stderr(errors):
            try:
                exec(compile(tool.replace(hook,injected+hook),'p877_verify','exec'),ns)
            except SystemExit as e:
                rc=e.code
        bns=dict(g=ns,dis=ns['dis'],re=re,BR=re.compile(r'^\s*(b\w*|j)\b'))
        exec(compile(branch_defs,'p877_branch_definitions','exec'),bns)
        differences=[]
        for fn in functions:
            a=bns['ours_branches'](fn);e=bns['oracle_branches'](fn)
            if a!=e:
                differences.append(dict(function=fn,ours=a,oracle=e))
        row=dict(source=stem,option=option,extra_flags=extra,returncode=rc,stdout=output.getvalue(),
                 stderr=errors.getvalue(),object_sha256=hashlib.sha256(ns['obj'].read_bytes()).hexdigest(),
                 branches=differences,functions=len(functions),passed=output.getvalue().count(': PASS'))
        results.append(row)
        print(stem,option,str(row['passed'])+'/16 PASS',flush=True)
        print(output.getvalue(),flush=True)
        print('Branch residual functions:',[x['function'] for x in differences],flush=True)
(HERE/('retail_rung_results.json' if args.retail_rung else
       'extra_flag_results.json' if args.extra_flags else 'identity_results.json')).write_text(json.dumps(results,indent=2)+'\n')
