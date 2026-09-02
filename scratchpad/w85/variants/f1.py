# plate0 via an explicit byte-offset cast (breaks the array-form CSE shape)
from _common import PAL_FULL
PAIRS=[(PAL_FULL, PAL_FULL.replace('plate0 = CarIO_licensePlate[carType][0];',
   'plate0 = *(short *)((char *)CarIO_licensePlate + carType * 12);'))]
