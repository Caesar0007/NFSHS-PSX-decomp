# -*- coding: utf-8 -*-
p = 'recon/game/psx/draww.cpp'
s = open(p, encoding='utf-8').read()
old = """    pts3d[0].x = tx + (sVar7 - sVar12);
    pts3d[0].y = ty + (sVar8 - sVar13);
    pts3d[0].z = tz + (sVar9 - sVar14);
    pts3d[0].light = pCoord->light;
    pts3d[1].x = tx + sVar7 + sVar12;
    pts3d[1].y = ty + sVar8 + sVar13;
    pts3d[1].z = tz + sVar9 + sVar14;
    pts3d[1].light = pCoord->light;
    pts3d = pts3d + 2;
"""
new = """    /* MATCH: the oracle walks pts3d with TWO +8 bumps per iteration (one per vertex,
       `addiu t3,t3,8` mid-body and again at the tail) and splits the stores across a
       base/base+6 giv pair -- the index form pts3d[0]/pts3d[1] + a single +16 bump
       collapses that to one walker.  Operand order `t + (v +/- n)` matches the oracle's
       `addu v1,v1,t0; addu v1,t8,v1` (vertex value first, translation last). */
    pts3d->x = tx + (sVar7 - sVar12);
    pts3d->y = ty + (sVar8 - sVar13);
    pts3d->z = tz + (sVar9 - sVar14);
    pts3d->light = pCoord->light;
    pts3d = pts3d + 1;
    pts3d->x = tx + (sVar7 + sVar12);
    pts3d->y = ty + (sVar8 + sVar13);
    pts3d->z = tz + (sVar9 + sVar14);
    pts3d->light = pCoord->light;
    pts3d = pts3d + 1;
"""
assert old in s
s = s.replace(old, new, 1)
open(p, 'w', encoding='utf-8').write(s)
print('ok')
