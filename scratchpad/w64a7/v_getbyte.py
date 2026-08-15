A = """    switch (info[0x36]) {
    case 0:                                  /* poll: stream the actuator data */
        if (idx < 6 && *(info + idx + 0x57) == 0)
            return 0;
        if (info[0x34] <= idx)
            return 0;
        buf = *(unsigned char **)(info + 0x28);
        break;
    case 'M':                                /* 0x4D align: pad with 0xff */
        if (info[0x35] <= idx)
            return 0xff;
        buf = *(unsigned char **)(info + 0x2c);
        break;
    default:                                 /* fixed command param block */
        if (info[0x35] <= idx)
            return 0;
        __asm__("" : : "i"(0));
        return (*(unsigned char **)(info + 0x2c))[idx];
    }
    return buf[idx];
}"""

HEAD = """    switch (info[0x36]) {
    case 0:                                  /* poll: stream the actuator data */
        if (idx < 6 && *(info + idx + 0x57) == 0)
            return 0;
        if (info[0x34] <= idx)
            return 0;
        buf = *(unsigned char **)(info + 0x28);
"""
MID = """    case 'M':                                /* 0x4D align: pad with 0xff */
        if (info[0x35] <= idx)
            return 0xff;
        buf = *(unsigned char **)(info + 0x2c);
"""
DEF = """    default:                                 /* fixed command param block */
        if (info[0x35] <= idx)
            return 0;
        __asm__("" : : "i"(0));
        return (*(unsigned char **)(info + 0x2c))[idx];
    }
"""

V1 = HEAD + "        goto deref;\n" + MID + "        break;\n" + DEF + "deref:\n    return buf[idx];\n}"
V2 = HEAD + "        break;\n" + MID + "        goto deref;\n" + DEF + "deref:\n    return buf[idx];\n}"
V3 = (HEAD + "        break;\n" + MID +
      "        __asm__(\"\" : : \"i\"(0));\n        break;\n" + DEF +
      "    return buf[idx];\n}")
V4 = (HEAD + "        break;\n" + MID + "        break;\n" + DEF +
      "    __asm__(\"\" : : \"i\"(0));\n    return buf[idx];\n}")
V5 = (HEAD + "        goto deref;\n" + MID + "        goto deref;\n" + DEF +
      "deref:\n    return buf[idx];\n}")
V6 = (HEAD + "        break;\n" + MID +
      "        __asm__(\"\" : : \"r\"(buf));\n        break;\n" + DEF +
      "    return buf[idx];\n}")

VARIANTS = [
    ("A control", []),
    ("V1 case0 goto / M break", [(A, V1)]),
    ("V2 case0 break / M goto", [(A, V2)]),
    ("V3 void fence in M tail", [(A, V3)]),
    ("V4 void fence before shared return", [(A, V4)]),
    ("V5 both goto deref", [(A, V5)]),
    ("V6 read fence on buf in M", [(A, V6)]),
]
