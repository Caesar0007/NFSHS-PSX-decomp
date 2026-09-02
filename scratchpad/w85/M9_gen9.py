import json
V = []
def add(n, s): V.append({"name": n, "subs": s})

B1 = '    __asm__ __volatile__("");  /* MATCH: Rage Racer CD_dmastart barrier -- keep the DICR read-back serial */\n'
B2 = '        __asm__ __volatile__("");  /* MATCH: Rage Racer CD_dmastart barrier */\n'
DVBLK = ("        dv  = ch << 2;\n        dv += 3;\n        bit = 1 << dv;\n" + B2 +
         "        p   = (volatile int *)(0x1F801080 + (ch << 4));\n        dp  = _dpcr;\n")
RB = "    dummy = *(volatile int *)_dicr;\n"

add("e00_control", [])
# --- B2 replacement attempts (no asm) ---
add("e01_noB2_bit_last", [[DVBLK,
    "        dv  = ch << 2;\n        dv += 3;\n"
    "        p   = (volatile int *)(0x1F801080 + (ch << 4));\n"
    "        bit = 1 << dv;\n        dp  = _dpcr;\n"]])
add("e02_noB2_p_outside", [[DVBLK,
    "        dv  = ch << 2;\n        dv += 3;\n        bit = 1 << dv;\n        dp  = _dpcr;\n"],
    [RB, "    p   = (volatile int *)(0x1F801080 + (ch << 4));\n" + RB]])
add("e03_noB2_dp_outside", [[DVBLK,
    "        dv  = ch << 2;\n        dv += 3;\n        bit = 1 << dv;\n"
    "        p   = (volatile int *)(0x1F801080 + (ch << 4));\n"],
    [RB, "    dp  = _dpcr;\n" + RB]])
add("e04_noB2_bitshift_var", [[DVBLK,
    "        dv  = ch << 2;\n        dv += 3;\n        bit = 1;\n        bit <<= dv;\n"
    "        p   = (volatile int *)(0x1F801080 + (ch << 4));\n        dp  = _dpcr;\n"]])
# --- B1 replacement attempts ---
add("e05_noB1_blockbefore", [[B1, ""]])
add("e06_noB1_rb_after_dvblk", [[B1, ""], [RB, ""],
    ["        dv  = ch << 2;\n", "        dv  = ch << 2;\n"],
    ["    {\n        int dv;\n", "    {\n        int dv;\n"]])
json.dump(V, open('scratchpad/w85/M9_v9.json', 'w'))
print('ok')
