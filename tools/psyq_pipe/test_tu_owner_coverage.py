"""All selected owner records count, even when their defining file is a header."""
import copy
import unittest

from tu_owner_coverage import audit, add_scope_receipts


def record(name, owner='sample', file='SAMPLE.CPP', changed=False):
    return dict(name=name, start=0x80010000, end=0x80010008,
                hdr=dict(file='C:\\nfs4\\GAME\\COMMON\\'+file), errors=[],
                provenance=dict(unit=owner), locals=[dict(name='value',home='REG:$4' if changed else 'REG:$3',
                    type='INT',size=0,dimensions=[],depth=1,
                    owner=dict(start=0,end=8,path=[0]))])


class TuCoverageTests(unittest.TestCase):
    source = ['recon/game/common/sample.cpp']

    def test_header_function_is_compared(self):
        records=[record('Foo'),record('dtor',file='CLASSES.H')]
        row=audit(records,copy.deepcopy(records),self.source)
        self.assertTrue(row['coverage_complete'])
        unit=row['units']['sample']
        self.assertEqual(unit['compared'],2)
        self.assertEqual(unit['non_primary_source_records'],1)

    def test_missing_header_is_not_covered(self):
        row=audit([record('Foo')],[record('Foo'),record('dtor',file='CLASSES.H')],self.source)
        self.assertFalse(row['coverage_complete'])

    def test_dirty_header_is_visible_not_a_coverage_failure(self):
        row=audit([record('Foo'),record('dtor',file='CLASSES.H',changed=True)],
                  [record('Foo'),record('dtor',file='CLASSES.H')],self.source)
        self.assertTrue(row['coverage_complete'])
        self.assertEqual(row['units']['sample']['functions']['dtor']['status'],'DIFF')

    def test_duplicate_same_owner_invalid(self):
        self.assertFalse(audit([record('Foo'),record('Foo')],[record('Foo')],self.source)['coverage_complete'])

    def test_same_name_other_owner_never_selected_by_address(self):
        native=[record('Foo',owner='other',changed=True),record('Foo')]
        retail=[record('Foo'),record('Foo',owner='other')]
        row=audit(native,retail,self.source)
        self.assertTrue(row['coverage_complete'])
        self.assertEqual(row['units']['sample']['functions']['Foo']['status'],'PASS')

    def test_unknown_owner_cannot_hide_a_copy(self):
        row=audit([record('Foo'),record('Foo',owner=None)],[record('Foo')],self.source)
        self.assertFalse(row['coverage_complete'])

    def test_game_extra_is_failure(self):
        self.assertFalse(audit([record('Foo'),record('Extra')],[record('Foo')],self.source)['coverage_complete'])

    def test_incomplete_sdk_does_not_invent_missing_retail_records(self):
        row=audit([record('Foo'),record('Extra')],[record('Foo')],['recon/eaclib/psx/sample.c'])
        self.assertTrue(row['coverage_complete'])
        self.assertEqual(row['units']['sample']['uncovered_native_records'],['Extra'])

    def test_no_retail_owner_or_ambiguous_selection_fails(self):
        self.assertFalse(audit([],[],self.source)['coverage_complete'])
        with self.assertRaises(ValueError):
            audit([],[],self.source+['recon/frontend/common/sample.cpp'])

    def test_malformed_native_record_fails(self):
        native=record('Foo');native['errors'].append('missing function end')
        self.assertFalse(audit([native],[record('Foo')],self.source)['coverage_complete'])


class RegionReceiptTests(unittest.TestCase):
    """A declaration-PASS empty-region counterexample must stay incomplete."""
    def fn(self, blocks=None, file='SAMPLE.CPP'):
        return dict(name='Foo',start=0x80010000,end=0x80010008,end_line=11,
                    hdr=dict(line='10',file='C:\\nfs4\\GAME\\COMMON\\'+file),
                    blocks=blocks if blocks is not None else [('90',0,1),('92',8,1)])

    def data(self, fn):
        return dict(functions={('Foo','sample'):[fn]}, keys=[fn['start']], events={fn['start']:10})

    def run_receipt(self, n=None, r=None, partial=False):
        records=[record('Foo')]
        records[0]['locals']=[]
        source=['recon/eaclib/psx/sample.c' if partial else 'recon/game/common/sample.cpp']
        report=audit(records,copy.deepcopy(records),source)
        return add_scope_receipts(report,n or self.data(self.fn()),r or self.data(self.fn()))

    def row(self, report):
        return report['units']['sample']['functions']['Foo']

    def test_all_exact_regions_and_lines(self):
        report=self.run_receipt();row=self.row(report)
        self.assertTrue(report['coverage_complete'])
        self.assertEqual(row['scope_regions']['status'],'PASS')
        self.assertEqual(row['sld']['status'],'EXACT')
        self.assertEqual(row['declaration_scope_sld_status'],'EXACT')
        group=report['directories']['GAME/COMMON']
        self.assertEqual(group['scope'],'selected-TUs-only')
        self.assertEqual(group['selected_units'],['sample'])
        self.assertEqual(group['declaration_scope_sld_statuses'],{'EXACT':1})

    def test_extra_empty_region_is_not_declaration_completion(self):
        n=self.data(self.fn([('90',0,1),('90',0,1),('92',4,1),('92',8,1)]))
        report=self.run_receipt(n=n);row=self.row(report)
        self.assertTrue(report['coverage_complete'])
        self.assertEqual(row['status'],'PASS')
        self.assertEqual(row['scope_regions']['status'],'DIFF')
        self.assertEqual(row['declaration_scope_sld_status'],'INCOMPLETE')

    def test_same_count_wrong_boundary_remains_diff(self):
        report=self.run_receipt(n=self.data(self.fn([('90',0,1),('92',4,1)])))
        self.assertEqual(self.row(report)['scope_regions']['status'],'DIFF')

    def test_line_differences_are_not_normalized_by_region_match(self):
        n=self.data(self.fn([('90',0,1),('92',8,2)]))
        row=self.row(self.run_receipt(n=n))
        self.assertEqual(row['scope_regions']['status'],'PASS')
        self.assertEqual(row['sld']['status'],'DIFF')
        self.assertEqual(row['declaration_scope_sld_status'],'INCOMPLETE')

    def test_missing_record_identity_fails_closed(self):
        n=self.data(self.fn());n['functions']={}
        report=self.run_receipt(n=n)
        self.assertFalse(report['coverage_complete'])
        self.assertEqual(self.row(report)['scope_regions']['status'],'INVALID_RECORD_IDENTITY')

    def test_duplicate_record_identity_is_not_best_matched(self):
        n=self.data(self.fn());n['functions'][('Foo','sample')]*=2
        self.assertFalse(self.run_receipt(n=n)['coverage_complete'])

    def test_sdk_absent_region_and_line_records_are_not_certified(self):
        r=self.data(self.fn([]));r['keys']=[];r['events']={}
        report=self.run_receipt(r=r,partial=True);row=self.row(report)
        self.assertTrue(report['coverage_complete'])
        self.assertEqual(row['scope_regions']['status'],'NOT_SUPPLIED')
        self.assertEqual(row['sld']['status'],'NOT_SUPPLIED')
        self.assertEqual(row['declaration_scope_sld_status'],'INCOMPLETE')
        self.assertTrue(report['directories']['EACLIB/PSX']['partial_retail'])

    def test_game_absent_regions_are_compared_not_ignored(self):
        row=self.row(self.run_receipt(r=self.data(self.fn([]))))
        self.assertEqual(row['scope_regions']['status'],'DIFF')

    def test_original_source_file_is_required_for_sld_exactness(self):
        row=self.row(self.run_receipt(n=self.data(self.fn(file='INVENTED.H'))))
        self.assertEqual(row['scope_regions']['status'],'PASS')
        self.assertEqual(row['sld']['status'],'SOURCE_FILE_MISMATCH')

    def test_malformed_sld_record_fails_coverage(self):
        n=self.data(self.fn());del n['functions'][('Foo','sample')][0]['hdr']['line']
        self.assertFalse(self.run_receipt(n=n)['coverage_complete'])


if __name__=='__main__':
    unittest.main()
