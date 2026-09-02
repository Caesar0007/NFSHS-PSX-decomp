# index-term-first spelling (W60-A6 lever)
from _common import PAL_FULL
PAIRS=[(PAL_FULL, PAL_FULL.replace('plate0 = CarIO_licensePlate[carType][0];',
   'plate0 = *(short *)(carType * 12 + (int)CarIO_licensePlate);'))]
