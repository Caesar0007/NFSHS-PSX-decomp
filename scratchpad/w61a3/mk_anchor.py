CR = b'\r\n'


def J(*ls):
    return CR.join(ls) + CR


# 1) the shared inline anchor helper, inserted just above MemCardSync
old1 = J(b'/* @0x800FBAFC : MemCardSync -- poll (mode!=0) or block (mode==0) for command completion.')
new1 = J(b'/* w61-a3 SHARED ANCHOR: ONE physical source line for the opacity fence, so that every',
         b' * expansion of it is exp_equiv_p-EQUAL (cse.c compares ASM_OPERANDS_SOURCE_LINE as an',
         b" * 'i' field, jump.c does the same in rtx_renumbered_equal_p -- catalog 12C).  That is",
         b' * what lets the INLINED MemCardSync body share the caller`s &_mc_cmd register instead',
         b' * of materializing its own. */',
         b'static __inline__ int *mc_anchor(void)',
         b'{',
         b'    int *b = &mc.cmd;',
         b'    __asm__("" : "=r"(b) : "0"(b));',
         b'    return b;',
         b'}',
         b'',
         b'/* @0x800FBAFC : MemCardSync -- poll (mode!=0) or block (mode==0) for command completion.')

# 2) MemCardSync uses it
old2 = J(b'    int *base = &mc.cmd;',
         b'    __asm__ __volatile__("" : "=r"(base) : "0"(base));',
         b'    if (base[0] == 0 && base[2] == 0)')
new2 = J(b'    int *base = mc_anchor();',
         b'    if (base[0] == 0 && base[2] == 0)')

# 3) DeleteFile's second anchor uses it
old3 = J(b'    p = base;',
         b'    _mc_present |= 1 << (p[3]);')
new3 = J(b'    p = mc_anchor();',
         b'    _mc_present |= 1 << (p[3]);')

for i, (o, n) in enumerate([(old1, new1), (old2, new2), (old3, new3)], 1):
    open('scratchpad/w61a3/an%d_old.txt' % i, 'wb').write(o)
    open('scratchpad/w61a3/an%d_new.txt' % i, 'wb').write(n)
print('ok')
