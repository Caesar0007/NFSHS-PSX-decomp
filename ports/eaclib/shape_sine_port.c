/* Portable raw-format accessors and exact retail integer sine table. */
#include "../include/nfs4_eac_port.h"
#include <stddef.h>

static uint32_t read_le32(const uint8_t *bytes)
{
    return bytes[0] | ((uint32_t)bytes[1] << 8) | ((uint32_t)bytes[2] << 16)
        | ((uint32_t)bytes[3] << 24);
}

/* SHPSUBS.ASM @800F0AAC/800F0AB8/800F0AE0. Requires a valid shape directory
 * and offsets inside its allocated file; invalid index is defined by retail. */
uint32_t nfs4_shapecount(const uint8_t *file) { return read_le32(file + 8); }
const uint8_t *nfs4_shapepointer(const uint8_t *file, uint32_t index)
{
    if (index >= nfs4_shapecount(file)) return NULL;
    return file + read_le32(file + 20 + (size_t)index * 8);
}
void nfs4_shapename(const uint8_t *file, uint32_t index, uint8_t name[4])
{
    const uint32_t value = index < nfs4_shapecount(file)
        ? read_le32(file + 16 + (size_t)index * 8) : 0u;
    unsigned i;
    for (i = 0; i < 4; ++i) name[i] = (uint8_t)(value >> (i * 8));
}

/* SINFUNC.ASM intsin @800F18E8, intcos @800F18E4 (fall-through entry).
 * Table @80137464, 257 signed 16.16 samples, copied from retail data.
 * Full circle is 1024 units; preserve quantization rather than calling libm. */
static const uint32_t quarter_sine[257] = {
    0,402,804,1206,1608,2010,2412,2814,
    3215,3617,4018,4420,4821,5222,5622,6023,
    6423,6823,7223,7623,8022,8421,8819,9218,
    9616,10013,10410,10807,11204,11600,11995,12390,
    12785,13179,13573,13966,14359,14751,15142,15533,
    15923,16313,16702,17091,17479,17866,18253,18638,
    19024,19408,19792,20175,20557,20938,21319,21699,
    22078,22456,22833,23210,23586,23960,24334,24707,
    25079,25450,25820,26189,26557,26925,27291,27656,
    28020,28383,28745,29105,29465,29824,30181,30538,
    30893,31247,31600,31952,32302,32651,32999,33346,
    33692,34036,34379,34721,35061,35400,35738,36074,
    36409,36743,37075,37406,37736,38064,38390,38716,
    39039,39361,39682,40002,40319,40636,40950,41263,
    41575,41885,42194,42501,42806,43110,43412,43712,
    44011,44308,44603,44897,45189,45480,45768,46055,
    46340,46624,46906,47186,47464,47740,48015,48288,
    48558,48828,49095,49360,49624,49886,50145,50403,
    50659,50914,51166,51416,51665,51911,52155,52398,
    52639,52877,53114,53348,53581,53811,54040,54266,
    54491,54713,54933,55152,55368,55582,55794,56004,
    56212,56417,56621,56822,57022,57219,57414,57606,
    57797,57986,58172,58356,58538,58718,58895,59070,
    59243,59414,59583,59749,59913,60075,60235,60392,
    60547,60700,60850,60998,61144,61288,61429,61568,
    61705,61839,61971,62100,62228,62353,62475,62596,
    62714,62829,62942,63053,63162,63268,63371,63473,
    63571,63668,63762,63854,63943,64030,64114,64197,
    64276,64353,64428,64501,64571,64638,64703,64766,
    64826,64884,64939,64992,65043,65091,65136,65179,
    65220,65258,65294,65327,65358,65386,65412,65436,
    65457,65475,65491,65505,65516,65524,65531,65534,65536
};
uint32_t nfs4_intsin(uint32_t angle)
{
    const unsigned quadrant = (angle >> 8) & 3u;
    unsigned index = angle & 255u;
    uint32_t value;
    if (quadrant & 1u) index = 256u - index;
    value = quarter_sine[index];
    return (quadrant & 2u) ? 0u - value : value;
}
uint32_t nfs4_intcos(uint32_t angle) { return nfs4_intsin(angle + 256u); }

/* NULLFUNC.ASM @800F6114: shared body for the 21 co-equal release aliases.
 * Argument signatures vary; this models the result, not invented prototypes. */
uint32_t nfs4_null_result(void) { return 0; }
