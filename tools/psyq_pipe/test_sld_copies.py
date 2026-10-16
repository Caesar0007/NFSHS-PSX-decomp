"""Copy SLD must not discard a second copy or use ordinal/address pairing."""
import tempfile
import unittest
from pathlib import Path

from sld_copies import audit, load_dump
from test_sldtree_cmp import fixture


def copy(unit, base, native=False, later=None):
    line = 200 if native else 100
    source = f'C:\\nfs4\\GAME\\COMMON\\{unit}.cpp'
    anchor = f'000010: ${base:08x} 88 Set SLD to line {line} of file {source}\n'
    if native:
        prefix, suffix = anchor+f'000011: ${base:08x} 8a End SLD info\n', ''
    else:
        tag = f'000012: $00000000 94 Def class FILE type NULL size 0 name {unit}.obj\n'
        prefix, suffix = tag+anchor, tag
    body = fixture(base, line, line+1 if later is None else later, line+2, 'sample')
    # The defining source is a header, distinct from the independently
    # anchored compilation unit. A second .cpp would be genuinely ambiguous.
    body = body.replace('X.CPP', 'CLASSES.H')
    return prefix+body+suffix


class SldCopiesTests(unittest.TestCase):
    def result(self, native, retail):
        with tempfile.TemporaryDirectory() as directory:
            left, right = Path(directory)/'native.txt', Path(directory)/'retail.txt'
            left.write_text(native)
            right.write_text(retail)
            return audit(load_dump(left), load_dump(right))['functions']['sample']

    def test_relocated_reversed_copies_pair_by_owner(self):
        native = copy('two', 0x80004000, True)+copy('one', 0x80003000, True)
        retail = copy('one', 0x80001000)+copy('two', 0x80002000)
        row = self.result(native, retail)
        self.assertEqual(row['status'], 'EXACT')
        self.assertEqual(set(row['copies']), {'one', 'two'})

    def test_changed_second_copy_is_visible(self):
        native = copy('one', 0x80003000, True)+copy('two', 0x80004000, True, 204)
        retail = copy('one', 0x80001000)+copy('two', 0x80002000)
        row = self.result(native, retail)
        self.assertEqual(row['status'], 'DIFF')
        self.assertEqual(row['copies']['one']['status'], 'EXACT')
        self.assertEqual(row['copies']['two']['tag_diffs'], 1)

    def test_missing_copy_is_not_exact(self):
        row = self.result(copy('one', 0x80003000, True),
                          copy('one', 0x80001000)+copy('two', 0x80002000))
        self.assertEqual(row['status'], 'COVERAGE')
        self.assertEqual(row['missing_native_owners'], ['two'])

    def test_same_owner_duplicates_invalid(self):
        row = self.result(copy('one', 0x80003000, True)+copy('one', 0x80004000, True),
                          copy('one', 0x80001000)+copy('two', 0x80002000))
        self.assertEqual(row['status'], 'INVALID_OWNERSHIP')

    def test_unknown_owner_does_not_use_matching_address(self):
        native = fixture(0x80001000, 200, 201, 202, 'sample')
        row = self.result(native, copy('one', 0x80001000)+copy('two', 0x80002000))
        self.assertEqual(row['status'], 'INVALID_OWNERSHIP')

    def test_changed_block_line_does_not_pass(self):
        native = (copy('one', 0x80003000, True)+copy('two', 0x80004000, True)).replace(
            'Block end  line = 2', 'Block end  line = 3')
        row = self.result(native, copy('one', 0x80001000)+copy('two', 0x80002000))
        self.assertEqual(row['status'], 'DIFF')
        self.assertFalse(row['copies']['two']['block_lines_equal'])

    def test_malformed_scope_cannot_pass_sld_alone(self):
        native = (copy('one', 0x80003000, True)+copy('two', 0x80004000, True)).replace(
            '90 Block start', '91 Unsupported')
        row = self.result(native, copy('one', 0x80001000)+copy('two', 0x80002000))
        self.assertEqual(row['status'], 'INVALID_OWNERSHIP')
        self.assertEqual(row['copies']['one']['status'], 'INVALID_DECLARATION_OWNERSHIP')

    def test_wrong_header_file_is_not_exact(self):
        native = (copy('one', 0x80003000, True)+copy('two', 0x80004000, True)).replace(
            'CLASSES.H', 'WRONG.H')
        row = self.result(native, copy('one', 0x80001000)+copy('two', 0x80002000))
        self.assertEqual(row['status'], 'DIFF')
        self.assertEqual(row['copies']['two']['status'], 'SOURCE_FILE_MISMATCH')

    def test_missing_in_function_sld_is_not_exact(self):
        native = copy('one', 0x80003000, True)+copy('two', 0x80004000, True)
        native = '\n'.join(line for line in native.splitlines()
                           if not (' 88 ' in line or ' 80 ' in line))
        # Retain genuine native unit anchors; only discard header/body events.
        for unit, base in [('one', 0x80003000), ('two', 0x80004000)]:
            native = native.replace(f'000011: ${base:08x} 8a',
                f'000010: ${base-4:08x} 88 Set SLD to line 200 of file C:\\nfs4\\GAME\\COMMON\\{unit}.cpp\n'
                f'000011: ${base:08x} 8a')
        row = self.result(native, copy('one', 0x80001000)+copy('two', 0x80002000))
        self.assertEqual(row['status'], 'DIFF')
        self.assertEqual(row['copies']['one']['status'], 'NO_FUNCTION_SLD_EVENT')


if __name__ == '__main__':
    unittest.main()
