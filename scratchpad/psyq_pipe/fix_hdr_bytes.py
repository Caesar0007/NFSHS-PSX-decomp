"""Replace raw NUL / 0x01 bytes inside char literals of a header with escaped text."""
import sys
p = sys.argv[1]
d = open(p, 'rb').read()
n0 = d.count(b"'\x00'")
n1 = d.count(b"'\x01'")
d = d.replace(b"'\x00'", b"'\\0'").replace(b"'\x01'", b"'\\x01'")
open(p, 'wb').write(d)
left = sum(1 for b in d if b < 9 or 13 < b < 32 or b > 126)
print('replaced', n0, n1, 'nonprint left', left)
