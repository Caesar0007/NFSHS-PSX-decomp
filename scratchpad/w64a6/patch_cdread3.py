import os

p = r'C:\Temp\nfs4-decomp\recon\syslib\psx\libcd\cdread.c'
d = open(p, 'rb').read()
NL = b"\n"

old2 = b" * retail carries `li $v0,1`. */\n"
assert d.count(old2) == 1, ("a2", d.count(old2))
add2 = NL.join([
b" * W64-A6: re-gated 15 @158/157 and the FENCE-REMOVAL axis is now closed too (the",
b" * w64 CdRead lesson -- an inherited fence can itself be the blocker -- does NOT apply",
b" * here): dropping the `exp` fence 24 @157, the DMA-arm `cur` fence 17, the PIO-arm",
b" * `cur` fence 37 @160, ALL FOUR 48 @159.  Only the trailing `g` fence in the PIO arm",
b" * is INERT (15) -- kept as documentation of the derived-view shape.",
b" * Per-fn `-mno-split-addresses` (the mechanism that seals CdRead) is decisively WRONG",
b" * here: 47 @162 (and _read_issue 32 @126, _read_data_int PASS -> 3, CdReadSync",
b" * PASS -> 2), so the two split `lui/addiu` pairs are not reachable that way.",
b""])
d = d.replace(old2, add2 + old2, 1)

tmp = p + '.tmp'
open(tmp, 'wb').write(d)
assert os.path.getsize(tmp) > 100
os.replace(tmp, p)
b = open(p, 'rb').read()
print('ok CR', b.count(13), 'NUL', b.count(0), 'size', len(b))
