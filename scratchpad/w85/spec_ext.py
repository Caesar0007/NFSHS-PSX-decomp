SE = """      dist = ({
        int selected = textpix >= dist ? textpix : dist;
        selFade = fSelFade;
        textType = textType_FlybyHelp;
        __asm__("" : "=r"(textType) : "0"(textType));
        __asm__("" : "=r"(selFade) : "0"(selFade));
        fade = 0;
        __asm__("" : "=r"(fade) : "0"(fade));
        selected;
      }) + 0x19;
"""
FENCE8 = """        __asm__("" : : "r"(helpText), "r"(helpText), "r"(helpText),
                         "r"(helpText), "r"(helpText), "r"(helpText),
                         "r"(helpText), "r"(helpText));
"""

SE_PLAIN = """      dist = ({
        int selected = textpix >= dist ? textpix : dist;
        selFade = fSelFade;
        textType = textType_FlybyHelp;
        fade = 0;
        selected;
      }) + 0x19;
"""

CASES = [
 ("R0 baseline", []),
 ("R1 three launders out", [(SE, SE_PLAIN)]),
 ("R2 eight-operand fence out", [(FENCE8, "")]),
 ("R3 everything out", [(SE, SE_PLAIN), (FENCE8, "")]),
 ("R4 launders out, dials in", [(SE, """      dist = ({
        int selected = textpix >= dist ? textpix : dist;
        selFade = fSelFade;
        do { textType = textType_FlybyHelp; } while (0);
        do { fade = 0; } while (0);
        selected;
      }) + 0x19;
""")]),
 ("R5 launders out, plain statements (no stmt-expr)", [(SE, """      {
        int selected = textpix >= dist ? textpix : dist;
        selFade = fSelFade;
        textType = textType_FlybyHelp;
        fade = 0;
        dist = selected + 0x19;
      }
""")]),
]
