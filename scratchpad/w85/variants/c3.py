# swap && operands
from _common import PAL_FULL
PAIRS=[(PAL_FULL, PAL_FULL.replace('if (carType < 0x16 && plate0 >= 0) {','if (plate0 >= 0 && carType < 0x16) {'))]
