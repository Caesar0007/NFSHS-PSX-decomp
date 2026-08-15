import unittest

from maspsx import MaspsxProcessor


from .util import strip_comments


class TestIncludeAsmHack(unittest.TestCase):

    def test_include_asm_hack(self):
        lines = [
            "\t.globl func_before",
            "\t.ent\t__maspsx_include_asm_hack_example",
            "__maspsx_include_asm_hack_example:",
            '\t.include "asm/example.s" # maspsx-keep',
            "\tj\t$31",
            ".end\t__maspsx_include_asm_hack_example",
            "\t.globl func_after",
        ]
        expected_lines = [
            ".globl func_before",
            '.include "asm/example.s"',
            ".globl func_after",
        ]

        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)
