/* syslib/psx/libpress/VLC.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libpress.lib(VLC.OBJ): the MDEC variable-length-code (Huffman/RLE) bit-stream decoder.
 *   DecDCTvlc unpacks a compressed coefficient stream into MDEC run/level format; it is a
 *   table-driven, resumable decoder -- pass a non-null `bs` to start a frame, or null to
 *   continue from the saved state, returning 1 when more output is pending and 0 at end.
 *
 *   The lookup tables are large const rodata (the AC primary table alone is 64 KB); they live in
 *   the binary at the addresses below and are pulled in by the data-materialization pass (the
 *   decoder logic indexes them exactly as the original does, single base + computed offset):
 *     _vlc_ac     @0x80124038 : AC primary table, 8192 entries x 8 bytes {u_int code; u_int extra}
 *     _vlc_acesc  @0x80123C38 : AC escape table,  512 entries x 4 bytes (code)
 *     _vlc_dc     @0x80134038 : DC magnitude tables (luma + chroma), 256 entries x 4 bytes each */

typedef unsigned long  u_long;
typedef unsigned int   u_int;
typedef unsigned short u_short;

extern const u_int   _vlc_ac[];      /* @0x80124038 */
extern const u_int   _vlc_acesc[];   /* @0x80123C38 (= _vlc_ac - 0x400) */
extern const u_short _vlc_dc_l[];    /* @0x80134xxx : luma DC table */
extern const u_short _vlc_dc_c[];    /* @0x80134xxx : chroma DC table */

/* ---- resumable decoder state (saved/restored when DecDCTvlc is called with bs == 0) ---- */
static int      _vlc_blksize = 0xffffff;  /* @0x801369E8 : output cells per slice */
static u_short *_vlc_rd;                   /* @0x801369EC : bit-stream read pointer  */
static u_short *_vlc_wr;                    /* @0x801369F0 : output write pointer      */
static u_int    _vlc_acc;                   /* @0x801369F4 : bit accumulator           */
static int      _vlc_bit;                   /* @0x801369F8 : bits buffered             */
static int      _vlc_q;                     /* @0x801369FC : quant-scale field (<<10)  */
static u_int    _vlc_blk;                   /* @0x80136A00 : block index 0..5          */
static int      _vlc_dc0, _vlc_dc1, _vlc_dc2; /* @0x80136A04/08/0C : DC predictors     */
static u_short *_vlc_end;                    /* @0x80136A10 : output slice end          */

/* @0x800F7400 : set the per-slice output size (in cells); returns the previous value. */
extern "C" int DecDCTvlcSize(int size)
{
    int prev = _vlc_blksize;
    if (size - 1 > 0) _vlc_blksize = size << 1;
    else              _vlc_blksize = 0xffffff;
    return prev;
}

/* @0x800F7430 : decode one slice of the MDEC bit-stream into run/level cells. */
extern "C" int DecDCTvlc(u_int *bs, u_int *buf)
{
    u_short *rd, *wr, *slice_end;
    u_int   acc, code, extra, saved;
    int     bit, qf;
    u_int   blk;
    int     dc0, dc1, dc2;
    u_short *blk0;

    if (bs != 0) {
        dc0 = 0; dc1 = 0; dc2 = 0;
        slice_end = (u_short *)((char *)buf + _vlc_blksize * 2);
        acc = *bs;
        qf  = (u_int)(u_short)bs[1] << 10;
        blk = (u_int)(-1 < (int)(*(u_short *)((char *)bs + 6) - 3));
        rd  = (u_short *)(bs + 3);
        bit = 0;
        *buf = acc;
        _vlc_end = (u_short *)(buf + (acc & 0xffff) + 1);
        wr = (u_short *)((char *)buf + 2);
        extra = 0;
        saved = ((u_int)(u_short)bs[2] << 16) | *(u_short *)((char *)bs + 10);
        goto coef;
    }
    slice_end = _vlc_wr + _vlc_blksize;
    acc = _vlc_acc;
    bit = _vlc_bit;
    rd  = _vlc_rd;
    wr  = _vlc_wr;
    qf  = _vlc_q;
    blk = _vlc_blk;
    dc0 = _vlc_dc0;
    dc1 = _vlc_dc1;
    dc2 = _vlc_dc2;

next_run:
    for (;;) {
        for (;;) {
            blk0 = wr;
            code = _vlc_ac[(acc >> 0x13) * 2];
            if (code == 0) {
                acc <<= 8;
                { int t = bit + 8; bit = t & 0xf;
                  if (t & 0x10) { acc |= (u_int)(u_short)*rd++ << bit; } }
                code  = _vlc_acesc[(acc >> 0x17)];
                extra = 0;
            } else {
                extra = _vlc_ac[(acc >> 0x13) * 2 + 1];
            }
            acc <<= (code & 0x1f);
            { int t = bit + (code & 0xff); bit = t & 0xf;
              if (t & 0x10) { acc |= (u_int)(u_short)*rd++ << bit; } }
            wr = blk0;
            if (code >> 0x10 != 0x7c1f) break;
escape16:
            *wr = (short)(acc >> 0x10);
            acc = acc << 0x10 | (u_int)(u_short)*rd++ << bit;
            wr = blk0 + 1;
        }
        *blk0 = (short)(code >> 0x10);
        {
            saved = acc;
            if (code >> 0x10 != 0xfe00) {
                wr = blk0 + 1;
                if (extra == 0) goto next_run;
                if ((extra & 0xffff) == 0x7c1f) goto escape16;
                *wr = (short)extra;
                if ((extra & 0xffff) != 0xfe00) {
                    code = extra >> 0x10;
                    wr = blk0 + 2;
                    if (code == 0) goto next_run;
                    if (code == 0x7c1f) goto escape16;
                    *wr = (short)(extra >> 0x10);
                    if (code != 0xfe00) { wr = blk0 + 3; goto next_run; }
                }
            }
coef:       /* end-of-block: emit the DC / block header for the next block */
            if (blk == 0) {
                if (saved >> 0x16 == 0x1ff) goto last;
                acc = saved << 10;
                { int t = bit + 10; bit = t & 0xf;
                  if (t & 0x10) { acc |= (u_int)(u_short)*rd++ << bit; } }
                wr[1] = (u_short)qf | (u_short)(saved >> 0x16);
            } else {
                if (saved >> 0x16 == 0x3ff) {
last:
                    while (wr = wr + 1, (int)((char *)wr - (char *)_vlc_end) < 0)
                        *wr = 0xfe00;
                    return 0;
                }
                const u_short *dct = (blk >= 3) ? _vlc_dc_l : _vlc_dc_c;
                u_int clen = dct[(saved >> 0x18) * 2];
                u_int dlen = dct[(saved >> 0x18) * 2 + 1];
                u_int diff = 0;
                acc = saved << (clen & 0x1f);
                if (dlen != 0) {
                    diff = acc >> ((0x20 - dlen) & 0x1f);
                    int neg = (int)acc >= 0;
                    acc <<= (dlen & 0x1f);
                    if (neg) diff -= (0xffffffffu >> ((0x20 - dlen) & 0x1f));
                    bit += dlen;
                }
                { int t = bit + clen; bit = t & 0xf;
                  if (t & 0x10) { acc |= (u_int)(u_short)*rd++ << bit; } }
                u_int dc;
                if ((int)(blk - 2) < 1) {           /* Cr / Cb */
                    if (blk == 2) { dc1 += diff; dc = dc1; }
                    else          { dc0 += diff; dc = dc0; }
                } else {                              /* Y0..Y3 */
                    dc2 += diff; dc = dc2;
                }
                bool wrap = (blk == 6);
                wr[1] = (u_short)qf | (u_short)((dc & 0xff) << 2);
                blk = wrap ? 1 : blk + 1;
            }
        }
        wr = wr + 2;
        if (-1 < (int)((char *)wr - (char *)slice_end)) {
            _vlc_rd = rd; _vlc_wr = wr; _vlc_acc = acc; _vlc_bit = bit;
            _vlc_q = qf; _vlc_blk = blk;
            _vlc_dc0 = dc0; _vlc_dc1 = dc1; _vlc_dc2 = dc2;
            return 1;
        }
    }
}
