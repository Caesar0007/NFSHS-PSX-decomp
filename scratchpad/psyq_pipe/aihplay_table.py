"""aih_play.cpp: the blockade-type lookup reads the real gBlockadeTypes table (retail 0x8013c568, shared
with aih_btccop) instead of a second string-literal copy.  Unsized extern before the use + definition
at the end of the file = retail's absolute lui/addiu addressing of a small-data object."""
p = 'C:/Temp/nfs4-decomp/recon/game/common/aih_play.cpp'
s = open(p, encoding='utf-8').read()
a = 'char         gBlockadeTypes[5] __attribute__((section(".sdata"))) = { 5, 6, 4, 2, 0 };   /* @0x8013c568 */\n'
b = '(u_int)(u_char)"\\x05\\x06\\x04\\x02"[blockadeType];'
assert s.count(a) == 1, 'def'
assert s.count(b) == 1, 'use'
s = s.replace(a, 'extern char gBlockadeTypes[];   /* UNSIZED before its definition (end of file): retail addresses this\n'
                 '                                   small-data table absolutely (lui/addiu 0x8013c568) */\n')
s = s.replace(b, '(u_int)(u_char)gBlockadeTypes[blockadeType];')
s = s.rstrip('\n') + '\n\nchar gBlockadeTypes[5] = { 5, 6, 4, 2, 0 };   /* @0x8013c568 (.sdata at -G8); shared with aih_btccop */\n'
open(p, 'w', encoding='utf-8', newline='').write(s)
print('edited')
