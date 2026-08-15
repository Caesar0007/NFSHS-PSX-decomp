from fr import frame

hdr = open('hdr.txt', errors='replace').read()
body = open('fnbody.txt', errors='replace').read()
OLD = '        int fix = _padFixResult[_padSioChan];'
assert body.count(OLD) == 1

CANDS = {
    'orig': OLD,
    'ptr-add deref': '        int fix = *(_padFixResult + _padSioChan);',
    'cast idx-first': '        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);',
    'cast base-first': '        int fix = *(int *)((int)_padFixResult + (_padSioChan << 2));',
    'cast *4 idx-first': '        int fix = *(int *)(_padSioChan * 4 + (int)_padFixResult);',
    'addr-of cast': '        int fix = *(int *)((int)&_padFixResult[_padSioChan]);',
    'q ptr block': '        int fix; { int *q = _padFixResult + _padSioChan; fix = *q; }',
    'double subscript': '        int fix = ((int *)_padFixResult)[_padSioChan];',
    'unsigned idx': '        int fix = _padFixResult[(unsigned)_padSioChan];',
    'char-cast base': '        int fix = *(int *)((char *)_padFixResult + _padSioChan * 4);',
    'vol': '        int fix = *(volatile int *)&_padFixResult[_padSioChan];',
}
for k, v in CANDS.items():
    open('v.i', 'w').write(hdr + '\n' + body.replace(OLD, v) + '\n')
    print('%-24s %s' % (k, frame('v.i', '_padInitSioMode')))
