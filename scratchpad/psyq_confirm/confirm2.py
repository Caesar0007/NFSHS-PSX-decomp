import importlib.util
import re
import struct

spec = importlib.util.spec_from_file_location(
    "pex", r"C:/Temp/nfs3-clean/tools_psyq_extract.py")
pex = importlib.util.module_from_spec(spec)
spec.loader.exec_module(pex)

obj = pex.parse_obj(open("sserver.obj", "rb").read())

# find the .text section id + the fn offset
sec_by_id = obj["sections"]
text_id = None
for sid, s in sec_by_id.items():
    nm = s["name"] if isinstance(s, dict) else s
    if str(nm).lower() in (".text", "text"):
        text_id = sid
print("sections:", {k: (v["name"] if isinstance(v, dict) else v)
                    for k, v in sec_by_id.items()})
fn_off = None
for x in obj["xdefs"]:
    if x["name"] == "iSND100hzserver":
        fn_off = x["off"]
        text_id = x["sect"]
print("fn xdef off:", fn_off, "sect:", text_id)

code = obj["code"][text_id]
print("text bytes:", len(code))

# retail words from the oracle .s comment column: /* FOFF VA WORD */
retail = []
for ln in open(r"C:/Temp/nfs4-decomp/asm/nonmatchings/main/iSND100hzserver.s",
               encoding="utf-8"):
    m = re.match(r'\s*/\* [0-9A-F]+ ([0-9A-F]{8}) ([0-9A-F]{8}) \*/', ln)
    if m:
        # the word is printed as the raw little-endian byte string
        retail.append((int(m.group(1), 16),
                       struct.unpack("<I", bytes.fromhex(m.group(2)))[0]))
print("retail words:", len(retail))

ours = [struct.unpack_from("<I", code, fn_off + i * 4)[0]
        for i in range(len(retail))]
patch_offs = {p["off"] for p in obj["patches"] if p["sect"] == text_id}

mism = []
for i, ((va, rw), ow) in enumerate(zip(retail, ours)):
    if rw != ow:
        at_patch = (fn_off + i * 4) in patch_offs
        mism.append((i, va, rw, ow, at_patch))
print(f"\nexact-equal words: {len(retail) - len(mism)}/{len(retail)}")
print(f"mismatches: {len(mism)} (patch-site: {sum(1 for m in mism if m[4])})")
for i, va, rw, ow, ap in mism:
    print(f"  insn {i:3d} @ {va:08X}: retail {rw:08X}  ours {ow:08X}  "
          f"{'PATCH-SITE' if ap else '!! REAL DIFF'}")
