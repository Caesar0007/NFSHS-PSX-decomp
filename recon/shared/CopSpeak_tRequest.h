/* CopSpeak_tRequest -- the one definition of this type (moved verbatim from game/common/audiocmn_types.h; retail places it
   after tfrontEnd in audiocmn.obj and right after Car_tObj in copspeak.obj). */
#ifndef NFS4_SHARED_COPSPEAK_TREQUEST_H
#define NFS4_SHARED_COPSPEAK_TREQUEST_H

typedef struct {
    Car_tObj *car;
    int buffer, offset, size, filehandle, ophandle, phrase;
    char player, sfx;
    /* P879: retail bank accesses/invalid sentinel are signed. Native CHAR
       encodes both char spellings; this restores the access contract, not
       an unprovable original keyword/flag choice. Layout stays byte +30. */
    signed char bank;
    char noise;
} CopSpeak_tRequest;
#endif
