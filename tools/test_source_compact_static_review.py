"""Negative cases must not turn sparse compact metadata into a source seal."""
import copy
import unittest
from source_compact_static_review import corroborate


def fixtures():
    candidate = dict(name='tick', home='STAT', type='INT', owner=dict(path=[0]), size=0, dimensions=[])
    row = dict(pairing='PAIRED', native_occurrences=1, retail_occurrences=1,
               declaration_owner_status='DIFF', name_balance=[dict(name='tick', native_count=1,
               retail_count=0, native_candidates=[candidate])])
    n = dict(locals=[('anchor', 'STAT', 'INT', 0), ('tick', 'STAT', 'INT', 0)],
             stat_addrs=dict(anchor=100, tick=104))
    r = dict(locals=[('anchor', 'STAT', 'INT', 0)], stat_addrs=dict(anchor=300))
    nc = dict(anchor=[(100, 'anchor.1')], tick=[(104, 'tick.2')])
    rc = dict(anchor=[(300, 'anchor.9')], tick=[(304, 'tick.10')])
    return row, n, r, nc, rc


class CompactReviewTests(unittest.TestCase):
    def test_supported_name_keeps_raw_diff_and_absent_type_scope(self):
        args = fixtures(); before = copy.deepcopy(args)
        result = corroborate(*args)
        self.assertEqual(args, before)
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]['native_detailed_status'], 'DIFF')
        self.assertFalse(result[0]['strict_owner_or_SLD_status_changed'])
        self.assertTrue(result[0]['retail_detailed_type_and_scope_still_absent'])

    def test_same_name_wrong_relative_storage_rejected(self):
        args = fixtures(); args[4]['tick'] = [(308, 'tick.10')]
        self.assertEqual(corroborate(*args), [])

    def test_duplicate_compact_name_rejected(self):
        args = fixtures(); args[4]['tick'].append((800, 'tick.11'))
        self.assertEqual(corroborate(*args), [])

    def test_wrong_native_detailed_address_rejected(self):
        args = fixtures(); args[1]['stat_addrs']['tick'] = 108
        self.assertEqual(corroborate(*args), [])

    def test_missing_same_function_anchor_rejected(self):
        args = fixtures(); args[2]['locals'] = []
        self.assertEqual(corroborate(*args), [])

    def test_non_int_or_non_static_candidate_rejected(self):
        for key, value in [('type', 'LONG'), ('home', 'REG:$2')]:
            args = fixtures(); args[0]['name_balance'][0]['native_candidates'][0][key] = value
            self.assertEqual(corroborate(*args), [])

    def test_multiple_source_occurrences_rejected(self):
        args = fixtures(); args[0]['name_balance'][0]['native_count'] = 2
        self.assertEqual(corroborate(*args), [])

    def test_unpaired_or_ambiguous_owner_rejected(self):
        args = fixtures(); args[0]['pairing'] = 'INVALID'
        self.assertEqual(corroborate(*args), [])
        args = fixtures(); args[0]['native_occurrences'] = 2
        self.assertEqual(corroborate(*args), [])


if __name__ == '__main__':
    unittest.main()
