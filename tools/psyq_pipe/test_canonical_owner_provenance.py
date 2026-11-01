"""Canonical-main include receipts may assign only independently proven owners.

Synthetic roots reuse the validator's fixture builder, without inheriting or
re-running its test class. No compiler, native lane or project-source writes.
"""
import copy
from pathlib import Path
import unittest

import test_compiler_origin_evidence as fixture_helpers
from local_owner_cmp import parse_owner_records


def native_fixture(sources, headers, *, names=None, base=0x80010000,
                   file_unit=None, close_file=True):
    """One real MND source group, independent of function names/addresses."""
    rows = []
    sequence = 0

    def record(address, kind, text):
        nonlocal sequence
        rows.append('%06x: $%08x %s %s' % (sequence, address, kind, text))
        sequence += 1

    if file_unit is not None:
        record(0, '94', 'Def class FILE type NULL size 0 name ' + file_unit)
    for source in sources:
        record(base, '88', 'Set SLD to line 1 of file ' + source)
    record(base, '8a', 'End SLD information')
    for index, header in enumerate(headers):
        start = base + index * 8
        record(start, '8c', 'Function start')
        rows.extend(('    fp = 29', '    fsize = 0', '    retreg = 31',
                     '    mask = $00000000', '    maskoffs = 0', '    line = 1',
                     '    file = ' + header,
                     '    name = ' + (names[index] if names else 'not_a_source_hint_' + str(index))))
        record(start, '90', 'Block start line = 1')
        record(2, '94', 'Def class REG type INT size 0 name value')
        record(start + 8, '92', 'Block end line = 2')
        record(start + 8, '8e', 'Function end line 2')
    if file_unit is not None and close_file:
        record(0, '94', 'Def class FILE type NULL size 0 name ' + file_unit)
    return ('\n'.join(rows) + '\n').encode()


class CanonicalOwnerProvenanceTests(unittest.TestCase):
    def setUp(self):
        self.f = fixture_helpers.OriginEvidenceTests('test_happy_canonical_speech_group')
        self.f.setUp()
        self.addCleanup(self.f.doCleanups)
        self.group = [self.f.canonical, self.f.canonical_include]
        self.install(native_fixture(self.group, self.group))

    def install(self, native):
        self.f.native.write_bytes(native)
        self.f.data['native_dump_sha256'] = fixture_helpers.sha(native)
        self.f.publish()

    def parse(self):
        functions = parse_owner_records(self.f.native, source_root=self.f.root)
        self.assertEqual(len(functions), 2)
        self.assertTrue(all(not fn['errors'] for fn in functions))
        return functions

    def assert_unowned(self):
        for fn in self.parse():
            self.assertIsNone(fn['provenance']['unit'])
            self.assertNotIn('sld_include_evidence', fn['provenance'])

    def test_canonical_group_supplies_only_validated_speech_owner(self):
        for fn in self.parse():
            provenance = fn['provenance']
            self.assertEqual(provenance['unit'], 'speech')
            self.assertIsNone(provenance['file_owner'])
            witness = provenance['sld_include_evidence']
            self.assertEqual(witness['kind'], 'validated_original_main_source_group')
            self.assertEqual(witness['primary_source'], self.f.source)
            self.assertEqual(witness['included_sources'], [self.f.included])
            self.assertEqual(frozenset(witness['source_group']), frozenset(self.group))
            self.assertTrue(witness['provenance_only'])

    def test_actual_function_header_filenames_remain_unchanged(self):
        headers = ['C:/checkout/not-retail/SPEECH.CPP', 'C:/different/source/SPCHEVNT.C']
        self.install(native_fixture(self.group, headers))
        before = self.f.native.read_bytes()
        functions = self.parse()
        self.assertEqual([fn['hdr']['file'] for fn in functions], headers)
        self.assertTrue(all(fn['provenance']['unit'] == 'speech' for fn in functions))
        self.assertEqual(self.f.native.read_bytes(), before)
        # Group ownership does not certify/correct either bad SLD header path.
        self.assertNotEqual(functions[0]['hdr']['file'], self.f.canonical)

    def test_representation_only_group_matching_preserves_raw_paths(self):
        sources = ['C:\\NFS4\\GAME\\COMMON\\SPEECH.CPP',
                   'c:\\nfs4\\game\\common\\spchevnt.c']
        self.install(native_fixture(sources, sources))
        functions = self.parse()
        self.assertEqual([fn['hdr']['file'] for fn in functions], sources)
        self.assertTrue(all(fn['provenance']['unit'] == 'speech' for fn in functions))

    def test_missing_sidecar_declines_canonical_group(self):
        self.f.sidecar.unlink()
        self.assert_unowned()

    def test_stale_dump_sidecar_declines_canonical_group(self):
        self.f.native.write_bytes(self.f.native.read_bytes() + b'ignored non-record comment\n')
        self.assert_unowned()

    def test_stale_bound_artifact_declines_canonical_group(self):
        for key in ('before_input', 'compiler_input', 'assembly', 'sn_object'):
            with self.subTest(artifact=key):
                path = self.f.root / self.f.unit[key]['path']
                before = path.read_bytes()
                try:
                    path.write_bytes(before + b'changed')
                    self.assert_unowned()
                finally:
                    path.write_bytes(before)

    def test_stale_source_or_include_declines_canonical_group(self):
        for relative in (self.f.source, self.f.included):
            with self.subTest(source=relative):
                path = self.f.root / relative
                before = path.read_bytes()
                try:
                    path.write_bytes(before + b'changed')
                    self.assert_unowned()
                finally:
                    path.write_bytes(before)

    def test_tampered_witness_declines_canonical_group(self):
        self.f.unit['origin']['replacement_count'] += 1
        self.f.publish()
        self.assert_unowned()

    def test_tampered_canonical_main_declines_canonical_group(self):
        self.f.unit['canonical_main'] = 'C:/nfs4/GAME/COMMON/UNRELATED.CPP'
        self.f.publish()
        self.assert_unowned()

    def test_duplicate_claim_declines_canonical_group(self):
        self.f.data['units'].append(copy.deepcopy(self.f.unit))
        self.f.publish()
        self.assert_unowned()

    def test_same_basename_elsewhere_is_not_a_group_match(self):
        for group in ([self.f.canonical.replace('/GAME/COMMON/', '/OTHER/COMMON/'), self.f.canonical_include],
                      [self.f.canonical, 'C:/nfs4/EACLIB/PSX/SPCHPSXZ/SPCHEVNT.C']):
            with self.subTest(group=group):
                self.install(native_fixture(group, self.group))
                self.assert_unowned()

    def test_extra_group_member_is_not_fuzzily_discarded(self):
        self.install(native_fixture(self.group + ['C:/nfs4/GAME/COMMON/EXTRA.C'], self.group))
        self.assert_unowned()

    def test_names_addresses_and_record_order_do_not_select_owner(self):
        names = ['Initialize__5tMenu', 'method_from_some_other_unit']
        self.install(native_fixture(list(reversed(self.group)), list(reversed(self.group)),
                                    names=names, base=0x80123400))
        for fn in self.parse():
            self.assertEqual(fn['provenance']['unit'], 'speech')
        self.f.sidecar.unlink()
        self.assert_unowned()

    def test_conflicting_paired_file_owner_is_not_overridden(self):
        self.install(native_fixture(self.group, self.group, file_unit='unrelated.obj'))
        for fn in self.parse():
            self.assertEqual(fn['provenance']['file_owner'], 'unrelated')
            self.assertIsNone(fn['provenance']['unit'])

    def test_unclosed_file_owner_stays_invalid(self):
        self.install(native_fixture(self.group, self.group, file_unit='speech.obj', close_file=False))
        for fn in self.parse():
            self.assertIsNone(fn['provenance']['unit'])

    def test_legacy_physical_include_group_works_without_sidecar(self):
        sources = [(self.f.root / self.f.source).as_posix(), (self.f.root / self.f.included).as_posix()]
        self.install(native_fixture(sources, self.group))
        self.f.sidecar.unlink()
        for fn in self.parse():
            self.assertEqual(fn['provenance']['unit'], 'speech')
            witness = fn['provenance']['sld_include_evidence']
            self.assertEqual(witness['kind'], 'declared_included_source_group')
            self.assertEqual(witness['primary_source'], self.f.source)
            self.assertEqual(witness['included_sources'], [self.f.included])

    def test_legacy_physical_group_uses_its_independent_graph_not_stale_receipt(self):
        sources = [(self.f.root / self.f.source).as_posix(), (self.f.root / self.f.included).as_posix()]
        self.install(native_fixture(sources, self.group))
        self.f.unit['origin']['replacement_count'] += 5
        self.f.publish()
        for fn in self.parse():
            self.assertEqual(fn['provenance']['unit'], 'speech')
            self.assertEqual(fn['provenance']['sld_include_evidence']['kind'],
                             'declared_included_source_group')

    def test_legacy_physical_group_still_requires_literal_include_edge(self):
        sources = [(self.f.root / self.f.source).as_posix(), (self.f.root / self.f.included).as_posix()]
        self.install(native_fixture(sources, self.group))
        self.f.sidecar.unlink()
        (self.f.root / self.f.source).write_bytes(b'// #include "spchevnt.c"\n')
        self.assert_unowned()


if __name__ == '__main__':
    unittest.main()
