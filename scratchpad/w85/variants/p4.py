from _common import PAL_HEAD
PAIRS = [(PAL_HEAD, """        license = 0;
        clut = CarIO_carPixMap[palIndex].clut;
        cx = (clut & 0x3f) << 4;
        plate0 = CarIO_licensePlate[carType][0];
        cy = (int)(clut >> 6);
        if (carType < 0x16 && plate0 >= 0) {
""")]
