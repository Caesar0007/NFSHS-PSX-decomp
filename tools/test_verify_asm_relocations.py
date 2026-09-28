"""Regression tests for comparison-only relocation handling (no binary edits).

Load the real normalizer functions through AST, avoiding verify_asm's CLI
compile side effects. Fixtures model unlinked objdump output; linked-address
correctness is independently checked by honest_measure, not these tests.
"""
import ast
from pathlib import Path
import re
import unittest


class RelocationTests(unittest.TestCase):
    def setUp(self):
        source = Path(__file__).with_name('verify_asm.py')
        tree = ast.parse(source.read_text())
        functions = [node for node in tree.body if isinstance(node, ast.FunctionDef)
                     and node.name in ('norm_ins', 'ours')]
        self.env = dict(re=re, _COP0={}, _resolve=lambda name: name,
                        _oracle_alabels=lambda *args: set(),
                        _compiler_debug_label=lambda name: False)
        exec(compile(ast.Module(body=functions, type_ignores=[]), str(source), 'exec'), self.env)

    def normalize(self, instruction, relocation=None):
        self.env['dis'] = '00000000 <probe>:\n   0:\t3c020004 \t' + instruction + '\n'
        if relocation:
            self.env['dis'] += '   0:\t' + relocation + ' bigBuf\n'
        return self.env['ours']('probe')[0]

    def test_hi16_large_addend(self):
        self.assertEqual(self.normalize('lui v0,0x4', 'R_MIPS_HI16'), 'lui v0,0')

    def test_hi16_signed_low_carry(self):
        self.assertEqual(self.normalize('lui v0,0x5', 'R_MIPS_HI16'), 'lui v0,0')

    def test_literal_high_without_relocation_is_not_masked(self):
        self.assertEqual(self.normalize('lui v0,0x4'), 'lui v0,4')

    def test_register_difference_is_not_masked(self):
        self.assertNotEqual(self.normalize('lui a0,0x4', 'R_MIPS_HI16'), 'lui v0,0')

    def test_non_lui_with_hi16_is_not_masked(self):
        self.assertEqual(self.normalize('addiu v0,v0,4', 'R_MIPS_HI16'), 'addiu v0,v0,4')

    def test_existing_lo16_addend_handling(self):
        self.assertEqual(self.normalize('addiu v0,v0,19728', 'R_MIPS_LO16'), 'addiu v0,v0,0')

    def test_literal_low_without_relocation_is_not_masked(self):
        self.assertEqual(self.normalize('addiu v0,v0,19728'), 'addiu v0,v0,19728')

    def test_existing_gp_relative_addend_handling(self):
        self.assertEqual(self.normalize('lw v0,4(gp)', 'R_MIPS_GPREL16'), 'lw v0,0(gp)')


if __name__ == '__main__':
    unittest.main()
