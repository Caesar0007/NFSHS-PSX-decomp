CR = b'\r\n'
BS = bytes([92])


def J(*ls):
    return CR.join(ls) + CR


# 1) file fence: move from after-strcat to the top (before the busy guard)
old1 = (b'    strcat(devname, file);' + CR +
        b'    __asm__("" : : "r"(file), "r"(file));' + CR +
        b'    _mc_present |= 1 << (base[3]);' + CR)
new1 = (b'    strcat(devname, file);' + CR +
        b'    _mc_present |= 1 << (base[3]);' + CR)

old2 = (b'    __asm__ __volatile__("" : "=r"(base) : "0"(base));' + CR + CR +
        b'    if (base[0] != 0) {' + CR +
        b'        printf("Access Denied. : system busy')
new2 = (b'    __asm__ __volatile__("" : "=r"(base) : "0"(base));' + CR +
        b'    __asm__("" : : "r"(file), "r"(file));' + CR + CR +
        b'    if (base[0] != 0) {' + CR +
        b'        printf("Access Denied. : system busy')

# 2) tail-placed success exit block
old3 = J(b'        fd = open(devname, (int)blocks | 0x200);   /* create */',
         b'        if (fd >= 0) {',
         b'            close(fd);',
         b'            return 0;',
         b'        }')
new3 = J(b'        fd = open(devname, (int)blocks | 0x200);   /* create */',
         b'        if (fd >= 0)',
         b'            goto created;')

old4 = J(b'    if (rslt == 0)',
         b'        rslt = 5;',
         b'    return rslt;',
         b'}',
         b'',
         b'/* @0x800FBE20 : MemCardDeleteFile -- synchronously erase a named file. */')
new4 = J(b'    if (rslt == 0)',
         b'        rslt = 5;',
         b'    return rslt;',
         b'',
         b'created:',
         b'    close(fd);',
         b'    return 0;',
         b'}',
         b'',
         b'/* @0x800FBE20 : MemCardDeleteFile -- synchronously erase a named file. */')

for i, (o, n) in enumerate([(old1, new1), (old2, new2), (old3, new3), (old4, new4)], 1):
    open('scratchpad/w61a3/ck%d_old.txt' % i, 'wb').write(o)
    open('scratchpad/w61a3/ck%d_new.txt' % i, 'wb').write(n)
print('ok')
