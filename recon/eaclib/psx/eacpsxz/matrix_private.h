/* matrix_private.h -- matrix.obj internals: the struct-assignment matrix alias (matrix.c only).
 * Game and frontend code include the public matrix.h only. */
#ifndef _MATRIX_PRIVATE_H_
#define _MATRIX_PRIVATE_H_

#include "matrix.h"

/* 36-byte matrix as a STRUCT: the oracle's 4-word/iter copy loops (+1-word tail, end-ptr
 * compare vs base+0x20) are gcc's movstrsi block-move expansion of STRUCT ASSIGNMENTS --
 * per-element copy loops do NOT emit this shape. */
typedef matrixtdef mtx;

#endif
