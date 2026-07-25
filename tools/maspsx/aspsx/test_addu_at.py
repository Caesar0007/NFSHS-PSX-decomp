from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util

ADDU_AT_TEST_RESULT = [
    # lh	$2,32767($2)
    "0x84427FFF",  # lh          $v0, 0x7FFF($v0)
    # nop
    "0x00000000",
    # lh	$2,32768($2)
    "0x3C010001",  # lui         $at, 0x1
    "0x00410821",  # addu        $at, $v0, $at
    "0x84228000",  # lh          $v0, -0x8000($at)
    # nop
    "0x00000000",
    # lh	$2,-32768($2)
    "0x84428000",  # lh          $v0, -0x8000($v0)
    # nop
    "0x00000000",
    # lh	$2,-32769($2)
    "0x3C01FFFF",  # lui         $at, 0xFFFF
    "0x00410821",  # addu        $at, $v0, $at
    "0x84227FFF",  # lh          $v0, 0x7FFF($at)
]

ADDU_AT_TEST_RESULT_2 = [
    # lh	$2,32767($2)
    "0x84427FFF",  # lh          $v0, 0x7FFF($v0)
    # lh	$2,32768($2)
    "0x3C010001",  # lui         $at, 0x1
    "0x00410821",  # addu        $at, $v0, $at
    "0x84228000",  # lh          $v0, -0x8000($at)
    # nop
    "0x00000000",
    # lh	$2,-32768($2)
    "0x84428000",  # lh          $v0, -0x8000($v0)
    # lh	$2,-32769($2)
    "0x3C01FFFF",  # lui         $at, 0xFFFF
    "0x00410821",  # addu        $at, $v0, $at
    "0x84227FFF",  # lh          $v0, 0x7FFF($at)
]

TESTS = {
    "source_asm": "ASM/ADDU.S",
    "versions": [
        {
            "aspsx_version": "1.07",
            "target_asm": ADDU_AT_TEST_RESULT,
        },
        {
            "aspsx_version": "2.08",
            "target_asm": ADDU_AT_TEST_RESULT,
        },
        {
            "aspsx_version": "2.21",
            "target_asm": ADDU_AT_TEST_RESULT,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": ADDU_AT_TEST_RESULT_2,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": ADDU_AT_TEST_RESULT_2,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": ADDU_AT_TEST_RESULT_2,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": ADDU_AT_TEST_RESULT_2,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": ADDU_AT_TEST_RESULT_2,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": ADDU_AT_TEST_RESULT_2,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": ADDU_AT_TEST_RESULT_2,
        },
    ],
}


class TestAtExpansion(unittest.TestCase):
    def test_at_expansion(self):
        source_asm: Path = Path(__file__).parent / TESTS["source_asm"]

        for version in TESTS["versions"]:
            with self.subTest(version=version):
                target_asm = version["target_asm"]
                print(f"{source_asm.name}: {version['aspsx_version']}")
                instructions = util.run_aspsx(source_asm, version)
                self.assertEqual(target_asm, instructions)
