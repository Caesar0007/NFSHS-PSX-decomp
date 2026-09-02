# i == plate0 -> plate0 == i (yoda)
from _common import PAL_FULL
PAIRS=[(PAL_FULL, PAL_FULL.replace('if (i == plate0) {','if (plate0 == i) {'))]
