"""Build a MEASUREMENT-ONLY copy of the NFS4-R-USA audioclc candidate.

The regiondiff MANIFEST/INDEX name-map for the audioclc cluster is shifted by
one function (see R13_receipt.md), so the gate's oracle FILE names do not line
up with the true function names.  This script renames the three affected
functions to the names of the oracle files that actually contain their bodies,
purely so `verify_region.py` can be pointed at them.  The DELIVERABLE candidate
keeps the honest names; this file is scratch evidence only.

  true AudioClc_SoundCloseCar(int,int)  -> oracle AudioClc_SoundPlayersCar__Fi.s
  true AudioClc_SoundPlayersCar(int)    -> oracle func_80075F28.s
  true func_8007593C(void)              -> oracle AudioClc_SoundCloseCar__Fii.s
"""
import re, sys, pathlib
src = pathlib.Path(sys.argv[1]).read_text()
src = src.replace('AudioClc_SoundCloseCar', '@@A@@')
src = src.replace('AudioClc_SoundPlayersCar', '@@B@@')
src = src.replace('func_8007593C', '@@C@@')
src = src.replace('@@A@@', 'AudioClc_SoundPlayersCar__Fi')
src = src.replace('@@B@@', 'func_80075F28')
src = src.replace('@@C@@', 'AudioClc_SoundCloseCar__Fii')
src = re.sub(r'^void (AudioClc_SoundPlayersCar__Fi|func_80075F28)\(',
             r'extern "C" void \1(', src, flags=re.M)
pathlib.Path(sys.argv[2]).write_text(src)
print('wrote', sys.argv[2])
