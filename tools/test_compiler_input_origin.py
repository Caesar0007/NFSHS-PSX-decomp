"""Fail-closed compiler-input identity tests; no compiler/native lane required."""
import hashlib
import json
from pathlib import Path
import tempfile
import unittest

import compiler_input_origin as origin


class CompilerInputOriginTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.rel = "recon/game/common/speech.cpp"
        self.src = self.root / self.rel
        self.src.parent.mkdir(parents=True)
        self.src.write_bytes(b"int example;\n")
        self.physical = self.src.resolve().as_posix()
        self.canonical = "C:/nfs4/GAME/COMMON/SPEECH.CPP"

    @staticmethod
    def quote(value):
        return value.replace("\\", "\\\\").replace('"', '\\"').encode()

    def marker(self, filename=None, number=0, flags="", newline=b"\n"):
        filename = self.physical if filename is None else filename
        return (b'# ' + str(number).encode() + b' "' + self.quote(filename)
                + b'"' + flags.encode() + newline)

    def run_origin(self, data, **kw):
        return origin.rewrite_main_input(self.root, self.src, data, **kw)

    def test_exact_policy_and_immutable_mapping(self):
        self.assertEqual(dict(origin.identities()), {
            "recon/frontend/common/femenudefs.cpp":
                "C:/nfs4/FRONTEND/COMMON/FEMENUDEFS.CPP",
            "recon/game/common/speech.cpp": self.canonical})
        with self.assertRaises(TypeError):
            origin.identities()[self.rel] = "other"

    def test_first_and_return_markers_only(self):
        header = (self.root / "recon/game/common/speech_types.h").as_posix()
        data = (self.marker() + self.marker("<built-in>")
                + self.marker("<command-line>") + self.marker(number=1)
                + self.marker(header, 1, " 1") + b"int value;\n"
                + self.marker(number=9, flags=" 2"))
        output, manifest = self.run_origin(data)
        expected = data.replace(self.quote(self.physical), self.canonical.encode())
        self.assertEqual(output, expected)
        self.assertEqual(manifest["replacement_count"], 3)
        self.assertEqual(manifest["source"], self.rel)
        self.assertEqual(manifest["physical_main"], self.physical)
        self.assertEqual(manifest["canonical_main"], self.canonical)
        self.assertEqual(manifest["source_sha256"], hashlib.sha256(self.src.read_bytes()).hexdigest())
        self.assertEqual(manifest["input_sha256_before"], hashlib.sha256(data).hexdigest())
        self.assertEqual(manifest["input_sha256_after"], hashlib.sha256(output).hexdigest())
        self.assertEqual(manifest["policy_sha256"], origin.policy_sha256())
        self.assertEqual(manifest["replacements"][-1]["flags"], [2])
        self.assertEqual(manifest["replacements"][-1]["cpp_line"], 9)
        json.dumps(manifest)

    def test_windows_marker_escaping_and_case(self):
        # Actual Windows GNU CPP emits doubled backslashes in filename strings.
        if not self.src.drive:
            self.skipTest("Windows drive spelling control")
        filename = str(self.src.resolve()).upper()
        output, manifest = self.run_origin(self.marker(filename))
        self.assertEqual(output, self.marker(self.canonical))
        self.assertEqual(manifest["replacement_count"], 1)

    def test_forward_marker_preserves_crlf_line_numbers_and_flags(self):
        data = self.marker(newline=b"\r\n") + b"int x;\r\n" + self.marker(number=281, flags=" 2 3 4", newline=b"\r\n")
        output, manifest = self.run_origin(data)
        self.assertEqual(output, data.replace(self.quote(self.physical), self.canonical.encode()))
        self.assertEqual(manifest["replacements"][-1]["flags"], [2, 3, 4])
        self.assertEqual(manifest["replacements"][-1]["line"], 3)

    def test_literals_and_comments_are_not_markers(self):
        fake = self.marker()
        data = (self.marker() + b'const char *s = "' + self.quote(self.physical)
                + b'";\n/* retained comment\n' + fake + b'*/\n'
                + b'const char *text = "begin\\\n' + fake + b'end";\n')
        output, manifest = self.run_origin(data)
        self.assertEqual(manifest["replacement_count"], 1)
        self.assertEqual(output, self.marker(self.canonical) + data[len(self.marker()):])

    def test_no_basename_or_prefix_matching(self):
        other = (self.root / "elsewhere/speech.cpp").as_posix()
        longer = self.physical + ".backup"
        data = self.marker() + self.marker(other, 1, " 1") + self.marker(longer, 2, " 1")
        output, manifest = self.run_origin(data)
        self.assertEqual(manifest["replacement_count"], 1)
        self.assertIn(self.marker(other, 1, " 1"), output)
        self.assertIn(self.marker(longer, 2, " 1"), output)

    def test_existing_canonical_named_anchors_are_not_rewritten(self):
        data = self.marker() + self.marker(self.canonical, 167) + b"void f() {}\n"
        output, manifest = self.run_origin(data)
        self.assertEqual(manifest["replacement_count"], 1)
        self.assertEqual(output, self.marker(self.canonical) + data[len(self.marker()):])

    def test_virtual_preamble_does_not_bind_main(self):
        output, manifest = self.run_origin(self.marker("<built-in>") + self.marker())
        self.assertEqual(manifest["replacement_count"], 1)
        self.assertTrue(output.startswith(self.marker("<built-in>")))

    def test_foreign_first_real_marker_rejected(self):
        with self.assertRaises(origin.InputOriginError):
            self.run_origin(self.marker("C:/other/speech.cpp") + self.marker())

    def test_virtual_only_and_markerless_inputs_rejected(self):
        for data in (b"int example;\n", self.marker("<built-in>"), b""):
            with self.subTest(data=data), self.assertRaises(origin.InputOriginError):
                self.run_origin(data)

    def test_already_mapped_input_cannot_be_rebound_as_physical(self):
        with self.assertRaises(origin.InputOriginError):
            self.run_origin(self.marker(self.canonical))

    def test_declared_main_entered_as_include_is_ambiguous(self):
        for data in (self.marker(flags=" 1"), self.marker() + self.marker(number=1, flags=" 1")):
            with self.subTest(data=data), self.assertRaises(origin.InputOriginError):
                self.run_origin(data)

    def test_second_unentered_root_marker_is_ambiguous(self):
        with self.assertRaises(origin.InputOriginError):
            self.run_origin(self.marker() + self.marker("C:/other/another.cpp"))

    def test_bad_marker_quoting_and_bad_escapes_rejected(self):
        for tail in (b'# 1 "unterminated\n', b'# 1 "bad\\q"\n', b'# 1 "bad\\000"\n',
                     b'# 1 "bad\\777"\n', b'# 1 "header.h" garbage\n'):
            with self.subTest(tail=tail), self.assertRaises(origin.InputOriginError):
                self.run_origin(self.marker() + tail)

    def test_expected_source_digest_checks_preprocess_stability(self):
        digest = hashlib.sha256(self.src.read_bytes()).hexdigest()
        _, manifest = self.run_origin(self.marker(), expected_source_sha256=digest)
        self.assertEqual(manifest["expected_source_sha256"], digest)
        self.src.write_bytes(b"changed source\n")
        with self.assertRaisesRegex(origin.InputOriginError, "stale"):
            self.run_origin(self.marker(), expected_source_sha256=digest)

    def test_invalid_expected_digest_rejected(self):
        for digest in ("", "0" * 63, "Z" * 64):
            with self.subTest(digest=digest), self.assertRaises(origin.InputOriginError):
                self.run_origin(self.marker(), expected_source_sha256=digest)

    def test_no_expected_digest_does_not_claim_generation_history(self):
        _, manifest = self.run_origin(self.marker())
        self.assertIsNone(manifest["expected_source_sha256"])

    def test_unknown_tu_is_identity_without_source_read(self):
        data = b"arbitrary compiler input\x00"
        self.assertEqual(origin.rewrite_main_input(self.root, Path("recon/game/common/aistate.cpp"), data), (data, None))

    def test_outside_root_is_not_a_declared_source(self):
        data = self.marker()
        self.assertEqual(origin.rewrite_main_input(self.root, self.root.parent / "speech.cpp", data), (data, None))

    def test_missing_declared_source_rejected(self):
        self.src.unlink()
        with self.assertRaises(origin.InputOriginError):
            self.run_origin(self.marker())

    def test_root_relative_source_argument(self):
        self.assertEqual(self.run_origin(self.marker()),
                         origin.rewrite_main_input(self.root, Path(self.rel), self.marker()))

    def test_determinism_positions_and_no_writes(self):
        data = self.marker() + b"int source;\n" + self.marker(number=9, flags=" 2")
        files_before = {p.relative_to(self.root): p.read_bytes() for p in self.root.rglob("*") if p.is_file()}
        a = self.run_origin(data)
        b = self.run_origin(data)
        self.assertEqual(a, b)
        output, manifest = a
        cursor = 0
        chunks = []
        for row in manifest["replacements"]:
            chunks.append(data[cursor:row["filename_start"]])
            self.assertEqual(data[row["filename_start"]:row["filename_end"]], self.quote(self.physical))
            chunks.append(self.canonical.encode())
            cursor = row["filename_end"]
        chunks.append(data[cursor:])
        self.assertEqual(output, b"".join(chunks))
        self.assertEqual(files_before, {p.relative_to(self.root): p.read_bytes() for p in self.root.rglob("*") if p.is_file()})

    def test_femenudefs_uses_only_its_own_policy(self):
        source = self.root / "recon/frontend/common/femenudefs.cpp"
        source.parent.mkdir(parents=True)
        source.write_bytes(b"void example();\n")
        data = self.marker(source.resolve().as_posix())
        output, manifest = origin.rewrite_main_input(self.root, source, data)
        self.assertEqual(output, self.marker("C:/nfs4/FRONTEND/COMMON/FEMENUDEFS.CPP"))
        self.assertEqual(manifest["source"], "recon/frontend/common/femenudefs.cpp")
        with self.assertRaises(origin.InputOriginError):
            origin.rewrite_main_input(self.root, source, self.marker())

    def test_bytes_required(self):
        with self.assertRaises(TypeError):
            self.run_origin("not bytes")


if __name__ == "__main__":
    unittest.main()
