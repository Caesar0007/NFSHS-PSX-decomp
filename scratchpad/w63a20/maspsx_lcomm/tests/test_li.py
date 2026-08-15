import unittest

from maspsx import MaspsxProcessor


from .util import strip_comments


class TestLi(unittest.TestCase):
    def test_no_expand_li(self):
        """
        Ensure we don't expand li if option is not enabled
        """
        lines = [
            "	li	$4,0x0000007f		# 127",
        ]
        expected_lines = [
            "li	$4,0x0000007f",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_li_0x1(self):
        """
        Correct expansion of "li $v0,1"
        """
        lines = [
            "	li	$2,0x0000001		# 1",
        ]
        expected_lines = [
            "ori	$2,$zero,1",
        ]
        mp = MaspsxProcessor(lines, expand_li=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_li_0xFFFF(self):
        """
        Correct expansion of "li $v0,65535"
        """
        lines = [
            "	li	$2,0x000FFFF		# 65535",
        ]
        expected_lines = [
            "ori	$2,$zero,65535",
        ]
        mp = MaspsxProcessor(lines, expand_li=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_li_65535(self):
        """
        Correct expansion of "li $v0,65535"
        """
        lines = [
            "	li	$v0,65535",
        ]
        expected_lines = [
            "ori	$v0,$zero,65535",
        ]
        mp = MaspsxProcessor(lines, expand_li=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_li_0x10000(self):
        """
        Correct expansion of "li $v0,0x10000"
        """
        lines = [
            "	li	$2,0x0010000		# 65536",
        ]
        expected_lines = [
            "lui	$2,(65536 >> 16) & 0xFFFF",
        ]
        mp = MaspsxProcessor(lines, expand_li=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_li_0x10001(self):
        """
        Correct expansion of "li $v0,0x10001"
        """
        lines = [
            "	li	$2,0x0010001		# 65537",
        ]
        expected_lines = [
            "lui	$2,(65537 >> 16) & 0xFFFF",
            "ori	$2,$2,65537 & 0xFFFF",
        ]
        mp = MaspsxProcessor(lines, expand_li=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_li_neg_0x1000(self):
        """
        Correct expansion of "li $v0,-0x1000"
        """
        lines = [
            "	li	$2,-0x00001000		# -4096",
        ]
        expected_lines = [
            "addiu	$2,$zero,-4096",
        ]
        mp = MaspsxProcessor(lines, expand_li=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_li_neg_0x8000(self):
        """
        Correct expansion of "li $v0,-0x8000"
        """
        lines = [
            "	li	$2,-0x00008000		# -32768",
        ]
        expected_lines = [
            "addiu	$2,$zero,-32768 & 0xFFFF",
        ]
        mp = MaspsxProcessor(lines, expand_li=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_li_neg_0x8001(self):
        """
        Correct expansion of "li $v0,-0x8001"
        """
        lines = [
            "	li	$v0,-0x00008001		# -32769",
        ]
        expected_lines = [
            "lui	$v0,(-32769 >> 16) & 0xFFFF",
            "ori	$v0,$v0,-32769 & 0xFFFF",
        ]
        mp = MaspsxProcessor(lines, expand_li=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_li_0x00ffffff(self):
        """
        Correct expansion of "li $6,0x00ffffff"
        BUG: https://github.com/mkst/maspsx/issues/85
        """
        lines = [
            "li	$6,0x00ffffff",
        ]
        expected_lines = [
            "lui	$6,(16777215 >> 16) & 0xFFFF",
            "ori	$6,$6,16777215 & 0xFFFF",
        ]

        mp = MaspsxProcessor(lines, expand_li=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)
