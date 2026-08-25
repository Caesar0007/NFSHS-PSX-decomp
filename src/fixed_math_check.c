#include "fixed_math_check.h"

#define PSX_ABS(x) ((x) < 0 ? -(x) : (x))

bool psx_validate_matrix_orthogonality(const int16_t matrix[3][3], int32_t tolerance)
{
    if (!matrix) {
        return false;
    }

    if (tolerance <= 0) {
        tolerance = 64; /* ~1.5% fixed point tolerance */
    }

    for (int i = 0; i < 3; i++) {
        /* Dot product of row with itself should equal PSX_ONE_FIXED^2 */
        int32_t dot = ((int32_t)matrix[i][0] * matrix[i][0] +
                       (int32_t)matrix[i][1] * matrix[i][1] +
                       (int32_t)matrix[i][2] * matrix[i][2]) >> 12;

        if (PSX_ABS(dot - PSX_ONE_FIXED) > tolerance) {
            return false;
        }
    }

    return true;
}
