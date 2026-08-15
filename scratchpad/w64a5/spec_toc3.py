import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from spec_toc import TU, FUNC, BASE, M
from spec_toc2 import mk

F = lambda *ops: '__asm__("" : : %s);' % ", ".join('"r"(%s)' % o for o in ops)

VARIANTS = {
    "ctl":            BASE,
    # semantically-clean twin of G: magic also set in the preheader (no uninit read)
    "Q_pre_f_m":      mk(pre=[M], a=[F("magic", "track_first"), M]),
    "Q2_pre_f_m_loc": mk(pre=[M], a=[F("magic", "track_first", "loc"), M]),
    # promote `loc` in the G basin
    "R1_loc":         mk(a=[F("magic", "track_first", "loc"), M]),
    "R2_loc2":        mk(a=[F("magic", "track_first", "loc", "loc"), M]),
    "R3_loc_only1t":  mk(a=[F("magic", "loc"), M]),
    "R4_loc_first":   mk(a=[F("loc", "magic", "track_first"), M]),
    # demote magic by lengthening: separate fences
    "S1_two_fences":  mk(a=[F("magic"), F("track_first"), M]),
    "S2_f_m_fd_loc":  mk(a=[F("magic", "track_first"), M], d=[F("loc")]),
    "S3_fd_loc_only": mk(a=[F("magic", "track_first"), M], d=[F("loc", "loc")]),
}
