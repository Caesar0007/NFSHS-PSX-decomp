F = ('  __asm__("" : : "r"(manager), "r"(manager), "r"(manager), "r"(manager),\n'
     '          "r"(manager), "r"(manager));\n')
M = '(int)manager'
W = '(int)frontEndState'


def nest(n):
    e = W
    for _ in range(n):
        e = '(%s & (%s | %s))' % (M, M, e)
    return '  manager = (tTournamentManager *)%s;\n' % e


def nest_or(n):
    e = W
    for _ in range(n):
        e = '(%s | (%s & %s))' % (M, M, e)
    return '  manager = (tTournamentManager *)%s;\n' % e


VARIANTS = [("nest%d" % n, [(F, nest(n))]) for n in (1, 2, 3, 4, 6)]
VARIANTS += [("nestor%d" % n, [(F, nest_or(n))]) for n in (1, 2, 3, 4, 6)]
