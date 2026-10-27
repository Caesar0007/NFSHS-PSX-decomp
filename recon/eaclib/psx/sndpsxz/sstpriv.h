#ifndef _SNDPSXZ_SSTPRIV_H_
#define _SNDPSXZ_SSTPRIV_H_

/* Private stream-object records shared by the SST implementation and the
 * library's stream-API wrappers.  This is not a public/game-facing header. */
#include "../../../shared/SNDPLAYOPTS.h"
#include "sndattrpriv.h"
#include "sndfmtpriv.h"

typedef struct SNDPLAYOPTS SNDPLAYOPTS;

/* SST.OBJ's private type graph is stripped.  The matching NFS3/NFS4-PC
 * streamer preserves these request-field roles; PSX accesses independently
 * establish the offsets and record size. */
typedef struct SndStreamReq {
    unsigned int stream_request_id; /* +0x00: STREAM_queuefile/queuemem result */
    unsigned int request_id;        /* +0x04: request counter | stream slot */
    int firstqid;                   /* +0x08: first submitted packet id; -1 before first submit */
    int qid;                        /* +0x0C: latest SNDPKTPLAY_submit result */
    int data_rate;                  /* +0x10 */
    int bytes_consumed;             /* +0x14 */
    int total_size;                 /* +0x18 */
    int remaining_bytes;            /* +0x1C */
    int submitted;                  /* +0x20 */
    int num_chunks;                 /* +0x24 */
    short hold_threshold;           /* +0x28: negative is a sentinel; positive values are byte thresholds */
    short pad2a;                    /* +0x2A */
} SndStreamReq;
typedef char SndStreamReq_size_check[(sizeof(SndStreamReq) == 0x2c) ? 1 : -1];

/* The common chunk prefix is 0x10 bytes; parser APIs use this view only for its shared header/value fields,
 * then switch to byte pointers for variable payload offsets. At +0x0C, SCCl/SCDl carry different values. */
typedef union SndStreamChunkValue {
    int chunk_count; /* SCCl */
    int data_size;   /* SCDl */
} SndStreamChunkValue;

typedef struct SndStreamChunkHeaderPrefix {
    unsigned char opaque_00_0B[0x0C];
    SndStreamChunkValue value;
} SndStreamChunkHeaderPrefix;
typedef char SndStreamChunkHeaderPrefix_size_check[(sizeof(SndStreamChunkHeaderPrefix) == 0x10) ? 1 : -1];

/* Private one-slot stream object. Its 0x60 stride and field offsets follow
 * PSX accesses and aggregate copies; format views remain interleaved. */
typedef struct SndStream {
    SndStreamReq *requests;        /* +0x00 */
    int stream_handle;             /* +0x04 */
    int start_result;              /* +0x08 */
    int packet_player;             /* +0x0C */
    int request_counter;           /* +0x10 */
    unsigned char state;           /* +0x14 */
    unsigned char max_requests;    /* +0x15 */
    unsigned char current_count;   /* +0x16 */
    unsigned char parse_index;     /* +0x17 */
    unsigned char external_stream; /* +0x18 */
    unsigned char pad19[3];        /* +0x19..+0x1B */
    SNDSAMPLEFORMAT locked_rate;   /* +0x1C */
    SNDSAMPLEFORMAT current_rate;  /* +0x20 */
    SndPatchAttributes locked_header; /* +0x24: decoded patch attributes */
    SndPatchAttributes current_header;/* +0x38: decoded patch attributes */
    SNDPLAYOPTS start_params;      /* +0x4C..+0x5F: play options for SNDPKTPLAY_start */
} SndStream;
typedef char SndStream_size_check[(sizeof(SndStream) == 0x60) ? 1 : -1];

#endif /* _SNDPSXZ_SSTPRIV_H_ */
