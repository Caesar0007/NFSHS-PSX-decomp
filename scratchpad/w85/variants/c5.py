# plate0 read through a deref of the row pointer
from _common import PAL_FULL
PAIRS=[(PAL_FULL, PAL_FULL.replace('plate0 = CarIO_licensePlate[carType][0];','plate0 = *CarIO_licensePlate[carType];'))]
