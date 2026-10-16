/* Portable behavioral reconstructions, not byte-matching replacements.
 * Fixed-width arithmetic, explicit PSX endian operations, no assembly.
 * See ../README.md for RAM/exception contracts and differential evidence. */
#include "../include/nfs4_eac_port.h"
#include <limits.h>
#include <stddef.h>
#include <string.h>

static uint32_t asr32(uint32_t value, unsigned shift)
{
    shift &= 31u;
    if (shift == 0) return value;
    return (value >> shift) | ((value & UINT32_C(0x80000000))
        ? (UINT32_MAX << (32u - shift)) : 0u);
}

/* blockfill @800F17A4 / blockclear @800F17A0. Ordinary RAM buffers only. */
void nfs4_blockfill(void *dst, int32_t count, uint32_t value)
{
    if (count > 0) memset(dst, (uint8_t)value, (size_t)count);
}
void nfs4_blockclear(void *dst, int32_t count) { nfs4_blockfill(dst, count, 0); }

/* blockmove @800E62DC: source first, overlap-safe in either direction. */
void nfs4_blockmove(const void *src, void *dst, int32_t count)
{
    if (count > 0) memmove(dst, src, (size_t)count);
}

/* fixedmult / rmult @800E4328. Round bias is positive even for negative products. */
uint32_t nfs4_fixedmult(int32_t a, int32_t b)
{
    const int64_t product = (int64_t)a * b + INT64_C(0x8000);
    return (uint32_t)((uint64_t)product >> 16);
}

/* fixeddiv / rdiv @800E4404. The overflow-aware fractional recurrence is
 * literal retail behavior; replacing it with int64 division is not assumed. */
nfs4_arithmetic_result nfs4_fixeddiv(int32_t a, int32_t b)
{
    nfs4_arithmetic_result result = {0, 0};
    const uint32_t sign = ((uint32_t)a ^ (uint32_t)b) >> 31;
    const uint32_t magnitude_a = a < 0 ? 0u - (uint32_t)a : (uint32_t)a;
    uint32_t denominator = b < 0 ? 0u - (uint32_t)b : (uint32_t)b;
    uint32_t remainder, quotient, bit;
    if (denominator == 0) return result;
    remainder = magnitude_a % denominator;
    quotient = (magnitude_a / denominator) << 16;
    bit = UINT32_C(0x10000);
    remainder <<= 1;
    for (;;) {
        const uint32_t shift_denominator = remainder >> 31;
        bit >>= 1;
        if (remainder >= denominator) {
            quotient |= bit;
            remainder -= denominator;
        }
        if (shift_denominator) denominator >>= 1;
        else remainder <<= 1;
        if (bit == 1) break;
    }
    /* Retail reapplies the sign with trapping SUB, unlike normal SUBU. */
    result.overflow = sign && quotient == UINT32_C(0x80000000);
    result.bits = sign ? 0u - quotient : quotient;
    return result;
}

/* fixedinverse / rinverse @800ED3EC, including raw DIVU's zero-divisor result.
 * The half-magnitude uses SRA, NOT a logical shift for magnitude 80000000. */
uint32_t nfs4_fixedinverse(int32_t x)
{
    const uint32_t sign = x < 0 ? UINT32_MAX : 0;
    const uint32_t magnitude = ((uint32_t)x ^ sign) - sign;
    uint32_t quotient = magnitude ? UINT32_MAX / magnitude : UINT32_MAX;
    const uint32_t remainder = magnitude ? UINT32_MAX % magnitude : UINT32_MAX;
    quotient += asr32(magnitude, 1) < remainder;
    return (quotient ^ sign) - sign;
}

/* fixedsqrt @800EB0AC. Retail's approximation tables, not a mathematical sqrt.
 * Exact data windows: scale 801234EC, offset 80123570. */
static const int32_t sqrt_scale[32] = {
    6949350,4913933,3474675,2456966,1737338,1228483,868669,614242,
    434334,307121,217167,153560,108584,76780,54292,38390,
    27146,19195,13573,9598,6786,4799,3393,2399,
    1697,1200,848,600,424,300,212,150
};
static const uint32_t sqrt_offset[32] = {
    152,215,304,430,608,860,1217,1721,
    2433,3441,4867,6883,9734,13765,19467,27531,
    38934,55061,77868,110122,155736,220244,311472,440488,
    622945,880977,1245890,1761954,2491779,3523908,4983558,7047816
};
uint32_t nfs4_fixedsqrt(int32_t x)
{
    unsigned bit = 31;
    uint32_t mask = UINT32_C(0x80000000);
    int64_t product;
    if (x == 0) return 0;
    while (((uint32_t)x & mask) == 0) { mask >>= 1; --bit; }
    product = (int64_t)x * sqrt_scale[bit];
    return (uint32_t)((uint64_t)product >> 16) + sqrt_offset[bit];
}

/* seedrandom @800E7878 / random @800E77A8. Explicit caller-owned state
 * replaces PSX global seed[6] @8012349C, permitting independent port contexts. */
void nfs4_seedrandom(nfs4_random_state *state, uint32_t seed)
{
    static const uint32_t increments[6] = {
        UINT32_C(0xF22D0E56),UINT32_C(0x96041893),UINT32_C(0x3DF3B646),
        UINT32_C(0x40DDE76D),UINT32_C(0x97327AE1),UINT32_C(0xD1A9FBE7)
    };
    unsigned i;
    for (i = 0; i < 6; ++i) { seed += increments[i]; state->words[i] = seed; }
}
uint32_t nfs4_random(nfs4_random_state *state)
{
    uint32_t carry = 0;
    int i;
    for (i = 4; i >= 0; --i) {
        const uint64_t sum = (uint64_t)state->words[i] + state->words[i+1] + carry;
        state->words[i] = (uint32_t)sum;
        carry = (uint32_t)(sum >> 32);
    }
    for (i = 5; i >= 0; --i) if (++state->words[i] != 0) break;
    return state->words[0];
}

/* crc16 @800F614C. Polynomial matches both raw 256-byte tables @80135C58.
 * Byte recurrence CRC-16/ARC, but with the retail initial value FBEA. */
uint32_t nfs4_crc16(const uint8_t *bytes, int32_t count)
{
    uint32_t crc = UINT32_C(0xFBEA);
    while (count > 0) {
        unsigned bit;
        --count;
        crc ^= *bytes++;
        for (bit = 0; bit < 8; ++bit)
            crc = (crc >> 1) ^ ((crc & 1u) ? UINT32_C(0xA001) : 0u);
    }
    return crc;
}

/* getm @800F3024. Values outside 1..4 use the same retail branch choices. */
uint32_t nfs4_getm(const uint8_t *bytes, int32_t count)
{
    const uint32_t minus3 = (uint32_t)count - 3u;
    unsigned n = (minus3 >> 31) ? (((uint32_t)count - 2u) >> 31 ? 1u : 2u)
        : minus3 == 0 ? 3u : 4u;
    uint32_t value = 0;
    unsigned i;
    for (i = 0; i < n; ++i) value = (value << 8) | bytes[i];
    return value;
}

/* geti @800F308C always reads FOUR LE bytes; shifts are MIPS masked counts. */
uint32_t nfs4_geti(const uint8_t *bytes, uint32_t count)
{
    const uint32_t word = bytes[0] | ((uint32_t)bytes[1] << 8)
        | ((uint32_t)bytes[2] << 16) | ((uint32_t)bytes[3] << 24);
    const unsigned shift = (32u - count * 8u) & 31u;
    return (word << shift) >> shift;
}

/* make64 @800FE488. out order is LOW then HIGH; shifts >=32 wrap modulo32.
 * ADDI shift-32 executes even on the <=0 arm, and can trap. */
uint32_t nfs4_make64(uint32_t out[2], int32_t value, int32_t shift)
{
    if (shift < INT32_MIN + 32) return 1;
    if (shift >= 32) {
        out[0] = 0; out[1] = (uint32_t)value << ((uint32_t)(shift - 32) & 31u);
    } else if (shift > 0) {
        out[0] = (uint32_t)value << (unsigned)shift;
        out[1] = asr32((uint32_t)value, 32u - (unsigned)shift);
    } else {
        out[0] = (uint32_t)value; out[1] = asr32((uint32_t)value, 31);
    }
    return 0;
}

/* divu64 @800FE4E0. The initial lo is the running remainder, not the low
 * half of an ordinary uint64 numerator. Preserve wraparound before compare. */
uint32_t nfs4_divu64(uint32_t hi, uint32_t lo, uint32_t denominator)
{
    uint32_t quotient = 0;
    unsigned i;
    for (i = 0; i < 32; ++i) {
        quotient <<= 1;
        lo = (lo << 1) + (hi >> 31);
        hi <<= 1;
        if (lo >= denominator) { lo -= denominator; ++quotient; }
    }
    return quotient;
}

/* shapedepth @800F43E4. Input is the format byte, with flags masked out. */
int32_t nfs4_shapedepth(const uint8_t *shape)
{
    switch (*shape & 0x77u) {
    case 0x40: return 4;
    case 0x41: case 0x72: return 8;
    case 0x42: case 0x23: return 16;
    case 0x43: return 24;
    default: return 1;
    }
}

/* initgp/savegp/restoregp @800EB080/800EB090/800EB0A4. Native platforms
 * have no PSX $gp. Model the observable ABI context instead of empty stubs. */
void nfs4_initgp(nfs4_gp_context *context) { context->boot_gp = context->current_gp; }
void nfs4_savegp(nfs4_gp_context *context, uint32_t *saved)
{ *saved = context->current_gp; context->current_gp = context->boot_gp; }
void nfs4_restoregp(nfs4_gp_context *context, uint32_t saved) { context->current_gp = saved; }
