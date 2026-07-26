exec(open('scratchpad/a5/r3.py').read().split('HD=')[0])
HD="""                memcpy(*(unsigned char **)(s + 0x20), *(unsigned char **)(s + 0x44), moveSize);
                q = *(int **)(s + 0x44);
                q[0] = -1;                       /* leave a wrap marker behind */
                q[1] = 8;
"""
t("I", HD+"""                p = *(int **)(s + 0x20);
                uVar5 = (unsigned int)p + moveSize;
                room = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = (int)p;
                MI(s, 0x48) = uVar5;""", keep=True)
