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
      int col = CalcTextFadeSelToHiWide(textType,selFade,fade);
"""

CASES = [
 ("S0 baseline", []),
 ("S1 dist add after the call", [(SE, """      int selected = textpix >= dist ? textpix : dist;
      selFade = fSelFade;
      textType = textType_FlybyHelp;
      fade = 0;
      int col = CalcTextFadeSelToHiWide(textType,selFade,fade);
      dist = selected + 0x19;
""")]),
 ("S2 dist add after the call, stmt-expr kept for the sets", [(SE, """      int selected = ({
        selFade = fSelFade;
        textType = textType_FlybyHelp;
        fade = 0;
        textpix >= dist ? textpix : dist;
      });
      int col = CalcTextFadeSelToHiWide(textType,selFade,fade);
      dist = selected + 0x19;
""")]),
 ("S3 dist add after the call, dist read first", [(SE, """      int selected = textpix >= dist ? textpix : dist;
      textType = textType_FlybyHelp;
      selFade = fSelFade;
      fade = 0;
      int col = CalcTextFadeSelToHiWide(textType,selFade,fade);
      dist = selected + 0x19;
""")]),
 ("S4 dist add after the reflected branch", [(SE, """      int selected = textpix >= dist ? textpix : dist;
      selFade = fSelFade;
      textType = textType_FlybyHelp;
      fade = 0;
      int col = CalcTextFadeSelToHiWide(textType,selFade,fade);
"""),
   ("      if (reflected != 0) {\n        col = CalcFadeVal(0,col,0xf0 - r.y);\n      }\n",
    "      dist = selected + 0x19;\n      if (reflected != 0) {\n        col = CalcFadeVal(0,col,0xf0 - r.y);\n      }\n")]),
 ("S5 dist add after the call, in-place +=", [(SE, """      int selected = textpix >= dist ? textpix : dist;
      selFade = fSelFade;
      textType = textType_FlybyHelp;
      fade = 0;
      int col = CalcTextFadeSelToHiWide(textType,selFade,fade);
      dist = selected;
      dist += 0x19;
""")]),
 ("S6 no stmt-expr, plain order (control)", [(SE, """      dist = (textpix >= dist ? textpix : dist) + 0x19;
      selFade = fSelFade;
      textType = textType_FlybyHelp;
      fade = 0;
      int col = CalcTextFadeSelToHiWide(textType,selFade,fade);
""")]),
]
