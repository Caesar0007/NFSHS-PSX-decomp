/* game/common/spchevnt.c -- RECONSTRUCTED (NFS4 cop speech-event table).
 *   C TU: SLD source = C:\nfs4\GAME\COMMON\SPCHEVNT.C -> CC1PSX lane (methodology 3.25;
 *   migrated from spchevnt.cpp, task #90). Self-contained per C-lane convention.
 *   53 SPCHNFS_<dir>_<dir>_<event> builders: each zero-inits long parms[12], writes the event
 *   code + SPCHNFSType_* field args, enqueues via SPCH_AddEvent. Unmangled C-linkage symbols.
 */

/* ---- local mirrors of the SPCHNFSType_* arg wrappers (nfs4_types.h is C++-only);
 *      all are 4-byte { u_long flags; } records ---- */
typedef unsigned long u_long;
typedef struct SPCHNFSType_POSITION        { u_long flags; } SPCHNFSType_POSITION;
typedef struct SPCHNFSType_DISTANCE        { u_long flags; } SPCHNFSType_DISTANCE;
typedef struct SPCHNFSType_COLOUR          { u_long flags; } SPCHNFSType_COLOUR;
typedef struct SPCHNFSType_ACCIDENT        { u_long flags; } SPCHNFSType_ACCIDENT;
typedef struct SPCHNFSType_AMBULANCE       { u_long flags; } SPCHNFSType_AMBULANCE;
typedef struct SPCHNFSType_PURS_UPDT       { u_long flags; } SPCHNFSType_PURS_UPDT;
typedef struct SPCHNFSType_ARREST          { u_long flags; } SPCHNFSType_ARREST;
typedef struct SPCHNFSType_vs_RDBLK_SSTRP  { u_long flags; } SPCHNFSType_vs_RDBLK_SSTRP;
typedef struct SPCHNFSType_PERP_NAME       { u_long flags; } SPCHNFSType_PERP_NAME;
typedef struct SPCHNFSType_CONFIRM         { u_long flags; } SPCHNFSType_CONFIRM;
typedef struct SPCHNFSType_SPIKE_BELT_SIDE { u_long flags; } SPCHNFSType_SPIKE_BELT_SIDE;
typedef struct SPCHNFSType_REVINTRO        { u_long flags; } SPCHNFSType_REVINTRO;
typedef struct SPCHNFSType_vs_KMH_MPH      { u_long flags; } SPCHNFSType_vs_KMH_MPH;
typedef struct SPCHNFSType_VOICE           { u_long flags; } SPCHNFSType_VOICE;

/* ---- the one true cross-TU extern (eaclib SPCHPSXZ speech-event queue) ---- */
extern long SPCH_AddEvent(long *parms);

/* ---- intra-TU forward declarations (sibling events call each other) ---- */
long SPCHNFS_C_A_CONFIRM(SPCHNFSType_VOICE *VOICE,int ID_UNIT,SPCHNFSType_CONFIRM *CONFIRM);
long SPCHNFS_C_D_REQUEST_EMS(SPCHNFSType_VOICE *VOICE,SPCHNFSType_AMBULANCE *AMBULANCE);
long SPCHNFS_C_C_IN_PURS_NEAR_PERP(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR);
long SPCHNFS_D_C_IN_PURS_NEAR_PERP(SPCHNFSType_PURS_UPDT *PURS_UPDT);
long SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(SPCHNFSType_VOICE *VOICE);
long SPCHNFS_C_D_REQ_RDBLK(SPCHNFSType_VOICE *VOICE);
long SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY(SPCHNFSType_vs_RDBLK_SSTRP *vs_RDBLK_SSTRP);
long SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY(SPCHNFSType_vs_RDBLK_SSTRP *vs_RDBLK_SSTRP,SPCHNFSType_CONFIRM *CONFIRM);
long SPCHNFS_D_C_RDBLK_CONFIRMED(SPCHNFSType_POSITION *POSITION,int ID_LOCATION,SPCHNFSType_DISTANCE *DISTANCE);
long SPCHNFS_C_D_RDBLK_FAILED(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR);
long SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY(void);
long SPCHNFS_C_C_NEW_OFFICER_ENGAGING(SPCHNFSType_VOICE *VOICE,int ID_UNIT);
long SPCHNFS_D_C_PERP_SIGHTED_CONFIRM(SPCHNFSType_CONFIRM *CONFIRM,int ID_UNIT);
long SPCHNFS_D_C_PERP_LOST_CONFIRM(SPCHNFSType_COLOUR *COLOUR,int ID_CAR);
long SPCHNFS_C_D_PERP_APPREHENSION(SPCHNFSType_VOICE *VOICE,SPCHNFSType_PERP_NAME *PERP_NAME);
long SPCHNFS_D_C_PERP_APPREHENSION_REPLY(int ID_UNIT,SPCHNFSType_CONFIRM *CONFIRM,SPCHNFSType_PERP_NAME *PERP_NAME);
long SPCHNFS_C_P_ARRESTED(SPCHNFSType_VOICE *VOICE,SPCHNFSType_ARREST *ARREST);
long SPCHNFS_C_P_WARNING(SPCHNFSType_VOICE *VOICE,SPCHNFSType_ARREST *ARREST);
long SPCHNFS_C_P_TICKET(SPCHNFSType_VOICE *VOICE,SPCHNFSType_ARREST *ARREST);
long SPCHNFS_C_P_FALSE_ARREST_BULLHORN(SPCHNFSType_VOICE *VOICE);
long SPCHNFS_C_D_DURING_FALSE_ARREST(SPCHNFSType_VOICE *VOICE,SPCHNFSType_PERP_NAME *PERP_NAME);
long SPCHNFS_C_P_BULLHORN_SPEECH(SPCHNFSType_VOICE *VOICE);
long SPCHNFS_S_C_SUPER_COP_ARRIVAL(SPCHNFSType_VOICE *VOICE);
long SPCHNFS_S_C_SUPER_COP_CRITICISM(SPCHNFSType_VOICE *VOICE);
long SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD(SPCHNFSType_VOICE *VOICE,int ID_SPEED,SPCHNFSType_vs_KMH_MPH *vs_KMH_MPH);
long SPCHNFS_D_C_INTRO_CALL(int ID_UNIT,int ID_UNIT1,SPCHNFSType_REVINTRO *REVINTRO);
long SPCHNFS_C_A_INTRO(SPCHNFSType_VOICE *VOICE,int ID_UNIT,int ID_UNIT1,SPCHNFSType_REVINTRO *REVINTRO);
long SPCHNFS_C_D_IN_PURS_PERP_AIRBORN(SPCHNFSType_VOICE *VOICE);
long SPCHNFS_C_D_REQ_SPBLT(SPCHNFSType_VOICE *VOICE);
long SPCHNFS_C_D_SPBLT_FAILED(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR);
long SPCHNFS_D_A_CONFIRM(SPCHNFSType_CONFIRM *CONFIRM);
long SPCHNFS_C_D_ENDGAME(SPCHNFSType_VOICE *VOICE);


/* ---- SPCHNFS_C_A_CONFIRM  [SPCHEVNT.C:7-20] SLD-VERIFIED ---- */
long SPCHNFS_C_A_CONFIRM(SPCHNFSType_VOICE *VOICE,int ID_UNIT,SPCHNFSType_CONFIRM *CONFIRM)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x151;
  parms[1] = VOICE->flags;
  parms[2] = ID_UNIT;
  parms[3] = CONFIRM->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_REQUEST_EMS  [SPCHEVNT.C:27-39] SLD-VERIFIED ---- */
long SPCHNFS_C_D_REQUEST_EMS(SPCHNFSType_VOICE *VOICE,SPCHNFSType_AMBULANCE *AMBULANCE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x152;
  parms[1] = VOICE->flags;
  parms[2] = AMBULANCE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_BEGIN_PURS_REP_SPDR  [SPCHEVNT.C:66-81] SLD-VERIFIED ---- */
long SPCHNFS_D_C_BEGIN_PURS_REP_SPDR(SPCHNFSType_COLOUR *COLOUR,int ID_CAR,SPCHNFSType_POSITION *POSITION,int ID_LOCATION
               ,SPCHNFSType_DISTANCE *DISTANCE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x154;
  parms[1] = COLOUR->flags;
  parms[2] = ID_CAR;
  parms[3] = POSITION->flags;
  parms[4] = ID_LOCATION;
  parms[5] = DISTANCE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR_REPLY  [SPCHEVNT.C:94-112] SLD-VERIFIED ---- */
long SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR_REPLY(SPCHNFSType_VOICE *VOICE,int ID_UNIT,SPCHNFSType_COLOUR *COLOUR,int ID_CAR,
               SPCHNFSType_DISTANCE *DISTANCE,SPCHNFSType_POSITION *POSITION,int ID_LOCATION,
               SPCHNFSType_CONFIRM *CONFIRM)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x155;
  parms[1] = VOICE->flags;
  parms[2] = ID_UNIT;
  parms[3] = COLOUR->flags;
  parms[4] = ID_CAR;
  parms[5] = DISTANCE->flags;
  parms[6] = POSITION->flags;
  parms[7] = ID_LOCATION;
  parms[8] = CONFIRM->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR  [SPCHEVNT.C:126-145] SLD-VERIFIED ---- */
long SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR,
               SPCHNFSType_POSITION *POSITION,int ID_LOCATION,SPCHNFSType_DISTANCE *DISTANCE,
               int ID_SPEED,SPCHNFSType_vs_KMH_MPH *vs_KMH_MPH,SPCHNFSType_PERP_NAME *PERP_NAME)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x156;
  parms[1] = VOICE->flags;
  parms[2] = COLOUR->flags;
  parms[3] = ID_CAR;
  parms[4] = POSITION->flags;
  parms[5] = ID_LOCATION;
  parms[6] = DISTANCE->flags;
  parms[7] = ID_SPEED;
  parms[8] = vs_KMH_MPH->flags;
  parms[9] = PERP_NAME->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_C_IN_PURS_NEAR_PERP  [SPCHEVNT.C:178-191] SLD-VERIFIED ---- */
long SPCHNFS_C_C_IN_PURS_NEAR_PERP(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x158;
  parms[1] = VOICE->flags;
  parms[2] = COLOUR->flags;
  parms[3] = ID_CAR;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_IN_PURS_NEAR_PERP  [SPCHEVNT.C:197-208] SLD-VERIFIED ---- */
long SPCHNFS_D_C_IN_PURS_NEAR_PERP(SPCHNFSType_PURS_UPDT *PURS_UPDT)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x159;
  parms[1] = PURS_UPDT->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_STS  [SPCHEVNT.C:219-235] SLD-VERIFIED ---- */
long SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_STS(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR,
               SPCHNFSType_DISTANCE *DISTANCE,SPCHNFSType_POSITION *POSITION,int ID_LOCATION)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x15a;
  parms[1] = VOICE->flags;
  parms[2] = COLOUR->flags;
  parms[3] = ID_CAR;
  parms[4] = DISTANCE->flags;
  parms[5] = POSITION->flags;
  parms[6] = ID_LOCATION;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_IN_PURS_NEAR_PERP_CONFIRM  [SPCHEVNT.C:245-260] SLD-VERIFIED ---- */
long SPCHNFS_D_C_IN_PURS_NEAR_PERP_CONFIRM(SPCHNFSType_COLOUR *COLOUR,int ID_CAR,int ID_UNIT,SPCHNFSType_CONFIRM *CONFIRM,
               SPCHNFSType_PERP_NAME *PERP_NAME)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x15b;
  parms[1] = COLOUR->flags;
  parms[2] = ID_CAR;
  parms[3] = ID_UNIT;
  parms[4] = CONFIRM->flags;
  parms[5] = PERP_NAME->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_STS  [SPCHEVNT.C:315-331] SLD-VERIFIED ---- */
long SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_STS(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR,
               SPCHNFSType_POSITION *POSITION,int ID_LOCATION,SPCHNFSType_DISTANCE *DISTANCE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x15e;
  parms[1] = VOICE->flags;
  parms[2] = COLOUR->flags;
  parms[3] = ID_CAR;
  parms[4] = POSITION->flags;
  parms[5] = ID_LOCATION;
  parms[6] = DISTANCE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_IN_PURS_AWAY_PERP_CONFIRM  [SPCHEVNT.C:341-356] SLD-VERIFIED ---- */
long SPCHNFS_D_C_IN_PURS_AWAY_PERP_CONFIRM(SPCHNFSType_COLOUR *COLOUR,int ID_CAR,int ID_UNIT,SPCHNFSType_CONFIRM *CONFIRM,
               SPCHNFSType_PERP_NAME *PERP_NAME)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x15f;
  parms[1] = COLOUR->flags;
  parms[2] = ID_CAR;
  parms[3] = ID_UNIT;
  parms[4] = CONFIRM->flags;
  parms[5] = PERP_NAME->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_STS  [SPCHEVNT.C:407-421] SLD-VERIFIED ---- */
long SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_STS(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR,
               SPCHNFSType_PERP_NAME *PERP_NAME)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x162;
  parms[1] = VOICE->flags;
  parms[2] = COLOUR->flags;
  parms[3] = ID_CAR;
  parms[4] = PERP_NAME->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS  [SPCHEVNT.C:467-478] SLD-VERIFIED ---- */
long SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(SPCHNFSType_VOICE *VOICE)

{
  int iVar2;
  long parms [12];

  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x165;
  parms[1] = VOICE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_REQ_RDBLK  [SPCHEVNT.C:484-495] SLD-VERIFIED ---- */
long SPCHNFS_C_D_REQ_RDBLK(SPCHNFSType_VOICE *VOICE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x167;
  parms[1] = VOICE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY  [SPCHEVNT.C:501-512] SLD-VERIFIED ---- */
long SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY(SPCHNFSType_vs_RDBLK_SSTRP *vs_RDBLK_SSTRP)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x168;
  parms[1] = vs_RDBLK_SSTRP->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY  [SPCHEVNT.C:519-531] SLD-VERIFIED ---- */
long SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY(SPCHNFSType_vs_RDBLK_SSTRP *vs_RDBLK_SSTRP,SPCHNFSType_CONFIRM *CONFIRM)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x169;
  parms[1] = vs_RDBLK_SSTRP->flags;
  parms[2] = CONFIRM->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_RDBLK_CONFIRMED  [SPCHEVNT.C:539-552] SLD-VERIFIED ---- */
long SPCHNFS_D_C_RDBLK_CONFIRMED(SPCHNFSType_POSITION *POSITION,int ID_LOCATION,SPCHNFSType_DISTANCE *DISTANCE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x16a;
  parms[1] = POSITION->flags;
  parms[2] = ID_LOCATION;
  parms[3] = DISTANCE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_RDBLK_FAILED  [SPCHEVNT.C:560-573] SLD-VERIFIED ---- */
long SPCHNFS_C_D_RDBLK_FAILED(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x16d;
  parms[1] = VOICE->flags;
  parms[2] = COLOUR->flags;
  parms[3] = ID_CAR;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_REQUEST_BKUP  [SPCHEVNT.C:584-600] SLD-VERIFIED ---- */
long SPCHNFS_C_D_REQUEST_BKUP(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR,
               SPCHNFSType_POSITION *POSITION,int ID_LOCATION,SPCHNFSType_DISTANCE *DISTANCE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x16f;
  parms[1] = VOICE->flags;
  parms[2] = COLOUR->flags;
  parms[3] = ID_CAR;
  parms[4] = POSITION->flags;
  parms[5] = ID_LOCATION;
  parms[6] = DISTANCE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_BKUP_REQUEST_GRANT_REPLY  [SPCHEVNT.C:655-669] SLD-VERIFIED ---- */
long SPCHNFS_D_C_BKUP_REQUEST_GRANT_REPLY(SPCHNFSType_DISTANCE *DISTANCE,SPCHNFSType_POSITION *POSITION,int ID_LOCATION,
               int ID_UNIT)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x172;
  parms[1] = DISTANCE->flags;
  parms[2] = POSITION->flags;
  parms[3] = ID_LOCATION;
  parms[4] = ID_UNIT;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY  [SPCHEVNT.C:675-685] SLD-VERIFIED ---- */
long SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY(void)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x174;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_C_NEW_OFFICER_ENGAGING  [SPCHEVNT.C:728-740] SLD-VERIFIED ---- */
long SPCHNFS_C_C_NEW_OFFICER_ENGAGING(SPCHNFSType_VOICE *VOICE,int ID_UNIT)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x177;
  parms[1] = VOICE->flags;
  parms[2] = ID_UNIT;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_PERP_SIGHTED  [SPCHEVNT.C:752-769] SLD-VERIFIED ---- */
long SPCHNFS_C_D_PERP_SIGHTED(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR,
               SPCHNFSType_DISTANCE *DISTANCE,SPCHNFSType_POSITION *POSITION,int ID_LOCATION,
               SPCHNFSType_PERP_NAME *PERP_NAME)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x178;
  parms[1] = VOICE->flags;
  parms[2] = COLOUR->flags;
  parms[3] = ID_CAR;
  parms[4] = DISTANCE->flags;
  parms[5] = POSITION->flags;
  parms[6] = ID_LOCATION;
  parms[7] = PERP_NAME->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_PERP_SIGHTED_CONFIRM  [SPCHEVNT.C:776-788] SLD-VERIFIED ---- */
long SPCHNFS_D_C_PERP_SIGHTED_CONFIRM(SPCHNFSType_CONFIRM *CONFIRM,int ID_UNIT)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x179;
  parms[1] = CONFIRM->flags;
  parms[2] = ID_UNIT;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_PERP_LOST  [SPCHEVNT.C:800-817] SLD-VERIFIED ---- */
long SPCHNFS_C_D_PERP_LOST(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR,
               SPCHNFSType_POSITION *POSITION,int ID_LOCATION,SPCHNFSType_DISTANCE *DISTANCE,
               SPCHNFSType_PERP_NAME *PERP_NAME)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x17a;
  parms[1] = VOICE->flags;
  parms[2] = COLOUR->flags;
  parms[3] = ID_CAR;
  parms[4] = POSITION->flags;
  parms[5] = ID_LOCATION;
  parms[6] = DISTANCE->flags;
  parms[7] = PERP_NAME->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_PERP_LOST_CONFIRM  [SPCHEVNT.C:824-836] SLD-VERIFIED ---- */
long SPCHNFS_D_C_PERP_LOST_CONFIRM(SPCHNFSType_COLOUR *COLOUR,int ID_CAR)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x17b;
  parms[1] = COLOUR->flags;
  parms[2] = ID_CAR;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_C_PERP_REAQUIRED  [SPCHEVNT.C:847-863] SLD-VERIFIED ---- */
long SPCHNFS_C_C_PERP_REAQUIRED(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR,
               SPCHNFSType_POSITION *POSITION,int ID_LOCATION,SPCHNFSType_DISTANCE *DISTANCE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x17c;
  parms[1] = VOICE->flags;
  parms[2] = COLOUR->flags;
  parms[3] = ID_CAR;
  parms[4] = POSITION->flags;
  parms[5] = ID_LOCATION;
  parms[6] = DISTANCE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_PERP_APPREHENSION  [SPCHEVNT.C:926-938] SLD-VERIFIED ---- */
long SPCHNFS_C_D_PERP_APPREHENSION(SPCHNFSType_VOICE *VOICE,SPCHNFSType_PERP_NAME *PERP_NAME)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x17f;
  parms[1] = VOICE->flags;
  parms[2] = PERP_NAME->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_PERP_APPREHENSION_REPLY  [SPCHEVNT.C:946-959] SLD-VERIFIED ---- */
long SPCHNFS_D_C_PERP_APPREHENSION_REPLY(int ID_UNIT,SPCHNFSType_CONFIRM *CONFIRM,SPCHNFSType_PERP_NAME *PERP_NAME)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x180;
  parms[1] = ID_UNIT;
  parms[2] = CONFIRM->flags;
  parms[3] = PERP_NAME->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_PERP_CRASH_GEN  [SPCHEVNT.C:971-988] SLD-VERIFIED ---- */
long SPCHNFS_C_D_PERP_CRASH_GEN(SPCHNFSType_VOICE *VOICE,SPCHNFSType_POSITION *POSITION,int ID_LOCATION,
               SPCHNFSType_COLOUR *COLOUR,int ID_CAR,SPCHNFSType_DISTANCE *DISTANCE,
               SPCHNFSType_PERP_NAME *PERP_NAME)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x181;
  parms[1] = VOICE->flags;
  parms[2] = POSITION->flags;
  parms[3] = ID_LOCATION;
  parms[4] = COLOUR->flags;
  parms[5] = ID_CAR;
  parms[6] = DISTANCE->flags;
  parms[7] = PERP_NAME->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_P_ARRESTED  [SPCHEVNT.C:1014-1026] SLD-VERIFIED ---- */
long SPCHNFS_C_P_ARRESTED(SPCHNFSType_VOICE *VOICE,SPCHNFSType_ARREST *ARREST)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x187;
  parms[1] = VOICE->flags;
  parms[2] = ARREST->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_P_WARNING  [SPCHEVNT.C:1033-1045] SLD-VERIFIED ---- */
long SPCHNFS_C_P_WARNING(SPCHNFSType_VOICE *VOICE,SPCHNFSType_ARREST *ARREST)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x188;
  parms[1] = VOICE->flags;
  parms[2] = ARREST->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_P_TICKET  [SPCHEVNT.C:1052-1064] SLD-VERIFIED ---- */
long SPCHNFS_C_P_TICKET(SPCHNFSType_VOICE *VOICE,SPCHNFSType_ARREST *ARREST)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x189;
  parms[1] = VOICE->flags;
  parms[2] = ARREST->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_P_FALSE_ARREST_BULLHORN  [SPCHEVNT.C:1070-1081] SLD-VERIFIED ---- */
long SPCHNFS_C_P_FALSE_ARREST_BULLHORN(SPCHNFSType_VOICE *VOICE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x18a;
  parms[1] = VOICE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_DURING_FALSE_ARREST  [SPCHEVNT.C:1088-1100] SLD-VERIFIED ---- */
long SPCHNFS_C_D_DURING_FALSE_ARREST(SPCHNFSType_VOICE *VOICE,SPCHNFSType_PERP_NAME *PERP_NAME)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x18b;
  parms[1] = VOICE->flags;
  parms[2] = PERP_NAME->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_P_BULLHORN_SPEECH  [SPCHEVNT.C:1106-1117] SLD-VERIFIED ---- */
long SPCHNFS_C_P_BULLHORN_SPEECH(SPCHNFSType_VOICE *VOICE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x18d;
  parms[1] = VOICE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_S_C_SUPER_COP_ARRIVAL  [SPCHEVNT.C:1123-1134] SLD-VERIFIED ---- */
long SPCHNFS_S_C_SUPER_COP_ARRIVAL(SPCHNFSType_VOICE *VOICE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x18e;
  parms[1] = VOICE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_S_C_SUPER_COP_CRITICISM  [SPCHEVNT.C:1140-1151] SLD-VERIFIED ---- */
long SPCHNFS_S_C_SUPER_COP_CRITICISM(SPCHNFSType_VOICE *VOICE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 399;
  parms[1] = VOICE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_LOC  [SPCHEVNT.C:1285-1299] SLD-VERIFIED ---- */
long SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_LOC(SPCHNFSType_VOICE *VOICE,SPCHNFSType_POSITION *POSITION,int ID_LOCATION,
               SPCHNFSType_DISTANCE *DISTANCE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x19e;
  parms[1] = VOICE->flags;
  parms[2] = POSITION->flags;
  parms[3] = ID_LOCATION;
  parms[4] = DISTANCE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD  [SPCHEVNT.C:1307-1320] SLD-VERIFIED ---- */
long SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD(SPCHNFSType_VOICE *VOICE,int ID_SPEED,SPCHNFSType_vs_KMH_MPH *vs_KMH_MPH)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x19f;
  parms[1] = VOICE->flags;
  parms[2] = ID_SPEED;
  parms[3] = vs_KMH_MPH->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_LOC  [SPCHEVNT.C:1332-1349] SLD-VERIFIED ---- */
long SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_LOC(SPCHNFSType_VOICE *VOICE,SPCHNFSType_POSITION *POSITION,int ID_LOCATION,
               SPCHNFSType_DISTANCE *DISTANCE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR,
               SPCHNFSType_PERP_NAME *PERP_NAME)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1a0;
  parms[1] = VOICE->flags;
  parms[2] = POSITION->flags;
  parms[3] = ID_LOCATION;
  parms[4] = DISTANCE->flags;
  parms[5] = COLOUR->flags;
  parms[6] = ID_CAR;
  parms[7] = PERP_NAME->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_LOC  [SPCHEVNT.C:1360-1376] SLD-VERIFIED ---- */
long SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_LOC(SPCHNFSType_VOICE *VOICE,SPCHNFSType_POSITION *POSITION,int ID_LOCATION,
               SPCHNFSType_DISTANCE *DISTANCE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1a2;
  parms[1] = VOICE->flags;
  parms[2] = POSITION->flags;
  parms[3] = ID_LOCATION;
  parms[4] = DISTANCE->flags;
  parms[5] = COLOUR->flags;
  parms[6] = ID_CAR;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_INTRO_CALL  [SPCHEVNT.C:1384-1397] SLD-VERIFIED ---- */
long SPCHNFS_D_C_INTRO_CALL(int ID_UNIT,int ID_UNIT1,SPCHNFSType_REVINTRO *REVINTRO)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1a3;
  parms[1] = ID_UNIT;
  parms[2] = ID_UNIT1;
  parms[3] = REVINTRO->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_A_INTRO  [SPCHEVNT.C:1427-1441] SLD-VERIFIED ---- */
long SPCHNFS_C_A_INTRO(SPCHNFSType_VOICE *VOICE,int ID_UNIT,int ID_UNIT1,SPCHNFSType_REVINTRO *REVINTRO)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1a5;
  parms[1] = VOICE->flags;
  parms[2] = ID_UNIT;
  parms[3] = ID_UNIT1;
  parms[4] = REVINTRO->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_IN_PURS_PERP_AIRBORN  [SPCHEVNT.C:1447-1458] SLD-VERIFIED ---- */
long SPCHNFS_C_D_IN_PURS_PERP_AIRBORN(SPCHNFSType_VOICE *VOICE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1a6;
  parms[1] = VOICE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_C_SPBLT_CONFIRMED  [SPCHEVNT.C:1468-1483] SLD-VERIFIED ---- */
long SPCHNFS_D_C_SPBLT_CONFIRMED(SPCHNFSType_POSITION *POSITION,int ID_LOCATION,SPCHNFSType_DISTANCE *DISTANCE,
               int ID_UNIT,SPCHNFSType_SPIKE_BELT_SIDE *SPIKE_BELT_SIDE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1a8;
  parms[1] = POSITION->flags;
  parms[2] = ID_LOCATION;
  parms[3] = DISTANCE->flags;
  parms[4] = ID_UNIT;
  parms[5] = SPIKE_BELT_SIDE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_REQ_SPBLT  [SPCHEVNT.C:1489-1500] SLD-VERIFIED ---- */
long SPCHNFS_C_D_REQ_SPBLT(SPCHNFSType_VOICE *VOICE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1a9;
  parms[1] = VOICE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_SPBLT_FAILED  [SPCHEVNT.C:1508-1521] SLD-VERIFIED ---- */
long SPCHNFS_C_D_SPBLT_FAILED(SPCHNFSType_VOICE *VOICE,SPCHNFSType_COLOUR *COLOUR,int ID_CAR)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1aa;
  parms[1] = VOICE->flags;
  parms[2] = COLOUR->flags;
  parms[3] = ID_CAR;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_W_D_RDBLK_PLC  [SPCHEVNT.C:1530-1544] SLD-VERIFIED ---- */
long SPCHNFS_W_D_RDBLK_PLC(SPCHNFSType_VOICE *VOICE,SPCHNFSType_POSITION *POSITION,int ID_LOCATION,
               SPCHNFSType_DISTANCE *DISTANCE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1ab;
  parms[1] = VOICE->flags;
  parms[2] = POSITION->flags;
  parms[3] = ID_LOCATION;
  parms[4] = DISTANCE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_W_D_SPBLT_PLC  [SPCHEVNT.C:1555-1571] SLD-VERIFIED ---- */
long SPCHNFS_W_D_SPBLT_PLC(SPCHNFSType_VOICE *VOICE,SPCHNFSType_POSITION *POSITION,
               SPCHNFSType_SPIKE_BELT_SIDE *SPIKE_BELT_SIDE,int ID_UNIT,int ID_LOCATION,
               SPCHNFSType_DISTANCE *DISTANCE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1ac;
  parms[1] = VOICE->flags;
  parms[2] = POSITION->flags;
  parms[3] = SPIKE_BELT_SIDE->flags;
  parms[4] = ID_UNIT;
  parms[5] = ID_LOCATION;
  parms[6] = DISTANCE->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_PERP_CRASH_ROLL  [SPCHEVNT.C:1581-1596] SLD-VERIFIED ---- */
long SPCHNFS_C_D_PERP_CRASH_ROLL(SPCHNFSType_VOICE *VOICE,SPCHNFSType_POSITION *POSITION,int ID_LOCATION,
               SPCHNFSType_DISTANCE *DISTANCE,SPCHNFSType_PERP_NAME *PERP_NAME)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1ae;
  parms[1] = VOICE->flags;
  parms[2] = POSITION->flags;
  parms[3] = ID_LOCATION;
  parms[4] = DISTANCE->flags;
  parms[5] = PERP_NAME->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_D_A_CONFIRM  [SPCHEVNT.C:1638-1649] SLD-VERIFIED ---- */
long SPCHNFS_D_A_CONFIRM(SPCHNFSType_CONFIRM *CONFIRM)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1b1;
  parms[1] = CONFIRM->flags;
  return SPCH_AddEvent(parms);
}

/* ---- SPCHNFS_C_D_ENDGAME  [SPCHEVNT.C:1655-1666] SLD-VERIFIED ---- */
long SPCHNFS_C_D_ENDGAME(SPCHNFSType_VOICE *VOICE)

{
  long *plVar1;
  long i;
  int iVar2;
  long parms [12];
  
  iVar2 = 0xb;
  do {
    parms[iVar2] = 0;
    iVar2 = iVar2 + -1;
  } while (-1 < iVar2);
  parms[0] = 0x1b3;
  parms[1] = VOICE->flags;
  return SPCH_AddEvent(parms);
}

/* end of spchevnt.c */
