SUBS = [("""    struct {
        int result;
        long *files;
    } local;""",
"""    struct {
        int result;
        long *files;
        long *files2;
    } local;"""),
("""    local.files = files;""", """    local.files = files;
    local.files2 = files;"""),
("""    output = local.files;
    if (output != 0)
        *output = stored;
    return 0;""",
"""    if (local.files2 != 0)
        *local.files = stored;
    return 0;""")]
FNS = "MemCardGetDirentry"
