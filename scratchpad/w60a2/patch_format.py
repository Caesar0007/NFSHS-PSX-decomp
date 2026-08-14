bld.PER_FN_FLAG_SPLICE_272["recon/syslib/psx/libmcrd/LIBMCRD.c"] = {
    "-fno-delayed-branch": {"MemCardFormat"},
}
_t = bld.PER_FN_TEXT_MOVES.setdefault("recon/syslib/psx/libmcrd/LIBMCRD.c", {})
_t["MemCardFormat"] = [
    {"take": r"\tli\t\$2,0x00000001[^\n]*\n",
     "after": r"\tbne\t\$2,\$0,\$L\w+\n", "slot": True},
]
