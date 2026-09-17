"""Rewrite the four NonActive sites of the LIVE AIHigh_BTC_Wingman::HighExecute (aih_btccop.cpp):
retail loads this->carObj_ AFTER operator new returns and keeps ONE 12-byte offset local (the inline
ctor's), so the arg must be the member expression itself and the dead block locals must go."""
import re
p = 'C:/Temp/nfs4-decomp/recon/game/common/aih_btccop.cpp'
s = open(p, encoding='utf-8').read()
a = s.index('void AIHigh_BTC_Wingman::HighExecute()\n{\n')
b = s.index('#if 0', a)
body = s[a:b]
n1 = len(re.findall(r'\n[ \t]*carObj = this->carObj_;\n[ \t]*newState = new AIState_NonActive\(carObj\);[^\n]*', body))
body = re.sub(r'\n([ \t]*)carObj = this->carObj_;\n[ \t]*newState = new AIState_NonActive\(carObj\);[^\n]*',
              r'\n\1newState = new AIState_NonActive(this->carObj_);', body)
n2 = len(re.findall(r'\n[ \t]*Car_tObj \*carObj;\n', body))
body = re.sub(r'\n[ \t]*Car_tObj \*carObj;\n', '\n', body)
n3 = len(re.findall(r'\n[ \t]*coorddef trafficOffset;\n', body))
body = re.sub(r'\n[ \t]*coorddef trafficOffset;\n', '\n', body)
print('sites', n1, 'carObj decls', n2, 'trafficOffset decls', n3)
assert n1 == 4
open(p, 'w', encoding='utf-8', newline='').write(s[:a] + body + s[b:])
