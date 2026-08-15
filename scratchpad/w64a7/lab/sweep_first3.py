from fr import frame

hdr = open('hdr.txt', errors='replace').read()
body = open('fnbody.txt', errors='replace').read()
OLD = '        int fix = _padFixResult[_padSioChan];'
assert body.count(OLD) == 1

C = {
 'orig': OLD,
 'fp0+use fence': '''        int *fp0 = &_padFixResult[_padSioChan];
        int fix = *fp0;
        __asm__("" : : "r"(fp0));''',
 'fp0+identity fence': '''        int *fp0 = &_padFixResult[_padSioChan];
        __asm__("" : "=r"(fp0) : "0"(fp0));
        fix0 = *fp0;''',
 'fix laundered': '''        int fix = _padFixResult[_padSioChan];
        __asm__("" : "=r"(fix) : "0"(fix));''',
 'fix use fence': '''        int fix = _padFixResult[_padSioChan];
        __asm__("" : : "r"(fix));''',
 'chan temp then idx': '''        int fix;
        {
            int c = _padSioChan;
            fix = *(int *)((c << 2) + (int)_padFixResult);
        }''',
}
for k, v in C.items():
    if 'fix0' in v:
        continue
    open('v.i', 'w').write(hdr + '\n' + body.replace(OLD, v) + '\n')
    print('%-24s %s' % (k, frame('v.i', '_padInitSioMode')))
