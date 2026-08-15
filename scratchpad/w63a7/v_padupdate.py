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

VARIANTS = [
    ("K0 control", ANCHOR),

    ("K1 explicit state walkers, btnOff last", """  {
    u_char *pt = &gPadinfo.state[0].time;
    u_char *pa = pt - 1;
    btnOff = 0;
    for (i = 0; i < 8; i++, btnOff += 8) {
      active = (((byte *)gPadinfo.buf)[btnOff] == 0);
      if (active != *pa) {
        debCount = *pt;
        *pt = debCount + 1;
        if (debCount > 5) {
          *pa = active;
          *pt = 0;
        }
      }
      pt += 2;
      pa += 2;
    }
  }"""),

    ("K2 launder i between the two inits", """  i = 0;
  __asm__("" : "=r"(i) : "0"(i));
  btnOff = 0;
  for (; i < 8; i++, btnOff += 8) {
    active = (((byte *)gPadinfo.buf)[btnOff] == 0);
    if (active != gPadinfo.state[i].bActive) {
      debCount = gPadinfo.state[i].time;
      gPadinfo.state[i].time = debCount + 1;
      if (debCount > 5) {
        gPadinfo.state[i].bActive = active;
        gPadinfo.state[i].time = 0;
      }
    }
  }"""),

    ("K3 launder i, btnOff init in the header", """  i = 0;
  __asm__("" : "=r"(i) : "0"(i));
  for (btnOff = 0; i < 8; i++, btnOff += 8) {
    active = (((byte *)gPadinfo.buf)[btnOff] == 0);
    if (active != gPadinfo.state[i].bActive) {
      debCount = gPadinfo.state[i].time;
      gPadinfo.state[i].time = debCount + 1;
      if (debCount > 5) {
        gPadinfo.state[i].bActive = active;
        gPadinfo.state[i].time = 0;
      }
    }
  }"""),

    ("K4 explicit walkers, both inits in header", """  {
    u_char *pt = &gPadinfo.state[0].time;
    u_char *pa = pt - 1;
    for (i = 0, btnOff = 0; i < 8; i++, btnOff += 8) {
      active = (((byte *)gPadinfo.buf)[btnOff] == 0);
      if (active != *pa) {
        debCount = *pt;
        *pt = debCount + 1;
        if (debCount > 5) {
          *pa = active;
          *pt = 0;
        }
      }
      pt += 2;
      pa += 2;
    }
  }"""),
]
