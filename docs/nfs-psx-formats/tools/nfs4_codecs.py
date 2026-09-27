#!/usr/bin/env python3
"""NFS4 PSX "Q" codecs -- Python port of the retail decoders (nfs4-decomp recon):
  dispatcher  unpackz / unpacksizez      game/psx/unpack.c
  RefPack     unrefpack  (0x10FB, 0x11FB) eaclib/psx/eacpsxz/unref.c
  Huffman     unhuff     (0x30FB, 0x32FB, 0x34FB, +0x100 variants) eaclib/psx/eacpsxz/unhuff.c
  B-tree      unbtree    (0x46FB, 0x47FB) eaclib/psx/eacpsxz/unbtree.c

  python nfs4_codecs.py <file> [out]      decode one file
  python nfs4_codecs.py census <dir>      decode every packed file, report
"""
import sys, os, glob, collections


# ----------------------------------------------------------------------------- dispatch
def signature(src):
    """(packed?, sig) using the loader's test: byte 1 == 0xFB (or 0x32); byte 0 & 0xFE selects the codec."""
    if len(src) < 5 or src[1] not in (0xFB, 0x32):
        return False, None
    return True, src[0] & 0xFE


def unpacksize(src):
    """unpacksizez: 24-bit big-endian size at +2 for sigs 0x10/0x18/0x30/0x32/0x34/0x46/0x4A, else 0."""
    ok, sig = signature(src)
    if ok and sig in (0x10, 0x18, 0x30, 0x32, 0x34, 0x46, 0x4A):
        return (src[2] << 16) | (src[3] << 8) | src[4]
    return 0


def unpack(src):
    """unpackz: returns decoded bytes, or None where the game would fail (unknown sig, e.g. 0x18/0x4A)."""
    ok, sig = signature(src)
    if not ok:
        return None
    if sig == 0x10:
        return unrefpack(src)
    if sig in (0x30, 0x32, 0x34):
        return unhuff(src)
    if sig == 0x46:
        return unbtree(src)
    return None


# ----------------------------------------------------------------------------- RefPack
def unrefpack(src):
    p = 2
    if src[0] & 1:                   # 0x11FB: 3-byte compressed-size field present
        p += 3
    size = (src[p] << 16) | (src[p + 1] << 8) | src[p + 2]
    p += 3
    out = bytearray()

    def backref(dist, n):
        start = len(out) - dist
        for i in range(n):           # byte-wise: overlapping copies replicate (retail refcpy)
            out.append(out[start + i])

    while True:
        b0 = src[p]
        if b0 < 0x80:                                     # 2-byte command
            b1 = src[p + 1]; p += 2
            lit = b0 & 3
            out += src[p:p + lit]; p += lit
            backref(((b0 & 0x60) << 3) + b1 + 1, ((b0 >> 2) & 7) + 3)
        elif b0 < 0xC0:                                   # 3-byte command
            b1, b2 = src[p + 1], src[p + 2]; p += 3
            lit = b1 >> 6
            out += src[p:p + lit]; p += lit
            backref(((b1 & 0x3F) << 8) + b2 + 1, (b0 & 0x3F) + 4)
        elif b0 < 0xE0:                                   # 4-byte command
            b1, b2, b3 = src[p + 1], src[p + 2], src[p + 3]; p += 4
            lit = b0 & 3
            out += src[p:p + lit]; p += lit
            backref(((b0 & 0x10) << 12) + (b1 << 8) + b2 + 1, ((b0 & 0x0C) << 6) + b3 + 5)
        elif b0 < 0xFC:                                   # literal run
            p += 1
            n = ((b0 & 0x1F) + 1) * 4
            out += src[p:p + n]; p += n
        else:                                             # terminator + 0..3 literals
            p += 1
            n = b0 & 3
            out += src[p:p + n]
            break
    return bytes(out[:size]) if len(out) >= size else bytes(out)


# ----------------------------------------------------------------------------- Huffman
class _Bits:
    """MSB-first reader over bytes in file order (retail GET16BITS refills big-endian 16-bit chunks)."""
    def __init__(self, data):
        self.d = data; self.pos = 0; self.acc = 0; self.n = 0
    def peek(self, k):
        while self.n < k:
            b = self.d[self.pos] if self.pos < len(self.d) else 0
            self.pos += 1; self.acc = (self.acc << 8) | b; self.n += 8
        return (self.acc >> (self.n - k)) & ((1 << k) - 1)
    def get(self, k):
        if k == 0:
            return 0
        v = self.peek(k); self.n -= k; self.acc &= (1 << self.n) - 1
        return v
    def getnum(self):
        """SQgetnum: '1xx' -> 0..3; else k leading zeros, a 1, then n=k+2 bits: v + 2^n - 4."""
        if self.peek(1):
            return self.get(3) - 4
        k = 0
        while self.get(1) == 0:
            k += 1
        k -= 1                                     # the first 0 was part of the prefix; retail counts shifts
        n = k + 3
        return self.get(n) + (1 << n) - 4


def unhuff(src):
    r = _Bits(src)
    typ = r.get(16)
    if typ & 0x100:
        r.get(8); r.get(16)
    typ &= ~0x100
    ulen = (r.get(8) << 16) | r.get(16)
    clue = r.get(8)
    # code-length table
    bitnum = {}; delta = {}; cmptbl = {}
    numchars = 0; numbits = 1; basecmp = 0
    while True:
        basecmp <<= 1
        delta[numbits] = basecmp - numchars
        bn = r.getnum()
        bitnum[numbits] = bn
        numchars += bn; basecmp += bn
        cmp = ((basecmp << (16 - numbits)) & 0xFFFF) if bn else 0
        cmptbl[numbits] = cmp
        numbits += 1
        if bn and not cmp:
            break
    mostbits = numbits - 1
    cmptbl[mostbits] = 0xFFFFFFFF
    # symbol order (leap deltas)
    leap = [0] * 256; nextchar = 255; codes = []
    for _ in range(numchars):
        ld = r.getnum() + 1
        while True:
            nextchar = (nextchar + 1) & 0xFF
            if not leap[nextchar]:
                ld -= 1
            if ld == 0:
                break
        leap[nextchar] = 1
        codes.append(nextchar)
    # decode
    out = bytearray()
    while True:
        peek16 = r.peek(16)
        L = 1
        while L < mostbits and (cmptbl[L] == 0 or peek16 >= cmptbl[L]):
            L += 1
        code = codes[r.get(L) - delta[L]]
        if code != clue:
            out.append(code); continue
        run = r.getnum()
        if run:
            out += bytes([out[-1]]) * run; continue
        if r.get(1):
            break
        out.append(r.get(8))
    if typ == 0x32FB:
        acc = 0
        for i in range(len(out)):
            acc = (acc + out[i]) & 0xFF; out[i] = acc
    elif typ == 0x34FB:
        a = c = 0
        for i in range(len(out)):
            a = (a + out[i]) & 0xFF; c = (c + a) & 0xFF; out[i] = c
    return bytes(out[:ulen]) if len(out) >= ulen else bytes(out)


# ----------------------------------------------------------------------------- B-tree
def unbtree(src):
    p = 2
    if src[0] == 0x47:
        p = 5
    size = (src[p] << 16) | (src[p + 1] << 8) | src[p + 2]; p += 3
    clue = [0] * 256; left = [0] * 256; right = [0] * 256
    esc = src[p]; p += 1; clue[esc] = 1
    nodes = src[p]; p += 1
    for _ in range(nodes):
        c, l, rr = src[p], src[p + 1], src[p + 2]; p += 3
        left[c] = l; right[c] = rr; clue[c] = -1
    out = bytearray()

    def chase(c):
        stack = [c]
        while stack:
            x = stack.pop()
            if clue[x] != 0:
                stack.append(right[x]); stack.append(left[x])
            else:
                out.append(x)

    while True:
        c = src[p]; p += 1
        k = clue[c]
        if k == 0:
            out.append(c)
        elif k > 0:
            c = src[p]; p += 1
            if c == 0:
                break
            out.append(c)
        else:
            chase(left[c]); chase(right[c])
    return bytes(out)


# ----------------------------------------------------------------------------- CLI
def census(d):
    stats = collections.Counter(); bad = []
    for f in sorted(glob.glob(os.path.join(d, '*'))):
        if not os.path.isfile(f):
            continue
        src = open(f, 'rb').read()
        ok, sig = signature(src)
        want = unpacksize(src)
        if not ok or want == 0:          # the game treats these as not packed (e.g. C0FB archives)
            continue
        try:
            got = unpack(src)
        except Exception as e:
            got = None; bad.append((os.path.basename(f), f'{sig:#x}', 'EXC ' + str(e)[:40])); stats[(sig, 'exception')] += 1; continue
        if got is None:
            stats[(sig, 'no decoder')] += 1; bad.append((os.path.basename(f), f'{sig:#x}', 'no decoder')); continue
        res = 'size ok' if len(got) == want else f'size {len(got)} != {want}'
        stats[(sig, res if res == 'size ok' else 'SIZE MISMATCH')] += 1
        if res != 'size ok':
            bad.append((os.path.basename(f), f'{sig:#x}', res))
    for k, v in sorted(stats.items(), key=lambda x: (x[0][0], x[0][1])):
        print(f'  sig 0x{k[0]:02x}FB  {k[1]:<14} {v}')
    for b in bad[:20]:
        print('  BAD', *b)


if __name__ == '__main__':
    if sys.argv[1] == 'census':
        census(sys.argv[2])
    else:
        data = unpack(open(sys.argv[1], 'rb').read())
        if data is None:
            sys.exit('not a supported packed file')
        out = sys.argv[2] if len(sys.argv) > 2 else sys.argv[1] + '.unpacked'
        open(out, 'wb').write(data); print(f'{len(data)} bytes -> {out}')
