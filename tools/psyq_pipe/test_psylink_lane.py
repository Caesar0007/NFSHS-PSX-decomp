"""ASPSX failure-path controls without importing the executable lane script.

2026-10-12: native COMMON assembly exposed empty objects after an ASPSX crash.
The exact production predicate is evaluated against independently specified
file/exit-status cases. No compiler, source, reference or game object is changed.
"""
import ast
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


if __name__ == '__main__':
    unittest.main()
