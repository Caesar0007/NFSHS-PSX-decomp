import importlib.util, sys, traceback
from pathlib import Path
ROOT=Path(__file__).resolve().parent.parent
spec=importlib.util.spec_from_file_location('bld', ROOT/'tools'/'build.py'); bld=importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT=bld.BUILD
import subprocess
mods=sorted((ROOT/sys.argv[1] if len(sys.argv)>1 else ROOT/'recon'/'game'/'common').glob('*.cpp'))
ok=[]; fail=[]
for m in mods:
    # compile via the same pipeline but capture errors instead of sys.exit
    try:
        rel=m.relative_to(ROOT); obj=bld.OUT/(str(rel)+'.o'); obj.parent.mkdir(parents=True,exist_ok=True)
        i_file=obj.with_suffix('.i'); s_file=obj.with_suffix('.s')
        r=bld.run([bld.CPP,'-x','c','-D__cplusplus=1','-nostdinc','-undef','-Dmips','-D__mips__','-D__psx__',f'-I{bld.RECON}',m,'-o',i_file])
        if r.returncode: fail.append((m.name,'cpp:'+r.stderr.strip().split(chr(10))[-1][:120])); continue
        r=bld.run([bld.CC1PL,'-quiet','-O2',f'-G{bld.G_VALUE}',i_file,'-o',s_file])
        if r.returncode:
            err=(r.stdout+r.stderr).strip().split(chr(10)); err=[e for e in err if 'error' in e.lower() or 'undeclared' in e.lower() or 'parse' in e.lower()]
            fail.append((m.name,'cc1:'+(err[0][:140] if err else 'unknown'))); continue
        ok.append(m.name)
    except Exception as e:
        fail.append((m.name,'exc:'+str(e)[:100]))
print(f"COMPILE OK: {len(ok)}/{len(mods)}   FAIL: {len(fail)}")
print("=== FAILURES ===")
for n,e in fail: print(f"  {n}: {e}")
