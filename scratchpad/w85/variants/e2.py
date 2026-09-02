# two fn-scope shorts, palette one declared FIRST
from _decls import FN_DECLS
from _common import PAL_FULL
new_decls = FN_DECLS.replace("  short plate0;   /* R-JPN delta carrier */\n",
                             "  short plate0b;  /* R-JPN delta carrier (palette block) */\n  short plate0;   /* R-JPN delta carrier */\n")
PAIRS=[(FN_DECLS, new_decls),
       (PAL_FULL, PAL_FULL.replace('plate0','plate0b'))]
