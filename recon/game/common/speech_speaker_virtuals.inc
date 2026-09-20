/* game/common/speech_speaker_virtuals.inc -- Speech::Speaker's 30 virtuals in retail SLOT order (table 0x80055DC4; there
 * is no destructor slot).  A member-declaration fragment included by every surface's `struct Speaker` where the hand-made
 * `_vf` member was.  Every surface nests its Speaker in `struct Speech`, so the manglings are natural. */
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
