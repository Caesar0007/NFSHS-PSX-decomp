NL = chr(10)
ENV = {}

A_DECL = "      int replayMode;" + NL + "      tReplayInterface *replayInterface;" + NL
A_ASSIGN = "      replayInterface = &Replay_ReplayInterface;" + NL
A_USE1 = "vel = (carObj->linearVel_ch).z >> (8U - replayInterface->speed);"
A_USE2 = "vel = vel << (replayInterface->speed + 7U);"
A_FENCE = '            __asm__("" : : "r"(replayInterface));' + NL

PATCHES = [
    ("ctl_jtblON", [(A_ASSIGN, A_ASSIGN)]),
    ("v1_no_base_jtblON", [
        (A_DECL, "      int replayMode;" + NL),
        (A_ASSIGN, ""),
        (A_USE1, "vel = (carObj->linearVel_ch).z >> (8U - Replay_ReplayInterface.speed);"),
        (A_USE2, "vel = vel << (Replay_ReplayInterface.speed + 7U);"),
        (A_FENCE, ""),
    ]),
]
