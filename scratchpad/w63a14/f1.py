NL = chr(13) + chr(10)
ENV = {}

Q = ("    q1 = CarIO_Plate1[player];" + NL +
     "    q2 = CarIO_Plate2[player];" + NL +
     "    *(u_int *)q2 = *(u_char *)q2 | 0x11800;" + NL +
     "    *(u_int *)q1 = *(u_char *)q1 | 0x11800;" + NL)
R = ("    r2 = CarIO_Plate2[player];" + NL +
     "    r1 = CarIO_Plate1[player];" + NL +
     "    r2->width = 0x18;" + NL +
     "    r1->width = 0x18;" + NL)
CALL = "    CarIO_CopyFromShape((short *)((int)shape + 0x10),thePlate,0x30,0x16,0,0);" + NL


def F(v, n=1):
    return ('    __asm__("" : : "r"(%s));' % v + NL) * n


def ins(where, txt):
    def f(s):
        assert s.count(where) == 1, ('anchor', s.count(where))
        return s.replace(where, txt + where)
    return f


def ins_after(where, txt):
    def f(s):
        assert s.count(where) == 1, ('anchor', s.count(where))
        return s.replace(where, where + txt)
    return f


PATCHES = [
    ("ctl", lambda s: s),
    ("f_shape_beforeQ", ins(Q, F("shape"))),
    ("f_thePlate_beforeQ", ins(Q, F("thePlate"))),
    ("f_player_beforeQ", ins(Q, F("player"))),
    ("f_shape_beforeR", ins(R, F("shape"))),
    ("f_thePlate_beforeR", ins(R, F("thePlate"))),
    ("f_shape_beforeCALL", ins(CALL, F("shape"))),
    ("f_thePlate_beforeCALL", ins(CALL, F("thePlate"))),
    ("f_shape_x3_beforeQ", ins(Q, F("shape", 3))),
]
