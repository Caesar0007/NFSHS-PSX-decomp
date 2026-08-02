"""Line-based, line-ending-preserving exact replace for the mixed CRCRLF/CRLF TU.
usage: a8_edit.py <file> <old.txt> <new.txt>   (old/new are plain LF text)"""
import sys
f, oldf, newf = sys.argv[1], sys.argv[2], sys.argv[3]
raw = open(f, 'rb').read()
lines = raw.split(b'\n')                       # last elem = tail after final \n
body = [l.rstrip(b'\r') for l in lines]
ends = [l[len(l.rstrip(b'\r')):] + b'\n' for l in lines]
old = open(oldf, 'rb').read().replace(b'\r', b'').rstrip(b'\n').split(b'\n')
new = open(newf, 'rb').read().replace(b'\r', b'').rstrip(b'\n').split(b'\n')
hits = [i for i in range(len(body) - len(old) + 1) if body[i:i+len(old)] == old]
if len(hits) != 1:
    print("MATCHES=%d -- ABORT" % len(hits)); sys.exit(1)
i = hits[0]
end = ends[i]
body[i:i+len(old)] = new
ends[i:i+len(old)] = [end] * len(new)
out = b''.join(b + e for b, e in zip(body[:-1], ends[:-1])) + body[-1]
open(f, 'wb').write(out)
print("OK nul=%d crcrlf=%d crlf=%d lf=%d" % (out.count(0), out.count(b'\r\r\n'),
                                             out.count(b'\r\n'), out.count(b'\n')))
