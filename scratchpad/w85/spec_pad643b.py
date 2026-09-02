FA = r"""      { int acc = player << 0x1e;
        __asm__("" : : "i"(0) : "$2","$3");
        return (acc |
                (0x7f - (byte)frontEnd.J1MIN[player]) * 0x10000 |
                (0x7f - (byte)frontEnd.J2MAX[player]) * 0x100) | 1; }"""

FB = r"""      { int acc = player << 0x1e;
        __asm__("" : : "i"(0) : "$2","$3");
        return (acc |
                (0x7f - (byte)frontEnd.deadSpot[player]) * 0x10000 |
                (0x7f - (byte)frontEnd.steeringRange[player]) * 0x100) | 1; }"""


def A(body):
    return body.replace('@1', 'J1MIN').replace('@2', 'J2MAX')


def B(body):
    return body.replace('@1', 'deadSpot').replace('@2', 'steeringRange')


SHAPES = [
 ("no-device block acc", r"""      { int acc = player << 0x1e;
        return (acc |
                (0x7f - (byte)frontEnd.@1[player]) * 0x10000 |
                (0x7f - (byte)frontEnd.@2[player]) * 0x100) | 1; }"""),
 ("fn-scope acc1", r"""      acc1 = player << 0x1e;
      return (acc1 |
              (0x7f - (byte)frontEnd.@1[player]) * 0x10000 |
              (0x7f - (byte)frontEnd.@2[player]) * 0x100) | 1;"""),
 ("fn-scope acc2", r"""      acc2 = player << 0x1e;
      return (acc2 |
              (0x7f - (byte)frontEnd.@1[player]) * 0x10000 |
              (0x7f - (byte)frontEnd.@2[player]) * 0x100) | 1;"""),
 ("newControl carrier", r"""      newControl = player << 0x1e;
      return (newControl |
              (0x7f - (byte)frontEnd.@1[player]) * 0x10000 |
              (0x7f - (byte)frontEnd.@2[player]) * 0x100) | 1;"""),
 ("stepwise |= on block acc", r"""      { int acc = player << 0x1e;
        acc = acc | (0x7f - (byte)frontEnd.@1[player]) * 0x10000;
        acc = acc | (0x7f - (byte)frontEnd.@2[player]) * 0x100;
        return acc | 1; }"""),
 ("stepwise |= on acc1", r"""      acc1 = player << 0x1e;
      acc1 = acc1 | (0x7f - (byte)frontEnd.@1[player]) * 0x10000;
      acc1 = acc1 | (0x7f - (byte)frontEnd.@2[player]) * 0x100;
      return acc1 | 1;"""),
 ("stepwise |= on acc2", r"""      acc2 = player << 0x1e;
      acc2 = acc2 | (0x7f - (byte)frontEnd.@1[player]) * 0x10000;
      acc2 = acc2 | (0x7f - (byte)frontEnd.@2[player]) * 0x100;
      return acc2 | 1;"""),
 ("single expr, no acc", r"""      return ((player << 0x1e) |
              (0x7f - (byte)frontEnd.@1[player]) * 0x10000 |
              (0x7f - (byte)frontEnd.@2[player]) * 0x100) | 1;"""),
 ("acc |= chained", r"""      { int acc = player << 0x1e;
        acc |= (0x7f - (byte)frontEnd.@1[player]) * 0x10000;
        acc |= (0x7f - (byte)frontEnd.@2[player]) * 0x100;
        acc |= 1;
        return acc; }"""),
]

CASES = [("BASE (both fences present)", [])]
for name, shape in SHAPES:
    CASES.append((name, [(FA, A(shape)), (FB, B(shape))]))
# also: remove only one of the two fences
CASES.append(("drop fence in arm A only", [(FA, A(SHAPES[0][1]))]))
CASES.append(("drop fence in arm B only", [(FB, B(SHAPES[0][1]))]))
