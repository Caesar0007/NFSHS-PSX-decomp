CR = chr(13) + chr(10)

QBLK = ("    q1 = CarIO_Plate1[player];" + CR
        + "    q2 = CarIO_Plate2[player];" + CR)
LOOP2 = "    i = 0;" + CR + "    do {" + CR + "      int tu3;" + CR
LOOP1 = "    do {" + CR + "      int hdr;" + CR


def move_q(anchor):
    def go(s):
        assert s.count(QBLK) == 1 and s.count(anchor) == 1
        out = s.replace(QBLK, "", 1)
        assert out.count(anchor) == 1
        return out.replace(anchor, QBLK + anchor, 1)
    return go


def swap_q(s):
    assert s.count(QBLK) == 1
    return s.replace(QBLK, "    q2 = CarIO_Plate2[player];" + CR
                     + "    q1 = CarIO_Plate1[player];" + CR, 1)


PATCHES = [
    ('Y_q_before_loop2', move_q(LOOP2)),
    ('Y_q_before_loop1', move_q(LOOP1)),
    ('Y_q_swap', swap_q),
]
