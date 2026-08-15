import re, sys, json, pathlib

S = pathlib.Path(r"C:\Temp\nfs4-decomp\build\recon\syslib\psx\libcd\cdread.c.s")
txt = S.read_text(errors="replace")
name = "CdRead"
m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(name), txt, re.M)
m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(name), txt[m.end():], re.M)
region = txt[m.start(): m.end() + m2.start()]
print("region lines:", region.count("\n"))

TAKE = r"\tsw\t\$20,0\(\$16\)\n(?=\t#\.set\tnovolatile\n\tjal\tCdSyncCallback\n)"
AFTER = r"\tjal\tCdSyncCallback\n(?=\tmove\t\$4,\$0\n)"

for nm, rx in (("TAKE", TAKE), ("AFTER", AFTER)):
    hits = list(re.finditer(rx, region))
    print("%-6s count=%d  %r" % (nm, len(hits), rx))
    for h in hits:
        print("        @%d  %r" % (h.start(), h.group(0)))

# unpinned controls, to show the pin is load-bearing
for nm, rx in (("TAKE-unpinned", r"\tsw\t\$20,0\(\$16\)\n"),
               ("AFTER-unpinned", r"\tjal\tCdSyncCallback\n"),
               ("sw $20 anywhere", r"\tsw\t\$20,\d+\(\$16\)\n"),
               ("sw $19,4", r"\tsw\t\$19,4\(\$16\)\n")):
    print("%-16s count=%d" % (nm, len(re.findall(rx, region))))

# what would the take-removed region look like around the anchor?
tk = re.search(TAKE, region)
r2 = region[:tk.start()] + region[tk.end():]
an = re.search(AFTER, r2)
print("\n--- context AFTER the splice (simulated) ---")
new = (r2[:an.start()] + "\t.set\tnoreorder\n" + an.group(0)
       + tk.group(0) + "\t.set\treorder\n" + r2[an.end():])
i = new.find("\t.set\tnoreorder\n\tjal\tCdSyncCallback")
print(new[i - 420:i + 260])
