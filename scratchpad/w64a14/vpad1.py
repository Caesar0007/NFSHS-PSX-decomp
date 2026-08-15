import re
CR = chr(13) + chr(10)

FN_START = "int InGame_GetPSXPadValue(int value,int player)" + CR + CR + "{" + CR
DECL = "  int newControl;" + CR + "  int c;" + CR + "  int type;" + CR
DECL_PO = DECL + "  int po;" + CR
PADUP = "  PAD_update();" + CR

FIELDS = ['IImaxRange', 'ImaxRange', 'J1MAX', 'J1MIN', 'J2MAX', 'J2MIN', 'deadSpot', 'steeringRange']


def _span(s):
    a = s.index(FN_START)
    b = s.index(CR + "/* ---- InGame_", a)
    return a, b


def base_hoist(assign_pos):
    """assign_pos: 'top' = right after PAD_update, 'switch' = right before switch(type)."""
    def go(s):
        a, b = _span(s)
        head, body, tail = s[:a], s[a:b], s[b:]
        assert body.count(DECL) == 1
        body = body.replace(DECL, DECL_PO, 1)
        stmt = "  po = player * 4;" + CR
        if assign_pos == 'top':
            assert body.count(PADUP) == 1
            body = body.replace(PADUP, PADUP + stmt, 1)
        else:
            key = "  switch (type) {" + CR
            assert body.count(key) == 1
            body = body.replace(key, stmt + key, 1)
        for f in FIELDS:
            old = "GameSetup_gData.controllerData.%s[player]" % f
            new = "((GameSetup_tData *)((char *)&GameSetup_gData + po))->controllerData.%s[0]" % f
            body = body.replace(old, new)
        assert 'controllerData.J1MIN[player]' not in body
        return head + body + tail
    return go


PATCHES = [
    ('N_po_top', base_hoist('top')),
    ('N_po_switch', base_hoist('switch')),
]
