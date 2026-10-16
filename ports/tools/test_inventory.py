import unittest
from inventory_asm import clean, decode, INSTRUCTION

class InventoryTests(unittest.TestCase):
    def test_empty_fence_constraints_are_not_code(self):
        self.assertEqual(decode('"" : : "r"(value), "r"(other) : "memory"'), '')

    def test_inline_macro_continuation_and_stringification(self):
        text='\\\n "\\t.set noreorder\\n" \\\n "\\tmtc2 %0,$" #REG "\\n" : : "r"(x)'
        value=decode(text)
        self.assertIn('mtc2',value)
        self.assertTrue(INSTRUCTION.search(value))
        self.assertNotIn('"r"',value)

    def test_comments_are_not_sites(self):
        self.assertNotIn('__asm__',clean('/* __asm__("jr $31"); */ int f;'))

    def test_symbol_alias_is_not_instruction(self):
        self.assertEqual(decode('"fixedmult"'),'fixedmult')
        self.assertIsNone(INSTRUCTION.search(decode('"fixedmult"')))

if __name__=='__main__':unittest.main()
