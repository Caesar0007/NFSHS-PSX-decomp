#!/usr/bin/env python3
"""elf_to_exe.py -- turn the recon-lane ELF (tools/full_link.py) into a PS-X EXE.

    python tools/full_link.py            # builds build/full_link/full.elf
    python tools/elf_to_exe.py           # -> build/full_link/nfs4.exe (+ ROM compare)

    python tools/elf_to_exe.py IN.elf OUT.exe [--rom rom/nfs4-f.exe | --no-compare]

Why not `objcopy -O binary` (or psxsdk's elf2exe, which is objcopy plus a
hard-coded header): nfs4_recon.ld gives every code/data section LMA == VMA
(0x8001xxxx) while `.header` sits at LMA 0, so a flat binary spans
0x00000000..0x8014xxxx = ~2 GB.  elf2exe would also hard-code pc0 = 0x80010000,
which in NFS4 is .rodata_front, not the entry point (0x800E402C).

What this does instead (the same image full_link.py compares, written out):
  * the 0x800-byte PS-X EXE header is the ELF's own `.header` section
    (assembled from asm/header.s: pc0, t_addr, t_size, stack, licence string);
  * the load image is t_addr .. t_addr+t_size taken FROM THAT HEADER, so the
    exe has exactly the retail size and needs no ROM to be produced;
  * every allocated, non-NOBITS section is copied at its VMA, in section-table
    order (later sections win on overlap -- the same order full_link's
    `objdump -s` walk uses); anything outside the load image is skipped
    (e.g. the dead jump-table blobs placed past the end, or an orphan section
    that ld dropped at VA 0 next to the header).
Standard library only; the ELF is parsed directly.
"""
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
HDR = 0x800

SHT_NOBITS = 8
SHF_ALLOC = 0x2


def sections(elf: bytes):
    """Yield (name, vma, data) for every allocated section with file bytes."""
    if elf[:4] != b"\x7fELF" or elf[4] != 1 or elf[5] != 1:
        sys.exit("[elf_to_exe] not a 32-bit little-endian ELF")
    e_shoff, = struct.unpack_from("<I", elf, 0x20)
    e_shentsize, e_shnum, e_shstrndx = struct.unpack_from("<HHH", elf, 0x2E)

    def sh(i):
        return struct.unpack_from("<IIIIIIIIII", elf, e_shoff + i * e_shentsize)

    strtab_off = sh(e_shstrndx)[4]

    def name(off):
        end = elf.index(b"\0", strtab_off + off)
        return elf[strtab_off + off:end].decode("ascii", "replace")

    for i in range(1, e_shnum):
        s_name, s_type, s_flags, s_addr, s_off, s_size = sh(i)[:6]
        if not (s_flags & SHF_ALLOC) or s_type == SHT_NOBITS or not s_size:
            continue
        yield name(s_name), s_addr, elf[s_off:s_off + s_size]


def build(elf_path: Path):
    elf = elf_path.read_bytes()
    secs = list(sections(elf))
    hdr = [d for n, a, d in secs if n == ".header"]
    if not hdr or len(hdr[0]) != HDR or not hdr[0].startswith(b"PS-X EXE"):
        sys.exit("[elf_to_exe] no 0x800-byte `.header` section starting with 'PS-X EXE'")
    header = hdr[0]
    pc0, gp0, t_addr, t_size = struct.unpack_from("<IIII", header, 0x10)
    if t_size % 0x800:
        sys.exit(f"[elf_to_exe] header t_size {t_size:#x} is not a multiple of 2048")

    exe = bytearray(HDR + t_size)
    exe[:HDR] = header
    covered = bytearray(t_size)
    skipped = []
    end = t_addr + t_size
    for name, vma, data in secs:
        if name == ".header":
            continue
        lo, hi = max(vma, t_addr), min(vma + len(data), end)
        if lo >= hi:
            skipped.append((name, vma, len(data)))
            continue
        exe[HDR + lo - t_addr: HDR + hi - t_addr] = data[lo - vma: hi - vma]
        covered[lo - t_addr: hi - t_addr] = b"\1" * (hi - lo)
    return bytes(exe), dict(pc0=pc0, gp0=gp0, t_addr=t_addr, t_size=t_size), \
        covered, skipped


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    flags = sys.argv[1:]
    elf_path = Path(args[0]) if args else ROOT / "build" / "full_link" / "full.elf"
    out_path = Path(args[1]) if len(args) > 1 else elf_path.with_name("nfs4.exe")
    rom_path = None
    if "--no-compare" not in flags:
        rom_path = ROOT / "rom" / "nfs4-f.exe"
        if "--rom" in flags:
            rom_path = Path(flags[flags.index("--rom") + 1])
    if not elf_path.is_file():
        sys.exit(f"[elf_to_exe] no ELF at {elf_path} -- run tools/full_link.py first")

    exe, h, covered, skipped = build(elf_path)
    out_path.write_bytes(exe)
    print(f"[exe] {out_path}  {len(exe)} bytes")
    print(f"[exe] header: pc0 {h['pc0']:#010x}  t_addr {h['t_addr']:#010x}  "
          f"t_size {h['t_size']:#x}  gp0 {h['gp0']:#x}")
    uncov = len(covered) - sum(covered)
    print(f"[exe] load image bytes not provided by any section (left zero): {uncov}")
    if skipped:
        print(f"[exe] sections outside the load image, not written: {len(skipped)} "
              f"(e.g. {', '.join('%s@%#x' % (n, a) for n, a, _ in skipped[:3])})")

    if rom_path and rom_path.is_file():
        rom = rom_path.read_bytes()
        if len(rom) != len(exe):
            print(f"[cmp] size differs: exe {len(exe)} vs {rom_path.name} {len(rom)}")
        n = min(len(rom), len(exe))
        same = sum(1 for i in range(n) if exe[i] == rom[i])
        hole_diff = sum(1 for i in range(HDR, n) if not covered[i - HDR] and exe[i] != rom[i])
        print(f"[cmp] vs {rom_path.name}: header {'identical' if exe[:HDR] == rom[:HDR] else 'DIFFERS'}; "
              f"{same}/{n} bytes identical ({100.0 * same / n:.4f}%), {n - same} differ "
              f"({hole_diff} of them in uncovered holes)")
        if exe == rom:
            print("[cmp] MATCH (byte-identical)")
    elif rom_path:
        print(f"[cmp] skipped: {rom_path} not found")


if __name__ == "__main__":
    main()
