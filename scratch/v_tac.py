TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_RenderTacView__Fv'

OLD = "          (((int *)(j4 + (int)&DashHUD_gInfo))[7] != 0)) {\n"

VARIANTS = [
    ('W1 natural field access', [(OLD, "          (DashHUD_gInfo.showhud[j] != 0)) {\n")]),
    ('W2 struct-cast base + field displacement', [
        (OLD, "          (((dashhud_info *)(j4 + (int)&DashHUD_gInfo))->showhud[0] != 0)) {\n")]),
    ('W3 byte base + displacement via showhud[0] addr', [
        (OLD, "          (*(int *)(j4 + (int)&DashHUD_gInfo.showhud[0]) != 0)) {\n")]),
    ('W4 struct-cast, index 0 written as j-j', [
        (OLD, "          (((dashhud_info *)((int)&DashHUD_gInfo + j4))->showhud[0] != 0)) {\n")]),
]
