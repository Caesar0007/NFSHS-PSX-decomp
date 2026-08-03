TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_BuildRadar__Fi'

HEAD = """  car = Camera_gInfo[player].anchor;
  visible = 0;
  mapx = 0x16;
  mapz = 0x18;
  m00 = car->orientMat.m[0] >> 8;   /* +0xF0 */
"""

VARIANTS = [
    # constants first, car last -> car's address math lands after the zero copy in RTL
    ('G1 consts-first',
     HEAD,
     """  visible = 0;
  mapx = 0x16;
  mapz = 0x18;
  car = Camera_gInfo[player].anchor;
  m00 = car->orientMat.m[0] >> 8;   /* +0xF0 */
"""),
    # mapx/mapz first, then car, then visible
    ('G2 consts,car,visible',
     HEAD,
     """  mapx = 0x16;
  mapz = 0x18;
  car = Camera_gInfo[player].anchor;
  visible = 0;
  m00 = car->orientMat.m[0] >> 8;   /* +0xF0 */
"""),
    # split the address computation into its own statement
    ('G3 split &Camera_gInfo[player]',
     HEAD,
     """  {
    Camera_tInfo *ci = &Camera_gInfo[player];
    car = ci->anchor;
  }
  visible = 0;
  mapx = 0x16;
  mapz = 0x18;
  m00 = car->orientMat.m[0] >> 8;   /* +0xF0 */
"""),
    # visible written through the loop counter explicitly (i = 0 first)
    ('G4 i=0 explicit first',
     HEAD,
     """  car = Camera_gInfo[player].anchor;
  i = 0;
  visible = i;
  mapx = 0x16;
  mapz = 0x18;
  m00 = car->orientMat.m[0] >> 8;   /* +0xF0 */
"""),
]
