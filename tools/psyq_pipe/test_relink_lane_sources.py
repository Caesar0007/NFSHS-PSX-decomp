"""Relink uses build-declared production roles, not every extant object.

2026-10-16: the old census admitted side-tree experiments and included-source
stale objects. AST-load real predicates/selection; no compiler or linker calls.
"""
import ast
from pathlib import Path
import tempfile
import unittest

TOOLS=Path(__file__).resolve().parents[1]


class RelinkLaneSourceTests(unittest.TestCase):
    def fixture(self, root):
        names=('recon/game/common/real.cpp','recon/eaclib/real.c',
            'recon/mod/game/common/real.cpp','recon/game-mod/common/real.cpp',
            'recon/syslib-mod/common/real.c','recon/game/tests/test.cpp',
            'recon/game/common/spchevnt.c','src/game/real.c','asm/data/data.s')
        for rel in names:
            p=root/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_text('')
            obj=root/'build'/(rel+'.o');obj.parent.mkdir(parents=True,exist_ok=True);obj.write_bytes(b'fixture')
        orphan=root/'build/recon/game/common/deleted.cpp.o';orphan.write_bytes(b'orphan')

    def context(self, root):
        tree=ast.parse((TOOLS/'build.py').read_text(encoding='utf-8'))
        predicates=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name in ('is_main_recon','is_tu')]
        constants={}
        for n in tree.body:
            if isinstance(n,ast.Assign):
                for t in n.targets:
                    if isinstance(t,ast.Name) and t.id in ('RECON_SIDE_TREES','INCLUDED_SOURCES'):
                        constants[t.id]=ast.literal_eval(n.value)
        ns=dict(ROOT=root,RECON=root/'recon',Path=Path,**constants)
        exec(compile(ast.Module(body=predicates,type_ignores=[]),'build_roles','exec'),ns)
        ns.update(validate_source_data_owners=lambda _:None,oracle_only_objects=lambda _:set(),
            validate_source_zero_owners=lambda _:None,oracle_only_zero_objects=lambda _:set())
        fn=next(n for n in ast.parse((TOOLS/'relink.py').read_text(encoding='utf-8')).body
            if isinstance(n,ast.FunctionDef) and n.name=='lane_objects')
        exec(compile(ast.Module(body=[fn],type_ignores=[]),'relink_sources','exec'),ns)
        return ns

    def test_main_source_and_data_survive(self):
        with tempfile.TemporaryDirectory() as td:
            root=Path(td).resolve();self.fixture(root);ns=self.context(root)
            got={p.relative_to(root).as_posix() for p in ns['lane_objects']('recon')}
            self.assertEqual(got,{'build/recon/game/common/real.cpp.o',
                'build/recon/eaclib/real.c.o','build/asm/data/data.s.o'})

    def test_src_lane_remains_independent(self):
        with tempfile.TemporaryDirectory() as td:
            root=Path(td).resolve();self.fixture(root);ns=self.context(root)
            self.assertEqual({p.relative_to(root).as_posix() for p in ns['lane_objects']('src')},
                {'build/src/game/real.c.o','build/asm/data/data.s.o'})

    def test_validated_oracle_exclusion_is_preserved(self):
        with tempfile.TemporaryDirectory() as td:
            root=Path(td).resolve();self.fixture(root);ns=self.context(root)
            excluded=(root/'build/asm/data/data.s.o').resolve()
            ns['oracle_only_objects']=lambda _: {excluded}
            self.assertNotIn(excluded,[p.resolve() for p in ns['lane_objects']('recon')])

    def test_final_link_generator_uses_the_same_real_source_roles(self):
        with tempfile.TemporaryDirectory() as td:
            root=Path(td).resolve();self.fixture(root);ns=self.context(root)
            fn=next(n for n in ast.parse((TOOLS/'gen_ld.py').read_text(encoding='utf-8')).body
                if isinstance(n,ast.FunctionDef) and n.name=='production_recon_sources')
            exec(compile(ast.Module(body=[fn],type_ignores=[]),'generator_sources','exec'),ns)
            self.assertEqual({p.relative_to(root).as_posix() for p in ns['production_recon_sources']()},
                {'recon/game/common/real.cpp','recon/eaclib/real.c'})


if __name__=='__main__':unittest.main()
