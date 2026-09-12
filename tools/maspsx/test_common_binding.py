"""P905 small-COMMON binding regression tests; no output-object rewriting."""
import unittest
from maspsx import MaspsxProcessor


def process(limit=4, **options):
    # Both public and file-static declarations deliberately cover both sides
    # of the small-data threshold. The instruction text is a test fixture,
    # not reconstructed application assembly.
    lines = [
        '.text', '.set noreorder', '.globl test_function',
        '.ent test_function', 'test_function:',
        'lw $2,public_word', 'jr $31', 'nop', '.end test_function',
        '.comm public_byte,1', '.lcomm private_byte,1',
        '.comm public_word,4', '.lcomm private_word,4',
        '.comm public_large,16', '.lcomm private_large,16',
    ]
    return MaspsxProcessor(lines, sdata_limit=limit, **options).process_lines()


def globals_in(lines):
    return {line.split()[1] for line in lines if line.strip().startswith('.globl ')}


class SmallCommonBindingTest(unittest.TestCase):
    def test_legacy_default_is_unchanged(self):
        for limit in (0, 1, 4, 8, 16, 32):
            with self.subTest(limit=limit):
                self.assertEqual(process(limit), process(limit, preserve_small_common_binding=False))

    def test_only_true_small_common_gains_public_binding(self):
        for limit in (0, 1, 4, 8, 16, 32):
            old = process(limit)
            new = process(limit, preserve_small_common_binding=True)
            extra = {name for name, size in (('public_byte', 1), ('public_word', 4),
                                           ('public_large', 16)) if size <= limit}
            with self.subTest(limit=limit):
                self.assertEqual(globals_in(new) - globals_in(old), extra)
                self.assertEqual([line for line in new if line.strip() not in
                                  {'.globl ' + name for name in extra}], old)

    def test_true_local_common_stays_local(self):
        for limit in (0, 1, 4, 8, 16, 32):
            names = globals_in(process(limit, preserve_small_common_binding=True))
            self.assertTrue({'public_byte', 'public_word', 'public_large'} <= names)
            self.assertFalse({'private_byte', 'private_word', 'private_large'} & names)

    def test_actual_common_option_retains_its_semantics(self):
        for limit in (0, 1, 4, 8, 16, 32):
            for include_local in (False, True):
                options = dict(use_comm_section=True, use_comm_for_lcomm=include_local)
                self.assertEqual(process(limit, **options), process(limit,
                                 preserve_small_common_binding=True, **options))

    def test_declaration_order_and_reserved_sizes_are_unchanged(self):
        for limit in (0, 1, 4, 8, 16, 32):
            old = process(limit)
            new = process(limit, preserve_small_common_binding=True)
            contract = lambda lines: [line for line in lines if line.endswith(':') or
                                      line.strip().startswith(('.space ', '.align ', '.section '))]
            self.assertEqual(contract(old), contract(new))


if __name__ == '__main__':
    unittest.main()
