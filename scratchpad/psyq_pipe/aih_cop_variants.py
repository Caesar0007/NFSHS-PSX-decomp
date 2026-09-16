import sys, subprocess, re, difflib
v = sys.argv[1]
s = open('aihC.i', encoding='utf-8', errors='replace').read()
a = s.index('    blockadeMode_t one;\n\n    this->requestSpikeBeltAtSlice_ = -1;')
marker = '      if ((this->blockade_.mode != 4) && (this->CheckForNewTarget() != 0)) {\n'
b = s.index(marker)
store = '(this->carObj_)->AIFlags = (this->carObj_)->AIFlags & 0xfffffffd;'
M = '(this->blockade_.mode'
D_one = '    blockadeMode_t one;\n'
D_cs = '    stateType_t chaseState;\n'
I_one = '    one = (blockadeMode_t)1;\n'
I_cs = '    chaseState = (stateType_t)4;\n'
CS_in = '      stateType_t chaseState;\n      chaseState = (stateType_t)4;\n'


def flat(g1, g2, decl, init, cs):
    return (decl + '\n    this->requestSpikeBeltAtSlice_ = -1;\n\n' + init + '\n    if (' + g1 + ') {\n      ' + store
            + '\n    }\n\n    {\n' + cs + '      if (' + g2 + ' && (this->CheckForNewTarget() != 0)) {\n')


V = {
    'V5': flat(M + ' != one) && ' + M + ' != chaseState)', M + ' != 1) && ' + M + ' != 4)', D_one + D_cs, I_one + I_cs, ''),
    'V6': flat(M + ' != one) && ' + M + ' != chaseState)', M + ' != one) && ' + M + ' != 4)', D_one + D_cs, I_one + I_cs, ''),
    'V7': flat(M + ' != one) && ' + M + ' != 4)', M + ' != one) && ' + M + ' != 4)', D_one, I_one, CS_in),
    'V8': flat(M + ' != 1) && ' + M + ' != chaseState)', M + ' != 1) && ' + M + ' != 4)', D_cs, I_cs, ''),
    'V9': flat(M + ' != one) && ' + M + ' != chaseState)', M + ' != one) && ' + M + ' != chaseState)', D_one + D_cs, I_one + I_cs, ''),
    'V10': flat(M + ' != 1) && ' + M + ' != 4)', M + ' != 1) && ' + M + ' != 4)', '', '', CS_in),
    'V11': flat(M + ' != one) && ' + M + ' != 4)', M + ' != 1) && ' + M + ' != 4)', D_one, I_one, CS_in),
}
tail = s[b + len(marker):]
close_old = '      }\n      }\n      }\n\n    }\n'
c = tail.index(close_old)
tail = tail[:c] + '      }\n    }\n' + tail[c + len(close_old):]
open('aihV.i', 'w', encoding='utf-8', newline='').write(s[:a] + V[v] + tail)
r = subprocess.run(['C:/Temp/psq43/COMPILER/CC1PLPSX.EXE', '-quiet', '-O2', '-G4', '-mgas', 'aihV.i', '-o', 'aihV.s'],
                   capture_output=True, text=True)
if 'error' in r.stderr:
    print(v, 'COMPILE ERROR', [l for l in r.stderr.splitlines() if 'error' in l][:3]); sys.exit()
txt = open('aihV.s').read()
m = re.search(r'^HighExecute__10AIHigh_Cop:.*?\.end\tHighExecute__10AIHigh_Cop', txt, re.S | re.M)
skip = re.compile(r'\s*\.(set|loc)|\s*#|\$L\d+:')
lab = re.compile(r'\$L\d+')
fn = [lab.sub('$L', l) for l in m.group(0).splitlines() if not skip.match(l)]
ref = [lab.sub('$L', l) for l in open('hxC.txt').read().splitlines() if not skip.match(l)]
d = [l for l in difflib.unified_diff(ref, fn, n=0, lineterm='') if l[:1] in '+-' and l[:3] not in ('+++', '---')]
print(v, 'insns', len(fn), 'vs', len(ref), 'difflines', len(d))
print('\n'.join(d[:24]))
