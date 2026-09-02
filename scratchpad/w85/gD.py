SUBS = [("""    output = local.files;
    if (output != 0)
        *output = stored;
    return 0;""",
"""    if (*(long *volatile *)&local.files != 0)
        *local.files = stored;
    return 0;""")]
FNS = "MemCardGetDirentry"
