# -*- coding: utf-8 -*-
p = 'recon/game/psx/draww.cpp'
s = open(p, encoding='utf-8').read()
old = ("    type = sd->night_LightningType;\n"
       "    *idx = (u_short)(*Night_gWeatherLightingTable[type])[*idx];\n")
new = ("    u_char (*ltbl)[256];\n\n"
       "    ltbl = Night_gWeatherLightingTable[sd->night_LightningType];\n"
       "    *idx = (u_short)(*ltbl)[*idx];\n")
assert old in s
s = s.replace(old, new, 1)
s = s.replace("    int type;\n\n", "", 1)
open(p, 'w', encoding='utf-8').write(s)
print('ok')
