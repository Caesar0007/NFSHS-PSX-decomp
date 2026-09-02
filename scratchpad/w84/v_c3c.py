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
 ('j no-anchor-temp', """      settrans(1);
      do {
        do {
          shapeOffset = 4;
          do {
            x = 0xe2 - shapes[5]->width;
            VSync(0);
            i = 0;
          } while (0);
        } while (0);
      } while (0);"""),
 ('k shapeOffset-after-x', """      settrans(1);
      do {
        anchorShape = shapes[5];
        do {
          do {
            x = 0xe2 - anchorShape->width;
            shapeOffset = 4;
            VSync(0);
            i = 0;
          } while (0);
        } while (0);
      } while (0);"""),
 ('l anchor-inside', """      settrans(1);
      do {
        do {
          shapeOffset = 4;
          do {
            anchorShape = shapes[5];
            x = 0xe2 - anchorShape->width;
            VSync(0);
            i = 0;
          } while (0);
        } while (0);
      } while (0);"""),
 ('m flat-noblocks', """      settrans(1);
      shapeOffset = 4;
      anchorShape = shapes[5];
      x = 0xe2 - anchorShape->width;
      VSync(0);
      i = 0;"""),
]
