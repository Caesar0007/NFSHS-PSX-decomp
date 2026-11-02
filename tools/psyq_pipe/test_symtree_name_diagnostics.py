"""Formatting-only repeated-name regression; no CLI/source/SYM mutation."""
import ast
import copy
from pathlib import Path
import unittest

SOURCE = Path(__file__).with_name('symtree_cmp.py')
tree = ast.parse(SOURCE.read_text())
definitions = [n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name == 'name_count_issue']
assert len(definitions) == 1
namespace = {}
exec(compile(ast.Module(body=definitions, type_ignores=[]), str(SOURCE), 'exec'), namespace)
issue = namespace['name_count_issue']

def local(name, home, kind='INT', depth=1):
    return name, home, kind, depth

class NameCountDiagnosticTests(unittest.TestCase):
    def test_unique_missing_retains_existing_concrete_wording(self):
        self.assertEqual(issue('MISSING', 'n', [], [local('n', 'REG:$2')]), 'MISSING n REG:$2')

    def test_unique_extra_retains_existing_concrete_wording(self):
        self.assertEqual(issue('EXTRA', 'n', [local('n', 'REG:$2')], []), 'EXTRA n REG:$2')

    def test_setmenu_duplicate_this_does_not_label_correct_root_missing(self):
        root = local('this', 'REGPARM:$17', 'PTR STRUCT tFEApplication', 0)
        body = local('this', 'REG:$16', 'PTR STRUCT tMenu', 4)
        inline = local('this', 'REG:$16', 'PTR STRUCT tMenu', 6)
        value = issue('MISSING', 'this', [root, body], [root, inline, body])
        self.assertTrue(value.startswith('MISSING this: 1 name-count occurrence(s)'))
        self.assertIn('native=2 retail=3', value)
        self.assertNotIn('REGPARM:$17', value)
        self.assertIn('home/type/owner not determined', value)

    def test_duplicate_extra_does_not_label_first_home_as_extra(self):
        rows = [local('i', 'REG:$2'), local('i', 'REG:$3', depth=3)]
        value = issue('EXTRA', 'i', rows, rows[:1])
        self.assertIn('native=2 retail=1', value)
        self.assertNotIn('REG:$2', value)

    def test_multiple_absent_occurrences_keep_exact_deficit(self):
        value = issue('MISSING', 'i', [], [local('i', 'REG:$2'), local('i', 'REG:$3')])
        self.assertIn('2 name-count occurrence(s), native=0 retail=2', value)

    def test_wrong_issue_kind_is_rejected(self):
        with self.assertRaises(ValueError):
            issue('MOVED', 'i', [], [local('i', 'REG:$2')])

    def test_no_count_difference_cannot_be_formatted_as_missing(self):
        rows = [local('i', 'REG:$2')]
        with self.assertRaises(ValueError):
            issue('MISSING', 'i', rows, rows)

    def test_formatting_does_not_mutate_or_reorder_inputs(self):
        ours = [local('i', 'REG:$2')]
        retail = [local('i', 'REG:$2'), local('i', 'REG:$3')]
        before = copy.deepcopy((ours, retail))
        self.assertEqual(issue('MISSING', 'i', ours, retail), issue('MISSING', 'i', ours, retail))
        self.assertEqual((ours, retail), before)

if __name__ == '__main__':
    unittest.main()
