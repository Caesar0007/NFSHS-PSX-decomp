/* syslib/psx/libcd/cddebug.c -- RECONSTRUCTED from nfs4-f.exe (.data materialised, bytes from EXE).
 *   obj libcd.lib(BIOS.OBJ): the two CD command/interrupt name tables the driver uses for its debug
 *   traces (referenced by CD_cw / the CD interrupt handlers).  char* tables, indexed by command /
 *   interrupt number.  String contents read verbatim from the EXE .data.  (libcd is from PsyQ
 *   bios.c v1.86 1997/03/28 -- the $Id string sits a few words below these tables.) */



const char *CD_comstr[32] = {            /* @0x8013BF6C : CD command names (CdlNop..CdlReadS) */
    "CdlSync",     "CdlNop",       "CdlSetloc",  "CdlPlay",     /* 0x00-0x03 */
    "CdlForward",  "CdlBackward",  "CdlReadN",   "CdlStandby",  /* 0x04-0x07 */
    "CdlStop",     "CdlPause",     "CdlReset",   "CdlMute",     /* 0x08-0x0B */
    "CdlDemute",   "CdlSetfilter", "CdlSetmode", "?",           /* 0x0C-0x0F */
    "CdlGetlocL",  "CdlGetlocP",   "?",          "CdlGetTN",    /* 0x10-0x13 */
    "CdlGetTD",    "CdlSeekL",     "CdlSeekP",   "?",           /* 0x14-0x17 */
    "?",           "?",            "?",          "CdlReadS",    /* 0x18-0x1B */
    "?",           "?",            "?",          "?"            /* 0x1C-0x1F */
};

const char *CD_intstr[8] = {             /* @0x8013BFEC : CD interrupt-result names */
    "NoIntr",      "DataReady",    "Complete",   "Acknowledge", /* 0-3 */
    "DataEnd",     "DiskError",    "?",          "?"            /* 4-7 */
};


