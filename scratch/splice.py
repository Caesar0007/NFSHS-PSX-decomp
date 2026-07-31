import io, sys
p = 'recon/game/psx/cario.cpp'
s = io.open(p, encoding='utf-8').read()
new = io.open(sys.argv[1], encoding='utf-8').read()
a = sys.argv[2]
b = sys.argv[3]
start = s.index(a)
end = s.index(b)
s = s[:start] + new + s[end:]
io.open(p, 'w', encoding='utf-8', newline='').write(s)
print('spliced', start, end)
