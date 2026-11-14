/* night_types_d1 -- moved verbatim out of night_types.h so that header holds only its include list. */
#ifndef NFS4_NIGHT_TYPES_D1_H
#define NFS4_NIGHT_TYPES_D1_H
struct tCompRGB { char r, g, b; };
struct tNightInitCache { tCompRGB table[257]; };
#endif
