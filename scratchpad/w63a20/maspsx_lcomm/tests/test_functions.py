import unittest

from maspsx import (
    strip_comments,
    line_loads_from_reg,
    uses_at,
    is_label,
)


class TestMaspsxFunctions(unittest.TestCase):
    def test_strip_comments(self):
        line = "li\t$v0,100 # comment here"
        expected = "li\t$v0,100"
        stripped = strip_comments(line)
        self.assertEqual(expected, stripped)

    def test_line_loads_from_reg_jal(self):
        line = "jal	$31,$2"
        self.assertTrue(line_loads_from_reg(line, "$2"))
        self.assertFalse(line_loads_from_reg(line, "$31"))

    def test_line_loads_from_reg_j(self):
        line = "j	$31"
        self.assertTrue(line_loads_from_reg(line, "$31"))
        self.assertFalse(line_loads_from_reg(line, "$3"))

    def test_line_loads_from_reg_beq(self):
        line = "beq   $v1, $v0, .L801B79E8"
        self.assertTrue(line_loads_from_reg(line, "$v0"))
        self.assertTrue(line_loads_from_reg(line, "$v1"))

    def test_line_loads_from_reg_mult(self):
        line = "mult  $v1, $a0"
        self.assertTrue(line_loads_from_reg(line, "$a0"))
        self.assertTrue(line_loads_from_reg(line, "$v1"))

    def test_line_loads_from_reg_addu(self):
        line = "addu  $s1, $a0, $zero"
        self.assertTrue(line_loads_from_reg(line, "$a0"))
        self.assertFalse(line_loads_from_reg(line, "$s1"))

    def test_is_label(self):
        labels = [
            "$L38:",
            "$Lb0:",
            "$Le3:",
            # "LM132:",  # NOTE: this is a line marker not true label
        ]
        for label in labels:
            with self.subTest():
                self.assertTrue(is_label(label))


class TestMaspsxUsesAt(unittest.TestCase):
    def test_uses_at(self):
        line = "sb   $2, g_InputSaveName($3)"
        self.assertTrue(uses_at(line))

    def test_uses_at_lo_macro(self):
        line = "sw	$2,%lo(s_attr)($3)"
        self.assertFalse(uses_at(line))

    def test_uses_at_sw(self):
        line = "sw	$2,D_801813A4"
        self.assertTrue(uses_at(line))

    def test_uses_at_sw_offset(self):
        line = "sw	$3,g_CurrentRoom+40"
        self.assertTrue(uses_at(line))

    def test_uses_at_small_store(self):
        line = "sb   $2,32767"
        self.assertFalse(uses_at(line))

    def test_uses_at_large_store(self):
        line = "sb   $2,32768"
        self.assertTrue(uses_at(line))

    def test_uses_at_large_negative_store(self):
        line = "sb	$2,-2147292186"
        self.assertTrue(uses_at(line))

    def test_uses_at_small_offset(self):
        line = "sw	$2,-32768($16)"
        self.assertFalse(uses_at(line))

    def test_uses_at_large_offset(self):
        line = "sw	$2,-32769($16)"
        self.assertTrue(uses_at(line))

    def test_uses_at_lw_small_offset(self):
        line = "lw	$2,-32768($16)"
        self.assertFalse(uses_at(line))

    def test_uses_at_lw_large_offset(self):
        line = "lw	$2,-32769($16)"
        self.assertTrue(uses_at(line))

    def test_uses_at_sw_struct_offset(self):
        line = "sw	$2,D_us_8017863C.4"
        self.assertTrue(uses_at(line))
