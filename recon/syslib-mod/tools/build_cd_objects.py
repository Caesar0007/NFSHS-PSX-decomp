#!/usr/bin/env python3
"""Build the compact resident CD core on its intended PsyQ 2.7.2/-G0 lane.

The main tree deliberately has no permanent PER_TU_FLAGS entries for the
experimental syslib-mod sources.  Apply the flags in-process so this staged
experiment cannot change the retail reconstruction build.
"""

import json
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "tools"))
import build as nfs4_build  # noqa: E402


SOURCES = (
    ROOT / "recon/syslib-mod/psx/libcd/core_api.c",
    ROOT / "recon/syslib-mod/psx/libcd/media_api.c",
    ROOT / "recon/syslib-mod/psx/libcd/drv_core.c",
    # These five wrappers are required by the restored CdRead/STR overlay.
    # Keeping them in the compact resident image lets the old SYS.OBJ text
    # become allocator-owned during a race without special movie patching.
    ROOT / "recon/syslib-mod/psx/libcd/movie_bridge.c",
    ROOT / "recon/syslib-mod/psx/libcd/cd_arena.c",
)
OUTPUT = ROOT / "build/recon/syslib-mod/psx/libcd/race_core_combined.o"

# Retail storage made unreachable by the compact redirects. Entry veneers and
# public ABI state (callbacks/status/position/mode/StMode) are deliberately
# absent. The compact CD arena serves these discontiguous pieces in this order.
RANGES = (
    (0x800E8450,308),(0x800E858C,320),(0x800F7788,8),(0x800F7798,8),
    (0x800F77A8,4),(0x800F77B4,100),(0x800F7820,24),(0x800F7840,12),
    (0x800F7854,24),(0x800F7874,24),(0x800F7894,12),(0x800F78A8,12),
    (0x800F78BC,308),(0x800F79F8,300),(0x800F7B2C,324),(0x800F7C78,24),
    (0x800F7C98,24),(0x800F7CB8,28),(0x800F7CDC,24),(0x800F7CFC,252),
    (0x800F7E00,120),(0x80107088,1364),(0x801075E4,632),(0x80107864,704),
    (0x80107B2C,1028),(0x80107F38,204),(0x8010800C,232),(0x801080FC,68),
    (0x80108148,472),(0x80108328,352),(0x80108490,248),(0x80108590,228),
    (0x8010867C,4),(0x80108688,208),(0x80109094,316),(0x801092A4,576),
    (0x80056C18,22),(0x80057100,5),(0x80057638,608),(0x800578E8,21),
    (0x80057908,62),(0x80136A18,128),(0x8013BF40,8),(0x8013BF6C,756),
    (0x8013C2D8,8),(0x8014899C,48),
)


def main() -> None:
    table = ROOT / "recon/syslib-mod/psx/libcd/cd_arena_table.inc"
    table.write_text(
        "#define NFS4_CD_ARENA_COUNT %d\n" % len(RANGES)
        + "static const u32 nfs4_cd_arena_start[NFS4_CD_ARENA_COUNT]={\n "
        + ",".join("0x%08X" % address for address, _ in RANGES)
        + "\n};\nstatic const unsigned short nfs4_cd_arena_size[NFS4_CD_ARENA_COUNT]={\n "
        + ",".join(str(size) for _, size in RANGES)
        + "\n};\n",
        encoding="ascii",
    )
    (table.parent / "retired_cd_ranges.json").write_text(
        json.dumps(
            {
                "schema": "nfs4-syslib-retired-cd-ranges-v1",
                "total_bytes": sum(size for _, size in RANGES),
                "ranges": [
                    {
                        "name": "retired_cd_%02d" % index,
                        "va": "%08X" % address,
                        "size": size,
                        "allocator": "cd",
                    }
                    for index, (address, size) in enumerate(RANGES)
                ],
            },
            indent=2,
        )
        + "\n",
        encoding="ascii",
    )
    objects = []
    for source in SOURCES:
        relative = source.relative_to(ROOT).as_posix()
        nfs4_build.PER_TU_FLAGS[relative] = {
            "cc1_272": True,
            "g_value": "0",
        }
        objects.append(nfs4_build.compile_c(source, False))

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    result = subprocess.run(
        [str(nfs4_build.LD), "-r", "-o", str(OUTPUT), *map(str, objects)],
        cwd=ROOT,
        capture_output=True,
        text=True,
    )
    if result.returncode:
        raise SystemExit(result.stdout + result.stderr)
    print(OUTPUT)


if __name__ == "__main__":
    main()
