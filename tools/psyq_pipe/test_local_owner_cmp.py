"""Ownership checks must reject same-depth, wrong-sibling declarations."""
import tempfile
import unittest
from pathlib import Path
from local_owner_cmp import parse_owners, compare


def fixture(base=0x80010000, second=False, empty=False, malformed=False):
    end = base + (0 if empty else 8)
    rows = [f'0000: ${base:08x} 8c Function start', '    name = sample',
            f'0001: ${base:08x} 90 Block start',
            f'0002: ${base:08x} 90 Block start']
    declaration = '0003: $00000003 94 Def class REG type INT size 0 name value'
    if not second:
        rows.append(declaration)
    rows += [f'0004: ${end:08x} 92 Block end',
             f'0005: ${end:08x} 90 Block start']
    if second:
        rows.append(declaration)
    rows.append(f'0006: ${end:08x} 92 Block end')
    if not malformed:
        rows.append(f'0007: ${end:08x} 92 Block end')
    rows.append(f'0008: ${end:08x} 8e Function end line 1')
    return '\n'.join(rows)


class OwnerTests(unittest.TestCase):
    def parse(self, text):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'fixture.txt'
            path.write_text(text)
            return parse_owners(path)['sample']

    def test_identical(self):
        self.assertEqual(compare(self.parse(fixture()), self.parse(fixture()))['status'], 'PASS')

    def test_relative_relocation(self):
        self.assertEqual(compare(self.parse(fixture()), self.parse(fixture(base=0x80020000)))['status'], 'PASS')

    def test_wrong_sibling_same_depth(self):
        first, second = self.parse(fixture()), self.parse(fixture(second=True))
        for key in ('name', 'home', 'type', 'depth'):
            self.assertEqual(first['locals'][0][key], second['locals'][0][key])
        self.assertEqual(compare(first, second)['status'], 'DIFF')

    def test_empty_siblings_same_bounds_still_distinct(self):
        first, second = self.parse(fixture(empty=True)), self.parse(fixture(second=True, empty=True))
        self.assertEqual(first['locals'][0]['owner']['start'], second['locals'][0]['owner']['start'])
        self.assertEqual(first['locals'][0]['owner']['end'], second['locals'][0]['owner']['end'])
        self.assertEqual(compare(first, second)['status'], 'DIFF')

    def test_unclosed_block_invalid(self):
        self.assertEqual(compare(self.parse(fixture(malformed=True)), self.parse(fixture()))['status'], 'INVALID')

    def test_missing_end_invalid(self):
        text = fixture().rsplit('\n', 1)[0]
        self.assertEqual(compare(self.parse(text), self.parse(fixture()))['status'], 'INVALID')

    def test_duplicate_function_invalid(self):
        duplicate = self.parse(fixture()+'\n'+fixture())
        self.assertEqual(compare(duplicate, self.parse(fixture()))['status'], 'INVALID')

    def test_shadowed_names_are_not_collapsed(self):
        text = fixture().replace('0005:',
            '0009: $00000004 94 Def class REG type INT size 0 name value\n0005:')
        parsed = self.parse(text)
        self.assertEqual(len(parsed['locals']), 2)
        self.assertNotEqual(parsed['locals'][0]['owner'], parsed['locals'][1]['owner'])

    def test_array_dimensions_are_checked(self):
        first = fixture().replace('type INT size 0 name value',
                                  'type ARY INT size 16 dims 4 name value')
        second = first.replace('size 16 dims 4', 'size 12 dims 3')
        self.assertEqual(compare(self.parse(first), self.parse(second))['status'], 'DIFF')

    def test_zero_array_dimension_is_not_dropped(self):
        text = fixture().replace('type INT size 0 name value',
                                 'type ARY INT size 0 dims 0 name value')
        self.assertEqual(self.parse(text)['locals'][0]['dimensions'], [0])


if __name__ == '__main__':
    unittest.main()
