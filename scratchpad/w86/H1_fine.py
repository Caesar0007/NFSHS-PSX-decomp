"""H1_fine -- hunt a FINE-GRAINED (1..4 object) pure-C chain-object device.

Why: the W85-M3 wall is "R1 needs prefix P >= 22, R2 needs P in [17,21]".  With
the TU's nine sites the achievable prefix sums are {0,5,9,10,13,14,15,18,19,20,
22,...} -- **21 is NOT reachable**, so the single value where both windows could
overlap was never tested.  A device of cost 1..4 objects makes P=21 reachable.

Cost model (base TU's own W76-A1 note, cse.c:8620-8645): a depth-1 `({ ... })`
= 4 NOTE_INSN_BLOCK notes + 1 cse-deleted value copy = 5 chain rtx; each extra
nesting level = +4 notes.  So a construct that yields ONE extra cse/flow-deleted
copy WITHOUT opening a block should cost exactly 1.

usage: python H1_fine.py            -- measure every candidate at cfg 001111133 (P=20)
       python H1_fine.py <cand> <cfg> [cfg...]
"""
import sys
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w86')
import H1_lib as L
import H1_score as S

GAR = 'tMenuItem *garageCarItem = &itemGarageCar; (void)garageCarItem; 0x1a00'

# candidate fine devices, each spelled INSIDE the garage statement expression
# (which already owns a real variable), pure C++, no volatile/asm/pin.
CANDS = {
 # one extra pointer copy: cse forwards it, flow deletes it -> 1 chain rtx, 0 insns
 'copy1': 'tMenuItem *garageCarItem = &itemGarageCar; tMenuItem *garageCarItem2 = garageCarItem; (void)garageCarItem; (void)garageCarItem2; 0x1a00',
 'copy2': 'tMenuItem *garageCarItem = &itemGarageCar; tMenuItem *garageCarItem2 = garageCarItem; tMenuItem *garageCarItem3 = garageCarItem2; (void)garageCarItem; (void)garageCarItem2; (void)garageCarItem3; 0x1a00',
 'copy3': 'tMenuItem *garageCarItem = &itemGarageCar; tMenuItem *garageCarItem2 = garageCarItem; tMenuItem *garageCarItem3 = garageCarItem2; tMenuItem *garageCarItem4 = garageCarItem3; (void)garageCarItem; (void)garageCarItem2; (void)garageCarItem3; (void)garageCarItem4; 0x1a00',
 # dead reassignment (33A-1 twin): store after the last read
 'dead1': 'tMenuItem *garageCarItem = &itemGarageCar; (void)garageCarItem; garageCarItem = &itemCar; 0x1a00',
 # 33A-1 ref inflator: idempotent op with a VARIABLE operand
 'inf1':  'tMenuItem *garageCarItem = &itemGarageCar; (void)garageCarItem; garageCarItem = (tMenuItem *)((int)garageCarItem | (int)garageCarItem); 0x1a00',
 # void-cast repeat (expected inert -- the control)
 'void1': 'tMenuItem *garageCarItem = &itemGarageCar; (void)garageCarItem; (void)garageCarItem; 0x1a00',
}


def measure(name, cfgs):
    body = CANDS[name]
    edits = [(GAR, body, 1)]
    for cfg in cfgs:
        st = S.build_cfg(cfg, edits=edits, tag='H1_fine')
        n, ln, err, bad = S.score_stream(st)
        print('%-6s %s insns=%-5d frame=%-4s R2delta=%-4s R1=%-10s score=%s' %
              (name, cfg, ln, S.frame(st), S.probe1747(st), S.probeR1(st), n), flush=True)


if __name__ == '__main__':
    if len(sys.argv) > 1:
        measure(sys.argv[1], sys.argv[2:] or ['001111133'])
    else:
        for k in CANDS:
            measure(k, ['001111133'])
