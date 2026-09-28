"""Regression tests for GCC global.c's dying-source copy preference expansion.

Run: python -m unittest discover -s tools -p test_allocsim_copy_preferences.py
This tests the diagnostic model, not reconstructed code or a byte oracle.
"""
import io
import unittest
from unittest.mock import patch

import allocsim


class CopyPreferencesTests(unittest.TestCase):
    def parse(self, rtl, order=(100, 101), conflicts=None):
        with patch('builtins.open', return_value=io.StringIO(
                '\n;; Function test\n' + rtl)):
            return allocsim.parse_copy_prefs(
                'unused.lreg', 'test', order, conflicts or {})

    seed = '(insn 1 0 2 (set (reg:SI 100) (reg:SI 5 a1)) (nil))\n'
    copy = ('(insn 2 1 3 (set (reg:SI 101) (reg:SI 100))\n'
            ' (expr_list:REG_DEAD (reg:SI 100) (nil)))\n')

    def test_dying_source_copy_merges_both_directions(self):
        prefs = self.parse(self.seed + self.copy)
        self.assertEqual(prefs[100], {5})
        self.assertEqual(prefs[101], {5})

    def test_live_source_does_not_expand(self):
        prefs = self.parse(self.seed + self.copy.replace('REG_DEAD', 'REG_EQUAL'))
        self.assertNotIn(101, prefs)

    def test_either_conflict_direction_prevents_merge(self):
        for x, y in ((100, 101), (101, 100)):
            prefs = self.parse(self.seed + self.copy, conflicts={x: {'allocnos': {y}}})
            self.assertNotIn(101, prefs)

    def test_non_allocno_source_does_not_expand(self):
        self.assertNotIn(101, self.parse(self.seed + self.copy, order=(101,)))

    def test_arithmetic_is_not_a_copy_preference(self):
        rtl = self.copy.replace('(reg:SI 100))',
                                '(plus:SI (reg:SI 100) (const_int 1)))', 1)
        self.assertNotIn(101, self.parse(self.seed + rtl))

    def test_wrong_dead_register_does_not_expand(self):
        rtl = self.copy.replace('REG_DEAD (reg:SI 100)', 'REG_DEAD (reg:SI 102)')
        self.assertNotIn(101, self.parse(self.seed + rtl))

    def test_replay_is_one_pass_not_fixed_point(self):
        first = self.copy.replace('101', '102').replace('100', '101')
        prefs = self.parse(self.seed + first + self.copy, order=(100, 101, 102))
        self.assertEqual(prefs[101], {5})
        self.assertEqual(prefs.get(102, set()), set())


if __name__ == '__main__':
    unittest.main()
