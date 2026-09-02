SUBS = [("""    output = local.files;
    if (output != 0)
        *output = stored;
    return 0;""",
"""    output = local.files;
    if (output == 0)
        return 0;
    *output = stored;
    return 0;""")]
FNS = "MemCardGetDirentry"
