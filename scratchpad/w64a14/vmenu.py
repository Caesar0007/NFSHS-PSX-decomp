CR = chr(13) + chr(10)

ROW = "  u_long **subOtRow = subOtStart[gFlip];" + CR
USE = ("  (carObj->render).sub_ot =" + CR
       + "       subOtRow[iVar9] + iVar11;" + CR)
FLIP = "  iVar9 = uVar20 != 0;" + CR


def mk(rowtxt, usetxt, fliptxt=None):
    def go(s):
        assert s.count(ROW) == 1 and s.count(USE) == 1
        out = s.replace(ROW, rowtxt, 1).replace(USE, usetxt, 1)
        if fliptxt is not None:
            assert out.count(FLIP) == 1
            out = out.replace(FLIP, fliptxt, 1)
        return out
    return go


U_BYTE = ("  (carObj->render).sub_ot =" + CR
          + "       *(u_long **)(iVar9 * 4 + flipOff + (int)subOtStart) + iVar11;" + CR)

PATCHES = [
    # launder the flip offset so the base cannot fold into it, keep the early load
    ('X_launder_flipoff',
     mk("  int flipOff = gFlip * 8;" + CR
        + '  __asm__("" : "=r"(flipOff) : "0"(flipOff));' + CR, U_BYTE)),
    # launder the ROW pointer instead (keeps subOtStart[gFlip] as the early statement)
    ('X_launder_row',
     mk(ROW + '  __asm__("" : "=r"(subOtRow) : "0"(subOtRow));' + CR, USE)),
    # base laundered: subOtStart opaque so cse cannot fold it into the row
    ('X_launder_base',
     mk('  __asm__("" : "=r"(subOtStart) : "0"(subOtStart));' + CR + ROW, USE)),
    # flipOff as a plain early temp (control for the receipt's 20/22)
    ('X_plain_flipoff',
     mk("  int flipOff = gFlip * 8;" + CR, U_BYTE)),
]
