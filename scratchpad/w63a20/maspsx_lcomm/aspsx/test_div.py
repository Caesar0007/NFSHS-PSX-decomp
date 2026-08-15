from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util

DIV_TEST_RESULT_TGE = [
    "0x0086001A",  # div         $zero, $a0, $a2
    "0x14C00002",  # bne         $a2, $zero, . + 4 + (0x2 << 2)
    "0x00000000",  # nop
    "0x0007000D",  # break       7
    "0x2401FFFF",  # addiu       $at, $zero, -0x1
    "0x14C10004",  # bne         $a2, $at, . + 4 + (0x4 << 2)
    "0x3C018000",  # lui         $at, 0x8000
    "0x14810002",  # bne         $a0, $at, . + 4 + (0x2 << 2)
    "0x00000000",  # nop
    "0x00001770",  # tge         $zero, $zero, 93
    "0x00001012",  # mflo        $v0
]

DIV_TEST_RESULT_BREAK = [
    "0x0086001A",  # div         $zero, $a0, $a2
    "0x14C00002",  # bne         $a2, $zero, . + 4 + (0x2 << 2)
    "0x00000000",  # nop
    "0x0007000D",  # break       7
    "0x2401FFFF",  # addiu       $at, $zero, -0x1
    "0x14C10004",  # bne         $a2, $at, . + 4 + (0x4 << 2)
    "0x3C018000",  # lui         $at, 0x8000
    "0x14810002",  # bne         $a0, $at, . + 4 + (0x2 << 2)
    "0x00000000",  # nop
    "0x0006000D",  # break       6
    "0x00001012",  # mflo        $v0
]

TESTS = {
    "source_asm": "ASM/DIV.S",
    "versions": [
        {
            "aspsx_version": "1.07",
            "target_asm": DIV_TEST_RESULT_BREAK,
        },
        {
            "aspsx_version": "2.08",
            "target_asm": DIV_TEST_RESULT_TGE,
        },
        {
            "aspsx_version": "2.21",
            "target_asm": DIV_TEST_RESULT_BREAK,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": DIV_TEST_RESULT_BREAK,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": DIV_TEST_RESULT_BREAK,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": DIV_TEST_RESULT_BREAK,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": DIV_TEST_RESULT_BREAK,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": DIV_TEST_RESULT_BREAK,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": DIV_TEST_RESULT_BREAK,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": DIV_TEST_RESULT_BREAK,
        },
    ],
}


class TestDiv(unittest.TestCase):
    def test_div(self):
        source_asm: Path = Path(__file__).parent / TESTS["source_asm"]

        for version in TESTS["versions"]:
            with self.subTest(version=version):
                target_asm = version["target_asm"]
                print(f"{source_asm.name}: {version['aspsx_version']}")
                instructions = util.run_aspsx(source_asm, version)
                self.assertEqual(target_asm, instructions)
