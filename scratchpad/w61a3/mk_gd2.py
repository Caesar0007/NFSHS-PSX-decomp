CR = b'\r\n'
BS = bytes([92])


def J(*ls):
    return CR.join(ls) + CR


P = b'                            printf("Access Denied. : event multiple open' + BS + b'n");'

old = J(b'                        if (mc.cmd < 1) {',
        b'                            mc.cmd  = 2;',
        b'                            mc.rslt = 0;',
        b'                            mc.done = 0;',
        b'                            mc.chan = chan;',
        b'                            UserFuncOpen((int)MemCardCmd_cb);',
        b'                        } else {',
        P,
        b'                        }')
new = J(b'                        if (mc.cmd > 0) {',
        P,
        b'                        } else {',
        b'                            mc.cmd  = 2;',
        b'                            mc.rslt = 0;',
        b'                            mc.done = 0;',
        b'                            mc.chan = chan;',
        b'                            UserFuncOpen((int)MemCardCmd_cb);',
        b'                        }')
open('scratchpad/w61a3/gd2_old.txt', 'wb').write(old)
open('scratchpad/w61a3/gd2_new.txt', 'wb').write(new)
print('ok')
