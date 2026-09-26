/* AISpeeds_tLeaderBoard -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_AISPEEDS_TLEADERBOARD_H
#define NFS4_SHARED_AISPEEDS_TLEADERBOARD_H

struct AISpeeds_tLeaderBoard {
    Car_tObj *leadRacer, *leadHumanRacer, *leadAIRacer, *lastAIRacer;
};
#endif
