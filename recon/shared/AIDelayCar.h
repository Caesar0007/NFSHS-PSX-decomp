/* AIDelayCar -- AIDELAYCAR.H, one definition for every includer (header-truth 4o). Members are defined in aidelaycar.cpp. */
#ifndef NFS4_SHARED_AIDELAYCAR_H
#define NFS4_SHARED_AIDELAYCAR_H
typedef struct AIDelayCar {
    int delayFactor_;
    Car_tObj *basisCar_, *targetCar_;
    int deltaMeters_, slice_;
    coorddef deltaPosition_, position_;
    int deltaRoadPosition_, roadPosition_, laneIndex_, currentSpeed_;

    AIDelayCar(Car_tObj *basisCar, Car_tObj *targetCar, int delayFactor);
    void SetNewTargetCar(Car_tObj *targetCar);
    void Update(); int GetCurrentSpeed() { return currentSpeed_; } /* inferred field getter */ int GetRoadPosition() { return roadPosition_; } /* inferred getter */
} AIDelayCar;
#endif
