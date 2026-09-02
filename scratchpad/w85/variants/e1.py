# two separate fn-scope shorts: plate0 (block1) + plate0b (palette block)
from _decls import FN_DECLS
from _common import PAL_FULL
new_decls = FN_DECLS.replace("  short plate0;   /* R-JPN delta carrier */\n",
                             "  short plate0;   /* R-JPN delta carrier */\n  short plate0b;  /* R-JPN delta carrier (palette block) */\n")
PAIRS=[(FN_DECLS, new_decls),
       (PAL_FULL, PAL_FULL.replace('plate0','plate0b'))]
