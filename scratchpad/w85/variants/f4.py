# lp pointer for the coordinate reads only ([1],[2],[4],[5]) and [3]
from _common import PAL_FULL, PAL_DECLS
new = PAL_FULL
for k in (1,2,3,4,5):
    new = new.replace('CarIO_licensePlate[carType][%d]' % k, 'lp[%d]' % k)
new = new.replace('plate0 = CarIO_licensePlate[carType][0];',
                  'plate0 = CarIO_licensePlate[carType][0];\n        lp = CarIO_licensePlate[carType];')
PAIRS=[(PAL_DECLS, PAL_DECLS.rstrip('\n') + '\n        short *lp;\n\n'), (PAL_FULL, new)]
