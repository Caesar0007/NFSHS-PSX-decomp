"""sdk_bss.py LIB/MEMBER ... -- per-section sizes of PsyQ 4.3 SN objects (code bytes + uninitialised-space records) and
their XBSS symbols (uninitialised globals the linker allocates in the named section)."""
import sys

sys.path.insert(0, 'C:/Temp/nfs4-decomp/tools')
import objtruth

for m in sys.argv[1:]:
    lib, mem = m.split('/')
    r = objtruth.parse_obj('C:/Temp/nfs4-clean/psyq43/extracted/%s/obj/%s.obj' % (lib, mem))
    secs = r['sections']
    print('== %s  %s' % (m, '  '.join('%s=0x%x' % (secs.get(k, k), len(v)) for k, v in sorted(r['code'].items()) if len(v))))
    for x in r['xdefs']:
        if 'bss' in x:
            print('     XBSS %-20s 0x%x in %s' % (x['name'], x['bss'], secs.get(x['sect'], x['sect'])))
