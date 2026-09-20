"""Isolated failure-path controls. Subprocesses are fakes, never real compilers.

Fixtures use a synthetic ELF32/MIPS object and retained stale files. Only these test files
are mutated; production source, compiler outputs and references are untouched.
"""
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import patch
import contextlib,hashlib,importlib.util,io,json,shutil,struct,tempfile,unittest

ROOT=Path(__file__).resolve().parents[2];HERE=ROOT/'build/symloop_guard_tests'
HERE.mkdir(parents=True,exist_ok=True)
spec=importlib.util.spec_from_file_location('guarded_symloop',ROOT/'tools/psyq_pipe/symloop.py')
loop=importlib.util.module_from_spec(spec);spec.loader.exec_module(loop)
def fixture_elf():
    """Minimal independent ELF32/MIPS object: Foo is jr ra/nop; no ROM needed."""
    names=['','.text','.rodata','.data','.sdata','.bss','.shstrtab','.strtab','.symtab']
    shstr=b'';name_offsets=[]
    for name in names:
        name_offsets.append(len(shstr));shstr+=name.encode()+b'\0'
    image=bytearray(52);headers=[(0,)*10]
    contents={1:b'\x08\x00\xe0\x03'+b'\0'*4,2:b'hello\0\0\0',3:b'\x01\0\0\0',4:b'\x02\0\0\0',
              6:shstr,7:b'\0Foo\0',8:b'\0'*16+struct.pack('<IIIBBH',1,0,8,0x12,0,1)}
    for index in range(1,len(names)):
        kind=8 if index==5 else 3 if index in (6,7) else 2 if index==8 else 1
        flags={1:6,2:2,3:3,4:0x10000003,5:3}.get(index,0)
        alignment=1 if index in (6,7) else 4
        image.extend(b'\0'*((-len(image))%alignment));offset=len(image)
        data=contents.get(index,b'');image.extend(data)
        headers.append((name_offsets[index],kind,flags,0,offset,16 if index==5 else len(data),
                        7 if index==8 else 0,1 if index==8 else 0,alignment,16 if index==8 else 0))
    image.extend(b'\0'*((-len(image))%4));table=len(image)
    image.extend(b''.join(struct.pack('<10I',*row) for row in headers))
    image[:16]=b'\x7fELF\x01\x01\x01'+b'\0'*9
    struct.pack_into('<HHIIIIIHHHHHH',image,16,1,8,1,0,0,table,0,52,0,0,40,len(headers),6)
    return bytes(image)

ELF=fixture_elf()
RESULTS=[]


class PipelineTests(unittest.TestCase):
    def setUp(self):
        parent=HERE/'fixtures';parent.mkdir(exist_ok=True)
        self.root=Path(tempfile.mkdtemp(prefix='case-',dir=parent))
        self.rel='recon/game/common/sample.cpp';self.mode='ok';self.calls=[]
        self.put(self.rel,'void Foo(void) {}\n')
        self.put('tools/source_section_owners.py',(ROOT/'tools/source_section_owners.py').read_bytes())
        self.obj='build/'+self.rel+'.o';self.asm='build/'+self.rel+'.s'
        self.gs='build/gdebug/'+self.rel+'.s';self.gr='scratchpad/psyq_pipe/gdebug_report.json'
        self.lane='build/psyq_g/';self.sn=self.lane+self.rel.replace('/','__')+'.obj'
        self.put(self.obj,ELF);self.put(self.asm,'OLD normal\n');self.put(self.gs,'OLD debug\n')
        self.put(self.gr,json.dumps({self.rel:dict(s=True,same_code=True,note='assembled')}))
        for name in ('nfs4.cpe','nfs4.sym','nfs4.map','nfs4_sym.txt'):
            self.put(self.lane+name,'OLD '+name+'\n')
        self.put(self.sn,b'LNK OLD');self.put(self.lane+'assemble_fails.json','[]')
        self.put(self.lane+'psylink.log','0 error(s)\n')
        self.board={'Foo':dict(file='C:\\nfs4\\GAME\\COMMON\\SAMPLE.CPP',issues=[])}
        self.put(self.lane+'symtree_report.json',json.dumps(self.board))
        self.retail={'Foo':dict(hdr=dict(file='C:\\nfs4\\GAME\\COMMON\\SAMPLE.CPP'))}
        self.root_patch=patch.object(loop,'ROOT',self.root);self.root_patch.start();self.addCleanup(self.root_patch.stop)
        self.ref='build/symloop_ref/'+self.rel+'.text';self.original_ref=loop.text_of(self.root/self.obj)
        self.put(self.ref,self.original_ref)
        self.layout=self.ref+'.json';self.original_layout=json.dumps(loop.object_snapshot(self.root/self.obj)[1])
        self.put(self.layout,self.original_layout)

    def put(self,rel,data):
        p=self.root/rel;p.parent.mkdir(parents=True,exist_ok=True)
        p.write_bytes(data if isinstance(data,bytes) else data.encode())

    def fake_run(self,command,**kwargs):
        stage={'build.py':'normal','gdebug_compile.py':'debug','psylink_lane.py':'lane','symtree_cmp.py':'compare'}[Path(command[1]).name]
        self.calls.append(stage)
        if self.mode==stage+'_exit':return SimpleNamespace(returncode=7,stdout='',stderr='controlled child failure')
        if stage=='normal':
            data=ELF
            if self.mode in ('bytes_moved','section_layout_moved'):
                data=bytearray(ELF)
                helper=importlib.util.spec_from_file_location('fixture_elf',self.root/'tools/source_section_owners.py')
                m=importlib.util.module_from_spec(helper);helper.loader.exec_module(m)
                image=m.read_owner_image(self.root/'build/symloop_runs'/next((self.root/'build/symloop_runs').iterdir()).name/'normal-before'/self.obj)
                if self.mode=='bytes_moved':data[image['sections']['.text'][4]]^=1
                else:
                    at=struct.unpack_from('<I',data,32)[0]+40*image['section_order'].index('.text')+32
                    align=image['sections']['.text'][8];struct.pack_into('<I',data,at,align*2)
                data=bytes(data)
            if self.mode=='invalid_elf':data=b'not an ELF object'
            if self.mode!='stale_normal_object':self.put(self.obj,data)
            if self.mode!='missing_normal_assembly':self.put(self.asm,'NEW normal\n')
        elif stage=='debug':
            if self.mode!='stale_debug_assembly':self.put(self.gs,'NEW debug\n')
            r=dict(s=True,same_code=True,note='assembled')
            if self.mode=='debug_failed_report':r['note']='FAILED: compiler error'
            if self.mode=='debug_code_diff':r['same_code']=False
            if self.mode=='debug_unknown_code':r['same_code']=None
            if self.mode=='debug_no_s':r['s']=False
            if self.mode!='stale_debug_report':self.put(self.gr,json.dumps({} if self.mode=='debug_wrong_tu' else {self.rel:r}))
        elif stage=='lane':
            self.assertEqual(kwargs['env']['NFS4_LANE_ONLY'],self.rel)
            self.assertEqual(kwargs['env']['NFS4_LANE_G'],'1')
            if self.mode!='stale_sn_object':self.put(self.sn,b'LNK NEW')
            for name in ('nfs4.cpe','nfs4.sym','nfs4.map','nfs4_sym.txt'):
                if self.mode!='missing_'+name:self.put(self.lane+name,'NEW '+name+'\n')
            self.put(self.lane+'assemble_fails.json','[["sample", "error"]]' if self.mode=='assembler_failed' else '[]')
            self.put(self.lane+'psylink.log','1 error(s)\n' if self.mode=='link_failed' else '0 error(s)\n')
        elif stage=='compare':
            if self.mode!='stale_board':
                board={} if self.mode=='missing_function' else self.board
                if self.mode=='dirty_valid':board={'Foo':dict(file=self.board['Foo']['file'],issues=['ORDER of declarations differs'])}
                if self.mode=='malformed_row':board={'Foo':{}}
                if self.mode=='malformed_issues':board={'Foo':dict(file=self.board['Foo']['file'],issues=[1])}
                self.put(self.lane+'symtree_report.json',json.dumps(board))
        return SimpleNamespace(returncode=0,stdout='ASPSX ok 1 bad 0\nPSYLINK: 0 error lines\n' if stage=='lane' else '',stderr='')

    def invoke(self,args=None):
        out=io.StringIO();err=io.StringIO()
        with patch.object(loop,'retail_functions',return_value=self.retail),patch.object(loop.subprocess,'run',side_effect=self.fake_run),contextlib.redirect_stdout(out),contextlib.redirect_stderr(err):
            rc=loop.main(args if args is not None else [self.rel])
        RESULTS.append(dict(test=self.id().split('.')[-1],mode=self.mode,returncode=rc,stages=list(self.calls),stdout=out.getvalue(),stderr=err.getvalue()))
        return rc,out.getvalue(),err.getvalue()

    def test_success(self):
        rc,out,_=self.invoke();self.assertEqual(rc,0);self.assertIn('BYTES: UNCHANGED',out)
        self.assertIn('1 functions, 1 CLEAN, 0 DIRTY',out);self.assertEqual(self.calls,['normal','debug','lane','compare'])
        self.assertEqual((self.root/self.ref).read_bytes(),self.original_ref)

    def test_dirty_is_valid_comparison(self):
        self.mode='dirty_valid';rc,out,_=self.invoke();self.assertEqual(rc,0);self.assertIn('0 CLEAN, 1 DIRTY',out)

    def test_missing_reference_fails_before_build(self):
        (self.root/self.ref).unlink();rc,out,_=self.invoke();self.assertNotEqual(rc,0);self.assertEqual(self.calls,[])
        self.assertFalse((self.root/self.ref).exists());self.assertNotIn('BYTES: UNCHANGED',out)

    def test_reference_capture_requires_fresh_build(self):
        (self.root/self.ref).unlink();rc,out,_=self.invoke([self.rel,'--ref-only'])
        self.assertEqual(rc,0);self.assertEqual(self.calls,['normal']);self.assertEqual((self.root/self.ref).read_bytes(),self.original_ref)

    def test_existing_reference_not_overwritten(self):
        self.mode='bytes_moved';rc,out,_=self.invoke([self.rel,'--ref-only'])
        self.assertNotEqual(rc,0);self.assertEqual((self.root/self.ref).read_bytes(),self.original_ref);self.assertNotIn('BYTES: UNCHANGED',out)

    def test_legacy_reference_requires_explicit_adoption(self):
        (self.root/self.layout).unlink();rc,_,_=self.invoke();self.assertNotEqual(rc,0);self.assertEqual(self.calls,[])
        rc,_,_=self.invoke([self.rel,'--ref-only']);self.assertEqual(rc,0)
        self.assertTrue((self.root/self.layout).is_file());self.assertEqual((self.root/self.ref).read_bytes(),self.original_ref)

    def test_typo_not_hidden_by_good_fragment(self):
        rc,_,_=self.invoke([self.rel,'no_such_tu']);self.assertNotEqual(rc,0);self.assertEqual(self.calls,[])

    def test_missing_retail_coverage(self):
        self.retail={};rc,_,_=self.invoke();self.assertNotEqual(rc,0);self.assertEqual(self.calls,[])

    def test_partial_comparison_is_not_success(self):
        self.retail['Bar']=self.retail['Foo'];rc,out,_=self.invoke()
        self.assertNotEqual(rc,0);self.assertNotIn('BYTES: UNCHANGED',out)

    def test_ambiguous_retail_coverage(self):
        self.retail['Other']=dict(hdr=dict(file='C:\\nfs4\\FRONTEND\\COMMON\\SAMPLE.CPP'))
        rc,_,_=self.invoke();self.assertNotEqual(rc,0);self.assertEqual(self.calls,[])

    def test_failure_paths(self):
        modes=['normal_exit','bytes_moved','section_layout_moved','stale_normal_object','missing_normal_assembly','invalid_elf',
            'debug_exit','stale_debug_assembly','stale_debug_report','debug_failed_report','debug_code_diff','debug_unknown_code','debug_no_s','debug_wrong_tu',
            'lane_exit','stale_sn_object','missing_nfs4.cpe','missing_nfs4.sym','missing_nfs4.map','missing_nfs4_sym.txt','assembler_failed','link_failed',
            'compare_exit','stale_board','missing_function','malformed_row','malformed_issues']
        for mode in modes:
            with self.subTest(mode=mode):
                # Every case gets its own filesystem and stale-artifact set.
                case=PipelineTests(methodName='test_success');case.setUp()
                try:
                    case.mode=mode;rc,out,_=case.invoke()
                    self.assertNotEqual(rc,0,mode);self.assertNotIn('BYTES: UNCHANGED',out,mode)
                    self.assertEqual((case.root/case.ref).read_bytes(),case.original_ref)
                    self.assertEqual((case.root/case.layout).read_text(),case.original_layout)
                    if mode in ('normal_exit','bytes_moved','section_layout_moved','stale_normal_object','missing_normal_assembly','invalid_elf'):
                        self.assertEqual(case.calls,['normal'])
                    if mode.startswith('debug') or mode.startswith('stale_debug'):
                        self.assertNotIn('lane',case.calls)
                finally:case.doCleanups()


if __name__=='__main__':
    result=unittest.TextTestRunner(verbosity=2).run(unittest.defaultTestLoader.loadTestsFromTestCase(PipelineTests))
    output=dict(passed=result.wasSuccessful(),tests=result.testsRun,control_runs=len(RESULTS),
        production_tool_sha256=hashlib.sha256((ROOT/'tools/psyq_pipe/symloop.py').read_bytes()).hexdigest(),
        isolated_fake_subprocess_controls=True,no_production_compiler_output_mutations=True,results=RESULTS)
    (HERE/'test_results.json').write_text(json.dumps(output,indent=2)+'\n')
    raise SystemExit(not result.wasSuccessful())
