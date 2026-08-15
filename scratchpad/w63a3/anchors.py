#!/usr/bin/env python3
"""Count TEXT_MOVES anchor matches inside one function's .ent/.end region."""
import re
import sys

s = open(sys.argv[1], encoding="utf-8", newline="").read()
fn = sys.argv[2]
m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(fn), s, re.M)
m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(fn), s[m.end():], re.M)
reg = s[m.start():m.end() + m2.start()]
for pat in sys.argv[3:]:
    hits = re.findall(pat, reg)
    print("%-45s %d  %r" % (pat, len(hits), hits[:2]))
