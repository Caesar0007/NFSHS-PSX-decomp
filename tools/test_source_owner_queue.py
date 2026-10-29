"""Read-only queue invariants; no source/SYM/compiler fixtures are rewritten."""
import copy
import unittest

from source_owner_queue import pair_records, name_balance, canonical_file, attach_coordinates, REGISTER_ARTIFACT
from local_owner_cmp import compare
from source_review_inventory import mask_trivia, SYNTHETIC


def function(unit='one', name='same', start=100):
    return dict(name=name, start=start, end=start+8, hdr={}, locals=[], errors=[],
                provenance=dict(unit=unit))


def local(name='i', home='REG:$2', path=None):
    return dict(name=name, home=home, type='INT', size=0, dimensions=[], depth=2,
                owner=dict(start=0, end=4, path=[0, 0] if path is None else path))


class QueueTests(unittest.TestCase):
    def test_duplicate_symbols_pair_by_independent_unit_not_address_or_order(self):
        n = [function('two', start=100), function('one', start=200)]
        r = [function('one', start=100), function('two', start=200)]
        rows = pair_records(n, r)
        self.assertEqual([x['unit'] for x in rows], ['one', 'two'])
        self.assertTrue(all(x['pairing'] == 'PAIRED' for x in rows))
        self.assertEqual(rows[0]['native'][0]['start'], 200)
        self.assertEqual(rows[0]['retail'][0]['start'], 100)

    def test_duplicate_same_unit_is_invalid_and_all_copies_remain(self):
        rows = pair_records([function(), function(start=200)], [function()])
        self.assertEqual(rows[0]['pairing'], 'INVALID')
        self.assertEqual(len(rows[0]['native']), 2)

    def test_missing_provenance_is_invalid_even_with_unique_symbol(self):
        self.assertEqual(pair_records([function(None)], [function(None)])[0]['pairing'], 'INVALID')

    def test_one_sided_records_remain(self):
        rows = pair_records([function('native')], [function('retail')])
        self.assertEqual({x['pairing'] for x in rows}, {'NATIVE_ONLY', 'MISSING_NATIVE'})
        self.assertEqual(sum(len(x['native']) for x in rows), 1)
        self.assertEqual(sum(len(x['retail']) for x in rows), 1)

    def test_repeated_names_preserve_surplus_cardinality_and_all_candidates(self):
        n = [local(path=[0, i]) for i in range(3)]
        row = name_balance(n, [local()])[0]
        self.assertEqual(row['native_surplus'], 2)
        self.assertEqual(len(row['native_candidates']), 3)
        self.assertEqual(row['native_candidates'], n)

    def test_wrong_home_is_not_invented_name_surplus(self):
        a, b = function(), function()
        a['locals'], b['locals'] = [local()], [local(home='REG:$3')]
        self.assertEqual(name_balance(a['locals'], b['locals']), [])
        self.assertEqual(compare(a, b)['status'], 'DIFF')

    def test_shadowed_name_wrong_owner_cannot_pass_by_name_count(self):
        a, b = function(), function()
        a['locals'] = [local(path=[0, 0]), local(path=[0, 1])]
        b['locals'] = [local(path=[0, 1]), local(path=[0, 0])]
        self.assertEqual(name_balance(a['locals'], b['locals']), [])
        self.assertEqual(len(compare(a, b)['differences']), 2)

    def test_matching_same_name_occurrences_are_not_coalesced(self):
        a = function(); a['locals'] = [local(path=[0, 0]), local(path=[0, 1])]
        self.assertEqual(compare(a, copy.deepcopy(a))['status'], 'PASS')
        self.assertEqual(len(a['locals']), 2)

    def test_comments_strings_and_character_literals_are_not_code_identifiers(self):
        text = '/* iVar1 */ const char *s = "uVar2"; // pCVar3\nint iVar4;'
        self.assertEqual(SYNTHETIC.findall(mask_trivia(text)), ['iVar4'])

    def test_source_directory_identity_not_basename_only(self):
        self.assertEqual(canonical_file('C:\\NFS4\\GAME\\A.CPP'), canonical_file('c:/nfs4/game/a.cpp'))
        self.assertNotEqual(canonical_file('c:/one/a.cpp'), canonical_file('c:/two/a.cpp'))

    def test_coordinate_attachment_rejects_parser_coverage_disagreement(self):
        with self.assertRaises(AssertionError):
            attach_coordinates([function()], [])
        with self.assertRaises(AssertionError):
            attach_coordinates([function()], [function(name='other')])

    def test_missing_names_and_malformed_records_remain_fail_closed(self):
        self.assertEqual(pair_records([function(name=None)], [function(name=None)])[0]['pairing'], 'INVALID')
        a, b = function(), function()
        a['errors'] = ['missing function end']; a['end'] = None
        self.assertEqual(compare(a, b)['status'], 'INVALID')

    def test_filename_quoting_is_not_a_directory_alias_exception(self):
        self.assertEqual(canonical_file('"C:/NFS4/GAME/A.CPP"'), canonical_file('c:\\nfs4\\game\\a.cpp'))

    def test_register_stack_artifacts_are_diagnostic_and_comment_masked(self):
        text = '/* in_a0 */ int unaff_s1; int extraout_v0; char auStack32[4];'
        self.assertEqual(REGISTER_ARTIFACT.findall(mask_trivia(text)), ['unaff_s1', 'extraout_v0', 'auStack32'])


if __name__ == '__main__':
    unittest.main()
