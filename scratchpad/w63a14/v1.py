NL = chr(10)
ENV = {"W60_TU_FLAGS": '{"recon/game/common/r3dcar.cpp":{"jtbl_at_fusion":false}}'}

A_DECL = "      int replayMode;" + NL + "      tReplayInterface *replayInterface;" + NL
A_ASSIGN = "      replayInterface = &Replay_ReplayInterface;" + NL
A_USE1 = "vel = (carObj->linearVel_ch).z >> (8U - replayInterface->speed);"
A_USE2 = "vel = vel << (replayInterface->speed + 7U);"
A_FENCE = '            __asm__("" : : "r"(replayInterface));' + NL
A_MODE = "      replayMode = Replay_ReplayMode;" + NL

PATCHES = [
    ("ctl", [(A_ASSIGN, A_ASSIGN)]),
    ("v1_no_base", [
        (A_DECL, "      int replayMode;" + NL),
        (A_ASSIGN, ""),
        (A_USE1, "vel = (carObj->linearVel_ch).z >> (8U - Replay_ReplayInterface.speed);"),
        (A_USE2, "vel = vel << (Replay_ReplayInterface.speed + 7U);"),
        (A_FENCE, ""),
    ]),
    ("v2_base_after_mode", [
        (A_ASSIGN, ""),
        (A_MODE, A_MODE + "      replayInterface = &Replay_ReplayInterface;" + NL),
    ]),
    ("v3_no_base_fence_on_speed", [
        (A_ASSIGN, ""),
        (A_USE1, "vel = (carObj->linearVel_ch).z >> (8U - Replay_ReplayInterface.speed);"),
        (A_USE2, "vel = vel << (Replay_ReplayInterface.speed + 7U);"),
        (A_FENCE, '            __asm__("" : : "r"(Replay_ReplayInterface.speed));' + NL),
    ]),
]
