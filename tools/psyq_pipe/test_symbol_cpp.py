"""Focused command/identity guards; no compiler output is normalized."""
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
import symbol_cpp as S


class SymbolCppTests(unittest.TestCase):
    def setUp(self):
        self.root=Path(__file__).resolve().parents[2]
        self.src=self.root/'recon/game/common/aih_btccop.cpp'
        self.cpp=self.root/'fake-cpp.exe'
        self.cmd=[self.cpp,'-x','c','-D__cplusplus=1','-nostdinc','-undef',
                  '-Dmips',f'-I{self.root / "recon"}',self.src,'-o',self.root/'x.i']

    def command(self, cmd=None, source=None):
        return S.symbol_cpp_command(self.cmd if cmd is None else cmd,
            source=self.src if source is None else source,root=self.root,
            default_cpp=self.cpp,cc1pl=self.root/'CC1PLPSX.EXE',env={})

    def test_selected_command_preserves_all_real_defines_inputs_and_output(self):
        original=list(self.cmd)
        with patch.object(S,'resolve_cpp43',return_value=Path('CPPPSX.EXE')):
            result=self.command()
        self.assertEqual(result,[Path('CPPPSX.EXE'),'-lang-c++',*self.cmd[3:-2],self.cmd[-1]])
        self.assertEqual(self.cmd,original)

    def test_other_tu_and_compiler_command_are_unchanged(self):
        with patch.object(S,'resolve_cpp43',side_effect=AssertionError('must not resolve')):
            self.assertEqual(self.command(source=self.root/'recon/game/common/mpause.cpp'),self.cmd)
            self.assertEqual(self.command(cmd=[self.root/'CC1PLPSX.EXE','-O2']),[self.root/'CC1PLPSX.EXE','-O2'])

    def test_screencongrats_whole_TU_profile_preserves_defines_and_output(self):
        # Evidence-backed second profile; normal build.py never calls this hook.
        src=self.root/'recon/frontend/common/screencongrats.cpp'
        cmd=list(self.cmd);cmd[-3]=src;before=list(cmd)
        with patch.object(S,'resolve_cpp43',return_value=Path('CPPPSX.EXE')):
            result=self.command(cmd=cmd,source=src)
        self.assertEqual(result,[Path('CPPPSX.EXE'),'-lang-c++',*cmd[3:-2],cmd[-1]])
        self.assertEqual(cmd,before)

    def test_unknown_selected_command_shape_is_not_silently_translated(self):
        with self.assertRaises(ValueError):self.command(cmd=[self.cpp,'-x','c',self.src])

    def test_missing_original_tool_fails_closed(self):
        with tempfile.TemporaryDirectory() as folder:
            with self.assertRaises(ValueError):S.resolve_cpp43(Path(folder)/'CC1PLPSX.EXE',{})

    def test_wrong_explicit_tool_identity_fails_closed(self):
        with tempfile.TemporaryDirectory() as folder:
            tool=Path(folder)/'CPPPSX.EXE';tool.write_bytes(b'not the original compiler')
            with self.assertRaises(ValueError):S.resolve_cpp43(Path(folder)/'CC1PLPSX.EXE',{'NFS4_CPPPSX':str(tool)})


if __name__=='__main__':unittest.main()
