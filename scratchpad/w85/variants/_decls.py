FN_DECLS = """  int i;
  int carType;
  int vx;
  int vy;
  int carPixMapCount;
  int recolor_flag;
  short plate0;   /* R-JPN delta carrier */
"""
BASE_LINES = ["  int i;", "  int carType;", "  int vx;", "  int vy;",
              "  int carPixMapCount;", "  int recolor_flag;"]
PLATE = "  short plate0;   /* R-JPN delta carrier */"
def at(pos):
    L = BASE_LINES[:]
    L.insert(pos, PLATE)
    return "\n".join(L) + "\n"
