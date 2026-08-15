CR = b'\r\n'
BS = bytes([92])          # a literal backslash, built numerically (heredoc-proof)


def J(*ls):
    return CR.join(ls) + CR


PRINTF = b'            printf("Access Denied. : event multiple open' + BS + b'n");'

old = J(b'        if (base[0] > 0) {',
        PRINTF,
        b'        } else {',
        b'            base[0] = 2;',
        b'            base[1] = 0;',
        b'            base[2] = 0;',
        b'            mc.chan = chan;',
        b'            __asm__("" : : "r"(chan), "r"(chan));',
        b'            UserFuncOpen((int)MemCardCmd_cb);',
        b'        }',
        b'        MemCardSync(0, 0, &rslt);',
        b'        MemCardCallback((int)_mc_save_cb);',
        b'',
        b'        if (rslt == 3)')
new = J(b'        if (p[0] > 0) {',
        PRINTF,
        b'        } else {',
        b'            p[0] = 2;',
        b'            p[1] = 0;',
        b'            p[2] = 0;',
        b'            mc.chan = chan;',
        b'            __asm__("" : : "r"(chan), "r"(chan));',
        b'            UserFuncOpen((int)MemCardCmd_cb);',
        b'        }',
        b'        MemCardSync(0, 0, &rslt);',
        b'        MemCardCallback((int)_mc_save_cb);',
        b'',
        b'        if (rslt == 3)')
open('scratchpad/w61a3/pb3_old.txt', 'wb').write(old)
open('scratchpad/w61a3/pb3_new.txt', 'wb').write(new)
print('written', len(old), len(new))
