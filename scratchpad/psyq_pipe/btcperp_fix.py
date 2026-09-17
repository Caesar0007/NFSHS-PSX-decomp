"""aih_btcperp.cpp: (1) AIHigh_BTC_AIPerp::HighExecute -- retail jump table 0x80055040 sends
stateType_ 1 to the default target (0x80060d50), not into case 2's body; (2) the AIPerp ctor's
intermediate (inlined AIHigh_BTC_Perp ctor) vptr store is this TU's BTC_Perp table 0x80054fe0."""
import re
p = 'C:/Temp/nfs4-decomp/recon/game/common/aih_btcperp.cpp'
s = open(p, encoding='utf-8').read()
a = "  case 1:   /* MATCH: oracle's compare-chain routes stateType_==1 into the SAME body as case 2 */\n"
assert s.count(a) == 1, s.count(a)
s = s.replace(a, "")
pat = re.compile(r"this->_vf =\s*\(__vtbl_ptr_type \(\*\) \[3\]\)\(AIHigh_BTC_HumanPerp_vtable \+ 8\);")
assert len(pat.findall(s)) == 1
s = pat.sub("this->_vf =\n       (__vtbl_ptr_type (*) [3])AIHigh_BTC_Perp_vtable;   /* the inlined AIHigh_BTC_Perp ctor's vptr store: retail 0x80054fe0 = this TU's BTC_Perp table */", s)
open(p, 'w', encoding='utf-8', newline='').write(s)
print('ok')
