# block-scope short plate0 in the PALETTE block only
from _common import PAL_DECLS
PAIRS = [(PAL_DECLS + '        license = 0;\n        clut = CarIO_carPixMap[palIndex].clut;',
          PAL_DECLS.rstrip('\n') + '\n        short plate0;\n\n        license = 0;\n        clut = CarIO_carPixMap[palIndex].clut;')]
