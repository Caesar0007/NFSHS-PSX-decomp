exec(open('scratchpad/a5/r1.py').read().split('t("base"')[0])
t("A", """                room = MI(s, 0x20);
                uVar5 = room + moveSize;
                MI(s, 0x44) = room;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x48) = uVar5;""", keep=True)
