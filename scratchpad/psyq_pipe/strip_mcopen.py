"""strip_mcopen.py -- libmcrd LIBMCRD.obj +1460 (392 B): MemCardOpen, the real owner of "Access Denied. : file already
open.\\n".  It replaces the inline accessor that carried the literal; the two consumers spell the literal themselves
(gcc pools the identical strings, first emission = MemCardOpen's, which is the SDK/retail position)."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
p = R + 'recon/syslib/psx/libmcrd/LIBMCRD.c'
s = open(p, encoding='utf-8').read()
a = s.index("/* PsyQ 4.3's vendor LIBMCRD.OBJ and the retail CPE both place this diagnostic")
b = s.index('#include "../../../link_stripped.h"')
LIT = '"Access Denied. : file already open.\\n"'
body = (
    '#include "../../../link_stripped.h"' + NL +
    '/* LIBMCRD.obj +1460 (LINK-STRIPPED) : MemCardOpen -- open a card file for the MemCardReadData / WriteData pair.' + NL +
    ' * Retail\'s link removed it (nobody calls it) but kept its "file already open" literal, first emitted here. */' + NL +
    'extern long MemCardOpen(long chan, char *file, long flag) LINK_STRIPPED;' + NL +
    'extern long MemCardOpen(long chan, char *file, long flag)' + NL + '{' + NL + '    int  rslt;' + NL + '    int  retry;' + NL +
    '    int *pfd = &mc.fd;' + NL + NL + '    retry = 0;' + NL + '    if (*pfd >= 0) {' + NL + '        printf(' + LIT + ');' + NL + '        return -1;' + NL + '    }' + NL +
    '    MemCardMakeDevname(chan, mc.devname);' + NL + '    strcat(mc.devname, file);' + NL + '    mc.chan = chan;' + NL +
    '    while (1) {' + NL + '        _clr_card_event();' + NL + '        mc.fd = open(mc.devname, flag | 0x8000);' + NL +
    '        if (mc.fd >= 0)' + NL + '            return 0;' + NL +
    '        _mc_save_cb = (int (*)(int, int))MemCardCallback(0);' + NL +
    '        if (mc.cmd > 0) {' + NL + '            printf("Access Denied. : event multiple open\\n");' + NL + '        } else {' + NL +
    '            mc.cmd = 2;' + NL + '            mc.rslt = 0;' + NL + '            mc.done = 0;' + NL + '            mc.chan = chan;' + NL +
    '            UserFuncOpen((int)MemCardCmd_cb);' + NL + '        }' + NL +
    '        MemCardSync(0, 0, &rslt);' + NL + '        MemCardCallback((int)_mc_save_cb);' + NL +
    '        if (rslt == 3)' + NL + '            continue;' + NL + '        if (rslt == 2) {' + NL + '            retry++;' + NL +
    '            if (retry < 5)' + NL + '                continue;' + NL + '        }' + NL + '        if (rslt == 0)' + NL + '            rslt = 5;' + NL +
    '        return rslt;' + NL + '    }' + NL + '}' + NL + NL)
s = s[:a] + body + s[b + len('#include "../../../link_stripped.h"') + 1:]
assert s.count('fmt = MemCardFileAlreadyOpenMessage();') == 2
s = s.replace('fmt = MemCardFileAlreadyOpenMessage();', 'fmt = ' + LIT + ';')
s = s.replace(' * is link-stripped too and NOT yet written: it owns the "file already open" literal the accessor above still carries.) */',
              ' * is written above.) */')
open(p, 'w', encoding='utf-8', newline='').write(s)
jf = json.load(open(R + 'linkers/link_stripped.json'))
jf['functions'].append({'object': 'build/recon/syslib/psx/libmcrd/LIBMCRD.c.o', 'function': 'MemCardOpen', 'sdk': 'LIBMCRD/MemCardOpen',
                        'evidence': 'PsyQ 4.3 libmcrd LIBMCRD.obj @1460+392; retail MemCardAccept is followed directly by MemCardReadData; its literal "file already open" stays in .rdata'})
open(R + 'linkers/link_stripped.json', 'w', encoding='utf-8', newline='').write(json.dumps(jf, indent=1) + NL)
print('ok')
