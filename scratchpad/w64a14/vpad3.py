import re
CR = chr(13) + chr(10)

FN_START = "int InGame_GetPSXPadValue(int value,int player)" + CR + CR + "{" + CR


def _span(s):
    a = s.index(FN_START)
    b = s.index(CR + "/* ---- InGame_", a)
    return a, b


ARM = re.compile(r'newControl = player << 0x1e \|\r\n((?: +[^\r\n]*\|\r\n)*) +([^\r\n;]*?) ;')


def move_player_last(s):
    a, b = _span(s)
    head, body, tail = s[:a], s[a:b], s[b:]
    n = [0]
    def r(m):
        mids, last = m.group(1), m.group(2)
        if 'controllerData' not in m.group(0):
            return m.group(0)
        n[0] += 1
        ind = ' ' * 19
        return ('newControl = ' + mids.lstrip() + ind + last + ' |' + CR
                + ind + 'player << 0x1e ;')
    out, k = ARM.subn(r, body)
    assert n[0] >= 10, n[0]
    return head + out + tail


def move_player_second(s):
    """player<<0x1e after the first tag/hi term."""
    a, b = _span(s)
    head, body, tail = s[:a], s[a:b], s[b:]
    n = [0]
    def r(m):
        mids, last = m.group(1), m.group(2)
        if 'controllerData' not in m.group(0):
            return m.group(0)
        lines = [l.strip().rstrip('|').strip() for l in mids.strip().splitlines()]
        lines = [l for l in lines if l]
        lines.append(last)
        n[0] += 1
        ind = ' ' * 19
        terms = [lines[0], 'player << 0x1e'] + lines[1:]
        return 'newControl = ' + (' |' + CR + ind).join(terms) + ' ;'
    out, k = ARM.subn(r, body)
    assert n[0] >= 10, n[0]
    return head + out + tail


PATCHES = [
    ('P_player_last', move_player_last),
    ('P_player_second', move_player_second),
]
