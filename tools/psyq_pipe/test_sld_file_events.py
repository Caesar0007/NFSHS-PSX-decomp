"""Filename coverage is separate from header equality and source-line tags."""
from pathlib import Path
import tempfile
import unittest

import sld_file_events as files


class FileEventsTests(unittest.TestCase):
    def decode(self, text):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'input.txt'
            path.write_text(text)
            return files.events(path)

    def test_windows_case_slashes_and_escaped_separators(self):
        self.assertEqual(files.normalize(r'C:\\nfs4\\GAME\COMMON\GROUP.CPP'),
                         files.normalize('c:/nfs4/game/common/group.cpp'))

    def test_only_file_events_change_filename(self):
        stream = self.decode('000008: $80010000 88 Set SLD to line 5 of file C:/a folder/a.cpp\n'
                             '000010: $80010004 84 Inc SLD linenum by word 300 (to 305)\n')
        self.assertEqual(files.file_at(stream, 0x80010004), 'C:/a folder/a.cpp')

    def test_last_same_address_event_wins(self):
        stream = self.decode('000008: $80010000 88 Set SLD to line 1 of file C:/old.cpp\n'
                             '000010: $80010000 88 Set SLD to line 3 of file C:/new.cpp\n')
        self.assertEqual(files.file_at(stream, 0x80010000), 'C:/new.cpp')

    def test_body_file_change_and_same_basename_different_directory_fail(self):
        native = self.decode('000008: $80010000 88 Set SLD to line 1 of file C:/a/x.cpp\n'
                             '000010: $80010004 88 Set SLD to line 2 of file C:/b/x.cpp\n')
        retail = self.decode('000008: $80020000 88 Set SLD to line 1 of file C:/a/x.cpp\n')
        with self.assertRaisesRegex(AssertionError, 'Word filename differs'):
            files.check(native, retail, {'start': 0x80010000, 'end': 0x80010008},
                        {'start': 0x80020000, 'end': 0x80020008})

    def test_missing_file_coverage_fails_even_when_both_missing(self):
        with self.assertRaisesRegex(AssertionError, 'Missing word filename'):
            files.check(([], {}), ([], {}), {'start': 0, 'end': 4}, {'start': 0, 'end': 4})
        files.check(([], {}), ([], {}), {'start': 0, 'end': 4}, {'start': 0, 'end': 4},
                    require_coverage=False)

    def test_length_mismatch_fails(self):
        with self.assertRaisesRegex(AssertionError, 'Function length differs'):
            files.check(([], {}), ([], {}), {'start': 0, 'end': 4}, {'start': 0, 'end': 8})


if __name__ == '__main__':
    unittest.main()
