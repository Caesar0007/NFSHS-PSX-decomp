NL = chr(13) + chr(10)
ENV = {}

FENCE = '  __asm__("" : : "r"(carPixMapCount));' + NL

I0 = ("  i = 0;" + NL +
      "  if (R3DCar_InMenu == 0) {" + NL +
      "    /* oracle: `lw t1,72(sp); ori t1,t1,0x10; sw t1,72(sp)` -- an OR into the" + NL)
PC = ("  Texture_palCopy = (Texture_pal8bit *)(carObj->render).palCopy;" + NL +
      "  Texture_ResetPaletteSharing();" + NL)
RESET = PC
TEXOFF = ("    (carObj->render).textureOffsetV = (u_short)vy & 0xff;" + NL +
          "  }" + NL)


def move(anchor, before=True, keep=False):
    def f(s):
        assert s.count(FENCE) == 1, ('fence', s.count(FENCE))
        assert s.count(anchor) == 1, ('anchor', s.count(anchor))
        if not keep:
            s = s.replace(FENCE, '')
        return s.replace(anchor, (FENCE + anchor) if before else (anchor + FENCE))
    return f


PATCHES = [
    ("ctl_join", lambda s: s),
    ("before_palcopy", move(PC)),
    ("after_reset", move(RESET, False)),
    ("join_plus_reset", move(RESET, True, True)),
]
