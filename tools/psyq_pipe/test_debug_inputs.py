"""Full-debug selections must not silently omit explicit C requests."""
import tempfile
import unittest
from pathlib import Path
from debug_inputs import select_debug_sources, full_debug_command


class DebugInputTests(unittest.TestCase):
    def tree(self, directory):
        root = Path(directory)
        for relative in ('game/a.cpp', 'frontend/b.cpp', 'eaclib/psx/pad.c',
                         'syslib/lib/x.c', 'game-mod/bad.c', 'game/tests/test.c',
                         'game/ignored.cpp.bak'):
            path = root/'recon'/relative
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text('')
        return root

    def test_default_scope_unchanged(self):
        with tempfile.TemporaryDirectory() as directory:
            root = self.tree(directory)
            self.assertEqual({p.name for p in select_debug_sources(root, [])}, {'a.cpp', 'b.cpp'})

    def test_explicit_c_and_cpp_are_selected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = self.tree(directory)
            self.assertEqual({p.name for p in select_debug_sources(root,
                ['recon\\eaclib\\psx\\pad.c', 'game/a.cpp'])}, {'pad.c', 'a.cpp'})

    def test_every_fragment_must_match(self):
        with tempfile.TemporaryDirectory() as directory:
            root = self.tree(directory)
            with self.assertRaises(ValueError):
                select_debug_sources(root, ['game/a.cpp', 'missing.c'])

    def test_side_trees_and_backups_cannot_be_selected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = self.tree(directory)
            for fragment in ('game-mod', 'game/tests', 'ignored.cpp.bak', ''):
                with self.assertRaises(ValueError):
                    select_debug_sources(root, [fragment])

    def test_c_compiler_gets_full_debug(self):
        original = ['C:\\compiler\\CC1.EXE', '-O2', '-g1', '-G0']
        self.assertEqual(full_debug_command(original),
                         ['C:\\compiler\\CC1.EXE', '-O2', '-g', '-G0'])
        self.assertEqual(original[2], '-g1')

    def test_cpp_compiler_gets_full_debug(self):
        self.assertEqual(full_debug_command(['CC1PLPSX.EXE', '-O2']),
                         ['CC1PLPSX.EXE', '-g', '-O2'])

    def test_noncompiler_is_unchanged(self):
        self.assertEqual(full_debug_command(['cpp.exe', '-g1']), ['cpp.exe', '-g1'])

    def test_existing_full_debug_is_not_duplicated(self):
        self.assertEqual(full_debug_command(['cc1.exe', '-g3']), ['cc1.exe', '-g3'])


if __name__ == '__main__':
    unittest.main()
