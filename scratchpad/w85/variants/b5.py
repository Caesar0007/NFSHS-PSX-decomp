# block-scope plate0 in the FIRST (non-palette) block only
BLK1 = """      license = 0;
      /* R-JPN delta: non-negative plate-index guard (see the palette block). */
      plate0 = CarIO_licensePlate[carType][0];"""
PAIRS=[("""      int license;

""" + BLK1, """      int license;
      short plate0;

""" + BLK1)]
