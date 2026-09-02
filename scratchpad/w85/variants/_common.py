PAL_HEAD = """        license = 0;
        clut = CarIO_carPixMap[palIndex].clut;
        cx = (clut & 0x3f) << 4;
        cy = (int)(clut >> 6);
        /* R-JPN delta: retail guards the licence-plate arms with a
           NON-NEGATIVE plate index -- `CarIO_licensePlate[carType][0]` is read
           into a `short` local BEFORE the recolour test (the oracle's
           `lhu`+`sll/sra` pair is a HImode pseudo, not a plain `lh` array
           read) and the arms only run when it is >= 0. */
        plate0 = CarIO_licensePlate[carType][0];
        if (carType < 0x16 && plate0 >= 0) {
"""
PAL_DECL = """        int license;
        u_short clut;
        int cx;
        int cy;

"""

PAL_FULL = open(__file__.rsplit('variants',1)[0] + 'M8_palblock.txt').read()
PAL_DECLS = """        int license;
        u_short clut;
        int cx;
        int cy;

"""
