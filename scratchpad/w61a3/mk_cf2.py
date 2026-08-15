CR = b'\r\n'


def J(*ls):
    return CR.join(ls) + CR


# CreateFile: retry dial (inside loop, weight 2 per operand)
old1 = J(b'        if (rslt != 2)',
         b'            break;',
         b'        retry = retry + 1;',
         b'        if (retry >= 4)',
         b'            break;',
         b'    }',
         b'    if (rslt == 0)',
         b'        rslt = 5;',
         b'    return rslt;',
         b'}',
         b'',
         b'/* @0x800FBE20 : MemCardDeleteFile -- synchronously erase a named file. */')
new1 = J(b'        if (rslt != 2)',
         b'            break;',
         b'        retry = retry + 1;',
         b'        __asm__("" : : "r"(retry), "r"(retry));',
         b'        if (retry >= 4)',
         b'            break;',
         b'    }',
         b'    if (rslt == 0)',
         b'        rslt = 5;',
         b'    return rslt;',
         b'}',
         b'',
         b'/* @0x800FBE20 : MemCardDeleteFile -- synchronously erase a named file. */')

# CreateFile: chan dial (inside loop)
old2 = J(b'            mc.chan = chan;',
         b'            UserFuncOpen((int)MemCardCmd_cb);')
new2 = J(b'            mc.chan = chan;',
         b'            __asm__("" : : "r"(chan));',
         b'            UserFuncOpen((int)MemCardCmd_cb);')

for i, (o, n) in enumerate([(old1, new1), (old2, new2)], 1):
    open('scratchpad/w61a3/cg%d_old.txt' % i, 'wb').write(o)
    open('scratchpad/w61a3/cg%d_new.txt' % i, 'wb').write(n)
print('ok')
