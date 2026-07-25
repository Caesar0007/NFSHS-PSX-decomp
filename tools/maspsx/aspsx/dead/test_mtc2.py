from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util

MTC2_RESULT = [
    "0x96480172",  # lhu         $t0, 0x172($s2)
    "0x00000000",  # nop
    "0x48884000",  # mtc2        $t0, $8
]


TESTS = {
    "source_asm": "ASM/MTC2.S",
    "versions": [
        {
            "aspsx_version": "2.08",
            "target_asm": MTC2_RESULT,
        },
        {
            "aspsx_version": "2.21",
            "target_asm": MTC2_RESULT,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": MTC2_RESULT,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": MTC2_RESULT,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": MTC2_RESULT,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": MTC2_RESULT,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": MTC2_RESULT,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": MTC2_RESULT,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": MTC2_RESULT,
        },
    ],
}


class TestMtc2(unittest.TestCase):
    def test_mtc2(self):
        source_asm: Path = Path(__file__).parent / TESTS["source_asm"]

        for version in TESTS["versions"]:
            with self.subTest(version=version):
                target_asm = version["target_asm"]
                print(f"{source_asm.name}: {version['aspsx_version']}")
                instructions = util.run_aspsx(source_asm, version)
                self.assertEqual(target_asm, instructions)
