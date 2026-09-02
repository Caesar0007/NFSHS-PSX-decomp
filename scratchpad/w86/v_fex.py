A='        __asm__("" : "=r"(textType) : "0"(textType));\n'
B='        __asm__("" : "=r"(selFade) : "0"(selFade));\n'
C='        __asm__("" : "=r"(fade) : "0"(fade));\n'
def ab(v,w,n=1): return ''.join(f'        {v} &= ({v} | {w});\n' for _ in range(n))
def orb(v,w,n=1): return ''.join(f'        {v} |= ({v} & {w});\n' for _ in range(n))
VARIANTS=[("drop",[(A,""),(B,""),(C,"")])]
for n in (1,2):
    VARIANTS.append((f"abs_all_sel{n}", [(A,ab('textType','selected',n)),(B,ab('selFade','selected',n)),(C,ab('fade','selected',n))]))
    VARIANTS.append((f"abs_all_tp{n}",  [(A,ab('textType','textpix',n)),(B,ab('selFade','textpix',n)),(C,ab('fade','textpix',n))]))
    VARIANTS.append((f"or_all_sel{n}",  [(A,orb('textType','selected',n)),(B,orb('selFade','selected',n)),(C,orb('fade','selected',n))]))
VARIANTS += [
 ("abs_tt_only", [(A,ab('textType','selected')),(B,B),(C,C)]),
 ("abs_sf_only", [(B,ab('selFade','selected'))]),
 ("abs_fade_only",[(C,ab('fade','selected'))]),
]
