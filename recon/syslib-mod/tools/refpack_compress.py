#!/usr/bin/env python3
"""Small deterministic greedy RefPack encoder for the syslib restore artifact."""
import argparse
from collections import defaultdict, deque
from pathlib import Path


def compress(data):
    if len(data) >= 1 << 24:
        raise ValueError('24-bit RefPack size exceeded')
    out = bytearray((0x10, 0xFB, len(data) >> 16, len(data) >> 8 & 255, len(data) & 255))
    chains = defaultdict(deque)
    pending = bytearray()

    def add(pos):
        if pos + 3 <= len(data):
            q = chains[data[pos:pos + 3]]
            q.append(pos)
            while q and pos - q[0] > 0x20000:
                q.popleft()

    def literals(force=False):
        while len(pending) > 3 if not force else len(pending) >= 4:
            n = min(112, len(pending) & ~3)
            if not n:
                break
            out.append(0xE0 | (n // 4 - 1));out.extend(pending[:n]);del pending[:n]

    pos = 0
    while pos < len(data):
        best_len = best_off = 0
        if pos + 3 <= len(data):
            q = chains.get(data[pos:pos + 3], ())
            for old in reversed(q):
                off = pos - old
                if off > 0x20000:
                    break
                limit = min(1028, len(data) - pos)
                n = 3
                while n < limit and data[old + n] == data[pos + n]:
                    n += 1
                if n > best_len and ((n >= 3 and off <= 1024) or (n >= 4 and off <= 16384) or n >= 5):
                    best_len,best_off=n,off
                    if n == limit:
                        break
        if best_len:
            literals(False);lit=len(pending);off=best_off-1
            if best_len <= 10 and best_off <= 1024:
                n=best_len;out.extend((((off >> 8) << 5) | ((n - 3) << 2) | lit, off & 255))
            elif best_len <= 67 and best_off <= 16384:
                n=best_len;out.extend((0x80 | (n - 4), (lit << 6) | (off >> 8), off & 255))
            else:
                n=min(best_len,1028);ln=n-5;out.extend((0xC0 | ((off >> 16) << 4) | ((ln >> 8) << 2) | lit, off >> 8 & 255, off & 255, ln & 255))
            out.extend(pending);pending.clear()
            for p in range(pos,pos+n):add(p)
            pos += n
        else:
            pending.append(data[pos]);add(pos);pos += 1;literals(False)
    literals(True)
    out.append(0xFC | len(pending));out.extend(pending)
    return bytes(out)


def decompress(src):
    size=(src[2]<<16)|(src[3]<<8)|src[4];p=5;out=bytearray()
    while True:
        b=src[p];p+=1
        if b<0x80:lit=b&3;n=((b>>2)&7)+3;off=((b&0x60)<<3)|src[p];p+=1;off+=1
        elif b<0xC0:lit=src[p]>>6;n=(b&0x3f)+4;off=((src[p]&0x3f)<<8)|src[p+1];p+=2;off+=1
        elif b<0xE0:lit=b&3;n=((b&0xc)<<6)|src[p+2];off=((b&0x10)<<12)|(src[p]<<8)|src[p+1];p+=3;n+=5;off+=1
        elif b<0xFC:lit=((b&0x1f)+1)*4;n=off=0
        else:lit=b&3;n=off=0
        out.extend(src[p:p+lit]);p+=lit
        for _ in range(n):out.append(out[-off])
        if b>=0xFC:break
    if len(out)!=size:raise ValueError((len(out),size))
    return bytes(out)


def main():
    p=argparse.ArgumentParser();p.add_argument('source',type=Path);p.add_argument('output',type=Path);a=p.parse_args();raw=a.source.read_bytes();packed=compress(raw)
    if decompress(packed)!=raw:raise RuntimeError('round-trip failed')
    a.output.write_bytes(packed);print(f'{len(raw)} -> {len(packed)} bytes ({len(packed)*100/len(raw):.1f}%)')


if __name__=='__main__':main()
