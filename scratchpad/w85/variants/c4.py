# nested ifs instead of &&
from _common import PAL_FULL
n=PAL_FULL.replace('if (carType < 0x16 && plate0 >= 0) {','if (carType < 0x16) {\n         if (plate0 >= 0) {')
n=n.rstrip('\n')
assert n.endswith('}')
n=n+'\n        }\n'
PAIRS=[(PAL_FULL,n)]
