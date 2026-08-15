import unittest

from maspsx import MaspsxProcessor


from .util import strip_comments


class TestMtlo(unittest.TestCase):
    def test_lbu_mtlo_same_reg(self):
        lines = [
            "	lbu	$2,23($2)",
            "	#nop",
            "	mtlo	$2",
        ]
        expected_lines = [
            "lbu\t$2,23($2)",
            "nop",
            "mtlo\t$2",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_lw_mtlo_same_reg(self):
        lines = [
            "	lw	$3,0($5)",
            "	#nop",
            "	mtlo	$3",
        ]
        expected_lines = [
            "lw\t$3,0($5)",
            "nop",
            "mtlo\t$3",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_lbu_mthi_same_reg(self):
        lines = [
            "	lbu	$4,0($5)",
            "	#nop",
            "	mthi	$4",
        ]
        expected_lines = [
            "lbu\t$4,0($5)",
            "nop",
            "mthi\t$4",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_lbu_mtlo_different_reg(self):
        lines = [
            "	lbu	$2,23($3)",
            "	#nop",
            "	mtlo	$4",
        ]
        expected_lines = [
            "lbu\t$2,23($3)",
            "mtlo\t$4",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_lw_mthi_same_reg(self):
        lines = [
            "	lw	$2,0($5)",
            "	#nop",
            "	mthi	$2",
        ]
        expected_lines = [
            "lw\t$2,0($5)",
            "nop",
            "mthi\t$2",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)
