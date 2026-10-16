"""Copy audits must use proven units, never ordinal or best-contract pairing."""
import tempfile
import unittest
from pathlib import Path

from local_owner_cmp import parse_owner_records, parse_owners, compare
from local_owner_copies import audit
from test_local_owner_cmp import fixture


def copy(unit, base, native=False, close=True, changed=False):
    if native:
        prefix = (f'0010: ${base:08x} 88 Set SLD to line 1 of file C:\\recon\\{unit}.cpp\n'
                  f'0011: ${base:08x} 8a End SLD info\n')
        suffix = ''
    else:
        tag = f'0010: $00000000 94 Def class FILE type NULL size 0 name {unit}.obj\n'
        prefix, suffix = tag, '\n'+tag if close else ''
    body = fixture(base=base)
    if changed:
        body = body.replace('$00000003 94', '$00000004 94')
    return prefix+body+suffix


class CopiesTests(unittest.TestCase):
    def parse(self, text):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory)/'copy.txt'
            path.write_text(text)
            return parse_owner_records(path)

    def result(self, left, right):
        return audit(self.parse(left), self.parse(right))['functions']['sample']

    def test_distinct_proven_owners_and_relocation(self):
        left = copy('one', 0x80030000, True)+'\n'+copy('two', 0x80040000, True)
        right = copy('one', 0x80010000)+'\n'+copy('two', 0x80020000)
        result = self.result(left, right)
        self.assertEqual(result['status'], 'PASS')
        self.assertEqual(set(result['copies']), {'one', 'two'})

    def test_order_cannot_choose_copy(self):
        left = copy('two', 0x80040000, True)+'\n'+copy('one', 0x80030000, True)
        right = copy('one', 0x80010000)+'\n'+copy('two', 0x80020000)
        self.assertEqual(self.result(left, right)['status'], 'PASS')

    def test_second_copy_difference_is_not_hidden(self):
        left = copy('one', 0x80030000, True)+'\n'+copy('two', 0x80040000, True, changed=True)
        right = copy('one', 0x80010000)+'\n'+copy('two', 0x80020000)
        result = self.result(left, right)
        self.assertEqual(result['status'], 'DIFF')
        self.assertEqual(result['copies']['one']['status'], 'PASS')
        self.assertEqual(result['copies']['two']['status'], 'DIFF')

    def test_missing_copy_is_coverage_failure(self):
        result = self.result(copy('one', 0x80030000, True),
                             copy('one', 0x80010000)+'\n'+copy('two', 0x80020000))
        self.assertEqual(result['status'], 'COVERAGE')
        self.assertEqual(result['missing_native_owners'], ['two'])

    def test_same_owner_duplicates_still_invalid(self):
        left = copy('one', 0x80030000, True)+'\n'+copy('one', 0x80040000, True)
        right = copy('one', 0x80010000)+'\n'+copy('two', 0x80020000)
        self.assertEqual(self.result(left, right)['status'], 'INVALID')

    def test_no_anchor_cannot_use_address_order(self):
        left = fixture()+'\n'+fixture(base=0x80020000)
        right = copy('one', 0x80010000)+'\n'+copy('two', 0x80020000)
        self.assertEqual(self.result(left, right)['status'], 'INVALID')

    def test_unclosed_file_cannot_be_owner(self):
        self.assertIsNone(self.parse(copy('one', 0x80010000, close=False))[0]['provenance']['unit'])

    def test_multiple_sld_sources_cannot_be_owner(self):
        text = copy('one', 0x80010000, True).replace('0011:',
            '0012: $80010000 88 Set SLD to line 1 of file C:\\recon\\two.cpp\n0011:')
        self.assertIsNone(self.parse(text)[0]['provenance']['unit'])

    def test_conflicting_anchors_cannot_be_owner(self):
        tag = '0013: $00000000 94 Def class FILE type NULL size 0 name other.obj\n'
        text = tag+copy('one', 0x80010000, True)+'\n'+tag
        self.assertIsNone(self.parse(text)[0]['provenance']['unit'])

    def test_legacy_view_remains_fail_closed(self):
        text = copy('one', 0x80010000)+'\n'+copy('two', 0x80020000)
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory)/'copy.txt'
            path.write_text(text)
            self.assertEqual(len(parse_owner_records(path)), 2)
            self.assertIn('duplicate function record', parse_owners(path)['sample']['errors'])

    def test_source_file_difference_is_visible(self):
        left = copy('one', 0x80030000, True)+'\n'+copy('two', 0x80040000, True)
        right = copy('one', 0x80010000)+'\n'+copy('two', 0x80020000)
        left = left.replace('    name = sample',
                            '    file = C:\\recon\\classes.h\n    name = sample')
        right = right.replace('    name = sample',
                              '    file = C:\\retail\\original.h\n    name = sample')
        report = audit(self.parse(left), self.parse(right))
        self.assertEqual(report['functions']['sample']['status'], 'PASS')
        self.assertEqual(report['coverage']['header_filename_differences'], 2)

    def test_unnamed_record_is_not_silently_lost(self):
        records = self.parse(fixture().replace('    name = sample', '    file = unknown.h'))
        self.assertEqual(len(records), 1)
        self.assertIn('missing function name', records[0]['errors'])
        self.assertEqual(audit(records, [])['coverage']['unnamed_native'], 1)


class IncludedSourceGroupsTests(unittest.TestCase):
    """Manifest plus include edges prove a group, never a best matching name."""
    primary = 'recon/game/common/speech.cpp'
    included = 'recon/game/common/spchevnt.c'

    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        (self.root/'tools').mkdir()
        (self.root/'tools/build.py').write_text(
            "INCLUDED_SOURCES = {'recon/game/common/spchevnt.c'}\n"
            "raise AssertionError('the manifest must never be executed')\n")
        folder = self.root/'recon/game/common'
        folder.mkdir(parents=True)
        (folder/'speech.cpp').write_text('#include "spchevnt.c"\n')
        (folder/'spchevnt.c').write_text('/* included body */\n')
        (folder/'sim.cpp').write_text('/* unrelated translation unit */\n')

    def parse(self, sources, changed=False, conflict=False):
        base = 0x80030000
        prefix = ''.join(f'0010: ${base:08x} 88 Set SLD to line 1 of file C:\\evidence\\'
                         + source.replace('/', '\\')+'\n' for source in sources)
        prefix += f'0011: ${base:08x} 8a End SLD info\n'
        tag = '0012: $00000000 94 Def class FILE type NULL size 0 name other.obj\n'
        body = fixture(base=base)
        if changed:
            body = body.replace('$00000003 94', '$00000004 94')
        data = (tag if conflict else '')+prefix+body+('\n'+tag if conflict else '')
        path = self.root/'native.txt';path.write_text(data)
        return parse_owner_records(path, source_root=self.root)

    def test_declared_include_group_is_proven(self):
        row = self.parse([self.primary, self.included])[0]
        self.assertEqual(row['name'], 'sample')  # Not a Speech symbol: names cannot choose an owner.
        self.assertEqual(row['provenance']['unit'], 'speech')
        evidence = row['provenance']['sld_include_evidence']
        self.assertEqual(evidence['primary_source'], self.primary)
        self.assertEqual(evidence['included_sources'], [self.included])
        self.assertEqual(len(evidence['source_sha256']), 2)

    def test_include_order_never_selects_owner(self):
        a = self.parse([self.primary,self.included])[0]
        b = self.parse([self.included,self.primary])[0]
        self.assertEqual(a['provenance'], b['provenance'])

    def test_unrelated_primary_cannot_claim_include(self):
        self.assertIsNone(self.parse(['recon/game/common/sim.cpp',self.included])[0]['provenance']['unit'])

    def test_two_roots_remain_ambiguous(self):
        self.assertIsNone(self.parse([self.primary,'recon/game/common/sim.cpp',self.included])[0]['provenance']['unit'])

    def test_same_basename_library_file_is_not_the_declared_include(self):
        library=self.root/'recon/eaclib/psx/spchpsxz/spchevnt.c'
        library.parent.mkdir(parents=True);library.write_text('/* different library object */\n')
        self.assertIsNone(self.parse([self.primary,'recon/eaclib/psx/spchpsxz/spchevnt.c'])[0]['provenance']['unit'])

    def test_commented_include_does_not_prove_edge(self):
        (self.root/self.primary).write_text('/*\n#include "spchevnt.c"\n*/\n')
        self.assertIsNone(self.parse([self.primary,self.included])[0]['provenance']['unit'])

    def test_conflicting_file_anchor_still_rejected(self):
        row=self.parse([self.primary,self.included],conflict=True)[0]
        self.assertIsNone(row['provenance']['unit'])
        self.assertEqual(row['provenance']['file_owner'],'other')

    def test_contract_difference_is_not_hidden_by_new_provenance(self):
        native=self.parse([self.primary,self.included],changed=True)
        path=self.root/'retail.txt';path.write_text(copy('speech',0x80010000))
        self.assertEqual(native[0]['provenance']['unit'],'speech')
        result=compare(native[0],parse_owner_records(path)[0])
        self.assertEqual(result['status'],'DIFF')

    def test_nonliteral_manifest_fails_closed(self):
        (self.root/'tools/build.py').write_text("INCLUDED_SOURCES = set(['recon/game/common/spchevnt.c'])\n")
        self.assertIsNone(self.parse([self.primary,self.included])[0]['provenance']['unit'])


if __name__ == '__main__':
    unittest.main()
