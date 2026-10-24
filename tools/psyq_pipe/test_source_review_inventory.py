"""2026-10-23: keep known string holders visible without touching source/SYM."""
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location(
    'source_review_inventory_fixture', ROOT / 'tools/source_review_inventory.py')
inventory = importlib.util.module_from_spec(spec)
spec.loader.exec_module(inventory)
HOLDER = 'static inline const char *SimpleMem_ClassName(void)'


class StringProducerReviewTests(unittest.TestCase):
    def test_camelcase_explicit_source_obligation_is_visible(self):
        text = '/* SourceRecoveryUnresolved: semantic name, original spelling absent. */'
        self.assertEqual(inventory.REVIEW.findall(text), ['SourceRecoveryUnresolved'])
        self.assertFalse(inventory.REVIEW.search('SourceRecoveryResolved'))
        self.assertFalse(inventory.REVIEW.search('SourceRecoveryUnresolvedCount'))

    def test_existing_explicit_recovery_markers_are_not_omitted(self):
        text = ('/* SOURCE-RECOVERY-UNRESOLVED: still needs original source. */\n'
                '/* SOURCE-REVIEW-UNRESOLVED: native cleanliness is insufficient. */')
        self.assertEqual(inventory.REVIEW.findall(text), [
            'SOURCE-RECOVERY-UNRESOLVED', 'SOURCE-REVIEW-UNRESOLVED'])

    def test_definition_not_comment_literal_prototype_or_call(self):
        text = ('/* ' + HOLDER + '{return 0;} */\n'
                'const char *quoted="' + HOLDER + '";\n'
                + HOLDER + ';\n' + HOLDER + '{return "SimpleMem";}\n'
                'void caller(){SimpleMem_ClassName();}')
        code = inventory.mask_trivia(text)
        hits = list(inventory.UNRESOLVED_STRING_PRODUCER.finditer(code))
        self.assertEqual(len(hits), 1)
        self.assertEqual(code.count('\n', 0, hits[0].start()) + 1, 4)

    def test_definition_whitespace_and_multiline_location(self):
        text = '\nstatic\ninline const char* SimpleMem_ClassName( void )\n{return "SimpleMem";}'
        code = inventory.mask_trivia(text)
        hits = list(inventory.UNRESOLVED_STRING_PRODUCER.finditer(code))
        self.assertEqual(len(hits), 1)
        self.assertEqual(code.count('\n', 0, hits[0].start()) + 1, 2)

    def test_known_producer_is_not_a_generic_class_name_claim(self):
        text = ('static inline const char *RecoveredName(void){return "SimpleMem";}\n'
                'const char *SimpleMem::ClassName(void){return "SimpleMem";}\n'
                'void function(){SimpleMem_ClassName();}')
        self.assertFalse(list(inventory.UNRESOLVED_STRING_PRODUCER.finditer(
            inventory.mask_trivia(text))))

    def test_report_is_read_only_and_mod_sources_stay_excluded(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            source = root / 'recon/game/common/one.cpp'
            mod = root / 'recon/game-mod/common/one.cpp'
            source.parent.mkdir(parents=True)
            mod.parent.mkdir(parents=True)
            source.write_text(HOLDER + '{return "SimpleMem";}\n', encoding='utf-8')
            mod.write_text(source.read_text(encoding='utf-8'), encoding='utf-8')
            native = root / 'native.json'
            sld = root / 'sld.json'
            native.write_text(json.dumps({'f': {
                'file': r'C:\nfs4\GAME\COMMON\ONE.CPP', 'issues': []}}), encoding='utf-8')
            sld.write_text(json.dumps({'functions': {'f': {'status': 'EXACT'}}}), encoding='utf-8')
            before = {p: p.read_bytes() for p in (source, mod, native, sld)}
            with patch.object(inventory, 'ROOT', root):
                report = inventory.inventory(native, sld)
            self.assertEqual({p: p.read_bytes() for p in before}, before)
            self.assertFalse(report['source_freshness_certified'])
            self.assertEqual(report['native_extra_rows'], [])
            self.assertEqual(report['source_files_scanned'], {'GAME/COMMON': 1})
            self.assertEqual(report['directories']['GAME/COMMON']['native_and_sld_exact'], 1)
            self.assertEqual(len(report['source_locations']), 1)
            row = report['source_locations'][0]
            self.assertEqual((row['kind'], row['file'], row['line']),
                             ('unresolved_string_producer', 'recon/game/common/one.cpp', 1))


if __name__ == '__main__':
    unittest.main()
