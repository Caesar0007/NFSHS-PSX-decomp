"""ASPSX failure-path controls without importing the executable lane script.

2026-10-12: native COMMON assembly exposed empty objects after an ASPSX crash.
The exact production predicate is evaluated against independently specified
file/exit-status cases. No compiler, source, reference or game object is changed.
"""
import ast
from collections import defaultdict
import os
import re
from pathlib import Path
from types import SimpleNamespace
import tempfile
import unittest


class AssemblyOutputTests(unittest.TestCase):
    def test_fresh_output_predicate(self):
        tree = ast.parse(Path(__file__).with_name('psylink_lane.py').read_text())
        nodes = [node for node in tree.body if isinstance(node, ast.FunctionDef)
                 and node.name == 'aspsx_output_ok']
        self.assertEqual(len(nodes), 1)
        namespace = {'re': re}
        exec(compile(ast.Module(body=nodes, type_ignores=[]), '<production-guard>', 'exec'), namespace)
        predicate = namespace['aspsx_output_ok']
        with tempfile.TemporaryDirectory(prefix='aspsx-output-test-') as tmp:
            obj = Path(tmp) / 'fixture.obj'
            known = 'Warning : Use of AT register without noat set\n li $1,-1026\n'
            for payload, returncode, output, expected in (
                    (None, 0, '', False), (b'', 0, '', False),
                    (b'bad!', 0, '', False), (b'LNK\x02', 0, '', True),
                    (b'LNK\x02', 1, '', False),
                    (b'LNK\x02', -1073741819, '', False),
                    (b'LNK\x02', 2, known, True),
                    (b'LNK\x02', 1, known, False),
                    (b'LNK\x02', 2, known+'Error : bad operand', False),
                    (b'LNK\x02', 2, known+'Warning : unknown warning', False),
                    (b'LNK\x02', 2, known+'The memory could not be written', False),
                    (b'', 2, known, False)):
                with self.subTest(payload=payload, returncode=returncode):
                    if payload is not None:
                        obj.write_bytes(payload)
                    result = predicate(SimpleNamespace(returncode=returncode,
                                                       stdout=output, stderr=''), obj)
                    self.assertEqual(result, expected)


class StrippedDeclarationOwnershipTests(unittest.TestCase):
    def production(self, official=False):
        tree = ast.parse(Path(__file__).with_name('psylink_lane.py').read_text())
        wanted = {'base_section', 'sdb_function_declaration_symbol',
                  'source_discarded_symbols', 'sn_text'}
        constants = {'SECTION_RE', 'ALIAS_RE', 'INCLUDE_RE', 'COMM_RE'}
        nodes = [n for n in tree.body if
                 (isinstance(n, ast.FunctionDef) and n.name in wanted) or
                 (isinstance(n, ast.Assign) and any(isinstance(t, ast.Name) and
                  t.id in constants for t in n.targets))]
        namespace = dict(re=re, os=os, Path=Path, defaultdict=defaultdict,
                         OFFICIAL=official, COMM4=False, EALIB_DECL_ORDER=True,
                         OFFICIAL_NATIVE_COMM=False, ROOT=Path('.'))
        exec(compile(ast.Module(body=nodes, type_ignores=[]), '<production-section-projection>', 'exec'), namespace)
        return namespace

    def test_function_type_and_value_identity_not_local_or_pointer(self):
        identify = self.production()['sdb_function_declaration_symbol']
        for kind in ('0x21', '0x24', '0x68'):
            row = ('.def f; .val f; .scl 2; .type %s; .endef' % kind).encode()
            self.assertEqual(identify(row), b'f')
        for row in (b'.def fp; .val fp; .scl 2; .type 0x94; .endef',
                    b'.def p; .val 4; .scl 17; .type 0x14; .endef',
                    b'.def f; .val other; .scl 2; .type 0x24; .endef',
                    b'.def T; .scl 10; .type 0x8; .endef'):
            self.assertIsNone(identify(row))

    def fixture(self):
        return (b'.text\n.def gone; .val gone; .scl 2; .type 0x68; .endef\n'
                b'.section .text.strip,"ax",@progbits\ngone:\n'
                b'.def this; .val 4; .scl 17; .type 0x14; .endef\n'
                b'addiu $2,$0,17\n'
                b'.def kept; .val kept; .scl 2; .type 0x21; .endef\n'
                b'.text\nkept:\njr $31\nnop\n')

    def translate(self, payload, official=False):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory)/'input.s'
            path.write_bytes(payload)
            return self.production(official)['sn_text'](path)

    def test_kept_declaration_after_strip_precedes_text_and_survives_unchanged(self):
        result = self.translate(self.fixture())
        self.assertIn(b'.def kept; .val kept; .scl 2; .type 0x21; .endef\r\n', result)
        self.assertIn(b'kept:\r\njr $31\r\nnop', result)
        self.assertNotIn(b'.def gone;', result)
        self.assertNotIn(b'.def this;', result)
        self.assertNotIn(b'addiu $2,$0,17', result)

    def test_discarded_declaration_before_its_section_is_not_kept(self):
        result = self.translate(self.fixture())
        self.assertNotIn(b'.def gone;', result)
        self.assertNotIn(b'gone:', result)

    def test_official_lane_retains_both_functions_for_authentic_linker(self):
        result = self.translate(self.fixture(), official=True)
        self.assertIn(b'.def gone;', result)
        self.assertIn(b'.def kept;', result)
        self.assertIn(b'addiu $2,$0,17', result)
        self.assertIn(b'jr $31\r\nnop', result)

    def test_no_strip_section_leaves_function_declaration_and_code_unchanged(self):
        source = b'.text\n.def f; .val f; .scl 2; .type 0x24; .endef\nf:\njr $31\nnop\n'
        result = self.translate(source)
        self.assertIn(source.split(b'\n',1)[1].replace(b'\n',b'\r\n'), result)


if __name__ == '__main__':
    unittest.main()
