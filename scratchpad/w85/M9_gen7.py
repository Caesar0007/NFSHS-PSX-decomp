import json
BS = chr(92)
NL = BS + 'n'

BUSY = "*(volatile int *)(0x1F801088 + (ch << 4))"
PRINTF = ('            printf("StCdInterrupt: DMA ch busy %08x' + NL + '",\n'
          "                   " + BUSY + ");\n")

HEAD = """    mode = enable_irq;
    i = 0;
    while (@B@ & 0x01000000) {
        if (i == 0x10000) {
@P@            break;
        }
        i++;
    }
""".replace('@B@', BUSY).replace('@P@', PRINTF)

V = []
def add(n, s): V.append({"name": n, "subs": s})

add("b00_control", [])

# b01: un-rotated infinite loop -> back edge should be an unconditional j
add("b01_forever_break", [[HEAD, """    mode = enable_irq;
    i = 0;
    for (;;) {
        if ((@B@ & 0x01000000) == 0)
            break;
        if (i == 0x10000) {
@P@            break;
        }
        i++;
    }
""".replace('@B@', BUSY).replace('@P@', PRINTF)]])

# b02: goto form with the exit reached only by branches, back edge unconditional
add("b02_goto_uncond_back", [[HEAD, """    mode = enable_irq;
    i = 0;
    if ((@B@ & 0x01000000) == 0)
        goto st_done;
st_wait:
    if (i == 0x10000) {
@P@        goto st_done;
    }
    i++;
    if ((@B@ & 0x01000000) == 0)
        goto st_done;
    goto st_wait;
st_done:
    ;
""".replace('@B@', BUSY).replace('@P@', PRINTF)]])

# b03: do/while
add("b03_do_while", [[HEAD, """    mode = enable_irq;
    i = 0;
    if (@B@ & 0x01000000) {
        do {
            if (i == 0x10000) {
@P@                break;
            }
            i++;
        } while (@B@ & 0x01000000);
    }
""".replace('@B@', BUSY).replace('@P@', PRINTF)]])

# b04: while with the counter test AFTER the increment (loop tail reshaped)
add("b04_tailtest", [[HEAD, """    mode = enable_irq;
    i = 0;
    while (@B@ & 0x01000000) {
        i++;
        if (i == 0x10001) {
@P@            break;
        }
    }
""".replace('@B@', BUSY).replace('@P@', PRINTF)]])

# b05: printf block LAST (break to a trailing label) -> the block before the exit
#      label may then end in the printf's unconditional jump
add("b05_printf_tail", [[HEAD, """    mode = enable_irq;
    i = 0;
    while (@B@ & 0x01000000) {
        if (i == 0x10000)
            goto st_busy;
        i++;
    }
    goto st_ok;
st_busy:
@P@st_ok:
    ;
""".replace('@B@', BUSY).replace('@P@', PRINTF)]])

json.dump(V, open('scratchpad/w85/M9_v7.json', 'w'))
print('ok')
