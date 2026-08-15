ANCHOR = """  for (i = 0, btnOff = 0; i < 8; i++, btnOff += 8) {
    active = (((byte *)gPadinfo.buf)[btnOff] == 0);
    if (active != gPadinfo.state[i].bActive) {
      debCount = gPadinfo.state[i].time;
      gPadinfo.state[i].time = debCount + 1;
      if (debCount > 5) {
        gPadinfo.state[i].bActive = active;
        gPadinfo.state[i].time = 0;
      }
    }
  }"""


def body(head, first):
    return ("""  %s {
    %s
    if (active != gPadinfo.state[i].bActive) {
      debCount = gPadinfo.state[i].time;
      gPadinfo.state[i].time = debCount + 1;
      if (debCount > 5) {
        gPadinfo.state[i].bActive = active;
        gPadinfo.state[i].time = 0;
      }
    }
  }""" % (head, first))


VARIANTS = [
    ("L1 index i*8, no btnOff",
     body("for (i = 0; i < 8; i++)",
          "active = (((byte *)gPadinfo.buf)[i * 8] == 0);")),

    ("L2 index i<<3, no btnOff",
     body("for (i = 0; i < 8; i++)",
          "active = (((byte *)gPadinfo.buf)[i << 3] == 0);")),

    ("L3 btnOff assigned IN the body (giv candidate)",
     body("for (i = 0; i < 8; i++)",
          "btnOff = i * 8;\n    active = (((byte *)gPadinfo.buf)[btnOff] == 0);")),

    ("L4 btnOff in body, shift form",
     body("for (i = 0; i < 8; i++)",
          "btnOff = i << 3;\n    active = (((byte *)gPadinfo.buf)[btnOff] == 0);")),

    ("L5 typed index gPadinfo.buf[i].nopad",
     body("for (i = 0; i < 8; i++)",
          "active = (gPadinfo.buf[i].nopad == 0);")),
]
