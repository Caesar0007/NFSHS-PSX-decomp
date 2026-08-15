import unittest

from maspsx import MaspsxProcessor

from .util import strip_comments


class TestFloatingPoint(unittest.TestCase):
    def test_load_float(self):
        lines = [
            "li.s	$4,1.00000000000000000000e+00",
            "li.s	$5,2.00000000000000000000e+00",
            "li.s	$6,4.00000000000000000000e+00",
            "li.s	$7,8.00000000000000000000e+00",
            "li.s	$8,1.60000000000000000000e+01",
            "li.s	$9,3.20000000000000000000e+01",
        ]
        expected_lines = [
            "lui\t$4,0x3F80",
            "lui\t$5,0x4000",
            "lui\t$6,0x4080",
            "lui\t$7,0x4100",
            "lui\t$8,0x4180",
            "lui\t$9,0x4200",
        ]

        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_load_float_2(self):
        lines = [
            "li.s	$4,-1.23450000000000000000e+00",
        ]
        expected_lines = [
            "lui\t$4,0xBF9E",
            "ori\t$4,0x419",
        ]

        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_load_double(self):
        lines = [
            "li.d	$2,1.00000000000000000000e+00",
            "li.d	$4,2.00000000000000000000e+00",
            "li.d	$6,4.00000000000000000000e+00",
            "li.d	$8,8.00000000000000000000e+00",
        ]
        expected_lines = [
            "li\t$2,0x0",
            "lui\t$3,0x3FF0",
            "li\t$4,0x0",
            "lui\t$5,0x4000",
            "li\t$6,0x0",
            "lui\t$7,0x4010",
            "li\t$8,0x0",
            "lui\t$9,0x4020",
        ]

        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)
