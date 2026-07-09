/* syslib/psx/libgpu/P34.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P34.OBJ): SetDrawMove @0x8010C698.  Builds a DR_MOVE (frame-buffer
 *   block copy) primitive: copies rect (src x/y, w/h) to dest (x,y).  Length byte = 5 only
 *   when both w and h are non-zero (a degenerate rect produces a 0-length no-op).  RECT is
 *   {short x,y,w,h}: w/h are the shorts at +4/+6. */
extern void SetDrawMove(void *p, void *rect, int x, int y)   /* @0x8010C698 */
{
    int           *w = (int *)p;
    short         *r = (short *)rect;
    int len = 5;
    if (r[2] == 0 || r[3] == 0) len = 0;            /* r[2]=w, r[3]=h */
    w[1] = 0x01000000;
    w[2] = (int)0x80000000;
    ((unsigned char *)p)[3] = (unsigned char)len;
    w[4] = (y << 16) | (x & 0xffff);
    w[3] = ((int *)rect)[0];                        /* src x|y */
    w[5] = ((int *)rect)[1];                        /* src w|h */
}
