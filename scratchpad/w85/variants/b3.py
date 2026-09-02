# named base pointer lp used ONLY for the guard reads [0] and [3]
from _common import PAL_FULL, PAL_DECLS
new = PAL_FULL
new = new.replace('plate0 = CarIO_licensePlate[carType][0];', 'lp = CarIO_licensePlate[carType];\n        plate0 = lp[0];')
new = new.replace('i == CarIO_licensePlate[carType][3]', 'i == lp[3]')
PAIRS = [(PAL_DECLS, PAL_DECLS.rstrip('\n') + '\n        short *lp;\n\n'), (PAL_FULL, new)]
