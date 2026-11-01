"""Read-only regression tests for actual sldprobe objdump grouping.

Load only the production disassembly-reader loop through AST: no compiler,
assembler, object, debug dump or source is modified by these fixtures.
"""
import ast
from pathlib import Path
import re
import unittest


class SldProbeSectionTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        source = Path(__file__).with_name('sldprobe.py')
        tree = ast.parse(source.read_text())
        loops = [node for node in tree.body if isinstance(node, ast.For)
                 and isinstance(node.iter, ast.Call)
                 and isinstance(node.iter.func, ast.Attribute)
                 and isinstance(node.iter.func.value, ast.Name)
                 and node.iter.func.value.id == 'dis'
                 and node.iter.func.attr == 'splitlines']
        assert len(loops) == 1
        cls.reader = compile(ast.Module(body=loops, type_ignores=[]), str(source), 'exec')

    def group(self, text, names=('kept',)):
        env = dict(re=re, dis=text, out={name: {} for name in names}, real={}, cur=None)
        exec(self.reader, env)
        return env['real']

    def test_text_strip_does_not_extend_preceding_kept_function(self):
        groups = self.group('''Disassembly of section .text:
00000000 <kept>:
   0: 03e00008 jr ra
   4: 00000000 nop
Disassembly of section .text.strip:
00000000 <unregistered_strip_helper>:
   0: 03e00008 jr ra
   4: 00000000 nop
''')
        self.assertEqual(len(groups['kept']), 2)
        self.assertEqual(len(groups['unregistered_strip_helper']), 2)

    def test_same_section_lm_labels_remain_in_their_function(self):
        groups = self.group('''Disassembly of section .text:
00000000 <kept>:
   0: 24020001 li v0,1
00000004 <LM18>:
   4: 03e00008 jr ra
   8: 00000000 nop
''')
        self.assertEqual(len(groups['kept']), 3)
        self.assertNotIn('LM18', groups)

    def test_same_section_non_ent_interior_label_is_not_a_boundary(self):
        groups = self.group('''Disassembly of section .text:
00000000 <kept>:
   0: 24020001 li v0,1
00000004 <case_alias>:
   4: 03e00008 jr ra
   8: 00000000 nop
''')
        self.assertEqual(len(groups['kept']), 3)

    def test_destructor_source_to_object_name_mapping_survives(self):
        groups = self.group('''Disassembly of section .text:
00000000 <___4Base>:
   0: 03e00008 jr ra
   4: 00000000 nop
Disassembly of section .text.strip:
00000000 <unregistered_strip_helper>:
   0: 03e00008 jr ra
   4: 00000000 nop
''', ('_._4Base',))
        self.assertEqual(len(groups['_._4Base']), 2)

    def test_strip_before_main_text_does_not_pollute_main(self):
        groups = self.group('''Disassembly of section .text.strip:
00000000 <strip_helper>:
   0: 03e00008 jr ra
   4: 00000000 nop
Disassembly of section .text:
00000000 <kept>:
   0: 03e00008 jr ra
   4: 00000000 nop
''')
        self.assertEqual(len(groups['kept']), 2)
        self.assertEqual(len(groups['strip_helper']), 2)

    def test_section_boundary_without_a_label_stops_attribution(self):
        groups = self.group('''Disassembly of section .text:
00000000 <kept>:
   0: 03e00008 jr ra
   4: 00000000 nop
Disassembly of section .text.other:
   0: 24020001 li v0,1
''')
        self.assertEqual(len(groups['kept']), 2)


if __name__ == '__main__':
    unittest.main()
