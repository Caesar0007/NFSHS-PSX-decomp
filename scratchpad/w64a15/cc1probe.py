"""w64a15: raw CC1PLPSX flag probe -- cpp a recon TU, compile with extra flags,
print the .s window around an anchor.  Search accelerator only, never the gate.

  python cc1probe.py <recon/rel/path.cpp> <asm-anchor-regex> [flag ...]
"""
import os, re, subprocess, sys, tempfile

ROOT = r'C:\Temp\nfs4-decomp'
CPP = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-cpp.exe'
CC1PL = r'C:/Temp/psq43/COMPILER/CC1PLPSX.EXE'
HERE = os.path.join(tempfile.gettempdir(), 'w64a15_%d' % os.getpid())
os.makedirs(HERE, exist_ok=True)


def main():
    src, anchor = sys.argv[1], sys.argv[2]
    extra = sys.argv[3:]
    i_file = os.path.join(HERE, 'v.i')
    r = subprocess.run([CPP, '-x', 'c', '-D__cplusplus=1', '-nostdinc', '-undef',
                        '-Dmips', '-D__mips__', '-D__psx__',
                        '-I' + os.path.join(ROOT, 'recon'),
                        os.path.join(ROOT, src), '-o', i_file],
                       capture_output=True, text=True, cwd=ROOT)
    if r.returncode:
        print('cpp FAILED', r.stderr[-300:])
        return
    s_file = os.path.join(HERE, 'v.s')
    subprocess.run([CC1PL, '-quiet', '-O2', '-G4', '-fno-exceptions', '-fno-rtti']
                   + extra + [i_file, '-o', s_file], capture_output=True, cwd=HERE)
    txt = open(s_file, errors='replace').read().splitlines()
    hits = [i for i, l in enumerate(txt) if re.search(anchor, l)]
    if not hits:
        print('anchor not found')
        return
    i = hits[0]
    print('\n'.join(txt[i:i + 32]))


if __name__ == '__main__':
    main()
