from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util

NOP_GP_RESULT_NOP = [
    "0x8F820000",
    "0x00000000",
    "0xAF820000",
]

TESTS = {
    "source_asm": "ASM/NOP_GP.S",
    "versions": [
        {
            "aspsx_version": "2.21",
            "target_asm": NOP_GP_RESULT_NOP,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": NOP_GP_RESULT_NOP,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": NOP_GP_RESULT_NOP,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": NOP_GP_RESULT_NOP,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": NOP_GP_RESULT_NOP,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": NOP_GP_RESULT_NOP,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": NOP_GP_RESULT_NOP,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": NOP_GP_RESULT_NOP,
        },
    ],
}


class TestNopGp(unittest.TestCase):
    """
    This test gives the same result across all assembler versions
    so the functionality has been simplified in maspsx.
    """

    def test_nop_gp(self):
        source_asm = Path(__file__).parent / TESTS["source_asm"]

        for version in TESTS["versions"]:
            with self.subTest(version=version):
                target_asm = version["target_asm"]
                print(f"{source_asm.name}: {version['aspsx_version']}")
                instructions = util.run_aspsx(source_asm, version, data_limit="-G8")
                self.assertEqual(target_asm, instructions)
