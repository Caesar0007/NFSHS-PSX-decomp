from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util

GP_OFFSET_TEST_RESULT_NO_GP_ANY = [
    "0x3C040000",  # lui         $a0, 0x0
    "0x8C840000",  # lw          $a0, 0x0($a0)
    "0x3C060000",  # lui         $a2, 0x0
    "0x8CC60000",  # lw          $a2, 0x0($a2)
]

GP_OFFSET_TEST_RESULT_NO_GP_COMM = [
    # comm
    "0x3C040000",  # lui         $a0, 0x0
    "0x8C840000",  # lw          $a0, 0x0($a0)
    # lcomm
    "0x8F860000",  # lw          $a2, 0x0($gp)
]

GP_OFFSET_TEST_RESULT_GP_ALL = [
    # comm
    "0x8F840000",  # lw          $a0, 0x0($gp)
    # lcomm
    "0x8F860000",  # lw          $a2, 0x0($gp)
]

TESTS = {
    "source_asm": "ASM/GP_OFFST.S",
    "versions": [
        {
            "aspsx_version": "1.07",
            "target_asm": GP_OFFSET_TEST_RESULT_NO_GP_ANY,
        },
        {
            "aspsx_version": "2.08",
            "target_asm": GP_OFFSET_TEST_RESULT_NO_GP_ANY,
        },
        {
            "aspsx_version": "2.21",
            "target_asm": GP_OFFSET_TEST_RESULT_NO_GP_COMM,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": GP_OFFSET_TEST_RESULT_NO_GP_COMM,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": GP_OFFSET_TEST_RESULT_NO_GP_COMM,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": GP_OFFSET_TEST_RESULT_NO_GP_COMM,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": GP_OFFSET_TEST_RESULT_GP_ALL,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": GP_OFFSET_TEST_RESULT_GP_ALL,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": GP_OFFSET_TEST_RESULT_GP_ALL,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": GP_OFFSET_TEST_RESULT_GP_ALL,
        },
    ],
}


class TestGpOffset(unittest.TestCase):
    def test_gp_offset(self):
        source_asm: Path = Path(__file__).parent / TESTS["source_asm"]

        for version in TESTS["versions"]:
            with self.subTest(version=version):
                target_asm = version["target_asm"]
                print(f"{source_asm.name}: {version['aspsx_version']}")
                instructions = util.run_aspsx(source_asm, version, data_limit="-G999")
                self.assertEqual(target_asm, instructions)
