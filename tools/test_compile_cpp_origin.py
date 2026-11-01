"""Exercise the actual build.py CPP-origin stages without external processes.

Only the four relevant function ASTs are loaded: importing the production
driver would inspect toolchain paths and unrelated build configuration.  The
origin helper is real; CPP/CC1/assembler and unrelated splice callbacks are
synthetic producers/observers confined to TemporaryDirectory fixtures.
"""

import ast
import hashlib
import json
import os
from pathlib import Path
import re
import sys
import tempfile
from types import SimpleNamespace
import unittest
from unittest import mock

import compiler_input_origin as origin


BUILD_FILE = Path(__file__).with_name("build.py")
FUNCTIONS = {"_cpp_origin_source_sha", "_prepare_cpp_origin",
             "_finish_cpp_origin", "compile_cpp"}


class CompileCppOriginTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name).resolve()
        self.events = []
        self.compiler_input = None
        self.raw_input = None
        self.race = False
        self.bad_first_marker = False
        self.cpp_failure = False
        self.cc1_failure = False
        self.as_failure = False
        self.assembly = b"\t.text\n\t.ent\tfixture\nfixture:\n\tli\t$2,281\n\tj\t$31\n\t.end\tfixture\n"
        self.object_bytes = b"synthetic object fixture\x00\x19\x01\x00\x00"
        self.ns = {"__file__": str(BUILD_FILE), "Path": Path, "hashlib": hashlib,
                   "ROOT": self.root, "OUT": self.root / "build",
                   "RECON": self.root / "recon", "G_VALUE": "4", "CPP": "fake-cpp",
                   "PY": sys.executable, "MASPSX": "fake-maspsx", "AS": "fake-as",
                   "AS_ARCH": ["-EL", "-mips1"], "ASPSX_VERSION": "2.77",
                   "JTBL_AT_FUSION": False, "os": os, "sys": sys, "re": re,
                   "INCLUDED_SOURCES": {"recon/game/common/spchevnt.c"},
                   "per_tu_flags": lambda src: {},
                   "cpp_compiler": lambda src: "fake-cc1plus",
                   "run": self.fake_run,
                   "subprocess": SimpleNamespace(run=self.fake_assembler),
                   "_apply_cc1plus_ver_splice": self.version_splice,
                   "_apply_fn_splice": self.function_splice}
        tree = ast.parse(BUILD_FILE.read_text(encoding="utf-8"))
        functions = [node for node in tree.body if isinstance(node, ast.FunctionDef)
                     and node.name in FUNCTIONS]
        self.assertEqual({node.name for node in functions}, FUNCTIONS)
        exec(compile(ast.Module(body=functions, type_ignores=[]), str(BUILD_FILE), "exec"), self.ns)
        self.fake_fix = SimpleNamespace(fix=self.fix_symsizes)
        patcher = mock.patch.dict(sys.modules, {"fix_symsizes": self.fake_fix})
        patcher.start()
        self.addCleanup(patcher.stop)
        self.choose_source("recon/frontend/common/femenudefs.cpp")

    def choose_source(self, relative):
        self.relative = relative
        self.src = self.root / relative
        self.src.parent.mkdir(parents=True, exist_ok=True)
        self.src.write_bytes(b"// actual source fixture\nint source_value = 281;\n")
        self.obj = self.ns["OUT"] / (relative + ".o")
        self.i = self.obj.with_suffix(".i")
        self.s = self.obj.with_suffix(".s")
        self.preorigin = self.i.with_suffix(".preorigin.i")
        self.sidecar = self.i.with_suffix(self.i.suffix + ".origin.json")
        self.declared = relative in origin.identities()
        if relative == "recon/game/common/speech.cpp":
            self.src.write_bytes(b'#include "spchevnt.c"\nint source_value = 281;\n')
            self.included = self.root / "recon/game/common/spchevnt.c"
            self.included.write_bytes(b"int included_value = 53;\n")

    @staticmethod
    def marker(path, line=0, flags=""):
        # JSON quotes use the same backslash escaping GNU CPP emits here.
        return ("# %d %s%s\n" % (line, json.dumps(str(path)), flags)).encode()

    @staticmethod
    def code_tokens(data):
        return b"".join(line for line in data.splitlines(keepends=True)
                        if not re.match(rb"^#\s+\d+\s+\"", line))

    def fake_run(self, command, *args, **kwargs):
        if command[0] == "fake-cpp":
            self.events.append("cpp")
            self.assertFalse(self.sidecar.exists())
            self.assertFalse(self.preorigin.exists())
            path = self.root / "elsewhere/foreign.cpp" if self.bad_first_marker else self.src
            self.raw_input = (self.marker(path) + self.marker("<built-in>")
                              + self.marker("<command-line>") + self.marker(self.src, 1)
                              + b'int numeric = 281; unsigned hex = 0x80010000;\n'
                              + b'const char *literal = ' + json.dumps(str(self.src)).encode() + b';\n')
            self.i.write_bytes(self.raw_input)
            if self.race:
                self.src.write_bytes(b"changed during CPP fixture\n")
            return SimpleNamespace(returncode=int(self.cpp_failure), stdout="", stderr="CPP fixture failure")
        self.assertEqual(command[0], "fake-cc1plus")
        self.events.append("cc1")
        self.assertFalse(self.sidecar.exists(), "assembly receipt must not precede compiler return")
        self.compiler_input = self.i.read_bytes()
        self.assertEqual(self.code_tokens(self.compiler_input), self.code_tokens(self.raw_input))
        if self.declared:
            self.assertEqual(self.preorigin.read_bytes(), self.raw_input)
            self.assertEqual(self.compiler_input.splitlines()[0],
                             self.marker(origin.identities()[self.relative]).strip())
        else:
            self.assertEqual(self.compiler_input, self.raw_input)
            self.assertFalse(self.preorigin.exists())
        if not self.cc1_failure:
            self.s.write_bytes(self.assembly)
        self.events.append("cc1-return")
        return SimpleNamespace(returncode=int(self.cc1_failure), stdout="", stderr="CC1 fixture failure")

    def version_splice(self, *args):
        self.events.append("version-splice")
        self.assertFalse(self.sidecar.exists())
        self.assertEqual(self.s.read_bytes(), self.assembly)

    def function_splice(self, *args):
        self.events.append("function-splice")
        self.assertFalse(self.sidecar.exists())
        self.assertEqual(self.s.read_bytes(), self.assembly)

    def fake_assembler(self, command, *args, **kwargs):
        self.events.append("assembler")
        self.assertEqual(self.s.read_bytes(), self.assembly)
        self.assertEqual(kwargs["input"].encode(), self.assembly)
        if self.declared:
            self.assertTrue(self.sidecar.is_file())
            sidecar = json.loads(self.sidecar.read_text())
            self.assertEqual(sidecar["assembly"]["sha256"], hashlib.sha256(self.assembly).hexdigest())
            self.assertEqual(sidecar["assembly"]["path"], self.s.relative_to(self.root).as_posix())
        else:
            self.assertFalse(self.sidecar.exists())
        if not self.as_failure:
            self.obj.write_bytes(self.object_bytes)
        return SimpleNamespace(returncode=int(self.as_failure), stdout="", stderr="assembler fixture failure")

    def fix_symsizes(self, path):
        self.events.append("fix-symsizes")
        self.assertEqual(Path(path).read_bytes(), self.object_bytes)

    def compile(self):
        with mock.patch.dict(os.environ, {"NFS4_FE_NII": "0"}):
            return self.ns["compile_cpp"](self.src)

    def test_declared_stage_order_and_compiler_binding(self):
        source_before = self.src.read_bytes()
        result = self.compile()
        self.assertEqual(result, self.obj)
        self.assertEqual(self.events, ["cpp", "cc1", "cc1-return", "version-splice",
                                       "function-splice", "assembler", "fix-symsizes"])
        self.assertEqual(self.src.read_bytes(), source_before)
        self.assertEqual(self.preorigin.read_bytes(), self.raw_input)
        self.assertEqual(self.s.read_bytes(), self.assembly)
        self.assertEqual(self.obj.read_bytes(), self.object_bytes)
        sidecar = json.loads(self.sidecar.read_text())
        self.assertEqual(sidecar["origin"]["expected_source_sha256"], hashlib.sha256(source_before).hexdigest())
        self.assertEqual(sidecar["origin"]["input_sha256_before"], hashlib.sha256(self.raw_input).hexdigest())
        self.assertEqual(sidecar["origin"]["input_sha256_after"], hashlib.sha256(self.compiler_input).hexdigest())
        self.assertEqual(sidecar["before_input"]["path"], self.preorigin.relative_to(self.root).as_posix())
        self.assertEqual(sidecar["before_input"]["sha256"], hashlib.sha256(self.raw_input).hexdigest())
        self.assertEqual(sidecar["compiler_input"]["sha256"], hashlib.sha256(self.compiler_input).hexdigest())
        self.assertEqual(sidecar["policy_sha256"], origin.policy_sha256())
        self.assertEqual(sidecar["build_manifest_sha256"], hashlib.sha256(BUILD_FILE.read_bytes()).hexdigest())

    def test_numeric_and_literal_bytes_are_untouched(self):
        self.compile()
        self.assertIn(b"int numeric = 281; unsigned hex = 0x80010000;\n", self.compiler_input)
        literal = b'const char *literal = ' + json.dumps(str(self.src)).encode() + b';\n'
        self.assertIn(literal, self.compiler_input)
        self.assertEqual(self.code_tokens(self.raw_input), self.code_tokens(self.compiler_input))

    def test_speech_binds_declared_included_source(self):
        self.choose_source("recon/game/common/speech.cpp")
        self.compile()
        sidecar = json.loads(self.sidecar.read_text())
        self.assertEqual(sidecar["included_sources"], [{"source": "recon/game/common/spchevnt.c",
                         "source_sha256": hashlib.sha256(self.included.read_bytes()).hexdigest(),
                         "canonical_source": "C:/nfs4/GAME/COMMON/SPCHEVNT.C"}])
        self.assertEqual(sidecar["canonical_main"], origin.identities()[self.relative])

    def test_source_hash_race_fails_before_compiler(self):
        self.race = True
        with self.assertRaisesRegex(origin.InputOriginError, "stale"):
            self.compile()
        self.assertEqual(self.events, ["cpp"])
        self.assertIsNone(self.compiler_input)
        self.assertFalse(self.preorigin.exists())
        self.assertFalse(self.sidecar.exists())
        self.assertFalse(self.s.exists())

    def test_foreign_first_marker_fails_before_compiler(self):
        self.bad_first_marker = True
        with self.assertRaisesRegex(origin.InputOriginError, "First real"):
            self.compile()
        self.assertEqual(self.events, ["cpp"])
        self.assertFalse(self.sidecar.exists())
        self.assertFalse(self.preorigin.exists())

    def test_unknown_tu_creates_no_origin_artifacts(self):
        self.choose_source("recon/game/common/example.cpp")
        self.compile()
        self.assertEqual(self.compiler_input, self.raw_input)
        self.assertFalse(self.preorigin.exists())
        self.assertFalse(self.sidecar.exists())
        self.assertEqual(self.s.read_bytes(), self.assembly)

    def test_cpp_failure_creates_no_origin_or_compiler_output(self):
        self.cpp_failure = True
        with self.assertRaises(SystemExit):
            self.compile()
        self.assertEqual(self.events, ["cpp"])
        self.assertFalse(self.sidecar.exists())
        self.assertFalse(self.preorigin.exists())

    def test_compiler_failure_never_creates_assembly_receipt(self):
        self.cc1_failure = True
        with self.assertRaises(SystemExit):
            self.compile()
        self.assertEqual(self.events, ["cpp", "cc1", "cc1-return"])
        self.assertTrue(self.preorigin.exists())
        self.assertFalse(self.sidecar.exists())
        self.assertFalse(self.s.exists())

    def test_assembly_receipt_precedes_assembler_not_compiler(self):
        self.as_failure = True
        with self.assertRaises(SystemExit):
            self.compile()
        self.assertTrue(self.sidecar.exists())
        self.assertEqual(self.s.read_bytes(), self.assembly)
        self.assertFalse(self.obj.exists())
        self.assertEqual(self.events[-1], "assembler")

    def test_undeclared_speech_include_refuses_compiler(self):
        self.choose_source("recon/game/common/speech.cpp")
        self.ns["INCLUDED_SOURCES"] = set()
        with self.assertRaisesRegex(ValueError, "INCLUDED_SOURCES"):
            self.compile()
        self.assertEqual(self.events, ["cpp"])
        self.assertFalse(self.sidecar.exists())


if __name__ == "__main__":
    unittest.main()
