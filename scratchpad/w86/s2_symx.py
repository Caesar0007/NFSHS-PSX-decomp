"""S2 helper: dump SYM `8c Function start` blocks for one source file (read-only)."""
import sys, re
SYM = r"C:\Temp\nfs4-psx\nfs4-psx-sym.txt"
want = sys.argv[1].upper()          # e.g. FEMENUEXTENDED.CPP
only = sys.argv[2].upper() if len(sys.argv) > 2 else None   # substring of fn name

lines = open(SYM, encoding='latin-1').read().split('\n')
blocks = []
i = 0
while i < len(lines):
    if lines[i].endswith('8c Function start'):
        j = i + 1
        blk = [lines[i]]
        # header fields
        while j < len(lines) and lines[j].startswith('    '):
            blk.append(lines[j]); j += 1
        # body records until matching 8e Function end
        depth = 0
        while j < len(lines):
            blk.append(lines[j])
            if '8e Function end' in lines[j]:
                j += 1; break
            if '8c Function start' in lines[j]:
                break
            j += 1
        blocks.append(blk)
        i = j
    else:
        i += 1

for blk in blocks:
    txt = '\n'.join(blk)
    m = re.search(r'file = (.*)', txt)
    if not m or not m.group(1).strip().upper().endswith(want):
        continue
    nm = re.search(r'name = (.*)', txt)
    if only and (not nm or only not in nm.group(1).upper()):
        continue
    print(txt)
    print('=' * 70)
