"""Storage audit regressions;project/reference outputs are never mutated."""
import contextlib
import io
from pathlib import Path
import tempfile
import unittest
import sym_linkage as audit


class LinkageTests(unittest.TestCase):
    def inputs(self,native,retail):
        temporary=tempfile.TemporaryDirectory();self.addCleanup(temporary.cleanup)
        root=Path(temporary.name);n=root/'native.txt';r=root/'retail.txt'
        n.write_text(native,encoding='utf-8');r.write_text(retail,encoding='utf-8')
        return n,r

    def test_current_native_default(self):
        self.assertEqual(audit.DEFAULT_NATIVE,audit.ROOT/'build/psyq_g/nfs4_sym.txt')

    def test_destructor_alias_only_at_prefix(self):
        self.assertEqual(audit.canonical_name('_._14Base'),'___14Base')
        self.assertEqual(audit.canonical_name('name_._part'),'name_._part')

    def test_storage_gap_even_when_addresses_differ(self):
        n,r=self.inputs('001: $80010000 2 Get\n002: $80010000 94 Def class EXT type FCN INT size 0 name Get\n',
                        'a01: $80010100 6 Get\na02: $80010100 94 Def class STAT type FCN INT size 0 name Get\n')
        result=audit.report(n,r)
        self.assertEqual(len(result['label_linkage']['mismatches']),1)
        self.assertEqual(len(result['function_storage']['mismatches']),1)

    def test_identical_duplicate_records_are_preserved(self):
        n,r=self.inputs('1: $80010000 2 Get\n2: $80010000 2 Get\n','3: $80010100 2 Get\n')
        result=audit.report(n,r)
        self.assertEqual(len(result['raw_records']['native']['labels']['Get']),2)
        self.assertEqual(result['label_linkage']['unambiguous_names'],1)
        self.assertFalse(result['label_linkage']['mismatches'])

    def test_distinct_local_copies_are_ambiguous_not_first_wins(self):
        n,r=self.inputs('1: $80010000 6 helper\n2: $80010200 2 helper\n','3: $80010100 6 helper\n')
        result=audit.report(n,r)['label_linkage']
        self.assertEqual(len(result['ambiguous_names_NOT_compared']),1)
        self.assertFalse(result['mismatches'])

    def test_global_kind_difference_is_not_claimed_exact(self):
        n,r=self.inputs('1: $80010000 1 boundary\n','2: $80010100 2 boundary\n')
        result=audit.report(n,r)['label_linkage']
        self.assertFalse(result['mismatches'])
        self.assertEqual(len(result['global_kind_differences']),1)

    def test_cli_explicit_inputs_report_and_no_mutation(self):
        n,r=self.inputs('1: $80010000 2 Get\n','2: $80010100 6 Get\n')
        nb,rb=n.read_bytes(),r.read_bytes();out=n.parent/'report.json'
        with contextlib.redirect_stdout(io.StringIO()):
            result=audit.main(['0','--native',str(n),'--retail',str(r),'--report',str(out),'--only'])
        self.assertTrue(out.is_file());self.assertEqual(n.read_bytes(),nb);self.assertEqual(r.read_bytes(),rb)
        self.assertEqual(result['inputs']['native']['path'],str(n.resolve()))

    def test_cli_rejects_input_overwrite(self):
        n,r=self.inputs('1: $80010000 2 Get\n','2: $80010100 6 Get\n')
        before=n.read_bytes()
        with contextlib.redirect_stderr(io.StringIO()),self.assertRaises(SystemExit):
            audit.main(['--native',str(n),'--retail',str(r),'--report',str(n)])
        self.assertEqual(n.read_bytes(),before)

    def test_empty_or_unrecognized_input_fails_closed(self):
        n,r=self.inputs('','not a MND dump\n')
        for path in (n,r):
            with self.assertRaises(ValueError):audit.read_records(path)


if __name__=='__main__':
    unittest.main()
