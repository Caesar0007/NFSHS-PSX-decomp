TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_BuildRadar__Fi'

BASE = """  car = Camera_gInfo[player].anchor;
  visible = 0;
  mapx = 0x16;
  mapz = 0x18;
  m00 = car->orientMat.m[0] >> 8;   /* +0xF0 */
  m01 = car->orientMat.m[6] >> 8;   /* +0x108 */
  m10 = car->orientMat.m[2] >> 8;   /* +0xF8 */
  m11 = car->orientMat.m[8] >> 8;   /* +0x110 */
  cenX = car->position.x >> 8;
  cenZ = -car->position.z >> 8;
"""

A = """  car = Camera_gInfo[player].anchor;
  mapx = 0x16;
  visible = 0;
  mapz = 0x18;
  m00 = car->orientMat.m[0] >> 8;   /* +0xF0 */
  m01 = car->orientMat.m[6] >> 8;   /* +0x108 */
  m10 = car->orientMat.m[2] >> 8;   /* +0xF8 */
  m11 = car->orientMat.m[8] >> 8;   /* +0x110 */
  cenX = car->position.x >> 8;
  cenZ = -car->position.z >> 8;
"""

B = """  car = Camera_gInfo[player].anchor;
  mapx = 0x16;
  mapz = 0x18;
  visible = 0;
  m00 = car->orientMat.m[0] >> 8;   /* +0xF0 */
  m01 = car->orientMat.m[6] >> 8;   /* +0x108 */
  m10 = car->orientMat.m[2] >> 8;   /* +0xF8 */
  m11 = car->orientMat.m[8] >> 8;   /* +0x110 */
  cenX = car->position.x >> 8;
  cenZ = -car->position.z >> 8;
"""

C = """  car = Camera_gInfo[player].anchor;
  mapx = 0x16;
  mapz = 0x18;
  m00 = car->orientMat.m[0] >> 8;   /* +0xF0 */
  m01 = car->orientMat.m[6] >> 8;   /* +0x108 */
  m10 = car->orientMat.m[2] >> 8;   /* +0xF8 */
  m11 = car->orientMat.m[8] >> 8;   /* +0x110 */
  cenX = car->position.x >> 8;
  cenZ = -car->position.z >> 8;
  visible = 0;
"""

D = """  car = Camera_gInfo[player].anchor;
  mapx = 0x16;
  mapz = 0x18;
  m00 = car->orientMat.m[0] >> 8;   /* +0xF0 */
  m01 = car->orientMat.m[6] >> 8;   /* +0x108 */
  visible = 0;
  m10 = car->orientMat.m[2] >> 8;   /* +0xF8 */
  m11 = car->orientMat.m[8] >> 8;   /* +0x110 */
  cenX = car->position.x >> 8;
  cenZ = -car->position.z >> 8;
"""

# visible materialized as its own literal zero rather than a copy of i
E = BASE.replace("  visible = 0;\n", "  visible = 0 * mapx;\n")

VARIANTS = [('A mapx-first', BASE, A),
            ('B after mapz', BASE, B),
            ('C after cenZ', BASE, C),
            ('D mid-matrix', BASE, D)]
