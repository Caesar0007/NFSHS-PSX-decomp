import os

p = r'C:\Temp\nfs4-decomp\recon\syslib\psx\libcd\stcdint.c'
d = open(p, 'rb').read()
CR = b"\r\n"

# ---- 1. _st_dma receipt: append after the existing FALSIFIED block ----------------
old1 = (b"     * with `bcr` 33. */" + CR)
assert d.count(old1) == 1, ("anchor1", d.count(old1))
add1 = CR.join([
b"     *",
b"     * W64-A6 -- THREE MORE AXES CLOSED, all measured in the CURRENT basin (04Z):",
b"     * (i) COMPILER LADDER re-run after w63's StCdInterrupt landing (rungs driven with",
b"     *     NFS4_FORCE_CC1_ALT through the 272 recipe): 2.6.0 25 / 2.6.3 25 / 2.7.2 25",
b"     *     (the wired lane) / 2.7.2-970404 81 / 2.8.0 74 / 2.8.1 77.  The wired 2.7.2 is",
b"     *     optimal and the sub-2.8 rungs are merely equal -- no version lever here.",
b"     * (ii) EVERY LANDED FENCE IN THIS FUNCTION IS LOAD-BEARING (the w64 CdRead lesson --",
b"     *     an inherited fence can itself be the blocker -- was tested here and does NOT",
b"     *     apply): drop the `bv` read-only fence 43 / drop the two `bit` identity fences",
b"     *     39 / keep only ONE `bit` fence 31 / add a THIRD 25 (saturated) / drop the `dp`",
b"     *     identity fence 39 / drop the FIRST __volatile__ barrier 37 @105 / drop BOTH",
b"     *     barriers 41 @105.  Only the SECOND __volatile__ barrier is inert (25) -- it is",
b"     *     kept as documentation of the Rage-Racer CD_dmastart shape.",
b"     * (iii) The cluster-(b) address/BCR EMISSION ORDER is a STRONG structural floor:",
b"     *     SIX distinct source spellings compile BYTE-IDENTICALLY (25 @107) --",
b"     *     `int base` + index-first sum, `int base` + base-first sum, literal index-first",
b"     *     sum, `p` computed before `dp`, a named `bcr` hoisted above the DPCR RMW, and",
b"     *     base+bcr together.  cse/RTL canonicalisation absorbs the whole family, so the",
b"     *     `addu a1,v0,a1` vs `addu a1,a1,a2` operand/dest tie (12D qty_combine) is not",
b"     *     reachable from C here.  Fencing the `bcr` temp instead COSTS 2 insns (53 @109).",
b"     *     Also re-confirmed inert: naming the 0x10000 busy-wait limit (27, slightly",
b"     *     worse -- it does NOT move retail's `lui a2,1` into the guard's delay slot).",
b""])
d = d.replace(old1, add1 + old1, 1)

# ---- 2. StCdInterrupt receipt -----------------------------------------------------
old2 = b"extern void StCdInterrupt(void)" + CR + b"{" + CR
assert d.count(old2) == 1, ("anchor2", d.count(old2))
add2 = CR.join([
b"    /* W64-A6 re-gate: 27 @576/583 (w63's landed void barrier holds).  TWO axes re-run",
b"     * in the NEW basin per 04Z and both CLOSED:",
b"     *  (a) A SECOND void barrier: tools/fencesweep.py over all 116 statement positions",
b"     *      in this body finds NOTHING under 27 -- the best non-baseline results are 28",
b"     *      (5 positions) and 29 (7 positions), everything else 27 or worse.  (The same",
b"     *      sweep is what found the 36 -> 27 barrier, so its emptiness is a real negative.)",
b"     *  (b) COMPILER LADDER: 2.6.0 66 / 2.6.3 66 / 2.7.2 27 (wired) / 2.7.2-970404 756 /",
b"     *      2.8.0 756 / 2.8.1 756.  The wired 272 lane is decisively optimal.",
b"     * The residual is still the w52-a2 cluster list; the ring-mechanics twins the W64",
b"     * corpus sweep looked for do not exist (see the file header note). */",
b""])
d = d.replace(old2, old2 + add2, 1)

tmp = p + '.tmp'
open(tmp, 'wb').write(d)
assert os.path.getsize(tmp) > 100
os.replace(tmp, p)
b = open(p, 'rb').read()
print('ok CRLF', b.count(CR), 'LF', b.count(b"\n"), 'NUL', b.count(0), 'size', len(b))
