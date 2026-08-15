import unittest

from maspsx import MaspsxProcessor


from .util import strip_comments


class TestMflo(unittest.TestCase):

    def test_mflo_disabled(self):
        lines = [
            "mult	$4,$2",
            "mflo	$4",
            "#nop",
            "#nop",
            "mult	$4,$5",
        ]
        expected_lines = [
            "mult	$4,$2",
            "mflo	$4",
            "mult	$4,$5",
        ]

        mp = MaspsxProcessor(lines, nop_mflo_mfhi=False)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_mflo_li(self):
        """
        li with large value will turn into two instructions (lui+ori)
        which means no nop is required
        """
        lines = [
            "	mflo	$3",
            "	li	$5,-2004318071			# 0x88888889",
            "	mult	$3,$5        ",
        ]
        expected_lines = [
            "mflo\t$3",
            "li\t$5,-2004318071",
            "mult\t$3,$5",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_mflo_li_hex(self):
        """
        li with large value will turn into two instructions (lui+ori)
        which means no nop is required
        """
        lines = [
            "	mflo	$3",
            "	li	$5,0x2aaaaaab		# 715827883",
            "	mult	$3,$5        ",
        ]
        expected_lines = [
            "mflo\t$3",
            "li\t$5,0x2aaaaaab",
            "mult\t$3,$5",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()
        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_mflo_bgez_no_set_noreorder(self):
        """
        Standard behaviour is to take the next instruction and insert a nop *after* it
        """
        lines = [
            "	mflo	$2",
            "	#nop",
            "	#nop",
            "	bgez	$2,$L14",
            "	mult	$17,$3",
        ]
        expected_lines = [
            "mflo\t$2",
            "bgez\t$2,$L14",
            "nop",
            "mult\t$17,$3",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()
        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_mflo_bgez_set_reorder(self):
        """
        Due to .set noreorder the nop should go BEFORE the bgez
        """
        lines = [
            "	mflo	$2",
            "	#nop",
            "	#nop",
            "	.set	noreorder",
            "	.set	nomacro",
            "	bgez	$2,$L14",
            "	mult	$17,$3",
        ]
        expected_lines = [
            "mflo\t$2",
            "nop",
            ".set\tnoreorder",
            "bgez\t$2,$L14",
            "mult\t$17,$3",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()
        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_div_mflo_load_from_register(self):
        """
        If the div requires expansion, aspsx checks whether the following
        instruction reads from the mflo/mfhi destination register.

        BUG: https://github.com/mkst/maspsx/issues/105
        """
        lines = [
            "div	$2,$2,$7",
            "subu	$2,$10,$2",
            "mult	$2,$8",
        ]
        expected_lines = [
            "div\t$zero,$2,$7",
            "mflo\t$2",
            "nop",
            "subu\t$2,$10,$2",
            "mult\t$2,$8",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()
        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_divu_mflo_load_from_register(self):
        lines = [
            "divu	$2,$2,$7",
            "subu	$2,$10,$2",
            "mult	$2,$8",
        ]
        expected_lines = [
            "divu\t$zero,$2,$7",
            "mflo\t$2",
            "nop",
            "subu\t$2,$10,$2",
            "mult\t$2,$8",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()
        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_expand_div_mflo_no_load_from_register(self):
        lines = [
            "div	$2,$2,$7",
            "subu	$2,$10,$3",
            "mult	$2,$8",
        ]
        expected_lines = [
            "div\t$zero,$2,$7",
            "mflo\t$2",
            "subu\t$2,$10,$3",
            "nop",
            "mult\t$2,$8",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()
        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_mflo_rem(self):
        lines = [
            "mflo	$7",
            "#nop",
            "sll	$2,$3,12",
            "rem	$7,$7,$2",
        ]
        expected_lines = [
            "mflo\t$7",
            "sll\t$2,$3,12",
            "nop",
            "div\t$zero,$7,$2",
            "mfhi\t$7",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()
        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_multu(self):
        """
        Handle a mflo/mfhi/mult combination
        BUG: https://github.com/mkst/maspsx/issues/112
        """
        lines = [
            "mfhi	$5",
            "mflo	$4",
            "#nop",
            "#nop",
            "mult	$6,$9",
        ]
        expected_lines = [
            "mfhi\t$5",
            "mflo\t$4",
            "nop",
            "nop",
            "mult\t$6,$9",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()
        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_div_div_label(self):
        """
        Ensure correct nop placement when encountering a label
        BUG: https://github.com/mkst/maspsx/issues/121
        """
        lines = [
            "	div	$16,$2,$4",
            "	sll	$2,$17,12",
            "$L15:",
            "	div	$17,$2,$4",
        ]
        expected_lines = [
            "div\t$zero,$2,$4",
            "mflo\t$16",
            "sll\t$2,$17,12",
            "$L15:",
            "nop",
            "div\t$zero,$2,$4",
            "mflo\t$17",
        ]

        mp = MaspsxProcessor(lines)
        res = mp.process_lines()
        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_mflo_mult_branch_label(self):
        lines = [
            "	mflo	$20",
            "	#nop",
            "	bne	$2,$0,$L78",
            "$L83:",
            "	mult	$16,$16",
        ]
        expected_lines = [
            "mflo\t$20",
            "bne\t$2,$0,$L78",
            "nop",
            "$L83:",
            "mult\t$16,$16",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()
        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)
