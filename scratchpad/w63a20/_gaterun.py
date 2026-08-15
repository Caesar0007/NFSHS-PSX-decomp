import os, sys
from pathlib import Path
ROOT = Path(r'C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
SRC = open(ROOT / 'tools' / 'verify_asm.py').read().replace(
    'bld.OUT = bld.BUILD',
    'bld.OUT = Path(os.environ["W63A20_OUT"]); bld.OUT.mkdir(parents=True, exist_ok=True)')
sys.argv = ['verify_asm.py'] + sys.argv[1:]
exec(compile(SRC, str(ROOT / 'tools' / 'verify_asm.py'), 'exec'),
     {'__name__': '__main__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')})
