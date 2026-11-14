/* nfs4_core_3_cd_d1 -- moved verbatim out of nfs4_core_3_cd.h so that header holds only its include list. */
#ifndef NFS4_NFS4_CORE_3_CD_D1_H
#define NFS4_NFS4_CORE_3_CD_D1_H
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
