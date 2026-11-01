"""Synthetic-file tests for fail-closed source-group provenance; no compiler needed."""
import copy
import hashlib
import json
from pathlib import Path
import sys
import tempfile
import unittest
from unittest import mock

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import compiler_input_origin as policy
import compiler_origin_evidence as evidence


def sha(data):
    return hashlib.sha256(data).hexdigest()


class OriginEvidenceTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name).resolve()
        self.source = 'recon/game/common/speech.cpp'
        self.included = 'recon/game/common/spchevnt.c'
        self.canonical = 'C:/nfs4/GAME/COMMON/SPEECH.CPP'
        self.canonical_include = 'C:/nfs4/GAME/COMMON/SPCHEVNT.C'
        self.write(self.source, b'#include "spchevnt.c"\nint speech_value;\n')
        self.write(self.included, b'int included_value;\n')
        self.write('tools/compiler_input_origin.py', Path(policy.__file__).read_bytes())
        self.write('tools/build.py', b'INCLUDED_SOURCES = {"recon/game/common/spchevnt.c"}\n')
        self.native = self.write('build/psyq_g/nfs4_sym.txt', b'native source-group fixture\n')
        self.sidecar = self.native.with_suffix('.origin.json')
        self.before = (self.marker(self.root / self.source)
                       + self.marker(self.root / self.included, flags=' 1')
                       + b'int included_value;\n'
                       + self.marker(self.root / self.source, flags=' 2'))
        self.unit = self.make_unit(self.source, self.before, included=True)
        self.data = {'schema': 1, 'native_dump_sha256': sha(self.native.read_bytes()),
                     'units': [self.unit]}
        self.publish()

    def write(self, relative, data):
        path = self.root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(data)
        return path

    @staticmethod
    def marker(path, flags=''):
        return ('# 1 ' + json.dumps(Path(path).as_posix()) + flags + '\n').encode()

    def artifact(self, relative, data):
        self.write(relative, data)
        return {'path': relative, 'sha256': sha(data)}

    def make_unit(self, source, before, *, included):
        source_path = self.root / source
        source_digest = sha(source_path.read_bytes())
        actual, origin = policy.rewrite_main_input(self.root, source_path, before,
                                                  expected_source_sha256=source_digest)
        canonical = policy.identities()[source]
        assembly = ('\t.file\t1 "' + canonical + '"\n').encode()
        inclusions = []
        if included:
            assembly += ('\t.file\t1 "' + self.canonical_include + '"\n').encode()
            inclusions = [{'source': self.included,
                           'source_sha256': sha((self.root / self.included).read_bytes()),
                           'canonical_source': self.canonical_include}]
        stem = source_path.stem
        return {'source': source, 'source_sha256': source_digest, 'canonical_main': canonical,
                'included_sources': inclusions,
                'before_input': self.artifact('build/' + stem + '.preorigin.i', before),
                'compiler_input': self.artifact('build/' + stem + '.i', actual),
                'assembly': self.artifact('build/' + stem + '.s', assembly),
                'sn_object': self.artifact('build/' + stem + '.obj', b'LNK\x02fixture'),
                'build_manifest_sha256': sha((self.root / 'tools/build.py').read_bytes()),
                'policy_sha256': policy.policy_sha256(), 'origin': origin}

    def publish(self):
        self.sidecar.write_text(json.dumps(self.data), encoding='utf-8')

    def validate(self):
        diagnostics = []
        result = evidence.validated_units(self.native, self.root, diagnostics=diagnostics)
        return result, diagnostics

    def assert_rejected(self, contains=None):
        result, diagnostics = self.validate()
        self.assertEqual(result, {})
        self.assertTrue(diagnostics)
        if contains:
            self.assertIn(contains, '\n'.join(diagnostics))

    def test_happy_canonical_speech_group(self):
        result, diagnostics = self.validate()
        self.assertEqual(diagnostics, [])
        group = frozenset((self.canonical, self.canonical_include))
        self.assertEqual(set(result), {group})
        self.assertEqual(result[group]['unit'], 'speech')
        self.assertEqual(result[group]['included_sources'], [self.included])
        self.assertTrue(result[group]['provenance_only'])

    def test_happy_main_only_femenudefs(self):
        source = 'recon/frontend/common/femenudefs.cpp'
        self.write(source, b'int menu_definition;\n')
        unit = self.make_unit(source, self.marker(self.root / source), included=False)
        self.data['units'] = [unit]
        self.publish()
        result, diagnostics = self.validate()
        self.assertFalse(diagnostics)
        self.assertEqual(set(result), {frozenset((policy.identities()[source],))})

    def test_standalone_validator_requires_exact_sidecar_membership(self):
        result, reason = evidence.validate_unit(self.unit, native_dump=self.native, root=self.root)
        self.assertIsNone(reason)
        self.assertEqual(result['unit'], 'speech')
        changed = copy.deepcopy(self.unit)
        changed['canonical_main'] = 'wrong'
        result, reason = evidence.validate_unit(changed, native_dump=self.native, root=self.root)
        self.assertIsNone(result)
        self.assertIn('sidecar member', reason)

    def test_missing_sidecar(self):
        self.sidecar.unlink()
        self.assert_rejected()
        result, reason = evidence.validate_unit(self.unit, native_dump=self.native, root=self.root)
        self.assertIsNone(result)
        self.assertTrue(reason)

    def test_malformed_and_unsupported_sidecar_schema(self):
        controls = ['{', '[]', '{"schema":1}', '[' * 2000 + ']' * 2000]
        controls += [json.dumps(dict(self.data, schema=value)) for value in (True, 2, '1')]
        controls += [json.dumps(dict(self.data, units=value)) for value in ({}, None, 'speech')]
        for value in controls:
            with self.subTest(sidecar=value[:70]):
                self.sidecar.write_text(value)
                self.assert_rejected()

    def test_missing_or_wrong_unit_fields(self):
        original = copy.deepcopy(self.unit)
        for name in original:
            with self.subTest(missing=name):
                self.data['units'] = [{key: value for key, value in original.items() if key != name}]
                self.publish()
                self.assert_rejected('schema fields')
        self.data['units'] = ['not a unit record']
        self.publish()
        self.assert_rejected('schema fields')

    def test_missing_native_dump(self):
        self.native.unlink()
        self.assert_rejected()

    def test_stale_native_dump(self):
        self.native.write_bytes(b'changed native dump')
        self.assert_rejected('native dump')

    def test_stale_bound_files(self):
        records = [('source', self.source), ('included source', self.included),
                   ('policy', 'tools/compiler_input_origin.py'), ('build manifest', 'tools/build.py')]
        records += [(name, self.unit[name]['path']) for name in
                    ('before_input', 'compiler_input', 'assembly', 'sn_object')]
        for label, relative in records:
            with self.subTest(binding=label):
                path = self.root / relative
                before = path.read_bytes()
                try:
                    path.write_bytes(before + b'\nchanged')
                    self.assert_rejected(label)
                finally:
                    path.write_bytes(before)

    def test_missing_bound_files(self):
        for name in ('before_input', 'compiler_input', 'assembly', 'sn_object'):
            with self.subTest(binding=name):
                path = self.root / self.unit[name]['path']
                before = path.read_bytes()
                try:
                    path.unlink()
                    self.assert_rejected(name)
                finally:
                    path.write_bytes(before)

    def test_wrong_canonical_main(self):
        self.unit['canonical_main'] = 'C:/nfs4/GAME/COMMON/OTHER.CPP'
        self.publish()
        self.assert_rejected('canonical main')

    def test_unknown_main_unit(self):
        self.unit['source'] = 'recon/game/common/unknown.cpp'
        self.write(self.unit['source'], b'int unknown;')
        self.publish()
        self.assert_rejected('unknown original-main')

    def test_wrong_included_copy_is_not_selected_by_basename(self):
        wrong = 'recon/eaclib/psx/spchpsxz/spchevnt.c'
        self.write(wrong, (self.root / self.included).read_bytes())
        self.unit['included_sources'][0]['source'] = wrong
        self.unit['included_sources'][0]['canonical_source'] = 'C:/nfs4/EACLIB/PSX/SPCHPSXZ/SPCHEVNT.C'
        self.publish()
        self.assert_rejected('literal include edge')

    def test_missing_include_witness(self):
        self.unit['included_sources'] = []
        self.publish()
        self.assert_rejected('missing a declared literal')

    def test_include_requires_membership(self):
        self.write('recon/other.c', b'int other;')
        changed = b'INCLUDED_SOURCES = {"recon/other.c"}\n'
        self.write('tools/build.py', changed)
        self.unit['build_manifest_sha256'] = sha(changed)
        self.publish()
        self.assert_rejected('explicit inclusion policy')

    def test_include_requires_actual_literal_edge(self):
        controls = [b'int speech_value;\n', b'// #include "spchevnt.c"\n',
                    b'/* #include "spchevnt.c" */\n', b'char *s = "#include \\"spchevnt.c\\"";\n']
        for content in controls:
            with self.subTest(source=content):
                self.write(self.source, content)
                self.unit['source_sha256'] = sha(content)
                self.publish()
                self.assert_rejected('explicit inclusion policy')

    def test_future_declared_source_cannot_derive_an_original_identity(self):
        extra = 'recon/game/common/extra.c'
        self.write(extra, b'int future_extra;\n')
        self.write(self.source, b'#include "spchevnt.c"\n#include "extra.c"\nint speech_value;\n')
        build = b'INCLUDED_SOURCES = {"recon/game/common/spchevnt.c", "recon/game/common/extra.c"}\n'
        self.write('tools/build.py', build)
        before = (self.marker(self.root / self.source)
                  + self.marker(self.root / self.included, flags=' 1')
                  + self.marker(self.root / extra, flags=' 1')
                  + self.marker(self.root / self.source, flags=' 2'))
        self.unit = self.make_unit(self.source, before, included=True)
        # Even a fully hash-bound declaration, direct include, CPP entry and
        # assembly identity cannot expand the explicit original-name policy.
        self.unit['included_sources'].append({'source': extra,
            'source_sha256': sha((self.root / extra).read_bytes()),
            'canonical_source': 'C:/nfs4/GAME/COMMON/EXTRA.C'})
        assembly = self.root / self.unit['assembly']['path']
        data = assembly.read_bytes() + b'\t.file\t1 "C:/nfs4/GAME/COMMON/EXTRA.C"\n'
        assembly.write_bytes(data)
        self.unit['assembly']['sha256'] = sha(data)
        self.data['units'] = [self.unit]
        self.publish()
        self.assert_rejected('explicit inclusion policy')

    def test_commented_tail_and_continued_include_edge(self):
        self.write(self.source, b'#inc\\\nlude "spchevnt.c" // real source edge\n')
        self.unit = self.make_unit(self.source, self.before, included=True)
        self.data['units'] = [self.unit]
        self.publish()
        result, diagnostics = self.validate()
        self.assertTrue(result)
        self.assertFalse(diagnostics)

    def test_include_requires_cpp_include_entry_not_just_line_anchor(self):
        changed = self.before.replace(b'" 1\n', b'"\n')
        self.unit = self.make_unit(self.source, changed, included=True)
        self.data['units'] = [self.unit]
        self.publish()
        self.assert_rejected('include-entry marker')

    def test_wrong_cpp_include_path(self):
        other = self.root / 'recon/eaclib/psx/spchpsxz/spchevnt.c'
        changed = self.before.replace(json.dumps((self.root / self.included).as_posix()).encode(),
                                      json.dumps(other.as_posix()).encode())
        self.unit = self.make_unit(self.source, changed, included=True)
        self.data['units'] = [self.unit]
        self.publish()
        self.assert_rejected('include-entry marker')

    def test_tampered_actual_input_even_with_updated_hash(self):
        record = self.unit['compiler_input']
        data = (self.root / record['path']).read_bytes() + b'int tampered;\n'
        self.write(record['path'], data)
        record['sha256'] = sha(data)
        self.publish()
        self.assert_rejected('exact policy replay')

    def test_empty_artifact_is_not_a_valid_hash_binding(self):
        record = self.unit['sn_object']
        self.write(record['path'], b'')
        record['sha256'] = sha(b'')
        self.publish()
        self.assert_rejected('empty artifact')

    def test_wrong_artifact_kind(self):
        self.unit['assembly'] = dict(self.unit['compiler_input'])
        self.publish()
        self.assert_rejected('wrong artifact suffix')

    def test_tampered_origin_witness_fields(self):
        for name, value in [('replacement_count', 999), ('policy_version', 999),
                            ('input_sha256_after', 'f' * 64), ('expected_source_sha256', None),
                            ('physical_main', 'C:/wrong/speech.cpp')]:
            with self.subTest(field=name):
                old = copy.deepcopy(self.unit['origin'])
                self.unit['origin'][name] = value
                self.publish()
                self.assert_rejected('witness does not exactly replay')
                self.unit['origin'] = old
        self.publish()

    def test_bool_and_float_do_not_equal_integer_witness_fields(self):
        for value in (True, 1.0):
            with self.subTest(value=value):
                self.unit['origin']['schema'] = value
                self.publish()
                self.assert_rejected('witness does not exactly replay')

    def test_tampered_replacement_span(self):
        self.unit['origin']['replacements'][0]['filename_start'] += 1
        self.publish()
        self.assert_rejected('witness does not exactly replay')

    def test_escaped_or_ambiguous_artifact_paths(self):
        for value in ('../outside.i', '/outside.i', 'C:/outside.i', 'build/../speech.i',
                      'build\\speech.i', './build/speech.i', 'build//speech.i', 'build/\x00bad.i'):
            with self.subTest(path=value):
                self.unit['compiler_input']['path'] = value
                self.publish()
                self.assert_rejected('root-relative')

    def test_source_path_escape_or_alias_cannot_select_known_unit(self):
        for value in ('../speech.cpp', 'recon/game/common/../common/speech.cpp',
                      'recon\\game\\common\\speech.cpp', 'C:/outside/speech.cpp'):
            with self.subTest(path=value):
                self.unit['source'] = value
                self.publish()
                self.assert_rejected('unknown original-main')

    def test_source_symlink_escaping_root(self):
        with tempfile.TemporaryDirectory() as outside:
            target = Path(outside) / 'outside.cpp'
            target.write_bytes((self.root / self.source).read_bytes())
            source = self.root / self.source
            source.unlink()
            try:
                source.symlink_to(target)
            except OSError as error:
                self.skipTest('symlinks unavailable: ' + str(error))
            self.assert_rejected('escapes root')

    def test_unknown_schema_fields_fail_closed(self):
        containers = [self.data, self.unit, self.unit['compiler_input'], self.unit['included_sources'][0], self.unit['origin']]
        for container in containers:
            with self.subTest(container=list(container)):
                container['unexpected'] = 'not accepted'
                self.publish()
                self.assert_rejected()
                del container['unexpected']
        self.publish()

    def test_duplicate_source_claim_is_not_order_selected(self):
        self.data['units'].append(copy.deepcopy(self.unit))
        self.publish()
        self.assert_rejected('duplicate unit claim')

    def test_duplicate_json_fields_fail_closed(self):
        text = self.sidecar.read_text()
        self.sidecar.write_text(text.replace('"schema": 1', '"schema": 1, "schema": 1', 1))
        self.assert_rejected('duplicate JSON field')

    def test_invalid_included_sources_manifest(self):
        for text in ('INCLUDED_SOURCES = make_sources()\n', 'INCLUDED_SOURCES = []\n',
                     'INCLUDED_SOURCES = {"recon/game/common/spchevnt.c"}\nINCLUDED_SOURCES = {}\n'):
            with self.subTest(manifest=text):
                self.write('tools/build.py', text.encode())
                self.unit['build_manifest_sha256'] = sha(text.encode())
                self.publish()
                self.assert_rejected('INCLUDED_SOURCES')

    def test_assembly_bad_main_filename_is_not_normalized(self):
        for filename in ((self.root / self.source).as_posix(), 'C:/nfs4/GAME/COMMON/WRONG.CPP'):
            with self.subTest(filename=filename):
                data = ('\t.file\t1 "' + filename + '"\n\t.file\t1 "' + self.canonical_include + '"\n').encode()
                record = self.unit['assembly']
                self.write(record['path'], data)
                record['sha256'] = sha(data)
                self.publish()
                self.assert_rejected('assembly: first file identity')

    def test_assembly_missing_included_identity(self):
        data = ('\t.file\t1 "' + self.canonical + '"\n').encode()
        record = self.unit['assembly']
        self.write(record['path'], data)
        record['sha256'] = sha(data)
        self.publish()
        self.assert_rejected('assembly: missing')

    def test_actual_native_bytes_are_not_filename_normalized(self):
        bad = b'0000: $80010000 88 Set SLD to line 3 of file C:/wrong/SPEECH.CPP\n'
        self.native.write_bytes(bad)
        self.data['native_dump_sha256'] = sha(bad)
        self.publish()
        result, diagnostics = self.validate()
        self.assertTrue(result)  # This witness proves input group only, not event-file correctness.
        self.assertFalse(diagnostics)
        self.assertEqual(self.native.read_bytes(), bad)
        self.assertNotIn(frozenset(('C:/wrong/SPEECH.CPP', self.canonical_include)), result)

    def test_validation_performs_no_writes_or_subprocess(self):
        before = {p.relative_to(self.root).as_posix(): p.read_bytes() for p in self.root.rglob('*') if p.is_file()}
        with mock.patch('pathlib.Path.write_bytes', side_effect=AssertionError('write forbidden')), \
             mock.patch('pathlib.Path.write_text', side_effect=AssertionError('write forbidden')), \
             mock.patch('subprocess.run', side_effect=AssertionError('subprocess forbidden')):
            result, diagnostics = self.validate()
        self.assertTrue(result)
        self.assertFalse(diagnostics)
        after = {p.relative_to(self.root).as_posix(): p.read_bytes() for p in self.root.rglob('*') if p.is_file()}
        self.assertEqual(before, after)

    def test_policy_import_does_not_depend_on_sys_path(self):
        # The validator executes only its adjacent trusted pure policy in
        # memory; it never imports a fixture-root policy or creates pyc files.
        with mock.patch.dict(sys.modules, {'compiler_input_origin': None}):
            result, diagnostics = self.validate()
        self.assertTrue(result)
        self.assertFalse(diagnostics)


if __name__ == '__main__':
    unittest.main()
