"""Whole-TU retail debug mode changes compiler input only.

2026-10-16: regression tests for FEMenuDefs' native full-debug identity.
AST-load the real command builder, stop before compilation, and never rewrite
compiler output or invoke the toolchain. New test file; no predecessor.
"""
import ast
from pathlib import Path
from types import SimpleNamespace
import tempfile
import unittest

from debug_inputs import full_debug_command

BUILD = Path(__file__).resolve().parents[1] / 'build.py'


class StopBeforeCompiler(Exception):
    pass


class RetailDebugModeTests(unittest.TestCase):
    def commands(self, flags):
        tree = ast.parse(BUILD.read_text(encoding='utf-8'))
        fn = next(n for n in tree.body if isinstance(n, ast.FunctionDef)
                  and n.name == 'compile_cpp')
        calls = []

        def run(command):
            calls.append(command)
            if len(calls) == 2:
                raise StopBeforeCompiler
            return SimpleNamespace(returncode=0)

        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            context = dict(ROOT=root, OUT=root/'out', RECON=root/'recon',
                G_VALUE='4', CPP=Path('cpp.exe'), run=run,
                per_tu_flags=lambda _: flags,
                cpp_compiler=lambda _: Path('CC1PLPSX.EXE'))
            exec(compile(ast.Module(body=[fn], type_ignores=[]), str(BUILD), 'exec'), context)
            with self.assertRaises(StopBeforeCompiler):
                context['compile_cpp'](root/'recon/frontend/common/example.cpp')
            self.assertEqual(len(calls), 2)
            return [str(v) for v in calls[1]]

    def test_full_debug_is_one_input_flag_with_other_flags_preserved(self):
        flags = dict(no_implement_inlines=True, g_value='0')
        plain = self.commands(flags)
        debug = self.commands(dict(flags, debug_g=True))
        self.assertEqual(debug.count('-g'), 1)
        # Temporary directory inputs differ, so compare only option sequences.
        self.assertEqual([s for s in debug if s.startswith('-') and s != '-g'],
                         [s for s in plain if s.startswith('-')])
        self.assertIn('-G0', debug)
        self.assertIn('-fno-implement-inlines', debug)

    def test_absent_or_false_opt_in_keeps_default_unchanged(self):
        for flags in ({}, {'debug_g': False}):
            self.assertNotIn('-g', self.commands(flags))

    def test_debug_twin_does_not_add_another_debug_flag(self):
        command = self.commands({'debug_g': True})
        self.assertEqual(full_debug_command(command), command)

    def test_femenudefs_has_explicit_whole_tu_opt_in(self):
        tree = ast.parse(BUILD.read_text(encoding='utf-8'))
        table = next(n.value for n in tree.body if isinstance(n, ast.Assign)
            and any(isinstance(t, ast.Name) and t.id == 'PER_TU_FLAGS' for t in n.targets))
        selected = [ast.literal_eval(v) for k, v in zip(table.keys, table.values)
            if isinstance(k, ast.Constant) and k.value == 'recon/frontend/common/femenudefs.cpp']
        self.assertEqual(len(selected), 1)
        self.assertIs(selected[0]['debug_g'], True)


if __name__ == '__main__':
    unittest.main()
