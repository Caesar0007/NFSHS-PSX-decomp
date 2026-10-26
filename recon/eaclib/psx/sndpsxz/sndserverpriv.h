/* Private overlay for shared sndgs output-configuration and audio-server/client state. */
#ifndef _SNDPSXZ_SNDSERVERPRIV_H_
#define _SNDPSXZ_SNDSERVERPRIV_H_

union SndServerHalfwordView {
    volatile unsigned short u;
    volatile short s;
};
typedef char SndServerHalfwordView_size_check[(sizeof(union SndServerHalfwordView) == 2) ? 1 : -1];

union SndServerClientCountView {
    signed char s;
    unsigned char u;
};
typedef char SndServerClientCountView_size_check[(sizeof(union SndServerClientCountView) == 1) ? 1 : -1];

/* sndgs overlay assembled from output-capability initialization, snd_globals.h, and server/client call sites. */
struct SndBankTableEntry;
struct SndChannel;

struct SndGlobalServerStateView {
    unsigned short sample_rate_00;                /* +0x00; defaulted to 44.1 kHz */
    unsigned short sample_rate_02;                /* +0x02; defaulted to 44.1 kHz */
    unsigned char min_output_mode;                /* +0x04; lower clamp in outputset */
    unsigned char max_output_mode;                /* +0x05; upper clamp in outputset */
    unsigned char voice_limit;                    /* +0x06; defaulted to 24 */
    unsigned char opaque_007_009[3];
    unsigned char opaque_00A_00B[2];
    unsigned short bank_count;                    /* +0x0C */
    unsigned short sample_rate_0E;                /* +0x0E; defaulted to 44.1 kHz */
    unsigned char output_mode;                    /* +0x10 */
    unsigned char channel_count;                  /* +0x11 */
    unsigned char opaque_012_014[3];
    unsigned char opaque_015_03B[0x27];
    signed char initialized;                      /* +0x3C */
    signed char master_volume;                    /* +0x3D */
    volatile unsigned char in_server;             /* +0x3E */
    unsigned char audio_lock_depth;               /* +0x3F */
    union SndServerClientCountView client_100hz_count; /* +0x40 */
    union SndServerClientCountView service_client_count; /* +0x41 */
    unsigned char opaque_042_043[2];
    int tick_count;                               /* +0x44 */
    void (*server_callback)(void);                /* +0x48 */
    void (*client_100hz_callbacks[6])(void);      /* +0x4C..+0x63 */
    void (*service_callbacks[12])(void);          /* +0x64..+0x93 */
    struct SndChannel *play_records;              /* +0x94 */
    struct SndBankTableEntry *bank_table;                               /* +0x98 */
    unsigned char opaque_09C_0AB[0x10];
    volatile int real_ticks;                      /* +0xAC */
    union SndServerHalfwordView timer_hz_cache;   /* +0xB0 */
    union SndServerHalfwordView deferred_requests; /* +0xB2 */
};
typedef char SndGlobalServerStateView_size_check[(sizeof(struct SndGlobalServerStateView) == 0xB4) ? 1 : -1];

/* Lifecycle hooks occupy bytes also viewed as service callback slots. Their signatures are
 * specific to the installed hooks; this overlay makes the observed aliases explicit without
 * treating the slots as one exclusive-purpose array. */
struct SndGlobalLifecycleHookView {
    unsigned char opaque_000_07B[0x7C];
    void (*bank_remove_hook)(int);             /* +0x7C */
    unsigned char opaque_080_087[8];
    int (*stream_destroy_all_hook)(void);      /* +0x88 */
};
typedef char SndGlobalLifecycleHookView_size_check[(sizeof(struct SndGlobalLifecycleHookView) == 0x8C) ? 1 : -1];

/* Exact-preserving cursor view: callers hold the current callback-slot stride from sndgs,
 * while this displacement exposes the service-client callback at +0x64. */
struct SndServerServiceClientCursorView {
    unsigned char opaque_000_063[0x64];
    void (*callback)(void);
};
typedef char SndServerServiceClientCursorView_size_check[(sizeof(struct SndServerServiceClientCursorView) == 0x68) ? 1 : -1];

/* iSND100hzserver walks a four-byte cursor from sndgs while the client callback is at +0x4C. */
struct SndServer100HzClientCursorView {
    unsigned char opaque_000_04B[0x4C];
    void (*callback)(void);
};
typedef char SndServer100HzClientCursorView_size_check[(sizeof(struct SndServer100HzClientCursorView) == 0x50) ? 1 : -1];

#endif /* _SNDPSXZ_SNDSERVERPRIV_H_ */
