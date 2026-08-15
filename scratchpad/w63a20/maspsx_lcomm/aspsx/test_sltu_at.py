from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util

SLTU_TEST_RESULT_AT_1 = [
    "0x34030064",  # ori     v1,0x64
    "0x2401FFE9",  # li      at,-23
    "0x0061182B",  # sltu    v1,v1,at
]
SLTU_TEST_RESULT_AT_2 = [
    "0x24030064",  # addiu   v1,100
    "0x2401FFE9",  # li      at,-23
    "0x0061182B",  # sltu    v1,v1,at
]
SLTU_TEST_RESULT_NO_AT = [
    "0x24030064",  # addiu   v1,100
    "0x2C63FFE9",  # sltiu   v1,v1,-23
]

TESTS = {
    "source_asm": "ASM/SLTU_AT.S",
    "versions": [
        {
            "aspsx_version": "1.07",
            "target_asm": SLTU_TEST_RESULT_AT_1,
        },
        {
            "aspsx_version": "2.08",
            "target_asm": SLTU_TEST_RESULT_AT_1,
        },
        {
            "aspsx_version": "2.21",
            "target_asm": SLTU_TEST_RESULT_AT_1,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": SLTU_TEST_RESULT_AT_1,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": SLTU_TEST_RESULT_AT_2,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": SLTU_TEST_RESULT_NO_AT,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": SLTU_TEST_RESULT_NO_AT,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": SLTU_TEST_RESULT_NO_AT,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": SLTU_TEST_RESULT_NO_AT,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": SLTU_TEST_RESULT_NO_AT,
        },
    ],
}


class TestSltuAt(unittest.TestCase):
    def test_sltu_at(self):
        source_asm: Path = Path(__file__).parent / TESTS["source_asm"]

        for version in TESTS["versions"]:
            with self.subTest(version=version):
                target_asm = version["target_asm"]
                print(f"{source_asm.name}: {version['aspsx_version']}")
                instructions = util.run_aspsx(source_asm, version)
                self.assertEqual(target_asm, instructions)
