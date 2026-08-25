#ifndef NFSHS_FIXED_MATH_CHECK_H
#define NFSHS_FIXED_MATH_CHECK_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

#define PSX_ONE_FIXED (1 << 12) /* 4096 in Q12.4 fixed-point format */

/**
 * Validates that a 3x3 rotational transformation matrix preserves orthogonality
 * within acceptable PlayStation GTE fixed-point tolerance.
 */
bool psx_validate_matrix_orthogonality(const int16_t matrix[3][3], int32_t tolerance);

#ifdef __cplusplus
}
#endif

#endif /* NFSHS_FIXED_MATH_CHECK_H */
