import re
CR = chr(13) + chr(10)

FN_START = "int InGame_GetPSXPadValue(int value,int player)" + CR + CR + "{" + CR
DECL = "  int newControl;" + CR + "  int c;" + CR + "  int type;" + CR
DECL_PO = DECL + "  int po;" + CR
FIELDS = ['IImaxRange', 'ImaxRange', 'J1MAX', 'J1MIN', 'J2MAX', 'J2MIN', 'deadSpot', 'steeringRange']
SWKEY = "  switch (type) {" + CR


def _span(s):
    a = s.index(FN_START)
    b = s.index(CR + "/* ---- InGame_", a)
    return a, b


def _fields_to(body, expr):
    for f in FIELDS:
        body = body.replace("GameSetup_gData.controllerData.%s[player]" % f,
                            expr % f)
    assert 'controllerData.J1MIN[player]' not in body
    return body


def inplace(pre_stmt_indent="      "):
    """po holds player*4 before the switch; each arm MUTATES it in place with the
    struct base (each arm returns, so the mutation is dead after)."""
    def go(s):
        a, b = _span(s)
        head, body, tail = s[:a], s[a:b], s[b:]
        body = body.replace(DECL, DECL_PO, 1)
        body = body.replace(SWKEY, "  po = player * 4;" + CR + SWKEY, 1)
        body = _fields_to(body, "((GameSetup_tData *)po)->controllerData.%s[0]")
        # prefix every arm whose newControl statement uses controllerData
        out = []
        i = 0
        NC = pre_stmt_indent + "newControl = player << 0x1e |"
        while True:
            j = body.find(NC, i)
            if j < 0:
                out.append(body[i:]); break
            k = body.index(';', j)
            stmt = body[j:k]
            out.append(body[i:j])
            if 'controllerData' in stmt:
                out.append(pre_stmt_indent + "po = po + (int)&GameSetup_gData;" + CR)
            out.append(stmt)
            i = k
        return head + ''.join(out) + tail
    return go


PATCHES = [
    ('O_inplace', inplace()),
]
