"""static_fix1.py -- retail SYM label kind 6 (local): these EA-library functions are `static` in their own file.
The definition gets `static`, the exported prototype leaves the header and becomes a static forward declaration after the
file's includes (so call-before-definition order is untouched)."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/eaclib/psx/'
NL = chr(10)
PLAN = {
    'eacpsxz/nsync.c': 'loadfileadratomic loadfileatadratomic loadbigfileheaderatomic',
    'spchpsxz/spchevnt.c': 'VoxEvent_GetKeepTillExpiresFlag',
    'eacpsxz/wildcard.c': 'strrstr',
    'eacpsxz/syncfile.c': 'synccallback syncblockio',
    'eacpsxz/nfile.c': 'iFILE_ExecCommand iFILE_perror reserveop freeop reservehandle freehandle',
    'eacpsxz/nasync.c': 'queueadd queuefetch newrequestid cancelrequest finishrequest loadfileclosecallback loadfilereadcallback '
                        'loadfilesizecallback loadfileopencallback loadsegreadcallback asyncsystemtask',
    'eacpsxz/textfor.c': 'textbsearch',
    'eacpsxz/cdfs.c': 'CD_systaskfunc CD_timerfunc CdReadyHandler dircompare',
    'eacpsxz/stream.c': 'validatehandle inbetween decbufferusage getfreerequest queuerequest freerequest filterchunk parsechunks '
                        'opencallback closecallback readcallback startnextrequest restartstream',
    'spchpsxz/spchrule.c': 'iSPCH_GetRuleDataAddr',
}
headers = [p.replace(chr(92), '/') for p in glob.glob(R + '**/*.h', recursive=True)]
for f, names in PLAN.items():
    s = open(R + f, encoding='utf-8').read()
    protos = []
    for n in names.split():
        m = re.search(r'^(?!static\b)(?![ \t])([A-Za-z_][\w \t\*]*?\b' + n + r'\s*\([^;{]*\))\s*(?:/\*[^\n]*\*/\s*)?\n?\{', s, re.M)
        assert m, (f, n)
        sig = ' '.join(m.group(1).split())
        s = s[:m.start()] + 'static ' + s[m.start():]
        got = False
        for h in headers:
            t = open(h, encoding='utf-8').read()
            t2, k = re.subn(r'^(?:extern\s+)?[A-Za-z_][\w \t\*]*?\b' + n + r'\s*\([^;]*\);[^\n]*\n', '', t, flags=re.M)
            if k:
                open(h, 'w', encoding='utf-8', newline='').write(t2)
                got = True
        protos.append('static ' + sig + ';')
        print('%-22s %-34s header prototype removed: %s' % (f.split('/')[-1], n, got))
    last = [m for m in re.finditer(r'^#include [^\n]*\n', s, re.M)][-1]
    block = (NL + '/* file-local functions (retail SYM: local labels) */' + NL + NL.join(protos) + NL)
    s = s[:last.end()] + block + s[last.end():]
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
