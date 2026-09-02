import json
BS = chr(92)
NL = BS + 'n'
BUSY = "*(volatile int *)(0x1F801088 + (ch << 4))"
NBUSY = "*(int *)(0x1F801088 + (ch << 4))"

V = []
def add(n, s): V.append({"name": n, "subs": s})

add("d00_control", [])

# (a) cast-away-volatile DIAGNOSTIC on the busy read (loop condition only)
add("d01_nonvol_loopcond", [
    ["    while (" + BUSY + " & 0x01000000) {",
     "    while (" + NBUSY + " & 0x01000000) {"]])
# (a') both reads non-volatile
add("d02_nonvol_both", [
    ["    while (" + BUSY + " & 0x01000000) {",
     "    while (" + NBUSY + " & 0x01000000) {"],
    ["                   " + BUSY + ");", "                   " + NBUSY + ");"]])

# volatile-on-plain-state audit inside _st_dma
add("d03_drop_chcr_volatile", [
    ["extern void _st_dma(int ch, int madr, int blocks, int blocksize, volatile int chcr,",
     "extern void _st_dma(int ch, int madr, int blocks, int blocksize, int chcr,"],
    ["extern void _st_dma(int ch, int madr, int blocks, int blocksize, volatile int chcr,\n                    u_char enable_irq, int arg6)\n{",
     "extern void _st_dma(int ch, int madr, int blocks, int blocksize, int chcr,\n                    u_char enable_irq, int arg6)\n{"]])
add("d04_drop_dummy_volatile", [["    volatile int  dummy;", "    int  dummy;"]])
add("d05_drop_p_volatile", [["    volatile int *p;", "    int *p;"]])
add("d06_drop_dp_volatile", [["    volatile int *dp;", "    int *dp;"]])

# volatile audit inside StCdInterrupt
add("d07_drop_hdr_volatile", [["    volatile short hdr[4];", "    short hdr[4];"]])
add("d08_drop_dly_volatile", [["    volatile int *dly_;", "    int *dly_;"]])
add("d09_drop_elsearm_volatile", [
    ["        else                 { (void)*(volatile u_short *)&_st_slot[0]; }",
     "        else                 { (void)*(u_short *)&_st_slot[0]; }"]])
add("d10_drop_slot_volatile", [
    ["extern volatile u_short *_st_slot; /* @0x80144864 : cached current ring slot */",
     "extern u_short *_st_slot; /* @0x80144864 : cached current ring slot */"]])

# the .bss placement asm blob (line 66)
add("d11_drop_bss_asm", [
    ['__asm__("' + BS + 't.local' + BS + 't_st_slot' + BS + 'n' + BS + 't.section' + BS + 't.bss' + BS + 'n' + BS + 't.align' + BS + 't2' + BS + 'n_st_slot:' + BS + 'n' + BS + 't.space' + BS + 't4' + BS + 'n' + BS + 't.text");\n'
     + 'extern volatile u_short *_st_slot; /* @0x80144864 : cached current ring slot */',
     'volatile u_short *_st_slot; /* @0x80144864 : cached current ring slot */']])

json.dump(V, open('scratchpad/w85/M9_v8.json', 'w'))
print('ok')
