from pathlib import Path
import unittest

import sys

sys.path.insert(0, str(Path(__file__).parent))

import util


EXPAND_LI_RESULT_1 = [
    "0x34020000",  # ori   $v0,$zero,0x0
    "0x3C020001",  # lui	v0,0x1
    "0x3C020001",  # lui	v0,0x1
    "0x34420001",  # ori	v0,v0,0x1
    "0x3C020001",  # lui	v0,0x1
    "0x34421000",  # ori	v0,v0,0x1000
    "0x2402FFFF",  # addiu $v0,$zero,-0x1
    "0x24028000",  # addiu $v0,$zero,-0x8000
    "0x3C02FFFF",  # lui	v0,0xffff
    "0x34427FFF",  # ori	v0,v0,0x7fff
    "0x3C02FFFF",  # lui	v0,0xffff
    "0x34427000",  # ori	v0,v0,0x7000
]

EXPAND_LI_RESULT_2 = [
    "0x24020000",  # addiu $v0, $zero, 0x0
    "0x3C020001",  # lui	v0,0x1
    "0x3C020001",  # lui	v0,0x1
    "0x34420001",  # ori	v0,v0,0x1
    "0x3C020001",  # lui	v0,0x1
    "0x34421000",  # ori	v0,v0,0x1000
    "0x2402FFFF",  # addiu $v0,$zero,-0x1
    "0x24028000",  # addiu $v0,$zero,-0x8000
    "0x3C02FFFF",  # lui	v0,0xffff
    "0x34427FFF",  # ori	v0,v0,0x7fff
    "0x3C02FFFF",  # lui	v0,0xffff
    "0x34427000",  # ori	v0,v0,0x7000
]

TESTS = {
    "source_asm": "ASM/EXPND_LI.S",  # 8.3 filenames
    "versions": [
        {
            "aspsx_version": "1.07",
            "target_asm": EXPAND_LI_RESULT_1,
        },
        {
            "aspsx_version": "2.08",
            "target_asm": EXPAND_LI_RESULT_1,
        },
        {
            "aspsx_version": "2.21",
            "target_asm": EXPAND_LI_RESULT_1,
        },
        {
            "aspsx_version": "2.34",
            "target_asm": EXPAND_LI_RESULT_1,
        },
        {
            "aspsx_version": "2.56",
            "target_asm": EXPAND_LI_RESULT_2,
        },
        {
            "aspsx_version": "2.67",
            "target_asm": EXPAND_LI_RESULT_2,
        },
        {
            "aspsx_version": "2.77",
            "target_asm": EXPAND_LI_RESULT_2,
        },
        {
            "aspsx_version": "2.79",
            "target_asm": EXPAND_LI_RESULT_2,
        },
        {
            "aspsx_version": "2.81",
            "target_asm": EXPAND_LI_RESULT_2,
        },
        {
            "aspsx_version": "2.86",
            "target_asm": EXPAND_LI_RESULT_2,
        },
    ],
}


class TestExpandLi(unittest.TestCase):
    def test_expand_li(self):
        source_asm = Path(__file__).parent / TESTS["source_asm"]

        for version in TESTS["versions"]:
            with self.subTest(version=version):
                target_asm = version["target_asm"]
                print(f"{source_asm.name}: {version['aspsx_version']}")
                instructions = util.run_aspsx(source_asm, version)
                self.assertEqual(target_asm, instructions)
