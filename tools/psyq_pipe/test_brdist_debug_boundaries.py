"""Full-debug labels cannot truncate real branch evidence (2026-10-16).

AST-load the read-only parser only; no toolchain calls or output rewrites.
"""
import ast
from pathlib import Path
import re
import unittest


class BranchDebugBoundaryTests(unittest.TestCase):
    def parse(self, text, interior=()):
        path = Path(__file__).resolve().parents[1] / 'brdist.py'
        tree = ast.parse(path.read_text(encoding='utf-8'))
        fn = next(n for n in tree.body if isinstance(n, ast.FunctionDef)
                  and n.name == 'ours_branches')
        context = dict(re=re, dis=text, BR=re.compile(r'^\s*(b\w*|j)\b'), g={
            '_resolve': lambda name: name,
            '_oracle_alabels': lambda _: set(interior),
            '_compiler_debug_label': lambda name: re.fullmatch(r'LM\d+', name) is not None})
        exec(compile(ast.Module(body=[fn], type_ignores=[]), str(path), 'exec'), context)
        return context['ours_branches']('target')

    def test_branch_after_debug_label_and_blank_is_not_lost(self):
        text = ('00000000 <target>:\n   0:\t00000000\tnop\n\n'
                '00000004 <LM12>:\n   4:\t1000fffe\tb 0 <target>\n'
                '   8:\t00000000\tnop\n')
        self.assertEqual(self.parse(text), [(1, -1)])

    def test_real_next_function_is_not_swallowed(self):
        text = ('00000000 <target>:\n   0:\t00000000\tnop\n\n'
                '00000004 <other>:\n   4:\t1000fffe\tb 0 <target>\n')
        self.assertEqual(self.parse(text), [])

    def test_retail_alabel_remains_inside_only_when_declared(self):
        text = ('00000000 <target>:\n   0:\t00000000\tnop\n\n'
                '00000004 <inside>:\n   4:\t10000001\tb c <inside+0x8>\n')
        self.assertEqual(self.parse(text, ('inside',)), [(1, 2)])
        self.assertEqual(self.parse(text), [])

    def test_debug_like_real_name_is_not_ignored(self):
        text = ('00000000 <target>:\n   0:\t00000000\tnop\n'
                '00000004 <LMreal>:\n   4:\t1000fffe\tb 0 <target>\n')
        self.assertEqual(self.parse(text), [])

    def test_real_distance_difference_stays_visible(self):
        def make(destination):
            return ('00000000 <target>:\n   0:\t00000000\tnop\n\n'
                '00000004 <LM1>:\n   4:\t10000001\tb '+destination+' <target>\n')
        self.assertNotEqual(self.parse(make('c')), self.parse(make('10')))


if __name__ == '__main__':
    unittest.main()
