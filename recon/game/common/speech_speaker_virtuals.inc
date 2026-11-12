/* game/common/speech_speaker_virtuals.inc -- Speech::Speaker's 30 virtuals in retail SLOT order (table 0x80055DC4; there
 * is no destructor slot).  A member-declaration fragment included by every surface's `struct Speaker` where the hand-made
 * `_vf` member was.  Every surface nests its Speaker in `struct Speech`, so the manglings are natural. */
/* SPEECHX2 2026-11-09: retail SPEECH.H defined the 15 virtual defaults IN-CLASS (Status at 262 .. CallSign at 370-372).
 * The AI surfaces see those bodies here (each records its `this` Speaker plus its class-typed return/param,
 * retail aih_*.obj Speaker run); speech.obj defines them in speech.cpp under their SPEECH.H anchors, cars/copspeak/nfs3
 * out of the class in speech_class.h.
 * Retail aih_cop.obj records none of the four Car_tObj ones (per-TU exclusion, kept from the INFERRED set). */
#if defined(NFS4_GAME_COMMON_SPEECH_TYPES_H) || defined(NFS4_GAME_COMMON_COPSPEAK_TYPES_H)   /* defined in speech.cpp / out of the class in speech_class.h */
    virtual void Report(Car_tObj *cop);
    virtual void Status();
    virtual void Deny();
    virtual void Grant();
    virtual void Ready(Car_tObj *wing);
    virtual void Engage(Car_tObj *perp);
    virtual void Lose();
    virtual void Accident(int slice);
    virtual void Catch(int ticket);
    virtual void RoadBlock();
    virtual void SpikeBelt();
    virtual void Backup();
    virtual void ReportBlockade();
    virtual void Roger();
    virtual void Bullhorn();
    virtual void Purge();
    virtual int Unit();
    virtual bool KnownPerp(Car_tObj *car);
    virtual void ClearPerp(Car_tObj *car);
    virtual bool IsSuper();
    virtual int StatusCount();
    virtual Speaker *StatusSub();
    virtual void PurgeStatusSub();
    virtual int DistToPerp();
    virtual Car_tObj *CarObj();
    virtual void ReActivate();
    virtual Car_tObj *Perp();
    virtual CarBank *GetCarBank(int carIndex);
    virtual LocationBank *FindClosestLocationTo(int slice);
    virtual CallSignBank *CallSign();
#else
    virtual void Report(Car_tObj *cop);
    virtual void Status() {}
    virtual void Deny();
    virtual void Grant();
    virtual void Ready(Car_tObj *wing);
    virtual void Engage(Car_tObj *perp);
    virtual void Lose();
    virtual void Accident(int slice);
    virtual void Catch(int ticket);
    virtual void RoadBlock();
    virtual void SpikeBelt();
    virtual void Backup();
    virtual void ReportBlockade();
    virtual void Roger();
    virtual void Bullhorn();
    virtual void Purge();
    virtual int Unit() { return 0; }
#if defined(NFS4_GAME_COMMON_AIH_COP_TYPES_H)
    virtual bool KnownPerp(Car_tObj *car);

#else
    virtual bool KnownPerp(Car_tObj *car) { return false; }
#endif
#if defined(NFS4_GAME_COMMON_AIH_COP_TYPES_H)
    virtual void ClearPerp(Car_tObj *car);

#else
    virtual void ClearPerp(Car_tObj *car) {}
#endif
    virtual bool IsSuper() { return false; }
    virtual int StatusCount() { return 0; }
    virtual Speaker *StatusSub() { return (Speaker *)0x0; }
    virtual void PurgeStatusSub() {}
    virtual int DistToPerp() { return 0x3e80000; }
#if defined(NFS4_GAME_COMMON_AIH_COP_TYPES_H)
    virtual Car_tObj *CarObj();

#else
    virtual Car_tObj *CarObj() { return (Car_tObj *)0x0; }
#endif
    virtual void ReActivate() {}
#if defined(NFS4_GAME_COMMON_AIH_COP_TYPES_H)
    virtual Car_tObj *Perp();

#else
    virtual Car_tObj *Perp() { return (Car_tObj *)0x0; }
#endif
    virtual CarBank *GetCarBank(int carIndex) { return (CarBank *)0x0; }
    virtual LocationBank *FindClosestLocationTo(int slice) { return (LocationBank *)0x0; }
    virtual CallSignBank *CallSign() { return (CallSignBank *)0; }
#endif
