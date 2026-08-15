from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util

LI_DIV_RESULT_1 = [
    "0x340203E8",  # ori     v0,0x3e8    (ori)
    "0x340301F4",  # ori     v1,0x1f4
    "0x0043001A",  # div     zero,v0,v1
    "0x14600002",  # bnez    v1,0x18
    "0x00000000",  # nop
    "0x0007000D",  # break   0x7
    "0x2401FFFF",  # li      at,-1
    "0x14610004",  # bne     v1,at,0x30
    "0x3C018000",  # lui     at,0x8000
    "0x14410002",  # bne     v0,at,0x30
    "0x00000000",  # nop
    "0x0006000D",  # break   0x6
    "0x00002012",  # mflo    a0
]

LI_DIV_RESULT_2 = [
    "0x240203E8",  # addiu   v0,1000     (addiu)
    "0x240301F4",  # addiu   v1,200
    "0x0043001A",  # div     zero,v0,v1
    "0x14600002",  # bnez    v1,0x18
    "0x00000000",  # nop
    "0x0007000D",  # break   0x7
    "0x2401FFFF",  # li      at,-1
    "0x14610004",  # bne     v1,at,0x30
    "0x3C018000",  # lui     at,0x8000
    "0x14410002",  # bne     v0,at,0x30
    "0x00000000",  # nop
    "0x0006000D",  # break   0x6
    "0x00002012",  # mflo    a0
]

TESTS = {
    "source_asm": "ASM/LI_DIV.S",
    "versions": [
        {
            "aspsx_version": "2.21",
            "target_asm": LI_DIV_RESULT_1,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": LI_DIV_RESULT_1,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": LI_DIV_RESULT_2,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": LI_DIV_RESULT_2,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": LI_DIV_RESULT_2,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": LI_DIV_RESULT_2,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": LI_DIV_RESULT_2,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": LI_DIV_RESULT_2,
        },
    ],
}


class TestLiDiv(unittest.TestCase):
    def test_li_div(self):
        source_asm = Path(__file__).parent / TESTS["source_asm"]

        for version in TESTS["versions"]:
            with self.subTest(version=version):
                target_asm = version["target_asm"]
                print(f"{source_asm.name}: {version['aspsx_version']}")
                instructions = util.run_aspsx(source_asm, version)
                self.assertEqual(target_asm, instructions)
