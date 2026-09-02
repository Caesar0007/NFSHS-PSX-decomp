BASE = """      settrans(1);
      do {
        anchorShape = shapes[5];
        do {
          shapeOffset = 4;
          do {
            i = 0;
            x = 0xe2 - anchorShape->width;
            VSync(0);
          } while (0);
        } while (0);
      } while (0);"""

def wrap(inner):
    return ("      settrans(1);\n      do {\n        anchorShape = shapes[5];\n"
            "        do {\n          shapeOffset = 4;\n          do {\n"
            + inner + "          } while (0);\n        } while (0);\n      } while (0);")

VARIANTS = [
    ('a i0-first (current)', wrap("            i = 0;\n            x = 0xe2 - anchorShape->width;\n            VSync(0);\n")),
    ('b vsync-then-i0', wrap("            x = 0xe2 - anchorShape->width;\n            VSync(0);\n            i = 0;\n")),
    ('c x-i0-vsync', wrap("            x = 0xe2 - anchorShape->width;\n            i = 0;\n            VSync(0);\n")),
    ('d vsync-first', wrap("            VSync(0);\n            i = 0;\n            x = 0xe2 - anchorShape->width;\n")),
    ('e i0-outer', """      settrans(1);
      i = 0;
      do {
        anchorShape = shapes[5];
        do {
          shapeOffset = 4;
          do {
            x = 0xe2 - anchorShape->width;
            VSync(0);
          } while (0);
        } while (0);
      } while (0);"""),
    ('f flat-i0-vsync-x', """      settrans(1);
      do {
        anchorShape = shapes[5];
        do {
          shapeOffset = 4;
          do {
            x = 0xe2 - anchorShape->width;
            VSync(0);
            i = 0;
          } while (0);
        } while (0);
      } while (0);"""),
]
