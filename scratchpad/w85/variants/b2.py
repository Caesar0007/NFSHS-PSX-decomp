# named base pointer lp for every licensePlate access in the palette block
from _common import PAL_FULL, PAL_DECLS
new = PAL_FULL
new = new.replace('plate0 = CarIO_licensePlate[carType][0];', 'lp = CarIO_licensePlate[carType];\n        plate0 = lp[0];')
for k in (1,2,3,4,5):
    new = new.replace('CarIO_licensePlate[carType][%d]' % k, 'lp[%d]' % k)
PAIRS = [(PAL_DECLS, PAL_DECLS.rstrip('\n') + '\n        short *lp;\n\n'), (PAL_FULL, new)]
