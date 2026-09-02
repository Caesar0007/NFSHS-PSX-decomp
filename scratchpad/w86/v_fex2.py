A='        __asm__("" : "=r"(textType) : "0"(textType));\n'
B='        __asm__("" : "=r"(selFade) : "0"(selFade));\n'
C='        __asm__("" : "=r"(fade) : "0"(fade));\n'
ATT='        textType &= (textType | selected);\n'
def ab(v,w,n=1): return ''.join(f'        {v} &= ({v} | {w});\n' for _ in range(n))
def orb(v,w,n=1): return ''.join(f'        {v} |= ({v} & {w});\n' for _ in range(n))
VARIANTS=[]
for w in ('selected','textpix','helpText','dist','(int)fSelFade'):
    VARIANTS.append((f"tt+sf[{w}]", [(A,ATT),(B,ab('selFade',w))]))
    VARIANTS.append((f"tt+fade[{w}]", [(A,ATT),(C,ab('fade',w))]))
VARIANTS.append(("tt+sfOR", [(A,ATT),(B,orb('selFade','selected'))]))
VARIANTS.append(("tt+fadeOR", [(A,ATT),(C,orb('fade','selected'))]))
VARIANTS.append(("tt+both_sel", [(A,ATT),(B,ab('selFade','selected')),(C,ab('fade','selected'))]))
VARIANTS.append(("tt2x", [(A,ab('textType','selected',2))]))
