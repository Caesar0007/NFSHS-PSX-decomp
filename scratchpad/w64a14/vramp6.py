CR = chr(13) + chr(10)
CUR = "          hp = hb + i; }" + CR

VARS = {
    'W_intsum': "          hp = (int *)(i * 4 + (int)hb); }",
    'W_intsum_sll': "          hp = (int *)((i << 2) + (int)hb); }",
    'W_intsum_noscale': "          hp = (int *)((int)(i * 4) + (int)hb); }",
    'W_ptr_i_first': "          hp = i + hb; }",
}


def mk(txt):
    def go(s):
        assert s.count(CUR) == 1
        return s.replace(CUR, txt + CR, 1)
    return go


PATCHES = [(k, mk(v)) for k, v in VARS.items()]
