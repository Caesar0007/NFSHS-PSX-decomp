from fr import frame

TMPL = """extern int g[2];
extern int gs;
extern int ch;
extern int (*fp)(unsigned char *);
int f(unsigned char *info)
{
%s
    return 1;
}
"""


def run(tag, body):
    open('micro.i', 'w').write(TMPL % body)
    print('%-40s %s' % (tag, frame('micro.i', 'f')))


run('J baseline', '    if (g[ch] > 0) { do { fp(0); } while (g[ch] > 0); }')
run('ptr local outside', '    { int *p = &g[ch]; if (*p > 0) { do { fp(0); } while (*p > 0); } }')
run('ch cached local', '    { int c = ch; if (g[c] > 0) { do { fp(0); } while (g[c] > 0); } }')
run('const index', '    if (g[0] > 0) { do { fp(0); } while (g[0] > 0); }')
run('scalar global', '    if (gs > 0) { do { fp(0); } while (gs > 0); }')
run('while form', '    while (g[ch] > 0) { fp(0); }')
run('test hoisted to local each iter',
    '    { int n = g[ch]; while (n > 0) { fp(0); n = g[ch]; } }')
run('ptr to base array', '    { int *b = g; if (b[ch] > 0) { do { fp(0); } while (b[ch] > 0); } }')
run('vol test', '    if (*(volatile int*)&g[ch] > 0) { do { fp(0); } while (*(volatile int*)&g[ch] > 0); }')
run('2 calls no loop', '    if (g[ch] > 0) { fp(0); fp(0); }')
run('loop, test scalar, body reads g[ch]',
    '    if (gs > 0) { do { fp((unsigned char*)g[ch]); } while (gs > 0); }')
