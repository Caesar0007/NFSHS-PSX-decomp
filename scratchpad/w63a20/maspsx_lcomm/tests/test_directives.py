import unittest

from maspsx import MaspsxProcessor


class TestDirectives(unittest.TestCase):

    def test_file_directive(self):
        line = '.file\t1 "/tmp/code.c"'
        mp = MaspsxProcessor([])
        res = mp.process_line(line)
        self.assertEqual([line], res)
        self.assertEqual(mp.file_num, 2)

    def test_file_directive_with_space(self):
        line = '.file\t1 "E:/ROOT/My Project/VehCalc_InterpSpeed.c"'
        mp = MaspsxProcessor([])
        res = mp.process_line(line)
        self.assertEqual([line], res)
        self.assertEqual(mp.file_num, 2)

    def test_named_section_resets_sdata_scan(self):
        # w26-a3: CC1PSX emits the generic ELF `.section NAME,"FLAGS",@TYPE` form for
        # any global carrying an explicit `__attribute__((section(".data"/".bss"/...)))`
        # (used to pin an otherwise-.sdata/.sbss-eligible global into a regular, absolute
        # section). Previously only a bare `.section .text` was recognised as ending an
        # `.sdata` run; any OTHER named section immediately after a bare `.sdata` block
        # (with no intervening `.text`/`.data`/`.rdata`) fell through to the sdata-entry
        # scan's catch-all and raised "Unable to parse .sdata instruction". Real trigger
        # (libgpu/SYS.cpp): a `.sdata`-placed const table's ascii literal-pool tail
        # immediately followed by an attribute-forced `.section .data,"aw",@progbits`.
        lines = [
            ".sdata",
            ".align\t2",
            "tbl:",
            ".word\t$LC1",
            ".align\t2",
            "$LC1:",
            '.ascii\t"GPU\\000"',
            ".globl\tGEnv_drv",
            '.section .data,"aw",@progbits',
            ".align\t2",
            "GEnv_drv:",
            ".word\ttbl",
        ]
        mp = MaspsxProcessor(lines)
        # must not raise "Unable to parse .sdata instruction: .section .data,..."
        out = mp.process_lines()
        self.assertIn("GEnv_drv:", out)

    def test_named_bss_section_after_sdata_run(self):
        # Same bug, `.bss`-flavoured (the other section name this tree's
        # `__attribute__((section(".bss")))` globals use).
        lines = [
            ".sdata",
            ".align\t2",
            "small_const:",
            ".word\t5",
            ".globl\tGPU_GP0",
            '.section .bss,"aw",@progbits',
            ".align\t2",
            "GPU_GP0:",
            ".space\t4",
        ]
        mp = MaspsxProcessor(lines)
        out = mp.process_lines()
        self.assertIn("GPU_GP0:", out)

    def test_named_sdata_section_enters_sdata_scan(self):
        # An explicit `.section .sdata,...` (never emitted by this project's CC1PSX in
        # practice, but the general form) should behave like the bare `.sdata` directive
        # -- i.e. still be tracked by the sdata-entry scan -- not silently ignored.
        lines = [
            '.section .sdata,"aw",@progbits',
            ".align\t2",
            "small:",
            ".word\t1",
        ]
        mp = MaspsxProcessor(lines)
        out = mp.process_lines()
        self.assertIn("small:", out)
