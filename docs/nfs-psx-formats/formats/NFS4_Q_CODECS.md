# NFS4 "Q" compression codecs (RefPack, Huffman, B-tree)

Games: NFS4 ★★★ (other titles: to survey; the same EA codecs are expected). Loader authority:
`unpackz`/`unpacksizez` (`recon/game/psx/unpack.c`), `unrefpack` (`eaclib/psx/eacpsxz/unref.c`),
`unhuff` (`unhuff.c`), `unbtree` (`unbtree.c`); files are loaded through `loadpackadrz`
(`nloadpk.c`). Python port: `tools/nfs4_codecs.py` (decode one file, or `census <dir>`).

## Detection and dispatch ★★★
A buffer is "packed" when **byte 1 is `0xFB` (or `0x32`)**. `byte0 & 0xFE` selects the codec, and bytes
2–4 hold the **unpacked size, 24-bit big-endian**.

| byte0 & 0xFE | Codec | `unpacksizez` | `unpackz` |
|--------------|-------|---------------|-----------|
| `0x10` | RefPack (`0x11` = with an extra 3-byte field) | size | decodes |
| `0x30`, `0x32`, `0x34` | Huffman (+ none / 1-D / 2-D delta) | size | decodes |
| `0x46` | B-tree (`0x47` = with an extra 3-byte field) | size | decodes |
| `0x18`, `0x4A` | (unknown) | size | **no decoder → returns 0** |
| anything else (e.g. `0xC0` of a C0FB archive) | — | 0 → treated as not packed | 0 |

`loadpackadrz` loads the file, asks `unpacksize`, and if non-zero copies the packed bytes to a scratch
block at the opposite end of the heap (memclass `^ 0x10`), allocates the output, unpacks, frees the
scratch. A `0x18`/`0x4A` file would get an output buffer and then fail.

## RefPack (LZ77) ★★★
Header: 2-byte signature; if bit 0 of byte 0 is set, 3 more bytes follow (compressed size, unused);
then the 3-byte big-endian unpacked size. Commands (b0 = first byte):

| b0 | Bytes | Literals copied first | Back-reference offset | Length |
|----|-------|----------------------|-----------------------|--------|
| `0x00–0x7F` | 2 | `b0 & 3` | `((b0 & 0x60) << 3) + b1 + 1` | `((b0 >> 2) & 7) + 3` |
| `0x80–0xBF` | 3 | `b1 >> 6` | `((b1 & 0x3F) << 8) + b2 + 1` | `(b0 & 0x3F) + 4` |
| `0xC0–0xDF` | 4 | `b0 & 3` | `((b0 & 0x10) << 12) + (b1 << 8) + b2 + 1` | `((b0 & 0x0C) << 6) + b3 + 5` |
| `0xE0–0xFB` | 1 | `((b0 & 0x1F) + 1) · 4` | — | — |
| `0xFC–0xFF` | 1 | `b0 & 3`, then **end** | — | — |

Back-references copy byte-by-byte when the offset is < 4 (so overlapping runs replicate; offset 1 is a
`memset`), word-wise otherwise. Every command stores 4 bytes blindly and then advances by the real
count, so the decoder saves the 4 bytes just past `out + size` first and restores them at the end.
Retail disc: no top-level RefPack file; it is used for compressed shapes inside PSH files (see
[NFS4_PSH.md](NFS4_PSH.md)).

## Huffman ("HUFF") ★★★
A **big-endian, MSB-first bitstream** over the whole file (the decoder refills 16 bits at a time).

1. `type` (16 bits) — `0x30FB`, `0x32FB`, `0x34FB`; bit `0x100` set adds a 24-bit extra field to skip.
2. Unpacked size (8 + 16 bits).
3. `clue` (8 bits) — the escape symbol.
4. **Code-length counts**, one per length L = 1, 2, … as numbers (below); stop after a non-zero count
   that completes the code space. Codes are canonical: `delta[L] = 2·base − assigned`, and a code of
   length L decodes to `symbols[value − delta[L]]`.
5. **Symbol order**: for each symbol, a number d; advance `d + 1` unused byte values (wrapping, starting
   at 255) and take the byte landed on.
6. **Data**: decode symbols; a non-clue symbol is output. After the clue: a number r; if r > 0,
   repeat the previous output byte r times; if r = 0, one bit: 1 = end of stream, 0 = the next 8 bits
   are a literal byte.
7. Post-process by type: `0x32FB` prefix-sum (1-D delta), `0x34FB` prefix-sum twice (2-D delta).

**Numbers** (`SQgetnum`): if the next bit is 1, read 3 bits and subtract 4 (values 0–3). Otherwise
count k leading zeros up to a 1 (consuming them and the 1), set n = k + 2, read n bits: value
`bits + 2^n − 4`. (The retail decoder has a second slow path for 16+ leading zeros that computes n one
larger; it never triggers on retail data.)

## B-tree (pair substitution) ★★★
Header: `0x46FB` (or `0x47FB` + 3 extra bytes), 3-byte big-endian unpacked size, then:
`u8 escape`, `u8 nodeCount`, `nodeCount × {u8 code, u8 left, u8 right}`.
Stream: read a byte c —
- ordinary byte: output c;
- `escape`: read the next byte; 0 = end of stream, otherwise output it literally;
- a node code: expand `left` then `right` recursively (children may themselves be nodes).

## Retail census ★★★
Every packed file on the NFS4 disc decodes to exactly its header size with `tools/nfs4_codecs.py`:

| Codec | Files | Content check |
|-------|-------|---------------|
| Huffman `0x30FB` | 29 `.QDA` (car data) | sizes |
| Huffman `0x32FB` | 10 `.QBE`, 10 `.QCR`, 29 `.QCS` | racing lines smooth (max step 12); curve-speed tables fall with curvature (16 have a single +1 round-off) |
| B-tree `0x46FB` | 22 `.QPS` | all decode to valid `SHPP` shape files |

NFS3's 25 `.QPS` (`ZLOADT*` track and `ZLOADC*` car loading pictures) are RefPack `0x10FB` and decode to `SHPP`
too (197,672 / 308,696 bytes) with the same tool.

The older `C:\Temp\_from_github\pcsx-redux\nfs4\unhuff_port.py` fails on these files; use
`tools/nfs4_codecs.py`.
