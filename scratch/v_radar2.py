TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_BuildRadar__Fi'

B0 = "  car = Camera_gInfo[player].anchor;\n  visible = 0;\n  mapx = 0x16;\n  mapz = 0x18;\n"
B1 = "  m11 = car->orientMat.m[8] >> 8;   /* +0x110 */\n  cenX = car->position.x >> 8;\n"
B2 = "  cenZ = -car->position.z >> 8;\n  for (i = 0; i < Cars_gNumRaceCars; i++) {\n"

F = '  __asm__("" : : "r" (%s));\n'

VARIANTS = [
    ('F1 fence(car) after car=',
     B0, "  car = Camera_gInfo[player].anchor;\n" + (F % 'car') +
         "  visible = 0;\n  mapx = 0x16;\n  mapz = 0x18;\n"),
    ('F2 fence(visible) after visible=',
     B0, "  car = Camera_gInfo[player].anchor;\n  visible = 0;\n" + (F % 'visible') +
         "  mapx = 0x16;\n  mapz = 0x18;\n"),
    ('F3 fence(mapz) after mapz=',
     B0, B0 + (F % 'mapz')),
    ('F4 fence(car,visible) before cenX',
     B1, "  m11 = car->orientMat.m[8] >> 8;   /* +0x110 */\n" +
         (F % 'visible') + "  cenX = car->position.x >> 8;\n"),
    ('F5 fence(visible) before loop',
     B2, "  cenZ = -car->position.z >> 8;\n" + (F % 'visible') +
         "  for (i = 0; i < Cars_gNumRaceCars; i++) {\n"),
]
