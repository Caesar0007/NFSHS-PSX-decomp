"""dumpfn.py OBJ SYMNAME  -> prints the function's instruction stream (mnemonic + operands)."""
import re, subprocess, sys
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
obj, fn = sys.argv[1], sys.argv[2]
dis = subprocess.run([OBJD, '-d', '-z', obj], capture_output=True, text=True).stdout
inb = False
for ln in dis.splitlines():
    m = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
    if m:
        if inb and re.fullmatch(r'LM\d+', m.group(1)):
            continue
        if inb:
            break
        inb = (m.group(1) == fn)
        continue
    if not inb:
        continue
    mm = re.match(r'^\s*[0-9a-f]+:\t([0-9a-f]+)\s*\t(.*)', ln)
    if not mm:
        continue
    print(re.sub(r'\s+', ' ', mm.group(2).strip()))
