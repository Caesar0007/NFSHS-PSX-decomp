/* trnsfrm_private.h -- trnsfrm.obj internals: the private 3-vector result (trnsfrm.c only).
 * Game and frontend code include the public trnsfrm.h only. */
#ifndef _TRNSFRM_PRIVATE_H_
#define _TRNSFRM_PRIVATE_H_

#include "trnsfrm.h"

/* trnsfrm.obj's private 3-vector result (transform writes it back through an
 * int* out-param of the same size). */
typedef struct {
    int x, y, z;
} TransformResult;

#endif
