"""Compile P875 typed-reference probes using the real CPP/CC1PLPSX.

Reads source/header files only; compiler intermediates stay in p875_psx/.
No post-compiler rewrites, aliases or build-lane mutations are performed.
"""
import concurrent.futures
import hashlib
import json
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
WORK = Path(__file__).with_name('p875_psx')
sys.path.insert(0, str(ROOT / 'tools'))
import build

stage = sys.argv[1]
selected = set(sys.argv[2:])
file_stage = 'after' if stage == 'owners' else stage
files = sorted(p for p in WORK.glob('*_' + file_stage + '.cpp')
               if not selected or p.stem.removesuffix('_' + file_stage) in selected)

def compile_owner(probe):
    stem = probe.stem.removesuffix('_after')
    source = 'recon/game/psx/' + stem + '.cpp'
    command = [sys.executable, 'tools/tugate.py', source]
    env = dict(os.environ, NFS4_SOURCE_ONLY='1')
    result = subprocess.run(command, cwd=ROOT, env=env, capture_output=True, text=True)
    obj = ROOT / 'build' / (source + '.o')
    item = {'source':source, 'command':command, 'returncode':result.returncode,
            'stdout':result.stdout, 'stderr':result.stderr}
    if obj.exists():
        item['object_sha256'] = hashlib.sha256(obj.read_bytes()).hexdigest()
        result = subprocess.run([str(build.MIPS / 'mipsel-none-elf-objdump.exe'), '-t', str(obj)],
                                cwd=ROOT, text=True, capture_output=True)
        item['actual_function_symbols'] = [line.split()[-1] for line in result.stdout.splitlines()
                                           if re.match(r'^[0-9a-fA-F]{8}\s+.*?\bF\b', line)
                                           and '*UND*' not in line]
        item['local_function_symbols'] = [line.split()[-1] for line in result.stdout.splitlines()
                                         if re.match(r'^[0-9a-fA-F]{8}\s+l\s+F\b', line)]
    return item

def compile_one(src):
    stem = src.stem.removesuffix('_' + stage)
    preprocessed, assembly = src.with_suffix('.i'), src.with_suffix('.s')
    commands = [
        [build.CPP, '-x', 'c', '-D__cplusplus=1', '-nostdinc', '-undef',
         '-Dmips', '-D__mips__', '-D__psx__', '-I' + str(build.RECON),
         src, '-o', preprocessed],
        [build.CC1PL, '-quiet', '-O2', '-G4', preprocessed, '-o', assembly],
    ]
    item = {'header': 'recon/game/psx/' + stem + '.h', 'probe': str(src.relative_to(ROOT)),
            'stage': stage, 'commands': [[str(v) for v in c] for c in commands],
            'diagnostics': []}
    item['probe_sha256'] = hashlib.sha256(src.read_bytes()).hexdigest()
    item['input_mode'] = 'frozen-original-prototype-surface' if stage == 'before' else 'live-public-header'
    if stage != 'before':
        item['header_sha256'] = hashlib.sha256((ROOT / item['header']).read_bytes()).hexdigest()
    for command in commands:
        result = subprocess.run([str(v) for v in command], cwd=ROOT, text=True,
                                capture_output=True)
        if result.stdout or result.stderr:
            item['diagnostics'].append(result.stdout + result.stderr)
        if result.returncode:
            item.update(ok=False, returncode=result.returncode,
                        error=result.stdout + result.stderr)
            return item
    asm = assembly.read_text()
    item['references'] = {m[1]:m[2] for m in re.finditer(
        r'(?m)^p875_probe_(\d+):\s*\n\s*\.word\s+(\S+)', asm)}
    item['ok'] = True
    item['assembly_sha256'] = hashlib.sha256(assembly.read_bytes()).hexdigest()
    obj = ROOT / 'build/recon/game/psx' / (stem + '.cpp.o')
    if obj.exists():
        result = subprocess.run([str(build.MIPS / 'mipsel-none-elf-objdump.exe'), '-t', str(obj)],
                                cwd=ROOT, text=True, capture_output=True)
        item['actual_symbols'] = [line.split()[-1] for line in result.stdout.splitlines()
                                  if re.match(r'^[0-9a-fA-F]{8}\s+', line) and '*UND*' not in line]
    else:
        item['actual_symbols'] = []
    return item

with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
    results = list(pool.map(compile_owner if stage == 'owners' else compile_one, files))
print(json.dumps(results))
