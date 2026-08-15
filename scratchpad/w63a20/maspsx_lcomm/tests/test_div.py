import unittest

from maspsx import MaspsxProcessor

from .util import strip_comments


class TestDivExpansion(unittest.TestCase):
    def test_div_expand(self):
        lines = [
            "	div	$16,$16,$2",
        ]
        expected_lines = [
            ".set\tnoat",
            "div\t$zero,$16,$2",
            "bnez\t$2,.L_NOT_DIV_BY_ZERO_0",
            "nop",
            "break\t0x7",
            ".L_NOT_DIV_BY_ZERO_0:",
            "addiu\t$at,$zero,-1",
            "bne\t$2,$at,.L_DIV_BY_POSITIVE_SIGN_0",
            "lui\t$at,0x8000",
            "bne\t$16,$at,.L_DIV_BY_POSITIVE_SIGN_0",
            "nop",
            "break\t0x6",
            ".L_DIV_BY_POSITIVE_SIGN_0:",
            "mflo\t$16",
            ".set\tat",
        ]

        mp = MaspsxProcessor(lines, expand_div=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_rem_expand(self):
        lines = [
            "	rem	$16,$16,$2",
        ]
        expected_lines = [
            ".set\tnoat",
            "div\t$zero,$16,$2",
            "bnez\t$2,.L_NOT_DIV_BY_ZERO_0",
            "nop",
            "break\t0x7",
            ".L_NOT_DIV_BY_ZERO_0:",
            "addiu\t$at,$zero,-1",
            "bne\t$2,$at,.L_DIV_BY_POSITIVE_SIGN_0",
            "lui\t$at,0x8000",
            "bne\t$16,$at,.L_DIV_BY_POSITIVE_SIGN_0",
            "nop",
            "break\t0x6",
            ".L_DIV_BY_POSITIVE_SIGN_0:",
            "mfhi\t$16",
            ".set\tat",
        ]

        mp = MaspsxProcessor(lines, expand_div=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_div_expand_tge(self):
        lines = [
            "	div	$16,$16,$2",
        ]
        expected_lines = [
            ".set\tnoat",
            "div\t$zero,$16,$2",
            "bnez\t$2,.L_NOT_DIV_BY_ZERO_0",
            "nop",
            "break\t0x7",
            ".L_NOT_DIV_BY_ZERO_0:",
            "addiu\t$at,$zero,-1",
            "bne\t$2,$at,.L_DIV_BY_POSITIVE_SIGN_0",
            "lui\t$at,0x8000",
            "bne\t$16,$at,.L_DIV_BY_POSITIVE_SIGN_0",
            "nop",
            "tge\t$zero,$zero,93",
            ".L_DIV_BY_POSITIVE_SIGN_0:",
            "mflo\t$16",
            ".set\tat",
        ]

        mp = MaspsxProcessor(lines, expand_div=True, div_uses_tge=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_rem_expand_tge(self):
        lines = [
            "	rem	$16,$16,$2",
        ]
        expected_lines = [
            ".set\tnoat",
            "div\t$zero,$16,$2",
            "bnez\t$2,.L_NOT_DIV_BY_ZERO_0",
            "nop",
            "break\t0x7",
            ".L_NOT_DIV_BY_ZERO_0:",
            "addiu\t$at,$zero,-1",
            "bne\t$2,$at,.L_DIV_BY_POSITIVE_SIGN_0",
            "lui\t$at,0x8000",
            "bne\t$16,$at,.L_DIV_BY_POSITIVE_SIGN_0",
            "nop",
            "tge\t$zero,$zero,93",
            ".L_DIV_BY_POSITIVE_SIGN_0:",
            "mfhi\t$16",
            ".set\tat",
        ]

        mp = MaspsxProcessor(lines, expand_div=True, div_uses_tge=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_div_nop(self):
        """
        Ensure we expand an li instruction during div/mflo handling
        when user has set expand_li=True
        Bug report: https://github.com/mkst/maspsx/issues/46
        """

        lines = [
            "	div	$16,$16,$2",
            "",
            "	.loc	2 173",
            "LM163:",
            "	li	$4,0x00001000		# 4096",
            "	div	$4,$4,$2",
        ]
        expected_lines = [
            # EXPAND_ZERO_DIV START
            "div\t$zero,$16,$2",
            "mflo\t$16",
            # EXPAND_ZERO_DIV END
            "li\t$4,0x00001000",
            "nop",  # DEBUG: mflo/mfhi with mult/div and li expands to 1 op
            # DEBUG: div needs expanding
            "",
            ".loc\t2 173",
            "LM163:",
            # li	$4,0x00001000		# 4096  # DEBUG: skipped
            # EXPAND_ZERO_DIV START
            "div\t$zero,$4,$2",
            "mflo\t$4",
            # EXPAND_ZERO_DIV END
        ]

        mp = MaspsxProcessor(lines, expand_li=False)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_div_no_nop(self):
        lines = [
            "	div	$16,$16,$2",
            "",
            "	.loc	2 173",
            "LM163:",
            "	li	$4,0x0010001		# 65537",
            "	div	$4,$4,$2",
        ]
        expected_lines = [
            # EXPAND_ZERO_DIV START
            "div\t$zero,$16,$2",
            "mflo\t$16",
            # EXPAND_ZERO_DIV END
            "li\t$4,0x0010001",
            # nop  # DEBUG: mflo/mfhi with mult/div and li expands to 2 ops
            # DEBUG: div needs expanding
            "",
            ".loc\t2 173",
            "LM163:",
            # li	$4,0x00001000		# 4096  # DEBUG: skipped
            # EXPAND_ZERO_DIV START
            "div\t$zero,$4,$2",
            "mflo\t$4",
            # EXPAND_ZERO_DIV END
        ]

        mp = MaspsxProcessor(lines, expand_li=False)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_div_expand_li_nop(self):
        """
        Ensure we expand an li instruction during div/mflo handling
        when user has set expand_li=True
        Bug report: https://github.com/mkst/maspsx/issues/46
        """

        lines = [
            "	div	$16,$16,$2",
            "",
            "	.loc	2 173",
            "LM163:",
            "	li	$4,0x00001000		# 4096",
            "	div	$4,$4,$2",
        ]
        expected_lines = [
            # EXPAND_ZERO_DIV START
            "div	$zero,$16,$2",
            "mflo	$16",
            # EXPAND_ZERO_DIV END
            "ori	$4,$zero,4096",
            "nop",  # DEBUG: mflo/mfhi with mult/div and li expands to 1 op
            # DEBUG: div needs expanding
            "",
            ".loc	2 173",
            "LM163:",
            # li	$4,0x00001000		# 4096  # DEBUG: skipped
            # EXPAND_ZERO_DIV START
            "div	$zero,$4,$2",
            "mflo	$4",
            # EXPAND_ZERO_DIV END
        ]

        mp = MaspsxProcessor(lines, expand_li=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_div_expand_li_no_nop(self):
        lines = [
            "	div	$16,$16,$2",
            "",
            "	.loc	2 173",
            "LM163:",
            "	li	$4,0x0010001		# 65537",
            "	div	$4,$4,$2",
        ]
        expected_lines = [
            # EXPAND_ZERO_DIV START
            "div	$zero,$16,$2",
            "mflo	$16",
            # EXPAND_ZERO_DIV END
            "lui\t$4,(65537 >> 16) & 0xFFFF",
            "ori	$4,$4,65537 & 0xFFFF",
            # nop  # DEBUG: mflo/mfhi with mult/div and li expands to 2 ops
            # DEBUG: div needs expanding
            "",
            ".loc	2 173",
            "LM163:",
            # li	$4,0x00001000		# 4096  # DEBUG: skipped
            # EXPAND_ZERO_DIV START
            "div	$zero,$4,$2",
            "mflo	$4",
            # EXPAND_ZERO_DIV END
        ]

        mp = MaspsxProcessor(lines, expand_li=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_div_expand_at_nop(self):
        """
        Only ASPSX 2.21 should insert a nop here, the sh uses $at.
        Bug report: https://github.com/mkst/maspsx/issues/76
        """
        lines = [
            "divu	$2,$2,$3",
            "sh	$2,gUpdateRate",
        ]
        expected_lines = [
            ".set\tnoat",
            "divu\t$zero,$2,$3",
            "bnez\t$3,.L_NOT_DIV_BY_ZERO_0",
            "nop",
            "break\t0x7",
            ".L_NOT_DIV_BY_ZERO_0:",
            "mflo\t$2",
            ".set\tat",
            "nop",
            "sh\t$2,gUpdateRate",
        ]

        mp = MaspsxProcessor(lines, expand_div=True, nop_at_expansion=True)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_div_expand_at_no_nop(self):
        """
        Only ASPSX 2.21 should insert a nop here, the sh uses $at.
        Bug report: https://github.com/mkst/maspsx/issues/76
        """
        lines = [
            "divu	$2,$2,$3",
            "sh	$2,gUpdateRate",
        ]
        expected_lines = [
            ".set\tnoat",
            "divu\t$zero,$2,$3",
            "bnez\t$3,.L_NOT_DIV_BY_ZERO_0",
            "nop",
            "break\t0x7",
            ".L_NOT_DIV_BY_ZERO_0:",
            "mflo\t$2",
            ".set\tat",
            "sh\t$2,gUpdateRate",
        ]

        mp = MaspsxProcessor(lines, expand_div=True, nop_at_expansion=False)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_nop_div_mult(self):
        """
        mult and mflo/mhfi must be separated by at least two instructions
        Bug: https://github.com/mkst/maspsx/issues/31
        """
        lines = [
            "	div	$3,$3,$6",
            "",
            "	.loc	2 67",
            "	mult	$3,$5",
        ]
        expected_lines = [
            "div\t$zero,$3,$6",
            "mflo\t$3",  # expanded div
            "nop",
            "nop",
            "mult\t$3,$5",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines[:5])

    def test_simple_div_expansion_nop(self):
        """
        We need to handle loads/stores from registers used immediately after mflo/mfhi
        Bug: https://github.com/mkst/maspsx/issues/34
        """
        lines = [
            "	div	$2,$2,$3",
            "	sw	$2,112($18)",
        ]
        expected_lines = [
            "div\t$zero,$2,$3",
            "mflo\t$2",  # expanded div
            "nop",
            "sw\t$2,112($18)",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_simple_div_expansion_no_nop(self):
        """
        Ensure we don't add a nop after div expansion if we dont need one
        Bug: https://github.com/mkst/maspsx/issues/34
        """
        lines = [
            "	div	$2,$2,$3",
            "",
            "	.loc	2 204",
            "	lh	$3,242($18)",
        ]
        expected_lines = [
            "div\t$zero,$2,$3",
            "mflo\t$2",  # expanded div
            "",
            ".loc\t2 204",
            "lh\t$3,242($18)",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)

    def test_simple_divu_expansion_no_nop(self):
        """
        Ensure we don't add a nop after divu expansion if we dont need one
        Bug: https://github.com/mkst/maspsx/issues/34
        """
        lines = [
            "	divu	$2,$2,$3",
            "",
            "	.loc	2 204",
            "	lh	$3,242($18)",
        ]
        expected_lines = [
            "divu\t$zero,$2,$3",
            "mflo\t$2",  # expanded div
            "",
            ".loc\t2 204",
            "lh\t$3,242($18)",
        ]
        mp = MaspsxProcessor(lines)
        res = mp.process_lines()

        clean_lines = strip_comments(res)
        self.assertEqual(expected_lines, clean_lines)
