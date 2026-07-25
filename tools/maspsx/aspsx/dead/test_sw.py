from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util

SW_AT_RESULT_NOP = [
    "0x3C010001",  # lui         $at, 0x1
    "0x00810821",  # addu        $at, $a0, $at
    "0xAC22DB88",  # sw          $v0, -0x2478($at)
    "0xAC820064",  # sw          $v0, 0x64($a0)
    "0x3C01FFFF",  # lui         $at, 0xFFFF
    "0x00810821",  # addu        $at, $a0, $at
    "0xAC222478",  # sw          $v0, 0x2478($at)
    "0xAC82FF9C",  # sw          $v0, -0x64($a0)
]

TESTS = {
    "source_asm": "ASM/SW_AT.S",
    "versions": [
        {
            "aspsx_version": "2.21",
            "target_asm": SW_AT_RESULT_NOP,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": SW_AT_RESULT_NOP,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": SW_AT_RESULT_NOP,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": SW_AT_RESULT_NOP,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": SW_AT_RESULT_NOP,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": SW_AT_RESULT_NOP,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": SW_AT_RESULT_NOP,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": SW_AT_RESULT_NOP,
        },
    ],
}


class TestSwAt(unittest.TestCase):
    def test_sw_at(self):
        source_asm = Path(__file__).parent / TESTS["source_asm"]

        for version in TESTS["versions"]:
            with self.subTest(version=version):
                target_asm = version["target_asm"]
                print(f"{source_asm.name}: {version['aspsx_version']}")
                instructions = util.run_aspsx(source_asm, version)
                self.assertEqual(target_asm, instructions)
