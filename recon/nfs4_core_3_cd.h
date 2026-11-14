/* root type graph, part 3 of 5 (cut from nfs4_types.h at its order hooks) */
#ifndef NFS4_CORE_3_CD_H
#define NFS4_CORE_3_CD_H
#ifndef NFS4_PSYQ_DDV_TYPES   /* (continued) */

/* NFS4_EAC_OLD_TYPES: the older EA/PsyQ header revision seen by the FRONTEND\PSX library objects (cache.obj):
 * no CD-stream block, no wchar_t / file / thread typedefs, MEMBLOCK before VOIDFN (retail cache.obj SYM block). */
#ifndef NFS4_EAC_OLD_TYPES
struct cdstreamstruct {
    long id;
    char *start, *end, *write, *header, *get, *release;
    int  handle, state, control, status, abort, datahascrc;
    int  crcerrors, crcretries, buffersize;
    long blocksize;
    int  readsize, chunksize, relocationsize;
    long fileoffset;
    int  fileend;
    long filesize;
    int  dataoffset, seekposition, seekoffset, idtype, idmask;
    struct cdstreamstruct *nextstream;
    void *emptyblock, *head, *tail, *block;  int  timer, blocktime, streamfull, getable, releaseable;
};
typedef struct cdstreamstruct CDSTREAM;
#endif
#endif   /* (block continues in the next part) */
#endif
