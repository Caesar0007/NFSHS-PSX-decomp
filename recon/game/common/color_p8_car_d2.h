/* color_p8_car_d2 -- moved verbatim out of color_p8_car.h so that header holds only its include list. */
#ifndef NFS4_COLOR_P8_CAR_D2_H
#define NFS4_COLOR_P8_CAR_D2_H
typedef struct AIPerson_t {
    int blockMaxDistance, blockMinDistance, oncomingLookAhead;
    int laneSwerve[4];
    int swerveChangeProb, brakeMultiplier, attackActivationHits, attackTime;
    int fishtailAngle, minimumBetweenWipeoutTicks, randomBetweenWipeoutTicks;
    int gripLossProbPerSecond, gripLossMinFactor, gripLossRecoveryPerTick;
    int bestLineAbility;
    unsigned int rearBumpProbMask, smackProbMask, copCollisionFirmness;
} AIPerson_t;
#endif
