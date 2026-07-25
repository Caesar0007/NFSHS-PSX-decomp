from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util

EXPAND_SW_TEST_RESULT_1 = [
    "0x3C010000",  # lui         $at, 0x0
    "0x24210000",  # addiu       $at, $at, 0x0
    "0x00220821",  # addu        $at, $at, $v0
    "0xAC240000",  # lw          $v0, 0x0($at)
]

EXPAND_SW_TEST_RESULT_2 = [
    "0x3C010000",  # lui         $at, 0x0
    "0x00220821",  # addu        $at, $at, $v0
    "0xAC240000",  # lw          $v0, 0x0($at)
]

TESTS = {
    "source_asm": "ASM/EXPND_SW.S",
    "versions": [
        {
            "aspsx_version": "1.07",
            "target_asm": EXPAND_SW_TEST_RESULT_1,
        },
        {
            "aspsx_version": "2.08",
            "target_asm": EXPAND_SW_TEST_RESULT_1,
        },
        {
            "aspsx_version": "2.21",
            "target_asm": EXPAND_SW_TEST_RESULT_1,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": EXPAND_SW_TEST_RESULT_2,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": EXPAND_SW_TEST_RESULT_2,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": EXPAND_SW_TEST_RESULT_2,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": EXPAND_SW_TEST_RESULT_2,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": EXPAND_SW_TEST_RESULT_2,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": EXPAND_SW_TEST_RESULT_2,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": EXPAND_SW_TEST_RESULT_2,
        },
    ],
}


class TestExpandSw(unittest.TestCase):
    def test_expand_sw(self):
        source_asm: Path = Path(__file__).parent / TESTS["source_asm"]

        for version in TESTS["versions"]:
            with self.subTest(version=version):
                target_asm = version["target_asm"]
                print(f"{source_asm.name}: {version['aspsx_version']}")
                instructions = util.run_aspsx(source_asm, version)
                self.assertEqual(target_asm, instructions)
