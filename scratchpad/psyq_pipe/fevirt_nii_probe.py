"""fevirt_nii_probe.py on|off FILE... -- A/B probe: add/remove {"no_implement_inlines": True} for the given recon TUs in
tools/build.py's PER_TU_FLAGS (one marked line per TU, so it is trivially reversible), to test whether the FRONT END
was compiled with -fno-implement-inlines."""
import sys

P = 'C:/Temp/nfs4-decomp/tools/build.py'
s = open(P, encoding='utf-8').read()
mode = sys.argv[1]
for tu in sys.argv[2:]:
    line = '    "%s": {"no_implement_inlines": True},   # FEVIRT-NII-PROBE\n' % tu
    if mode == 'on' and line not in s:
        assert ('"%s":' % tu) not in s, 'TU already has flags: merge by hand: ' + tu
        s = s.replace('PER_TU_FLAGS = {\n', 'PER_TU_FLAGS = {\n' + line, 1)
    if mode == 'off':
        s = s.replace(line, '')
open(P, 'w', encoding='utf-8', newline='').write(s)
print(mode, len(sys.argv) - 2, 'TUs')
