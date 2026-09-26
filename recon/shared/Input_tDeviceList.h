/* Input_tDeviceList -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_INPUT_TDEVICELIST_H
#define NFS4_SHARED_INPUT_TDEVICELIST_H

struct Input_tDeviceList {
    char *devicename;
    int (*devicefunc)(u_long);
    int (*startupfunc)(int);
};
#endif
