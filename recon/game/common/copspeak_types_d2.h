/* copspeak_types_d2 -- moved verbatim out of copspeak_types.h so that header holds only its include list. */
#ifndef NFS4_COPSPEAK_TYPES_D2_H
#define NFS4_COPSPEAK_TYPES_D2_H
struct CopSpeak_tFileIndex { long offset; long size; };
struct CopSpeak_tBankHeader { int id; u_char ver; };
struct CopSpeak_tBank {
    int FileHandle, FileOpen;
    CopSpeak_tFileIndex *Index;
    int Count;
};
#endif
