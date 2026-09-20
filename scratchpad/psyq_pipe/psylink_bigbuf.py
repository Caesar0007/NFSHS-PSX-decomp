"""psylink_bigbuf.py -- the PSYLINK lane links the REAL bigbuf.c / address.c objects (recon/frontend/psx) instead of its two
hand-made placeholders (which modelled bigbuf as 0x44548 bytes and address as ONE word)."""
R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
p = R + 'scratchpad/psyq_pipe/psylink_lane.py'
s = open(p, encoding='utf-8').read()
a = s.index('    # placeholders: bigbuf (the 0x44548 .rdata reservation')
b = s.index("    print('ASPSX ok %d bad %d (front-overlay objects: %d)'")
s = (s[:a] + "    # bigbuf.obj / address.obj are real TUs now (recon/frontend/psx/bigbuf.c = 282000-byte reservation, address.c = the two" + NL +
     "    # overlay boundary words); drop the placeholders an earlier run left behind." + NL +
     "    for n in ('bigbuf.obj', 'address.obj'):" + NL + "        if (OUT / n).exists():" + NL + "            (OUT / n).unlink()" + NL + s[b:])
k = "    return {o for o, sec in first.items() if sec.startswith('front.')}" + NL
assert s.count(k) == 1
s = s.replace(k, "    # bigbuf.obj is the MAIN binary's reservation the overlay is linked over -- it starts at the overlay origin but is `text` group .rdata" + NL +
              "    return {o for o, sec in first.items() if sec.startswith('front.') and not o.endswith('frontend/psx/bigbuf.c.o')}" + NL)
k = "k = next((i for i, (_, p) in enumerate(inc) if p == 'address.obj'), 1)"
assert s.count(k) == 1
s = s.replace(k, "k = next((i for i, (_, p) in enumerate(inc) if p and p.endswith('__address.c.obj')), 1)")
open(p, 'w', encoding='utf-8', newline='').write(s)
print('ok')
