from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util

LA_TEST_RESULT_NO_GP = [
    "0x3C040000",  # lui         $a0, 0x0
    "0x24840000",  # addiu       $a0, $a0, 0x0
]

LA_TEST_RESULT_GP = [
    "0x27840000",  # addiu       $a0, $gp, 0x0
]

TESTS = {
    "source_asm": "ASM/LA.S",
    "versions": [
        {
            "aspsx_version": "1.07",
            "target_asm": LA_TEST_RESULT_NO_GP,
        },
        {
            "aspsx_version": "2.08",
            "target_asm": LA_TEST_RESULT_NO_GP,
        },
        {
            "aspsx_version": "2.21",
            "target_asm": LA_TEST_RESULT_NO_GP,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": LA_TEST_RESULT_NO_GP,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": LA_TEST_RESULT_NO_GP,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": LA_TEST_RESULT_NO_GP,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": LA_TEST_RESULT_NO_GP,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": LA_TEST_RESULT_NO_GP,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": LA_TEST_RESULT_GP,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": LA_TEST_RESULT_GP,
        },
    ],
}


class TestLa(unittest.TestCase):
    def test_la(self):
        source_asm: Path = Path(__file__).parent / TESTS["source_asm"]

        for version in TESTS["versions"]:
            with self.subTest(version=version):
                target_asm = version["target_asm"]
                print(f"{source_asm.name}: {version['aspsx_version']}")
                instructions = util.run_aspsx(source_asm, version, data_limit="-G999")
                self.assertEqual(target_asm, instructions)
