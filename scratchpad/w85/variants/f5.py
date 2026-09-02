# pointer to the carPixMap element for the clut read
from _common import PAL_FULL
PAIRS=[(PAL_FULL, PAL_FULL.replace('clut = CarIO_carPixMap[palIndex].clut;',
   'clut = (&CarIO_carPixMap[palIndex])->clut;'))]
