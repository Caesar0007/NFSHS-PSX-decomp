# injected into verify_asm's namespace right after `bld` is created (see probe.py).
# Adds a candidate PER_FN_TEXT_MOVES entry for LIBMCRD.c without touching tools/build.py.
_MOVES = {}
for _fn, _lit in (("MemCardReadFile_cb",  "0x0000000b"),
                  ("MemCardWriteFile_cb", "0x0000000b"),
                  ("MemCardReadData_cb",  "0x0000001e"),
                  ("MemCardWriteData_cb", "0x0000001e")):
    _MOVES[_fn] = [
        {"take": r"(?<=:\n)\tli\t\$2," + _lit + r"[^\n]*\n",
         "after": r"\tbeq\t\$2,\$0,\$L\d+\n",
         "slot": True},
    ]
bld.PER_FN_TEXT_MOVES["recon/syslib/psx/libmcrd/LIBMCRD.c"] = _MOVES
