/* syslib/psx/libmath/DBSHIFTU.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays, fresh NFS4.EXE.i64).
 *   obj DBSHIFTU.obj ; libmath.lib.  _dbl_shift_us @0x801048E8 (188 B) -- (unsigned variant) shift a 64-bit value [w0:w1] by
 *   `count` bits: right when dir!=0, left when dir==0; result -> out[0..1].  Soft-float mantissa primitive.
 */
extern "C" unsigned int *_dbl_shift_us(unsigned int *out, int dir, unsigned int w0, int w1, int count) /* @0x801048E8 */
{
    if (dir) {
        for (int i = 0; i < count; i++) {
            unsigned int v = w0 >> 1;
            w0 >>= 1;
            if (w1 & 1) w0 = v | 0x80000000;
            w1 >>= 1;
        }
    } else {
        for (int j = 0; j < count; j++) {
            int v = 2 * w1;
            w1 *= 2;
            if (w0 & 0x80000000) w1 = v | 1;
            w0 *= 2;
        }
    }
    out[0] = w0;
    out[1] = w1;
    return out;
}
