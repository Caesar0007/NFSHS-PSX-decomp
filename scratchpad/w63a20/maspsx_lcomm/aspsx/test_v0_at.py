from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util

V0_AT_RESULT_NOP = [
    "0x3C020000",  # lui   v0,0x0
    "0x8C420000",  # lw    v0,0(v0)
    "0x00000000",  # nop
    "0x3C010000",  # lui   at,0x0
    "0xAC220000",  # sw    v0,0(at)
]

V0_AT_RESULT_NO_NOP = [
    "0x3C020000",  # lui   v0,0x0
    "0x8C420000",  # lw    v0,0(v0)
    "0x3C010000",  # lui   at,0x0
    "0xAC220000",  # sw    v0,0(at)
]

TESTS = {
    "source_asm": "ASM/V0_AT.S",
    "versions": [
        {
            "aspsx_version": "1.07",
            "target_asm": V0_AT_RESULT_NOP,
        },
        {
            "aspsx_version": "2.08",
            "target_asm": V0_AT_RESULT_NOP,
        },
        {
            "aspsx_version": "2.21",
            "target_asm": V0_AT_RESULT_NOP,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": V0_AT_RESULT_NO_NOP,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": V0_AT_RESULT_NO_NOP,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": V0_AT_RESULT_NO_NOP,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": V0_AT_RESULT_NO_NOP,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": V0_AT_RESULT_NO_NOP,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": V0_AT_RESULT_NO_NOP,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": V0_AT_RESULT_NO_NOP,
        },
    ],
}


class TestV0At(unittest.TestCase):
    def test_v0_at(self):
        source_asm = Path(__file__).parent / TESTS["source_asm"]

        for version in TESTS["versions"]:
            with self.subTest(version=version):
                target_asm = version["target_asm"]
                print(f"{source_asm.name}: {version['aspsx_version']}")
                instructions = util.run_aspsx(source_asm, version, data_limit="-G8")
                self.assertEqual(target_asm, instructions)
