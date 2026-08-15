TU = "recon/game/psx/hud.cpp"
FN = "Hud_RenderHudView__Fv"

S = "        *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tagp & otmask;\n"

def blk(body):
    return "        {\n" + body + "        }\n"

PW_F = blk("          u_int pw = *(u_int *)pal;\n"
           "          __asm__ (\"\" : \"=r\"(pw) : \"0\"(pw));\n"
           "          *(u_int *)pal = pw & 0xff000000 | (u_int)tagp & otmask;\n")
PW = blk("          u_int pw = *(u_int *)pal;\n"
         "          *(u_int *)pal = pw & 0xff000000 | (u_int)tagp & otmask;\n")
PH_F = blk("          u_int ph = *(u_int *)pal & 0xff000000;\n"
           "          __asm__ (\"\" : \"=r\"(ph) : \"0\"(ph));\n"
           "          *(u_int *)pal = ph | (u_int)tagp & otmask;\n")
PH = blk("          u_int ph = *(u_int *)pal & 0xff000000;\n"
         "          *(u_int *)pal = ph | (u_int)tagp & otmask;\n")
SWAP = "        *(u_int *)pal = (u_int)tagp & otmask | *(u_int *)pal & 0xff000000;\n"
BITF = "        ((Hud_PTag *)pal)->addr = (u_int)tagp;\n"
REMASK = ("        *(u_int *)pal = *(u_int *)pal & 0xff000000 |"
          " ((u_int)tagp & otmask) & otmask;\n")
PA_F = blk("          u_int pa = (u_int)tagp & otmask;\n"
           "          __asm__ (\"\" : \"=r\"(pa) : \"0\"(pa));\n"
           "          *(u_int *)pal = *(u_int *)pal & 0xff000000 | pa;\n")

VARIANTS = [
    ("control", []),
    ("named pw", [(S, PW, 1)]),
    ("named pw + identity fence", [(S, PW_F, 1)]),
    ("named ph", [(S, PH, 1)]),
    ("named ph + identity fence", [(S, PH_F, 1)]),
    ("OR operand swap", [(S, SWAP, 1)]),
    ("bitfield form", [(S, BITF, 1)]),
    ("re-mask no-op on addr24", [(S, REMASK, 1)]),
    ("named pa + identity fence", [(S, PA_F, 1)]),
]
