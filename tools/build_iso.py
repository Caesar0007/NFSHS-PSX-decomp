#!/usr/bin/env python3
"""build_iso.py -- source -> NFS4.EXE + FRONT.BIN -> bootable disc image.

    python tools/build_iso.py                 # full run
    python tools/build_iso.py --skip-compile  # reuse build/**/*.o
    python tools/build_iso.py --restore       # put the retail files back, rebuild the image
    python tools/build_iso.py --no-iso        # stop after staging the two binaries

Steps:
  1. compile  tools/build.py --skip-asm       -- recon-lane objects + asm/data blobs
  2. link     tools/full_link.py              -> build/full_link/full.elf
  3. cut      tools/elf_to_exe.py --split     -> build/full_link/disc/{NFS4.EXE,FRONT.BIN}
  4. stage    copy both into build/cd/<NAME>/ -- the retail originals are saved
              once into build/cd/orig/ and restored by --restore
  5. iso      tools/psxiso/mkpsxiso.exe -y -o build/cd/<NAME>.bin
                                             -c build/cd/<NAME>.cue  build/cd/<NAME>.xml
  6. verify   read the .bin back (MODE2/2352, user data at offset 24) and confirm
              the two staged files are really in it

Both files matter.  The disc has no SYSTEM.CNF, so the console boots PSX.EXE,
which loads `cdrom:nfs4.exe`; the frontend (menus, tournament, car select --
VA 0x80010000..0x80054548) is NOT part of that exe on disc: NFS4.EXE has a zero
hole there and the game loads FRONT.BIN over it at run time.  Change frontend
code and only FRONT.BIN carries it; change game code and only NFS4.EXE does.
"""
import argparse
import hashlib
import os
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CD = ROOT / "build" / "cd"
DISC = ROOT / "build" / "full_link" / "disc"
MKPSXISO = ROOT / "tools" / "psxiso" / "mkpsxiso.exe"
FILES = ("NFS4.EXE", "FRONT.BIN")
SECTOR, USER_OFF, USER = 2352, 24, 2048


def run(cmd, **kw):
    print("\n$ " + " ".join(str(c) for c in cmd), flush=True)
    r = subprocess.run([str(c) for c in cmd], cwd=ROOT, **kw)
    return r.returncode


def sha(p):
    return hashlib.sha1(Path(p).read_bytes()).hexdigest()[:12]


def stage(name, restore):
    """Copy our binaries into the disc folder (or put the originals back)."""
    folder = CD / name
    orig = CD / "orig"
    if not folder.is_dir():
        sys.exit(f"[iso] no disc folder {folder}")
    orig.mkdir(exist_ok=True)
    for f in FILES:
        if not (orig / f).exists():          # first run: keep the retail file
            shutil.copy2(folder / f, orig / f)
            print(f"[stage] saved retail {f} -> {(orig / f).relative_to(ROOT)}")
    for f in FILES:
        src = (orig if restore else DISC) / f
        if not src.is_file():
            sys.exit(f"[stage] missing {src}")
        shutil.copyfile(src, folder / f)
        print(f"[stage] {f} <- {src.relative_to(ROOT)}  sha1 {sha(src)}")


def verify(image, name):
    """Find each staged file's first sector in the image (MODE2/2352)."""
    img = Path(image).read_bytes()
    print(f"[verify] {Path(image).name}  {len(img)} bytes, "
          f"{len(img) // SECTOR} sectors")
    heads = {}
    for f in FILES:
        heads[(CD / name / f).read_bytes()[:USER]] = f
    found = {}
    for lba in range(len(img) // SECTOR):
        u = img[lba * SECTOR + USER_OFF: lba * SECTOR + USER_OFF + USER]
        if u in heads and heads[u] not in found:
            found[heads[u]] = lba
    for f in FILES:
        if f in found:
            print(f"[verify] {f}: first sector at LBA {found[f]} -- our copy is on the image")
        else:
            print(f"[verify] {f}: NOT FOUND on the image")
    return len(found) == len(FILES)


def main():
    ap = argparse.ArgumentParser(description="build the NFS4 disc image from source")
    ap.add_argument("--name", default="Need For Speed 4 v9.0",
                    help="disc folder / xml base name under build/cd")
    ap.add_argument("--skip-compile", action="store_true")
    ap.add_argument("--skip-link", action="store_true")
    ap.add_argument("--no-iso", action="store_true")
    ap.add_argument("--restore", action="store_true",
                    help="stage the retail NFS4.EXE/FRONT.BIN instead of ours")
    ap.add_argument("--tolerant", action="store_true",
                    help="let individual TUs fail (build.py default); off by default")
    a = ap.parse_args()

    py = sys.executable
    if not a.restore:
        if not a.skip_compile:
            env = dict(os.environ)
            if not a.tolerant:
                env["NFS4_STRICT"] = "1"
            if run([py, "tools/build.py", "--skip-asm"], env=env):
                sys.exit("[iso] compile failed")
        if not a.skip_link:
            if run([py, "tools/full_link.py"]):
                sys.exit("[iso] link failed")
        if run([py, "tools/elf_to_exe.py", "--split"]):
            sys.exit("[iso] elf_to_exe failed")

    stage(a.name, a.restore)
    if a.no_iso:
        return

    xml = CD / f"{a.name}.xml"
    out = CD / f"{a.name}.bin"
    cue = CD / f"{a.name}.cue"
    if not MKPSXISO.is_file():
        sys.exit(f"[iso] {MKPSXISO} not found")
    if run([MKPSXISO, "-y", "-o", out, "-c", cue, xml]):
        sys.exit("[iso] mkpsxiso failed")
    print(f"[iso] {out}  {out.stat().st_size} bytes")
    if not verify(out, a.name):
        sys.exit("[iso] verification failed: the image does not carry our binaries")


if __name__ == "__main__":
    main()
