import unittest

from maspsx import MaspsxProcessor


from .util import strip_comments


class TestMove(unittest.TestCase):

    def test_move(self):
        """
        Modern GNU as will expand a 'move' instruction into an 'or', however we want an 'addu'.
        """
        lines = [
            "move $2,$6",
        ]
        expected_lines = [
            "addu\t$2,$6,$zero",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_move_with_comment(self):
        """
        Ensure we can handle comments
        """
        lines = [
            "move $2,$6 # sp not trusted here",
        ]
        expected_lines = [
            "addu\t$2,$6,$zero",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_mflo_move(self):
        """
        Ensure we expand a move instruction when processing an mflo expansion
        """
        lines = [
            "	mflo	$3",
            "	move	$2,$6",
            "	mult	$3,$5",
        ]
        expected_lines = [
            "mflo\t$3",
            "addu\t$2,$6,$zero",
            "nop",
            "mult\t$3,$5",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()
        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_mflo_move_noreorder(self):
        """
        Ensure we expand a move instruction when processing an mflo expansion
        """
        lines = [
            "	mflo	$3",
            ".set\tnoreorder",
            "	move	$2,$6",
            "	mult	$3,$5",
        ]
        expected_lines = [
            "mflo\t$3",
            "nop",
            ".set\tnoreorder",
            "addu\t$2,$6,$zero",
            "mult\t$3,$5",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()
        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)
