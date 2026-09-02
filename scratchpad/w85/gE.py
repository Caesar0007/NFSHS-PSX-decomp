SUBS = [("""    output = local.files;
    if (output != 0)
        *output = stored;
    return 0;""",
"""    if (local.files != 0)
        *(*(long *volatile *)&local.files) = stored;
    return 0;""")]
FNS = "MemCardGetDirentry"
