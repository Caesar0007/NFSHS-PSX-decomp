"""Round 2: pick the SECOND-block reference so the shared (=> GLOBAL, zero-copy)
pseudo does NOT pick up an $a3 conflict."""
import sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "..", "tools"))
import fast
import viv

SRC, FN = viv.SRC, viv.FN
DECL2 = viv.DECL2
B1 = (viv.B1DECL, viv.B1DECL2)
NOFENCE = (viv.FENCE, b"")

HL = (b"    u_int headerLength = header->hlen;\n", b"    swappedType = header->hlen;\n")
HLX = (b"    header->hlen = headerLength << 0x18 | (headerLength & 0xff00) << 8 |\n"
       b"                   (headerLength & byteMask) >> 8 | headerLength >> 0x18;\n",
       b"    header->hlen = swappedType << 0x18 | (swappedType & 0xff00) << 8 |\n"
       b"                   (swappedType & byteMask) >> 8 | swappedType >> 0x18;\n")
HN = (b"    u_int headerNum = header->num;\n", b"    swappedType = header->num;\n")
HNX = (b"    header->num = headerNum << 0x18 | (headerNum & 0xff00) << 8 |\n"
       b"                  (headerNum & byteMask) >> 8 | headerNum >> 0x18;\n",
       b"    header->num = swappedType << 0x18 | (swappedType & 0xff00) << 8 |\n"
       b"                  (swappedType & byteMask) >> 8 | swappedType >> 0x18;\n")

V = {
    "G5 share w/ b2 num, fence": [(viv.DECL, DECL2), B1, HN, HNX],
    "G5b share w/ b2 num, no fence": [(viv.DECL, DECL2), B1, HN, HNX, NOFENCE],
    "G6 share w/ b2 hlen, fence": [(viv.DECL, DECL2), B1, HL, HLX],
    "G6b share w/ b2 hlen, nofence": [(viv.DECL, DECL2), B1, HL, HLX, NOFENCE],
}
if __name__ == "__main__":
    fast.run(SRC, FN, "FeAudio_InitViv", V, gval="0", dump=False)
