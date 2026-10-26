"""Same-address records must never disappear behind a per-word EXACT result."""
import unittest

from sld_records_cmp import compare, decode_records, index_functions, strict_failure


def stream(lines, base=0x80010000, file='C:/nfs4/a.cpp'):
    text = '000000: $%08x 88 Set SLD to line 1 of file %s\n' % (base, file)
    for i, (offset, line) in enumerate(lines, 1):
        text += '%06x: $%08x 86 Set SLD linenum to %d\n' % (i, base+offset, line)
    return decode_records(text)


def fn(base=0x80010000, size=12):
    return dict(start=base, end=base+size)


class SldRecordTests(unittest.TestCase):
    def test_same_address_missing_note_cannot_pass(self):
        n, r = stream([(4, 20)]), stream([(4, 10), (4, 20)])
        self.assertEqual(n[0][-1]['line'], r[0][-1]['line'])
        self.assertEqual(compare(fn(), fn(), n, r)['status'], 'DIFF')

    def test_duplicate_same_line_record_preserved(self):
        n, r = stream([(4, 20)]), stream([(4, 20), (4, 20)])
        self.assertEqual(compare(fn(), fn(), n, r)['retail_count'], 2)
        self.assertFalse(compare(fn(), fn(), n, r)['semantic_sequence_equal'])

    def test_same_address_order_not_sorted_by_line(self):
        n, r = stream([(4, 10), (4, 20)]), stream([(4, 20), (4, 10)])
        self.assertEqual(compare(fn(), fn(), n, r)['status'], 'DIFF')

    def test_non_monotonic_record_order_not_hidden(self):
        n, r = stream([(8, 10), (4, 20)]), stream([(4, 20), (8, 10)])
        self.assertEqual(compare(fn(), fn(), n, r)['status'], 'DIFF')

    def test_shifted_code_addresses_and_normalized_filename(self):
        n = stream([(4, 10)], file=r'C:\\NFS4\\a.cpp')
        r = stream([(4, 10)], base=0x80020000)
        result = compare(fn(), fn(0x80020000), n, r)
        self.assertEqual(result['status'], 'INTERIOR_EXACT')

    def test_different_directories_cannot_match(self):
        result = compare(fn(), fn(), stream([(4, 10)], file='C:/x/a.cpp'),
                         stream([(4, 10)], file='C:/y/a.cpp'))
        self.assertEqual(result['status'], 'DIFF')

    def test_boundary_exclusion_is_explicit_and_empty_is_not_function_pass(self):
        n, r = stream([(0, 20), (12, 30)]), stream([(0, 40), (12, 50)])
        result = compare(fn(), fn(), n, r)
        self.assertEqual(result['status'], 'EMPTY_INTERIOR')
        self.assertEqual((result['native_count'], result['retail_count']), (0, 0))

    def test_raw_encoding_differences_are_not_raw_exact(self):
        n = stream([(4, 10)])
        r = decode_records('000000: $80010000 88 Set SLD to line 1 of file C:/nfs4/a.cpp\n'
                           '000001: $80010004 82 Inc SLD linenum by byte 9 (to 10)\n')
        result = compare(fn(), fn(), n, r)
        self.assertEqual(result['status'], 'SEMANTIC_INTERIOR_EXACT')
        self.assertFalse(result['raw_payload_sequence_equal'])

    def test_ambiguous_function_names_not_arbitrarily_paired(self):
        unique, ambiguous = index_functions([dict(name='a'), dict(name='a'), dict(name='b')])
        self.assertEqual(set(unique), {'b'})
        self.assertEqual(ambiguous, {'a': 2})

    def test_no_coverage_bad_bounds_and_length_fail_closed(self):
        n = stream([(4, 10)])
        self.assertEqual(compare(fn(), fn(), ([], []), n)['status'], 'NO_FUNCTION_SLD_EVENTS')
        self.assertEqual(compare(fn(size=3), fn(), n, n)['status'], 'INVALID_BOUNDS')
        self.assertEqual(compare(fn(size=8), fn(), n, n)['status'], 'LENGTH_MISMATCH')

    def test_word_increment_record_retained_and_malformed_known_record_rejected(self):
        records, _ = decode_records('000001: $80010004 84 Inc SLD linenum by word 300 (to 305)\n')
        self.assertEqual(records[0]['line'], 305)
        with self.assertRaisesRegex(ValueError, 'Undecoded SLD'):
            decode_records('000001: $80010004 84 invalid SLD\n')

    def test_missing_bound_is_not_arithmetic_or_vacuous_success(self):
        result = compare(dict(start=0, end=None), fn(), stream([]), stream([]))
        self.assertEqual(result['status'], 'INVALID_BOUNDS')
        self.assertTrue(strict_failure({'f': result}))

    def test_raw_mode_also_requires_inherited_filename_semantics(self):
        result = compare(fn(), fn(), stream([(4, 10)], file='C:/x/a.cpp'),
                         stream([(4, 10)], file='C:/y/a.cpp'))
        self.assertTrue(result['raw_payload_sequence_equal'])
        self.assertEqual(result['status'], 'DIFF')
        self.assertTrue(strict_failure({'f': result}, require_raw=True))


if __name__ == '__main__':
    unittest.main()
