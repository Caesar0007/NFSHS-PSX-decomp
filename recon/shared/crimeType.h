/* crimeType -- the one definition of this type (moved verbatim from game/common/aih_hierarchy_types.h;
   every copy now includes this file; retail declares it next to its first user). */
#ifndef NFS4_SHARED_CRIMETYPE_H
#define NFS4_SHARED_CRIMETYPE_H

#ifdef NFS4_CRIMETYPE_PLAIN_ENUM   /* aidebug.obj: plain C++ enum; its TPDEF is the field re-emission */
enum crimeType {
#else
enum crimeType {
#endif
    CRIME_NONE = 0,
    CRIME_SPEEDER = 1,
    CRIME_WRONGSIDE = 2,
    CRIME_BUMPCOP = 3,
    CRIME_SMASHCOP = 4
#ifdef NFS4_CRIMETYPE_PLAIN_ENUM
};
#else
};
#endif
#endif
