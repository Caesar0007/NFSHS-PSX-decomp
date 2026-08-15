"""w64a10 StatusReply probe -- the SLD says retail's fWing store, the array read
AND the a3 arg copy all belong to source line 1687, i.e. ONE statement."""
import sys
import pathlib
ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
import fast

SRC = "recon/game/common/speech.cpp"
FN = "StatusReply__Q26Speech15DispatchSpeaker"

STORE = b"    (pThis->_base_Speaker).fWing = wing;\n"
CALL = (b"    SPCHNFS_D_C_SPBLT_CONFIRMED((SPCHNFSType_POSITION *)pThis,\n"
        b"      location,distance,wing,\n"
        b"      &(pThis->_base_Speaker).fSpikeSide);\n")

V = {}
# V1: the store becomes the 4th ARGUMENT EXPRESSION (one statement)
V["V1 assign-expr as arg4"] = [
    (STORE, b""),
    (CALL, b"    SPCHNFS_D_C_SPBLT_CONFIRMED((SPCHNFSType_POSITION *)pThis,\n"
            b"      location,distance,(pThis->_base_Speaker).fWing = wing,\n"
            b"      &(pThis->_base_Speaker).fSpikeSide);\n")]
# V2: value expression inlined into the assignment inside the arg list
V["V2 assign-expr, value inline"] = [
    (b"    int wing = bank->fMobile[(*(*Blocker->_vf)[0x11].pfn)\n"
     b"      ((int)&Blocker->fPosition.flags + (*Blocker->_vf)[0x11].delta)];\n", b""),
    (STORE, b""),
    (CALL, b"    SPCHNFS_D_C_SPBLT_CONFIRMED((SPCHNFSType_POSITION *)pThis,\n"
            b"      location,distance,\n"
            b"      (pThis->_base_Speaker).fWing = bank->fMobile[(*(*Blocker->_vf)[0x11].pfn)\n"
            b"      ((int)&Blocker->fPosition.flags + (*Blocker->_vf)[0x11].delta)],\n"
            b"      &(pThis->_base_Speaker).fSpikeSide);\n")]
# V3: comma expression -- store then pass the local
V["V3 comma (store,wing)"] = [
    (STORE, b""),
    (CALL, b"    SPCHNFS_D_C_SPBLT_CONFIRMED((SPCHNFSType_POSITION *)pThis,\n"
            b"      location,distance,((pThis->_base_Speaker).fWing = wing, wing),\n"
            b"      &(pThis->_base_Speaker).fSpikeSide);\n")]
# V4: store stays, arg4 = a RE-READ of the field (the W55-A16 control)
V["V4 re-read field as arg4"] = [
    (CALL, b"    SPCHNFS_D_C_SPBLT_CONFIRMED((SPCHNFSType_POSITION *)pThis,\n"
            b"      location,distance,(pThis->_base_Speaker).fWing,\n"
            b"      &(pThis->_base_Speaker).fSpikeSide);\n")]

if __name__ == "__main__":
    only = sys.argv[1:] or None
    fast.run(SRC, FN, FN,
             {k: v for k, v in V.items() if not only or any(o in k for o in only)},
             gval="4", minrefs=99, dump=False)
