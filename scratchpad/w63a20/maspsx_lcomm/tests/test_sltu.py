import unittest

from maspsx import MaspsxProcessor


from .util import strip_comments


class TestSltu(unittest.TestCase):

    def test_sltu_at(self):
        lines = [
            "	sltu	$3,$3,-23",
        ]
        expected_lines = [
            "li\t$at,-23",
            "sltu\t$3,$3,$at",
        ]

        mp = MaspsxProcessor(lines, sltu_at=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_no_sltu_at(self):
        lines = [
            "	sltu	$3,$3,-23",
        ]
        expected_lines = [
            "sltu\t$3,$3,-23",
        ]
        mp = MaspsxProcessor(lines, sltu_at=False)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)
