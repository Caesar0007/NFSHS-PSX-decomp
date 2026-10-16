#ifndef NFS4_EAC_PORT_H
#define NFS4_EAC_PORT_H

#include <stdint.h>

/* A MIPS trapping operation is a result, not host-language undefined behavior. */
typedef struct nfs4_arithmetic_result {
    uint32_t bits;
    uint32_t overflow;
} nfs4_arithmetic_result;

typedef struct nfs4_random_state { uint32_t words[6]; } nfs4_random_state;
typedef struct nfs4_gp_context { uint32_t boot_gp, current_gp; } nfs4_gp_context;

void nfs4_blockfill(void *dst, int32_t count, uint32_t value);
void nfs4_blockclear(void *dst, int32_t count);
void nfs4_blockmove(const void *src, void *dst, int32_t count);
uint32_t nfs4_fixedmult(int32_t a, int32_t b);
nfs4_arithmetic_result nfs4_fixeddiv(int32_t a, int32_t b);
uint32_t nfs4_fixedinverse(int32_t x);
uint32_t nfs4_fixedsqrt(int32_t x);
void nfs4_seedrandom(nfs4_random_state *state, uint32_t seed);
uint32_t nfs4_random(nfs4_random_state *state);
uint32_t nfs4_crc16(const uint8_t *bytes, int32_t count);
uint32_t nfs4_getm(const uint8_t *bytes, int32_t count);
uint32_t nfs4_geti(const uint8_t *bytes, uint32_t count);
/* Returns 1 for the retail ADDI overflow domain; leaves out untouched then. */
uint32_t nfs4_make64(uint32_t out[2], int32_t value, int32_t shift);
/* Preserves the retail bit recurrence, even outside normal division inputs. */
uint32_t nfs4_divu64(uint32_t hi, uint32_t lo, uint32_t denominator);
int32_t nfs4_shapedepth(const uint8_t *shape);
uint32_t nfs4_shapecount(const uint8_t *file);
const uint8_t *nfs4_shapepointer(const uint8_t *file, uint32_t index);
void nfs4_shapename(const uint8_t *file, uint32_t index, uint8_t name[4]);
uint32_t nfs4_intsin(uint32_t angle);
uint32_t nfs4_intcos(uint32_t angle);
uint32_t nfs4_null_result(void);
void nfs4_initgp(nfs4_gp_context *context);
void nfs4_savegp(nfs4_gp_context *context, uint32_t *saved);
void nfs4_restoregp(nfs4_gp_context *context, uint32_t saved);

/* Co-equal retail entry labels; ports need no compiler-specific alias attribute. */
#define nfs4_rmult nfs4_fixedmult
#define nfs4_rdiv nfs4_fixeddiv
#define nfs4_rinverse nfs4_fixedinverse
#define nfs4_fastintsin nfs4_intsin
#define nfs4_fastintcos nfs4_intcos

#endif
