import sys
v = sys.argv[1]
s = open('scratchpad/psyq_pipe/aih_cop.orig.cpp', encoding='utf-8').read()
a = s.index('    blockadeMode_t one;\n\n    this->requestSpikeBeltAtSlice_ = -1;')
marker = '      if ((this->blockade_.mode != 4) && (this->CheckForNewTarget() != 0)) {\n'
b = s.index(marker)
G1 = {'V1': '(this->blockade_.mode != 1) && (this->blockade_.mode != 4)',
      'V2': '(this->blockade_.mode != one) && (this->blockade_.mode != chaseState)',
      'V3': '(this->blockade_.mode != one) && (this->blockade_.mode != 4)'}[v]
G2 = {'V1': '(this->blockade_.mode != 1) && (this->blockade_.mode != 4)',
      'V2': '(this->blockade_.mode != one) && (this->blockade_.mode != 4)',
      'V3': '(this->blockade_.mode != one) && (this->blockade_.mode != chaseState)'}[v]
decl = {'V1': '', 'V2': '    blockadeMode_t one;\n    stateType_t chaseState;\n\n', 'V3': '    blockadeMode_t one;\n\n'}[v]
init = {'V1': '', 'V2': '    one = (blockadeMode_t)1;\n    chaseState = (stateType_t)4;\n\n', 'V3': '    one = (blockadeMode_t)1;\n\n'}[v]
cs = {'V1': '      stateType_t chaseState;\n      chaseState = (stateType_t)4;\n', 'V2': '', 'V3': '      stateType_t chaseState;\n      chaseState = (stateType_t)4;\n'}[v]
head = (decl + '    this->requestSpikeBeltAtSlice_ = -1;\n\n' + init +
        '    if (' + G1 + ') {\n      (this->carObj_)->AIFlags = (this->carObj_)->AIFlags & 0xfffffffd;\n    }\n\n'
        '    {\n' + cs + '      if (' + G2 + ' && (this->CheckForNewTarget() != 0)) {\n')
tail = s[b + len(marker):]
close_old = '      }\n      }\n      }\n\n    }\n'
c = tail.index(close_old)
tail = tail[:c] + '      }\n    }\n' + tail[c + len(close_old):]
open('recon/game/common/aih_cop.cpp', 'w', encoding='utf-8', newline='').write(s[:a] + head + tail)
print(v, 'written')
