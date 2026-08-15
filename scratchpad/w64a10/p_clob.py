"""w64a10 -- PRICE the hard-reg CLOBBER fence that copypref.py names as the only
model-reachable device for the two availability residuals.  MEASUREMENT ONLY:
the clobber fence is pin-adjacent and parked on a USER decision (AGENT_GUIDE
4.4), so nothing here is landed.  fast.run restores the TU in `finally`.
"""
import sys
import pathlib
ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
import fast

WHICH = sys.argv[1] if len(sys.argv) > 1 else "sr"

if WHICH == "sr":
    SRC = "recon/game/common/speech.cpp"
    FN = "StatusReply__Q26Speech15DispatchSpeaker"
    ANCH = (b"    int wing = bank->fMobile[(*(*Blocker->_vf)[0x11].pfn)\n"
            b"      ((int)&Blocker->fPosition.flags + (*Blocker->_vf)[0x11].delta)];\n")
    V = {
        # copypref: p199's copy_sugg={a3} is honoured because $a3 is FREE over
        # [birth,death).  Occupying $a3 removes the suggestion's only candidate
        # -> the general pass runs the ascending scan -> v0 blocked -> $v1.
        "A a3-clobber before wing": (ANCH, b'    __asm__ __volatile__("" : : : "$7");\n' + ANCH),
        "B a3-clobber after wing": (ANCH, ANCH + b'    __asm__ __volatile__("" : : : "$7");\n'),
        "C a3-clobber before the store": (
            b"    (pThis->_base_Speaker).fWing = wing;\n",
            b'    __asm__ __volatile__("" : : : "$7");\n'
            b"    (pThis->_base_Speaker).fWing = wing;\n"),
    }
else:
    SRC = "recon/game/common/audiocmn.cpp"
    FN = "AudioCmn_CheckState__FP8Car_tObj"
    ANCH = b"      if (bestLapTime[car->carIndex] <= carspeed) goto LAB_800774e0;\n"
    V = {
        # copypref: the HIGH pseudo p246 is a suggestion-less block-local qty;
        # its register is the ascending scan (v0 taken by an earlier suggested
        # qty -> v1).  The lo_sum then FOLLOWS via global.c set_preference
        # (reg_renumber conversion).  Retail's a1 needs v1 AND a0 unavailable.
        "A v1-clobber": (ANCH, b'      __asm__ __volatile__("" : : : "$3");\n' + ANCH),
        "B v1+a0-clobber": (ANCH, b'      __asm__ __volatile__("" : : : "$3","$4");\n' + ANCH),
        "C v1+a0+v0-clobber": (ANCH, b'      __asm__ __volatile__("" : : : "$2","$3","$4");\n' + ANCH),
    }

fast.run(SRC, FN, FN, V, gval="4", minrefs=99, dump=False)
