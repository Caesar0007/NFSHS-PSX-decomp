import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'tools'))
import fast

SRC = "recon/frontend/common/feapp.cpp"
FN = "Redraw__14tFEApplication"

OLD = b"""    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);
      daprim = (DR_AREA *)Render_gPacketPtr;
    }
    else {
      daprim = (DR_AREA *)Render_gPacketPtr;
    }
    {
    r.x = 0;
    r.y = *(short *)((char *)drenv + 2) + this->fYOffset;
    r.w = 0x200;
    r.h = height;
    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    Render_gPacketPtr = (u_char *)daprim + 0xc;
    SetDrawArea(daprim,&r);
    }
"""

def blk(head, body):
    return head + body

# A: single read at the join, no cell
A = b"""    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);
    }
    daprim = (DR_AREA *)Render_gPacketPtr;
    {
    r.x = 0;
    r.y = *(short *)((char *)drenv + 2) + this->fYOffset;
    r.w = 0x200;
    r.h = height;
    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    Render_gPacketPtr = (u_char *)daprim + 0xc;
    SetDrawArea(daprim,&r);
    }
"""

# B: single read at join + cell local (block scope), read+store through cell
B = b"""    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);
    }
    {
    u_char **cell = (u_char **)0x1f800004;
    daprim = (DR_AREA *)*cell;
    r.x = 0;
    r.y = *(short *)((char *)drenv + 2) + this->fYOffset;
    r.w = 0x200;
    r.h = height;
    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    *cell = (u_char *)daprim + 0xc;
    SetDrawArea(daprim,&r);
    }
"""

# D: B + USE ADJACENCY (store moved right after the read -> collapses the movable's LIFE)
D = b"""    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);
    }
    {
    u_char **cell = (u_char **)0x1f800004;
    daprim = (DR_AREA *)*cell;
    *cell = (u_char *)daprim + 0xc;
    r.x = 0;
    r.y = *(short *)((char *)drenv + 2) + this->fYOffset;
    r.w = 0x200;
    r.h = height;
    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    SetDrawArea(daprim,&r);
    }
"""

# E: D but keeping the per-arm reads (original arm shape)
E = b"""    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);
      daprim = (DR_AREA *)Render_gPacketPtr;
    }
    else {
      daprim = (DR_AREA *)Render_gPacketPtr;
    }
    {
    u_char **cell = (u_char **)0x1f800004;
    *cell = (u_char *)daprim + 0xc;
    r.x = 0;
    r.y = *(short *)((char *)drenv + 2) + this->fYOffset;
    r.w = 0x200;
    r.h = height;
    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    SetDrawArea(daprim,&r);
    }
"""

# F: B with the store placed one statement later than D (read, r.x, store, rest)
F = b"""    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);
    }
    {
    u_char **cell = (u_char **)0x1f800004;
    daprim = (DR_AREA *)*cell;
    r.x = 0;
    *cell = (u_char *)daprim + 0xc;
    r.y = *(short *)((char *)drenv + 2) + this->fYOffset;
    r.w = 0x200;
    r.h = height;
    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    SetDrawArea(daprim,&r);
    }
"""

fast.run(SRC, FN, FN, {"A_joinread_nocell": (OLD, A),
                       "B_joinread_cell": (OLD, B),
                       "D_cell_adjacent_store": (OLD, D),
                       "E_armreads_cell_adjacent": (OLD, E),
                       "F_cell_store_after_rx": (OLD, F),
                       }, dump=False)
