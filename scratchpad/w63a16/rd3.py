import sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import rd2
from rd import OLD

HEAD = b"""    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);
    }
"""
ARMS = b"""    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);
      daprim = (DR_AREA *)Render_gPacketPtr;
    }
    else {
      daprim = (DR_AREA *)Render_gPacketPtr;
    }
"""
RSET = b"""    r.x = 0;
    r.y = *(short *)((char *)drenv + 2) + this->fYOffset;
    r.w = 0x200;
    r.h = height;
"""
RMW = b"""    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
"""
CELL = b"    u_char **cell = (u_char **)0x1f800004;\n"
READ = b"    daprim = (DR_AREA *)*cell;\n"
STORE = b"    *cell = (u_char *)daprim + 0xc;\n"
CALL = b"    SetDrawArea(daprim,&r);\n"

def mk(head, body):
    return head + b"    {\n" + body + CALL + b"    }\n"

G = mk(HEAD, RSET + CELL + READ + RMW + STORE)
H = mk(HEAD, RSET + CELL + READ + STORE + RMW)
I = mk(HEAD, CELL + READ + RSET + RMW + STORE)          # == B
J = mk(HEAD, RSET + RMW[:0] + CELL + READ + RMW + STORE)  # same as G
K = mk(HEAD, CELL + READ + RMW + STORE + RSET)          # rset last
L = mk(HEAD, RSET + CELL + READ + b"""    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr;\n""" + STORE + b"""    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;\n""")

rd2.run({"G_rset_first_store_late": G,
         "H_rset_first_store_adj": H,
         "K_rset_last": K,
         "L_rset_first_store_mid_rmw": L,
         }, OLD)
