import os
_flag = os.environ["W60A2_FLAG"]
_fns = set(os.environ["W60A2_FNS"].split(","))
bld.PER_FN_FLAG_SPLICE_272["recon/syslib/psx/libmcrd/LIBMCRD.c"] = {_flag: _fns}
