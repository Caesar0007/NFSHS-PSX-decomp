/* aiscript.obj's exact source-visible type graph reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_AISCRIPT_TYPES_H
#define NFS4_GAME_COMMON_AISCRIPT_TYPES_H

#ifdef NFS4_SINGLE_IMPLICIT_ENUM_TYPEDEF
enum AIScript_tPlayAction {
#else
typedef enum AIScript_tPlayAction {
#endif
    AISCRIPT_PLAYACTION_COLLISION = 0,
    AISCRIPT_PLAYACTION_OPP_WIZZED_BY = 1,
    AISCRIPT_PLAYACTION_HUMAN_BLOCK_OPP = 2,
    AISCRIPT_PLAYACTION_OPP_BLOCK_HUMAN = 3,
    AISCRIPT_PLAYACTION_OPP_PASS_HUMAN = 4,
    AISCRIPT_PLAYACTION_HUMAN_PASS_OPP = 5,
    AISCRIPT_PLAYACTION_HUMAN_HONK = 6,
    AISCRIPT_PLAYACTION_SENTINAL = 7
#ifdef NFS4_SINGLE_IMPLICIT_ENUM_TYPEDEF
};
#else
} AIScript_tPlayAction;
#endif

#ifdef NFS4_SINGLE_IMPLICIT_ENUM_TYPEDEF
enum AIScript_tAIReaction {
#else
typedef enum AIScript_tAIReaction {
#endif
    AISCRIPT_AIREACTION_INIT = 1,
    AISCRIPT_AIREACTION_END = 2,
    AISCRIPT_AIREACTION_SPEED_BURST = 4,
    AISCRIPT_AIREACTION_HONK_HORN = 8,
    AISCRIPT_AIREACTION_HARD_BRAKE = 16,
    AISCRIPT_AIREACTION_SWIPE = 32,
    AISCRIPT_AIREACTION_ATTACK = 64,
    AISCRIPT_AIREACTION_PAUSE = 128,
    AISCRIPT_AIREACTION_REAR_END = 256,
    AISCRIPT_AIREACTION_SWERVE = 512,
    AISCRIPT_AIREACTION_MOVE_AWAY = 1024,
    AISCRIPT_AIREACTION_WIPE_OUT = 2048,
    AISCRIPT_AIREACTION_CRAZY_HORN = 4096,
    AISCRIPT_AIREACTION_TEST1 = 8192,
    AISCRIPT_AIREACTION_TEST2 = 16384,
    AISCRIPT_AIREACTION_TEST3 = 32768,
    AISCRIPT_AIREACTION_TEST4 = 65536
#ifdef NFS4_SINGLE_IMPLICIT_ENUM_TYPEDEF
};
#else
} AIScript_tAIReaction;
#endif

struct AIScript_tReactionDetails {
    char reaction[4], halfSeconds[4];
};

struct AIScript_t {
    AIScript_tPlayAction detectAction;
    int detectHumCarIndex;
    AIScript_tPlayAction actionIndex;
    int actionHumCarIndex, reactionIndex;
    AIScript_tAIReaction reaction;
    int reactionTicksLeft;
    AIScript_tReactionDetails (*data)[7];
    int lastReactionIndex[7];
    int lastActionTime;
};

typedef AIScript_tReactionDetails AIScript_tScriptData[7];

#endif
