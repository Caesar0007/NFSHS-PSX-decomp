# -*- coding: utf-8 -*-
p = 'recon/game/psx/draww.cpp'
s = open(p, encoding='utf-8').read()
old = "    *idx = (u_short)(*Night_gWeatherLightingTable[sd->night_LightningType])[*idx];\n"
new = ("    int type;\n\n"
       "    /* MATCH: the oracle reads night_LightningType BEFORE materialising the table's\n"
       "     * %hi (`lbu v0,269(a2); lui v1,%hi(...)`); folding the read into the subscript\n"
       "     * lets sched1 sink it one slot. */\n"
       "    type = sd->night_LightningType;\n"
       "    *idx = (u_short)(*Night_gWeatherLightingTable[type])[*idx];\n")
assert old in s
s = s.replace(old, new, 1)
open(p, 'w', encoding='utf-8').write(s)
print('ok')
