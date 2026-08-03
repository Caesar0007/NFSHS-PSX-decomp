import io, re, sys

src, dst = sys.argv[1], sys.argv[2]
s = io.open(src, encoding='utf-8', newline='').read()

# Replace each  __asm__ volatile( "...multi-line..."  : outs : ins : clobbers );
# with an EMPTY-template asm carrying the SAME operand/clobber signature.
# Keeps every value's liveness + the hard-reg clobbers, drops the instruction text.
pat = re.compile(r'__asm__\s+volatile\s*\(', re.S)
out = []
i = 0
n = 0
while True:
    m = pat.search(s, i)
    if not m:
        out.append(s[i:])
        break
    out.append(s[i:m.start()])
    # find the matching ')' from m.end()-1
    depth = 1
    j = m.end()
    instr = False
    while depth:
        c = s[j]
        if instr:
            if c == '\\':
                j += 2
                continue
            if c == '"':
                instr = False
        else:
            if c == '"':
                instr = True
            elif c == '(':
                depth += 1
            elif c == ')':
                depth -= 1
        j += 1
    body = s[m.end():j - 1]
    # split off the template string: everything up to the first top-level ':'
    depth = 0
    instr = False
    k = 0
    while k < len(body):
        c = body[k]
        if instr:
            if c == '\\':
                k += 2
                continue
            if c == '"':
                instr = False
        else:
            if c == '"':
                instr = True
            elif c == '(':
                depth += 1
            elif c == ')':
                depth -= 1
            elif c == ':' and depth == 0:
                break
        k += 1
    tail = body[k:]
    out.append('__asm__ volatile("" ' + tail + ')')
    n += 1
    i = j

io.open(dst, 'w', encoding='utf-8', newline='').write(''.join(out))
print('replaced', n, 'asm templates ->', dst)
