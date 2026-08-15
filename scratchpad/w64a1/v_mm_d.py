TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildMapMarkers__Fi"

R1 = "0x79,mapx + x + -3 & 0xffff,mapy - z & 0xffff,currentSpriteColor,0);"
R2 = "        Hud_BuildSprite(sprt,0x79,mapx + x + -3 & 0xffff,mapy - z & 0xffff,\n"
R3 = "        Hud_BuildSprite(sprt,0x7a,mapx + x + -2 & 0xffff,mapy - z & 0xffff,\n"


def swap(s):
    return s.replace("mapx + x + -3", "x + mapx + -3").replace(
        "mapx + x + -2", "x + mapx + -2")


def paren(s):
    return s.replace("mapx + x + -3", "mapx + (x + -3)").replace(
        "mapx + x + -2", "mapx + (x + -2)")


RACE_HEAD_OLD = "  i = 0;\n  while (true) {\n    if (Cars_gNumRaceCars <= i) break;\n"
RACE_HEAD_NEW = "  mapx = 0x16;\n  i = 0;\n  while (true) {\n    if (Cars_gNumRaceCars <= i) break;\n"

VARIANTS = [
    ("CONTROL", []),
    ("N1 swap x+mapx (race 3)",
     [(R1, swap(R1), 1), (R2, swap(R2), 1), (R3, swap(R3), 1)]),
    ("N2 mapx+(x+K) (race 3)",
     [(R1, paren(R1), 1), (R2, paren(R2), 1), (R3, paren(R3), 1)]),
    ("N3 re-assign mapx before race loop", [(RACE_HEAD_OLD, RACE_HEAD_NEW, 1)]),
    ("N4 swap all 4",
     [(R1, swap(R1), 1), (R2, swap(R2), 1), (R3, swap(R3), 1),
      ("      Hud_BuildSprite(sprt,0x7a,mapx + x + -2 & 0xffff,mapy - z & 0xffff,currentSpriteColor,0);",
       "      Hud_BuildSprite(sprt,0x7a,x + mapx + -2 & 0xffff,mapy - z & 0xffff,currentSpriteColor,0);", 1)]),
]
