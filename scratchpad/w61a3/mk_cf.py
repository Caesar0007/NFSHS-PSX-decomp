CR = b'\r\n'
BS = bytes([92])


def J(*ls):
    return CR.join(ls) + CR


PRINTF = b'            printf("Access Denied. : event multiple open' + BS + b'n");'

# 1) declare p
old1 = J(b'    char devname[32];',
         b'    int  fd;',
         b'    int  retry;',
         b'    int  rslt;')
new1 = J(b'    char devname[32];',
         b'    int  fd;',
         b'    int  retry;',
         b'    int  rslt;',
         b'    int *p;')

# 2) second anchor at the loop preheader + file ref dial after strcat
old2 = J(b'    blocks = blocks << 16;',
         b'    while (1) {')
new2 = J(b'    blocks = blocks << 16;',
         b'    p = base;',
         b'    while (1) {')

old3 = J(b'    strcat(devname, file);',
         b'    _mc_present |= 1 << (base[3]);',
         b'',
         b'    fd = open(devname, 1);                       /* probe: does it already exist? */')
new3 = J(b'    strcat(devname, file);',
         b'    __asm__("" : : "r"(file), "r"(file));',
         b'    _mc_present |= 1 << (base[3]);',
         b'',
         b'    fd = open(devname, 1);                       /* probe: does it already exist? */')

# 3) loop body base[] -> p[]
old4 = J(b'        if (base[0] > 0) {',
         PRINTF,
         b'        } else {',
         b'            base[0] = 2;',
         b'            base[1] = 0;',
         b'            base[2] = 0;',
         b'            mc.chan = chan;',
         b'            UserFuncOpen((int)MemCardCmd_cb);',
         b'        }')
new4 = J(b'        if (p[0] > 0) {',
         PRINTF,
         b'        } else {',
         b'            p[0] = 2;',
         b'            p[1] = 0;',
         b'            p[2] = 0;',
         b'            mc.chan = chan;',
         b'            UserFuncOpen((int)MemCardCmd_cb);',
         b'        }')

for i, (o, n) in enumerate([(old1, new1), (old2, new2), (old3, new3), (old4, new4)], 1):
    open('scratchpad/w61a3/cf%d_old.txt' % i, 'wb').write(o)
    open('scratchpad/w61a3/cf%d_new.txt' % i, 'wb').write(n)
print('ok')
