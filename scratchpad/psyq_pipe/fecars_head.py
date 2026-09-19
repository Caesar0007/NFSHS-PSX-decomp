"""fecars.cpp: retail fecars.obj .rodata opens with three UNREFERENCED constants ahead of LoadDescription's strings:
"%s%s.viv" 0x80010170, the {0x121,0x153,0x185} name template 0x80010180 (the very constant TextValue's local
initializer uses -- cc1plus shares identical constants) and an int table 0x80010188 {22,22,25,25,26,27,27,22,22,22,0}.
An unused static function expanded before the first definition reproduces that emission order: its constants are
output at expansion time, its body never is."""
p = 'C:/Temp/nfs4-decomp/recon/frontend/common/fecars.cpp'
s = open(p, encoding='utf-8').read()
anchor = '/* ---- tCarManager::Initialize  [FECARS.CPP:77-94] SLD-VERIFIED ---- */'
assert s.count(anchor) == 1
carrier = (
    '/* SYM-CODEGEN-CARRIER (2026-09-19): retail fecars.obj .rodata opens with three constants no retail code references --\n'
    '   "%s%s.viv" 0x80010170, the name template 0x80010180 (shared with tListIteratorCar::TextValue\'s initializer) and\n'
    '   an int table 0x80010188.  They are the expansion-time constants of a function the compiler never emitted: an\n'
    '   unused static helper ahead of the first definition.  Its original name is not retained. */\n'
    'static void FeCars_UnusedCarFileName(char *filename, char *path, char *name)\n'
    '{\n'
    '  sprintf(filename,"%s%s.viv",path,name);\n'
    '  short nameBase [3] = { 0x121, 0x153, 0x185 };\n'
    '  int nameId [11] = { 22, 22, 25, 25, 26, 27, 27, 22, 22, 22, 0 };\n'
    '  filename[0] = (char)(nameBase[0] + nameId[0]);\n'
    '}\n\n')
s = s.replace(anchor, carrier + anchor)
open(p, 'w', encoding='utf-8', newline='').write(s)
print('ok')
