from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util

NO_GP_RESULT = [
    "0x3C020000",  # lui         $v0, 0x0
    "0x8C420000",  # lw          $v0, 0x0($v0)
    "0x3C040000",  # lui         $a0, 0x0
    "0x8C840000",  # lw          $a0, 0x0($a0)
]

GP_RESULT_1 = [
    "0x8F820000",  # lw          $v0, 0x0($gp)
    "0x3C040000",  # lui         $a0, 0x0
    "0x8C840000",  # lw          $a0, 0x0($a0)
]

GP_RESULT_2 = [
    "0x8F820000",  # lw          $v0, 0x0($gp)
    "0x8F840000",  # lw          $a0, 0x0($gp)
]


TESTS = {
    "source_asm": "ASM/GP.S",
    "versions": [
        {
            "aspsx_version": "1.07",
            "target_asm": NO_GP_RESULT,
        },
        {
            "aspsx_version": "2.08",
            "target_asm": NO_GP_RESULT,
        },
        {
            "aspsx_version": "2.21",
            "target_asm": GP_RESULT_1,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": GP_RESULT_1,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": GP_RESULT_1,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": GP_RESULT_1,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": GP_RESULT_2,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": GP_RESULT_2,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": GP_RESULT_2,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": GP_RESULT_2,
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
