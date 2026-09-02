import pathlib

NZ = '(nz2 = *(volatile int *)&normal.z)'
MX = '  islandMatrix.m[6] = *(volatile int *)&barrierVec.x;\n'
MY = '  islandMatrix.m[7] = *(volatile int *)&barrierVec.y;\n'

variants = [
    ('nz2 plain', [(NZ, '(nz2 = normal.z)')]),
    ('nz2 plain + absorb', [(NZ, '(nz2 = (int)((unsigned int)normal.z | ((unsigned int)normal.z & 3u)))')]),
    ('nz2 plain, absorb nz2 after', [(NZ, '(nz2 = normal.z, nz2 = (int)((unsigned int)nz2 | ((unsigned int)nz2 & 3u)), nz2)')]),
    ('m6/m7 plain + absorb source', [
        (MX, '  islandMatrix.m[6] = (int)((unsigned int)barrierVec.x | ((unsigned int)barrierVec.x & 3u));\n'),
        (MY, '  islandMatrix.m[7] = (int)((unsigned int)barrierVec.y | ((unsigned int)barrierVec.y & 3u));\n')]),
    ('m6/m7 plain', [(MX, '  islandMatrix.m[6] = barrierVec.x;\n'),
                     (MY, '  islandMatrix.m[7] = barrierVec.y;\n')]),
]
pathlib.Path('scratchpad/w86/D2_nw1.txt').write_text(repr(variants))
print(len(variants))
