import json
BS = chr(92)
NL = BS + 'n'   # the two-character C escape inside the printf literal

HEAD = """    mode = enable_irq;
    i = 0;
    while (*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000) {
        if (i == 0x10000) {
            printf("StCdInterrupt: DMA ch busy %08x@NL@",
                   *(volatile int *)(0x1F801088 + (ch << 4)));
            break;
        }
        i++;
    }
""".replace('@NL@', NL)

DECL = "    int           mode;\n"

V = []
def add(n, s): V.append({"name": n, "subs": s})

def loop(limitexpr, modestmt_before, modestmt_after, limitdecl=''):
    b = ''
    if modestmt_before:
        b += "    mode = enable_irq;\n"
    b += "    i = 0;\n"
    if limitdecl:
        b += "    limit = 0x10000;\n"
    b += "    while (*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000) {\n"
    b += "        if (i == %s) {\n" % limitexpr
    b += '            printf("StCdInterrupt: DMA ch busy %%08x' + NL + '",\n'
    b += "                   *(volatile int *)(0x1F801088 + (ch << 4)));\n"
    b += "            break;\n        }\n        i++;\n    }\n"
    if modestmt_after:
        b += "    mode = enable_irq;\n"
    return b

add("n00_control", [])
add("n01_limit", [[HEAD, loop('limit', 1, 0, 1)],
                  [DECL, "    int           mode;\n    int           limit;\n"]])
add("n02_mode_late", [[HEAD, loop('0x10000', 0, 1)]])
add("n03_limit_mode_late", [[HEAD, loop('limit', 0, 1, 1)],
                            [DECL, "    int           mode;\n    int           limit;\n"]])
add("n04_no_mode_var", [[HEAD, loop('0x10000', 0, 0)],
                        [DECL, ""],
                        ["    if (mode == 1) {", "    if (enable_irq == 1) {"]])
json.dump(V, open('scratchpad/w85/M9_v6.json', 'w'))
print('ok')
