import io, os
p = r'C:\Temp\nfs4-decomp\recon\syslib\psx\libcd\streamhelp.c'
d = open(p, 'rb').read()
old = (b"     * likely the 4-byte align-1 struct copy being expanded as a movstrsi block move,\n"
       b"     * whose expander reserves its own address registers.  Measure with qty272 --keep on\n"
       b"     * the fenced basin and read `[find_free_reg]`, do not spell-probe further. */\n")
assert d.count(old) == 1, d.count(old)
add = (
    "    /* W64-A6 -- THE ANGLE WAS MEASURED, AND IT CLOSES AS A QUANTIFIED HARDNESS\n"
    "     * CERTIFICATE: this is an AVAILABILITY loss (a find_free_reg exclusion), not a\n"
    "     * priority loss, and 15A bounds every fence/ref/live dial out of that class by\n"
    "     * construction.  qty272 on the FENCED (count-EXACT 35/35) basin, cc1_272 lane,\n"
    "     * -O2 -G0 -mgas:\n"
    "     *     pseudo blk refs live sz calls    pri    home\n"
    "     *        72   0    4    5   4   0   1.6000   $v1   (slot base)\n"
    "     *        74   0    2    2   4   0   1.0000   $v0\n"
    "     *        76   0    4    9   4   0   0.8888   $a0   <- `dst`, THE ANCHOR\n"
    "     *        77/80/73/75/81   all pri <= 0.5, all reuse $v0/$v1\n"
    "     *     global allocnos: only p82 (refs 3 / live 5), home $a0 after 76 dies.\n"
    "     * The movstrsi hypothesis is FALSIFIED: the block-move expander mints no reserved\n"
    "     * hard reg here -- `dst` is an ordinary BLOCK-LOCAL qty, served 3rd, and $a0 is\n"
    "     * simply the FIRST FREE register in find_free_reg's numeric scan (MIPS has no\n"
    "     * REG_ALLOC_ORDER).  Retail's $a2 is the THIRD free register, so reaching it needs\n"
    "     * TWO MORE values simultaneously live across the anchor's 9-insn window.  This\n"
    "     * function has exactly two ($v0 = the lwl/lwr value, $v1 = the slot base) and there\n"
    "     * is no zero-insn way to mint a third: every hoist that would occupy $a0/$a1 also\n"
    "     * moves retail's own loads, which retail emits AFTER the copy.  MEASURED on the\n"
    "     * fenced basin (all gated, all reverted): hoist the _ds_word1 load 24 - hoist\n"
    "     * StFunc1 18 - hoist StRingIdx1 22 - w1+StFunc1 28 - w1+StRingIdx1 28; unfenced\n"
    "     * with both hoists 23.  Baseline 9, fenced control 10.\n"
    "     * ==> no priority/live/ref dial can reach retail's register; KEEP the un-anchored\n"
    "     * form.  Re-open only with a device that adds a live value at ZERO instructions. */\n")
d = d.replace(old, old + add.encode('ascii'), 1)
tmp = p + '.tmp'
open(tmp, 'wb').write(d)
assert os.path.getsize(tmp) > 100
os.replace(tmp, p)
b = open(p, 'rb').read()
print('ok CR', b.count(13), 'NUL', b.count(0), 'size', len(b))
