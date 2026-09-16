"""one-shot patch: model the retail 4-aligned COMMON layout for game objects in psylink_lane.py"""
p = 'C:/Temp/nfs4-decomp/scratchpad/psyq_pipe/psylink_lane.py'
s = open(p, encoding='utf-8').read()
reps = [
 ("def sn_text(src: Path, vtables=False, front=False, pads=None) -> bytes:",
  "def sn_text(src: Path, vtables=False, front=False, pads=None, g=None) -> bytes:"),
 ("        m = COMM_RE.match(s)\n        if m and front:\n",
  "        m = COMM_RE.match(s)\n"
  "        if m and (front or (COMM4 and (m.group(1) == b'lcomm' or g is None or int(m.group(3)) > g))):\n"
  "            # retail COMMON law (2026-09-17): .lcomm/.comm are laid out after the object's\n"
  "            # explicit .bss, locals first then globals, each aligned to min(4, size) -- retail\n"
  "            # corrPt.47 12B @4, fogstrspc 64B @4, gPadinfo 84B @4 (ASPSX 2.56 does this; 2.77\n"
  "            # aligns min(8, size) -- build/psyq/probe/al2.s).  Small .comm (<= G) stay .sbss.\n"),
 ("    if lcomm or comm:\n        out.append(b'\\t.section front.bss')\n",
  "    if lcomm or comm:\n        out.append(b'\\t.section front.bss' if front else b'\\t.bss')\n"),
 ("def crlf(src: Path, dst: Path, front=False, pads=None):",
  "def crlf(src: Path, dst: Path, front=False, pads=None, g=None):"),
 ("    dst.write_bytes(sn_text(src, vtables='vtables_' in src.name, front=front, pads=pads).replace(b'_._', b'___'))",
  "    dst.write_bytes(sn_text(src, vtables='vtables_' in src.name, front=front, pads=pads, g=g).replace(b'_._', b'___'))"),
 ("        tmp = OUT / (rel.replace('/', '__') + '.s'); crlf(sfile, tmp, front=front, pads=PADS.get(bo))",
  "        tmp = OUT / (rel.replace('/', '__') + '.s'); crlf(sfile, tmp, front=front, pads=PADS.get(bo), g=int(g))"),
 ("steps = [a for a in sys.argv[1:] if a.startswith('--')] or ['--assemble', '--link', '--compare']",
  "steps = [a for a in sys.argv[1:] if a.startswith('--')] or ['--assemble', '--link', '--compare']\n"
  "COMM4 = '--no-comm4' not in sys.argv   # model the retail 4-aligned COMMON layout for game objects"),
]
for a, b in reps:
    assert s.count(a) == 1, a[:70]
    s = s.replace(a, b)
open(p, 'w', encoding='utf-8', newline='').write(s)
print('lane patched')
