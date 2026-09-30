"""Small fail-closed fixtures for the whole-tree SLD comparison."""

import tempfile
import unittest
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from sldtree_cmp import compare_function, directory_of, end_delta, parse_dump


def fixture(base, header_line, later_line, end_line, name="fn"):
    return (
        "000000: $%08x 88 Set SLD to line %d of file C:\\nfs4\\GAME\\COMMON\\X.CPP\n"
        "000001: $%08x 8c Function start\n"
        "    fp = 29\n"
        "    line = %d\n"
        "    file = C:\\nfs4\\GAME\\COMMON\\X.CPP\n"
        "    name = %s\n"
        "000002: $%08x 90 Block start  line = 1\n"
        "000003: $%08x 80 Inc SLD linenum (to %d)\n"
        "000004: $%08x 92 Block end  line = 2\n"
        "000005: $%08x 8e Function end   line %d\n"
    ) % (base, header_line, base, header_line, name, base,
         base + 4, later_line, base + 8, base + 8, end_line)


class SldTreeCompareTests(unittest.TestCase):
    def parse(self, contents):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "fixture.txt"
            path.write_text(contents)
            return parse_dump(path)

    def test_exact_shifted_address_and_header(self):
        native, nk, ne, nd = self.parse(fixture(0x80001000, 200, 201, 202))
        retail, rk, re, rd = self.parse(fixture(0x80002000, 100, 101, 102))
        self.assertFalse(nd or rd)
        result = compare_function(native["fn"], retail["fn"], nk, ne, rk, re)
        self.assertEqual(result["status"], "EXACT")
        self.assertEqual(result["tag_diffs"], 0)
        self.assertEqual(result["retail_words"], 2)
        self.assertEqual((result["native_end_delta"], result["retail_end_delta"]), (2, 2))

    def test_changed_tag_is_not_exact(self):
        native, nk, ne, _ = self.parse(fixture(0x80001000, 200, 202, 202))
        retail, rk, re, _ = self.parse(fixture(0x80002000, 100, 101, 102))
        result = compare_function(native["fn"], retail["fn"], nk, ne, rk, re)
        self.assertEqual(result["status"], "DIFF")
        self.assertEqual(result["tag_diffs"], 1)
        self.assertEqual(result["tag_examples"][0]["offset"], 4)

    def test_block_or_end_line_mismatch_is_not_exact(self):
        native, nk, ne, _ = self.parse(fixture(0x80001000, 200, 201, 202))
        wrong_block = fixture(0x80002000, 100, 101, 102).replace(
            "Block end  line = 2", "Block end  line = 3")
        retail, rk, re, _ = self.parse(wrong_block)
        result = compare_function(native["fn"], retail["fn"], nk, ne, rk, re)
        self.assertEqual(result["tag_diffs"], 0)
        self.assertFalse(result["block_lines_equal"])
        self.assertEqual(result["status"], "DIFF")
        retail, rk, re, _ = self.parse(fixture(0x80002000, 100, 101, 103))
        result = compare_function(native["fn"], retail["fn"], nk, ne, rk, re)
        self.assertFalse(result["end_line_equal"])
        self.assertEqual(result["status"], "DIFF")

    def test_length_mismatch_is_not_compared(self):
        native, nk, ne, _ = self.parse(fixture(0x80001000, 200, 201, 202))
        text = fixture(0x80002000, 100, 101, 102).replace(
            "$80002008 8e Function end", "$8000200c 8e Function end")
        retail, rk, re, _ = self.parse(text)
        result = compare_function(native["fn"], retail["fn"], nk, ne, rk, re)
        self.assertEqual(result["status"], "LENGTH_MISMATCH")
        self.assertIsNone(result["tag_diffs"])

    def test_no_in_function_event_cannot_inherit_previous_module(self):
        native_text = fixture(0x80001000, 200, 201, 202)
        native_text = native_text.replace(
            "000003: $80001004 80 Inc SLD linenum (to 201)\n", "")
        native_text = native_text.replace(
            "000000: $80001000 88 Set SLD to line 200",
            "000000: $80000ffc 88 Set SLD to line 200")
        native, nk, ne, _ = self.parse(native_text)
        retail, rk, re, _ = self.parse(fixture(0x80002000, 100, 101, 102))
        result = compare_function(native["fn"], retail["fn"], nk, ne, rk, re)
        self.assertEqual(result["status"], "NO_FUNCTION_SLD_EVENT")

    def test_relative_end_line_and_duplicate_names(self):
        source = fixture(0x80001000, 200, 201, 2)
        source += fixture(0x80002000, 300, 301, 302)
        funcs, _, _, duplicates = self.parse(source)
        self.assertEqual(duplicates, ["fn"])
        self.assertEqual(end_delta(funcs["fn"]), 2)

    def test_directory(self):
        self.assertEqual(directory_of(r"C:\nfs4\FRONTEND\PSX\FRONT.CPP"), "FRONTEND/PSX")


if __name__ == "__main__":
    unittest.main()
