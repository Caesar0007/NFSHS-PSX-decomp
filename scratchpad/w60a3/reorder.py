#!/usr/bin/env python3
"""W60-A3: reorder SYS.c function DEFINITIONS into retail VA order.

Strategy (MSC02 precedent): all non-function file-scope text keeps its original
relative order and is emitted first (so every static/typedef/table is declared
before any function body); a forward-declaration block for all 44 functions is
inserted; then the function definitions follow in retail VA order.
"""
import io
import os
import re
import sys

SRC = "recon/syslib/psx/libgpu/SYS.c"

VA_ORDER = """ResetGraph SetDispMask DrawSync _image ClearImage LoadImage StoreImage
MoveImage ClearOTagR DrawOTag PutDrawEnv PutDispEnv SetTexWindow SetDrawArea
SetDrawStp SetDrawMode SetDrawEnv _set_drawenv _set_draw_mode _set_clip_tl
_set_clip_br _set_draw_offset _get_tw _get_status _clearOTagR_dma _BlitClear
_dws _drs _send_gp1 _get_gp1 _send_gp0 _gpu_dma_chain _get_gpuinfo _que_ref
_gpu_que_push _gpu_que_drain _reset _sync _gpu_arm_timeout _gpu_check_timeout
_gpu_init_videomode DrawOTag2 _install_drain_cb _memset""".split()

with open(SRC, "rb") as f:
    raw = f.read()
crlf = raw.count(b"\r\n")
EOL = "\r\n" if crlf else "\n"
assert crlf == 0 or crlf > 100, "mixed endings: %d" % crlf
text = raw.decode("utf-8")
lines = text.split(EOL)             # keep list of logical lines

n = len(lines)
# ---- locate function definition blocks -------------------------------------
defs = {}          # name -> (start_idx, end_idx_exclusive)
i = 0
sig_re = re.compile(r"^extern\s+.*?\b(\w+)\s*\(")
while i < n:
    ln = lines[i]
    m = sig_re.match(ln)
    if m and not ln.rstrip().endswith(";") and "*/" not in ln:
        # find the opening brace: signature may span lines until a line == '{'
        j = i
        while j < n and lines[j].strip() != "{":
            if lines[j].rstrip().endswith(";"):
                break
            j += 1
        if j < n and lines[j].strip() == "{":
            name = m.group(1)
            # find closing '}' at column 0
            k = j + 1
            while k < n and lines[k] != "}":
                k += 1
            assert k < n, "no closing brace for %s" % name
            # absorb preceding contiguous comment/blank-free block
            s = i
            while s - 1 >= 0 and lines[s - 1].strip() != "":
                s -= 1
            defs[name] = (s, k + 1)
            i = k + 1
            continue
    i += 1

missing = [x for x in VA_ORDER if x not in defs]
extra = [x for x in defs if x not in VA_ORDER]
assert not missing, "missing defs: %s" % missing
assert not extra, "unexpected defs: %s" % extra

# ---- split ------------------------------------------------------------------
spans = sorted(defs.values())
covered = [False] * n
for s, e in spans:
    for x in range(s, e):
        covered[x] = True

skeleton = [lines[x] for x in range(n) if not covered[x]]
# collapse runs of >2 blank lines in the skeleton
out = []
blank = 0
for ln in skeleton:
    if ln.strip() == "":
        blank += 1
        if blank > 1:
            continue
    else:
        blank = 0
    out.append(ln)
while out and out[-1].strip() == "":
    out.pop()

# ---- forward declarations ---------------------------------------------------
fwd = ["",
       "/* ---- forward declarations -------------------------------------------------",
       " * W60-A3: the function DEFINITIONS below are emitted in retail VA order (the",
       " * object's .text symbol order must match 0x800ED670..0x800EFE58; a wrong intra-TU",
       " * order is a LINK-VISIBLE defect the byte gate cannot see -- see the MSC02",
       " * precedent).  Since a callee can now sit after its call site, every definition",
       " * gets a prototype here.  The prototypes are byte-identical to the definitions'",
       " * own signatures, so no call site sees a different declaration than before. */"]
for name in VA_ORDER:
    s, e = defs[name]
    # signature = from the 'extern' line up to (not incl.) the '{'
    k = s
    while not sig_re.match(lines[k]):
        k += 1
    sig = []
    while lines[k].strip() != "{":
        sig.append(lines[k])
        k += 1
    sig[-1] = sig[-1].rstrip() + ";"
    fwd.extend(sig)
fwd.append("")

body = []
for name in VA_ORDER:
    s, e = defs[name]
    blk = lines[s:e]
    while blk and blk[-1].strip() == "":
        blk.pop()
    body.extend(blk)
    body.append("")

# the driver table's initializer names functions -> the prototypes must precede it
anchor = next(i for i, ln in enumerate(out)
              if ln.startswith("static const GpuTbl _gpu_tbl"))
out = out[:anchor] + fwd + out[anchor:]

new_lines = out + body
while new_lines and new_lines[-1].strip() == "":
    new_lines.pop()
new_lines.append("")            # trailing newline

newtext = EOL.join(new_lines)
tmp = SRC + ".tmp"
with open(tmp, "wb") as f:
    f.write(newtext.encode("utf-8"))
assert os.path.getsize(tmp) > len(raw) * 0.8, "suspicious shrink"
os.replace(tmp, SRC)
print("ok: %d lines -> %d lines" % (n, len(new_lines)))
