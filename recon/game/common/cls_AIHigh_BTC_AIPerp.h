/* game/common/cls_AIHigh_BTC_AIPerp.h -- class AIHigh_BTC_AIPerp (AIH_BTCPERP), one definition (header-truth 4x; owner text from aih_btcperp_types.h). */
#ifndef NFS4_GAME_COMMON_CLS_AIHIGH_BTC_AIPERP_H
#define NFS4_GAME_COMMON_CLS_AIHIGH_BTC_AIPERP_H
struct AIHigh_BTC_AIPerp : public AIHigh_BTC_Perp {
    __typeof__(PERPMODE_CRUISE) perpMode_;
    int creationTime_, madeContactTime_, timeUntilContact_, escapeDuration_;
    int originalMass_, originalMassInv_;
    Car_tObj *closestCopCarObj_;
    int closestCopCarDistanceMeters_;
    AIHigh_BTC_AIPerp(Car_tObj *carObj);
    ~AIHigh_BTC_AIPerp();
    void AvoidCops();
    void CalculateTimeTillContact();
    void FindClosestCop();
    void HighExecute();
    void NewStage(AIHigh_BTC_HumanCop *cop);
};
#endif
