BASE = """      settrans(1);
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
      } while (0);"""
VARIANTS = [
 ('b cur', BASE),
 ('n extra-level', """      settrans(1);
      do {
        anchorShape = shapes[5];
        do {
          shapeOffset = 4;
          do {
            x = 0xe2 - anchorShape->width;
            do {
              VSync(0);
              i = 0;
            } while (0);
          } while (0);
        } while (0);
      } while (0);"""),
 ('o i0-outside-inner', """      settrans(1);
      do {
        anchorShape = shapes[5];
        do {
          shapeOffset = 4;
          do {
            x = 0xe2 - anchorShape->width;
            VSync(0);
          } while (0);
          i = 0;
        } while (0);
      } while (0);"""),
 ('p vsync-block-first', """      settrans(1);
      do {
        do {
          VSync(0);
          i = 0;
        } while (0);
        anchorShape = shapes[5];
        shapeOffset = 4;
        x = 0xe2 - anchorShape->width;
      } while (0);"""),
 ('q i0-outermost', """      settrans(1);
      do {
        anchorShape = shapes[5];
        do {
          shapeOffset = 4;
          do {
            x = 0xe2 - anchorShape->width;
            VSync(0);
          } while (0);
        } while (0);
        i = 0;
      } while (0);"""),
 ('r two-blocks-flat', """      settrans(1);
      do {
        anchorShape = shapes[5];
      } while (0);
      do {
        shapeOffset = 4;
      } while (0);
      do {
        x = 0xe2 - anchorShape->width;
        VSync(0);
        i = 0;
      } while (0);"""),
]
