"""fenceprobe.py FILE -- for each code-level __asm__ fence line, delete it alone, gate the TU,
report diffs. Always restores the file. Prints INERT for fences whose removal keeps the baseline."""
import re,sys,subprocess,pathlib,shutil,os
f=pathlib.Path(sys.argv[1]); bak=str(f)+'.fpbak'; shutil.copyfile(str(f),bak)
def gate():
    r=subprocess.run([sys.executable,'tools/tugate.py',str(f)],capture_output=True,text=True)
    o=(r.stdout or '')+(r.stderr or '')
    m=re.search(r':\s*(\d+)/(\d+) PASS',o)
    fails=[l.strip() for l in o.split('\n') if l.startswith('  ') and 'ORACLE' not in l and l.strip()]
    if not m: return None,o[:400]
    return (int(m.group(1)),int(m.group(2))),' | '.join(fails[:3])
src=f.read_text(errors='replace'); lines=src.split('\n')
masked=re.sub(r'/\*.*?\*/',lambda m:re.sub(r'[^\n]','.',m.group(0)),src,flags=re.S)
masked=re.sub(r'//[^\n]*',lambda m:'.'*len(m.group(0)),masked).split('\n')
# a fence = a statement line whose masked text contains __asm__("" ...
idx=[i for i in range(len(masked)) if re.search(r'__asm__\s*(__volatile__|volatile)?\s*\(\s*""',masked[i])]
base,_=gate(); print(f"BASELINE {f}: {base}")
inert=[]
try:
    for i in idx:
        # find the full statement (may span lines until the terminating ');')
        j=i
        while j<len(lines) and not re.search(r'\)\s*;\s*$',masked[j]): j+=1
        newlines=lines[:i]+lines[j+1:]
        f.write_text('\n'.join(newlines))
        g,fl=gate()
        tag='INERT' if g==base else ('COMPILE-FAIL' if g is None else 'LOAD-BEARING')
        if g==base: inert.append((i,j))
        print(f"  L{i+1}-{j+1} {tag:13} {g}  {lines[i].strip()[:80]}  {fl[:70]}")
finally:
    shutil.copyfile(bak,str(f)); os.remove(bak)
print("INERT LINE RANGES (1-based):", [(a+1,b+1) for a,b in inert])
