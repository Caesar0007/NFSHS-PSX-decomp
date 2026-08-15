import unittest

from maspsx import MaspsxProcessor

from .util import strip_comments


class TestAt(unittest.TestCase):

    def test_no_at_expansion_nop(self):
        """
        The 2nd value being loaded is less than 0x8000 therefore $at is not used
        and a nop is required between the two instructions
        """
        lines = [
            "lh	$2,32767($2)",
            "lh	$2,32767($2)",
        ]
        expected_lines = [
            "lh	$2,32767($2)",
            "nop",
            "lh	$2,32767($2)",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_no_at_expansion_nop_negative(self):
        """
        The 2nd value being loaded is greater than -0x7FFF therefore $at is not used
        and a nop is required between the two instructions
        """
        lines = [
            "lh	$2,-32768($2)",
            "lh	$2,-32768($2)",
        ]
        expected_lines = [
            "lh	$2,-32768($2)",
            "nop",
            "lh	$2,-32768($2)",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_at_expansion_nop(self):
        """
        The 2nd value being loaded is greater than 0x7FFF therefore $at is used
        and a nop is required between the two instructions when ASPSX 2.21 is used
        """
        lines = [
            "lh	$2,32767($2)",
            "lh	$2,32768($2)",
        ]
        expected_lines = [
            "lh	$2,32767($2)",
            "nop",
            ".set\tnoat",
            "lui\t$at,%hi(32768)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(32768)($at)",
            ".set\tat",
        ]
        mp = MaspsxProcessor(lines, nop_at_expansion=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_at_expansion_nop_negative(self):
        """
        The 2nd value being loaded is less than -0x8000 therefore $at is used
        and a nop is required between the two instructions when ASPSX 2.21 is used
        """
        lines = [
            "lh	$2,-32768($2)",
            "lh	$2,-32769($2)",
        ]
        expected_lines = [
            "lh	$2,-32768($2)",
            "nop",
            ".set\tnoat",
            "lui\t$at,%hi(-32769)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(-32769)($at)",
            ".set\tat",
        ]
        mp = MaspsxProcessor(lines, nop_at_expansion=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_at_expansion_no_nop(self):
        """
        The 2nd value being loaded is greater than 0x7FFF therefore $at is used
        and a nop is not required between the two instructions when ASPSX
        higher than 2.21 is used
        """
        lines = [
            "lh	$2,32767($2)",
            "lh	$2,32768($2)",
        ]
        expected_lines = [
            "lh	$2,32767($2)",
            ".set\tnoat",
            "lui\t$at,%hi(32768)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(32768)($at)",
            ".set\tat",
        ]
        mp = MaspsxProcessor(lines, nop_at_expansion=False)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_at_expansion_no_nop_negative(self):
        """
        The 2nd value being loaded is less than -0x8000 therefore $at is used
        and a nop is not required between the two instructions when ASPSX
        higher than 2.21 is used
        """
        lines = [
            "lh	$2,-32768($2)",
            "lh	$2,-32769($2)",
        ]
        expected_lines = [
            "lh	$2,-32768($2)",
            ".set\tnoat",
            "lui\t$at,%hi(-32769)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(-32769)($at)",
            ".set\tat",
        ]
        mp = MaspsxProcessor(lines, nop_at_expansion=False)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_at_expansion_prefix_nop(self):
        """
        The 1st value being loaded is greater than 0x7FFF therefore $at is used.
        The final load is into $v0 and therefore a nop is required between
        the two instructions
        """
        lines = [
            "lh	$2,32768($2)",
            "lh	$2,32767($2)",
        ]
        expected_lines = [
            ".set\tnoat",
            "lui\t$at,%hi(32768)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(32768)($at)",
            ".set\tat",
            "nop",
            "lh	$2,32767($2)",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_at_expansion_prefix_nop_negative(self):
        """
        The 1st value being loaded is less than -0x8000 therefore $at is used.
        The final load is into $v0 and therefore a nop is required between
        the two instructions
        """
        lines = [
            "lh	$2,-32769($2)",
            "lh	$2,-32768($2)",
        ]
        expected_lines = [
            ".set\tnoat",
            "lui\t$at,%hi(-32769)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(-32769)($at)",
            ".set\tat",
            "nop",
            "lh	$2,-32768($2)",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_double_at_expansion_no_nop(self):
        """
        Both values being loaded are greater than 0x7FFF therefore $at is used.
        The final load is into $v0 and therefore no nop is required between
        the two instructions
        """
        lines = [
            "lh	$2,32768($2)",
            "lh	$2,32768($2)",
        ]
        expected_lines = [
            ".set\tnoat",
            "lui\t$at,%hi(32768)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(32768)($at)",
            ".set\tat",
            ".set\tnoat",
            "lui\t$at,%hi(32768)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(32768)($at)",
            ".set\tat",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_double_at_expansion_no_nop_negative(self):
        """
        Both values being loaded are less than -0x8000 therefore $at is used.
        The final load is into $v0 and therefore no nop is required between
        the two instructions
        """
        lines = [
            "lh	$2,-32769($2)",
            "lh	$2,-32769($2)",
        ]
        expected_lines = [
            ".set\tnoat",
            "lui\t$at,%hi(-32769)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(-32769)($at)",
            ".set\tat",
            ".set\tnoat",
            "lui\t$at,%hi(-32769)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(-32769)($at)",
            ".set\tat",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_double_at_expansion_nop(self):
        """
        Both values being loaded are greater than 0x7FFF therefore $at is used.
        The final load is into $v0 and therefore a nop is required between
        the two instructions on ASPSX 2.21
        """
        lines = [
            "lh	$2,32768($2)",
            "lh	$2,32768($2)",
        ]
        expected_lines = [
            ".set\tnoat",
            "lui\t$at,%hi(32768)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(32768)($at)",
            ".set\tat",
            "nop",
            ".set\tnoat",
            "lui\t$at,%hi(32768)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(32768)($at)",
            ".set\tat",
        ]
        mp = MaspsxProcessor(lines, nop_at_expansion=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_double_at_expansion_nop_negative(self):
        """
        Both values being loaded are less than -0x8000 therefore $at is used.
        The final load is into $v0 and therefore a nop is required between
        the two instructions on ASPSX 2.21
        """
        lines = [
            "lh	$2,-32769($2)",
            "lh	$2,-32769($2)",
        ]
        expected_lines = [
            ".set\tnoat",
            "lui\t$at,%hi(-32769)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(-32769)($at)",
            ".set\tat",
            "nop",
            ".set\tnoat",
            "lui\t$at,%hi(-32769)",
            "addu\t$at,$2,$at",
            "lh\t$2,%lo(-32769)($at)",
            ".set\tat",
        ]
        mp = MaspsxProcessor(lines, nop_at_expansion=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_lw_use_addiu(self):
        lines = [
            "lw	$2,ctlbuf($2)",
        ]

        expected_lines = [
            ".set\tnoat",
            "lui\t$at,%hi(ctlbuf)",
            "addiu\t$at,$at,%lo(ctlbuf)",
            "addu\t$at,$at,$2",
            "lw\t$2,0x0($at)",
            ".set\tat",
        ]

        mp = MaspsxProcessor(lines, addiu_at=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_lw_dont_use_addiu(self):
        lines = [
            "lw	$2,ctlbuf($2)",
        ]

        expected_lines = [
            ".set\tnoat",
            "lui\t$at,%hi(ctlbuf)",
            "addu\t$at,$at,$2",
            "lw\t$2,%lo(ctlbuf)($at)",
            ".set\tat",
        ]

        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_sw_use_addiu(self):
        lines = [
            "sw	$2,ctlbuf($2)",
        ]

        expected_lines = [
            ".set\tnoat",
            "lui\t$at,%hi(ctlbuf)",
            "addiu\t$at,$at,%lo(ctlbuf)",
            "addu\t$at,$at,$2",
            "sw\t$2,0x0($at)",
            ".set\tat",
        ]

        mp = MaspsxProcessor(lines, addiu_at=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_sw_dont_use_addiu(self):
        lines = [
            "sw	$2,ctlbuf($2)",
        ]

        expected_lines = [
            "sw	$2,ctlbuf($2)",
        ]

        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_sw_pointer_offset(self):
        """
        Expand sw with large operand
        BUG: https://github.com/mkst/maspsx/issues/85
        """

        lines = [
            "sw	$2,56200($4)",
        ]
        expected_lines = [
            ".set\tnoat",
            "lui\t$at,%hi(56200)",
            "addu\t$at,$4,$at",
            "sw\t$2,%lo(56200)($at)",
            ".set\tat",
        ]

        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_lh_lbu_nop_at_expansion(self):
        """
        Ensure we place a nop between v0/at
        BUG: https://github.com/mkst/maspsx/issues/87
        """
        lines = [
            "lh	$2,10($18)",
            "lbu	$2,buttonDoorIdx.29($2)",
        ]

        expected_lines = [
            "lh	$2,10($18)",
            "nop",
            ".set\tnoat",
            "lui\t$at,%hi(buttonDoorIdx.29)",
            "addu\t$at,$at,$2",
            "lbu\t$2,%lo(buttonDoorIdx.29)($at)",
            ".set\tat",
        ]

        mp = MaspsxProcessor(lines, nop_at_expansion=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_lh_lbu_nop_at_expansion_v1(self):
        lines = [
            "lh	$3,10($18)",
            "lbu	$2,buttonDoorIdx.29($3)",
        ]

        expected_lines = [
            "lh	$3,10($18)",
            "nop",
            ".set\tnoat",
            "lui\t$at,%hi(buttonDoorIdx.29)",
            "addu\t$at,$at,$3",
            "lbu\t$2,%lo(buttonDoorIdx.29)($at)",
            ".set\tat",
        ]

        mp = MaspsxProcessor(lines, nop_at_expansion=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_lh_lbu_no_nop_at_expansion(self):
        lines = [
            "lh	$2,10($18)",
            "lbu	$2,buttonDoorIdx.29($2)",
        ]

        expected_lines = [
            "lh	$2,10($18)",
            ".set\tnoat",
            "lui\t$at,%hi(buttonDoorIdx.29)",
            "addu\t$at,$at,$2",
            "lbu\t$2,%lo(buttonDoorIdx.29)($at)",
            ".set\tat",
        ]

        mp = MaspsxProcessor(lines, nop_at_expansion=False)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_lbu_sb_nop_at_expansion(self):

        lines = [
            "lbu	$3,104($4)",
            "#nop",
            "sb	$2,gPartyMemberSlain-1($3)",
        ]

        expected_lines = [
            "lbu\t$3,104($4)",
            "nop",
            ".set\tnoat",
            "lui\t$at,%hi(gPartyMemberSlain-1)",
            "addiu\t$at,$at,%lo(gPartyMemberSlain-1)",
            "addu\t$at,$at,$3",
            "sb	$2,0x0($at)",
            ".set\tat",
        ]

        mp = MaspsxProcessor(lines, nop_at_expansion=True, addiu_at=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)
