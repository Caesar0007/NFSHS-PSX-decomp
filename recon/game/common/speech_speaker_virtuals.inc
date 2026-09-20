/* game/common/speech_speaker_virtuals.inc -- Speech::Speaker's 30 virtuals in retail SLOT order (table 0x80055DC4; there
 * is no destructor slot).  A member-declaration fragment included by every surface's `struct Speaker` where the hand-made
 * `_vf` member was.  The asm labels carry the nested-class manglings until the classes are really nested in Speech. */
    virtual void Report(Car_tObj *cop) asm("Report__Q26Speech7SpeakerP8Car_tObj");
    virtual void Status() asm("Status__Q26Speech7Speaker");
    virtual void Deny() asm("Deny__Q26Speech7Speaker");
    virtual void Grant() asm("Grant__Q26Speech7Speaker");
    virtual void Ready(Car_tObj *wing) asm("Ready__Q26Speech7SpeakerP8Car_tObj");
    virtual void Engage(Car_tObj *perp) asm("Engage__Q26Speech7SpeakerP8Car_tObj");
    virtual void Lose() asm("Lose__Q26Speech7Speaker");
    virtual void Accident(int slice) asm("Accident__Q26Speech7Speakeri");
    virtual void Catch(int ticket) asm("Catch__Q26Speech7Speakeri");
    virtual void RoadBlock() asm("RoadBlock__Q26Speech7Speaker");
    virtual void SpikeBelt() asm("SpikeBelt__Q26Speech7Speaker");
    virtual void Backup() asm("Backup__Q26Speech7Speaker");
    virtual void ReportBlockade() asm("ReportBlockade__Q26Speech7Speaker");
    virtual void Roger() asm("Roger__Q26Speech7Speaker");
    virtual void Bullhorn() asm("Bullhorn__Q26Speech7Speaker");
    virtual void Purge() asm("Purge__Q26Speech7Speaker");
    virtual int Unit() asm("Unit__Q26Speech7Speaker");
    virtual bool KnownPerp(Car_tObj *car) asm("KnownPerp__Q26Speech7SpeakerP8Car_tObj");
    virtual void ClearPerp(Car_tObj *car) asm("ClearPerp__Q26Speech7SpeakerP8Car_tObj");
    virtual bool IsSuper() asm("IsSuper__Q26Speech7Speaker");
    virtual int StatusCount() asm("StatusCount__Q26Speech7Speaker");
    virtual Speaker *StatusSub() asm("StatusSub__Q26Speech7Speaker");
    virtual void PurgeStatusSub() asm("PurgeStatusSub__Q26Speech7Speaker");
    virtual int DistToPerp() asm("DistToPerp__Q26Speech7Speaker");
    virtual Car_tObj *CarObj() asm("CarObj__Q26Speech7Speaker");
    virtual void ReActivate() asm("ReActivate__Q26Speech7Speaker");
    virtual Car_tObj *Perp() asm("Perp__Q26Speech7Speaker");
    virtual CarBank *GetCarBank(int carIndex) asm("GetCarBank__Q26Speech7Speakeri");
    virtual LocationBank *FindClosestLocationTo(int slice) asm("FindClosestLocationTo__Q26Speech7Speakeri");
    virtual CallSignBank *CallSign() asm("CallSign__Q26Speech7Speaker");
