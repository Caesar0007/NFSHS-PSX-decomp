#ifndef DECOMP_TYPES_H
#define DECOMP_TYPES_H

/* Fixed-width integer aliases (PSX / Silent-Hill-decomp convention). */
typedef signed char        s8;
typedef unsigned char      u8;
typedef signed short       s16;
typedef unsigned short     u16;
typedef signed int         s32;
typedef unsigned int       u32;
typedef signed long long   s64;
typedef unsigned long long u64;
typedef float              f32;
typedef double             f64;

typedef signed char        byte;

/* PsyQ-style aliases (the original source used these). */
typedef unsigned char      u_char;
typedef unsigned short     u_short;
typedef unsigned int       u_int;
typedef unsigned long      u_long;

/* Q-format fixed point (NFS4 is Q12-heavy in physics/camera). */
typedef signed short       q3_12;   /* 1.3.12 */
typedef signed int         q19_12;  /* 1.19.12 */
typedef signed int         q23_8;   /* 1.23.8 */

#ifndef __cplusplus
typedef enum { false, true } bool;
#endif

#ifndef NULL
#define NULL ((void *)0)
#endif

#endif /* DECOMP_TYPES_H */
