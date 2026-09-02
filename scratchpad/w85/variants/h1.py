# drop the now-unused function-scope carrier (apply AFTER b1+p2+b5)
from _decls import FN_DECLS, BASE_LINES
PAIRS=[(FN_DECLS, "\n".join(BASE_LINES) + "\n")]
