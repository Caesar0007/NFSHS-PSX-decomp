import unittest

from maspsx import MaspsxProcessor

from .util import strip_comments


class TestBreak(unittest.TestCase):
    def test_break_7(self):
        lines = [
            "	break	7",
        ]
        expected_lines = [
            "break\t0x0,0x7",
        ]

        mp = MaspsxProcessor(
            lines,
        )
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_break_0x407(self):
        """
        We must not assume that all breaks will be:
          a) compiler generated
          b) decimal numbers
        BUG: https://github.com/mkst/maspsx/issues/84
        """
        lines = [
            "	break 0x407",
        ]
        expected_lines = [
            "break\t0x1,0x7",
        ]

        mp = MaspsxProcessor(
            lines,
        )
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)
