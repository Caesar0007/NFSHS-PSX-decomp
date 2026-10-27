"""Fail-closed ownership/layout controls for SimQueue's ordinary static BSS."""
import ast,importlib.util,struct,tempfile,unittest
from pathlib import Path
from unittest.mock import patch

ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('_simqueue_zero_contract',ROOT/'tools/source_zero_owners.py')
zero=importlib.util.module_from_spec(spec);spec.loader.exec_module(zero)
QUEUE=next(r for r in zero.SOURCE_ZERO_OWNERS if r['source']=='recon/game/common/simqueue.cpp')

def object_bytes(extent=524,kind=8,flags=3,section='.bss',value=0,size=0,bind=0,typ=0,visibility=0,extra=False,reloc=False):
 names=['',section,'.symtab','.strtab','.shstrtab']+(['.rel.bss'] if reloc else [])
 shnames=b'\0';offsets={}
 for name in names[1:]:offsets[name]=len(shnames);shnames+=name.encode()+b'\0'
 strings=b'\0inputQueue\0unexpected\0'
 symbols=b'\0'*16+struct.pack('<IIIBBH',1,value,size,(bind<<4)|typ,visibility,1)
 if extra:symbols+=struct.pack('<IIIBBH',12,0,4,1,0,1)
 data=bytearray(52)
 payload_offset=len(data)
 if kind!=8:data+=b'\0'*extent
 st_offset=len(data);data+=symbols
 str_offset=len(data);data+=strings
 shstr_offset=len(data);data+=shnames
 rel_offset=len(data)
 if reloc:data+=b'\0'*8
 while len(data)%4:data+=b'\0'
 shoff=len(data)
 headers=[(0,0,0,0,0,0,0,0,0,0),
          (offsets[section],kind,flags,0,payload_offset,extent,0,0,16,0),
          (offsets['.symtab'],2,0,0,st_offset,len(symbols),3,len(symbols)//16,4,16),
          (offsets['.strtab'],3,0,0,str_offset,len(strings),0,0,1,0),
          (offsets['.shstrtab'],3,0,0,shstr_offset,len(shnames),0,0,1,0)]
 if reloc:headers.append((offsets['.rel.bss'],9,0,0,rel_offset,8,2,1,4,8))
 for header in headers:data+=struct.pack('<10I',*header)
 ident=b'\x7fELF\x01\x01\x01'+b'\0'*9
 data[:52]=struct.pack('<16sHHIIIIIHHHHHH',ident,1,8,1,0,0,shoff,0,52,0,0,40,len(headers),4)
 return bytes(data)

class SimQueueZeroOwnerTests(unittest.TestCase):
 def setUp(self):
  self.temp=tempfile.TemporaryDirectory();self.addCleanup(self.temp.cleanup);self.root=Path(self.temp.name)
  self.obj=self.root/(QUEUE['source']+'.o');self.obj.parent.mkdir(parents=True)
 def validate(self,**kwargs):
  self.obj.write_bytes(object_bytes(**kwargs))
  with patch.object(zero,'SOURCE_ZERO_OWNERS',(QUEUE,)):zero.validate_source_zero_owners(self.root)
 def rejects(self,**kwargs):
  with self.assertRaises((AssertionError,ValueError)):self.validate(**kwargs)
 def test_exact_native_owner_and_valid_plain_local_reservation(self):
  self.assertEqual((QUEUE['section'],QUEUE['address'],QUEUE['size']),('.bss',0x8013e0f4,524))
  self.assertEqual(QUEUE['symbols'],(('inputQueue',0,524,0),))
  self.assertTrue(QUEUE['exact_symbols']);self.assertTrue(QUEUE['linker_early_seam'])
  self.validate();self.validate(size=524,typ=1)
 def test_generated_NOLOAD_extent_and_original_early_output_alignment(self):
  tree=ast.parse((ROOT/'tools/gen_ld.py').read_text())
  fn=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='source_zero_owner_lines')
  env={};exec(compile(ast.Module(body=[fn],type_ignores=[]),'<actual zero-owner emitter>','exec'),env)
  lines=env['source_zero_owner_lines'](QUEUE);text='\n'.join(lines)
  self.assertIn('.simqueue_bss 0x8013e0f4 (NOLOAD) : SUBALIGN(4)',text)
  self.assertIn('build/recon/game/common/simqueue.cpp.o(.bss)',text)
  self.assertIn('SIZEOF(.simqueue_bss) == 524',text)
  self.assertNotIn('.bss.simqueue_input_queue',text)
  for row in zero.SOURCE_ZERO_OWNERS:
   self.assertIn('SUBALIGN('+str(row.get('alignment',4))+')','\n'.join(env['source_zero_owner_lines'](row)))
 def test_initialized_zero_payload_is_not_BSS(self):self.rejects(kind=1)
 def test_extent_and_source_section_are_exact(self):
  for extent in (520,528):
   with self.subTest(extent=extent):self.rejects(extent=extent)
  self.rejects(section='.bss.simqueue_input_queue')
 def test_allocated_writable_nonexecuting_flags_are_exact(self):
  for flags in (0,2,7,19,0x10000003):
   with self.subTest(flags=flags):self.rejects(flags=flags)
 def test_static_name_offset_binding_type_and_size_are_exact(self):
  for kwargs in [dict(value=4),dict(bind=1),dict(typ=2),dict(size=520)]:
   with self.subTest(kwargs=kwargs):self.rejects(**kwargs)
 def test_hidden_visibility_is_not_source_local_storage(self):self.rejects(visibility=2)
 def test_no_additional_shadow_storage_is_admitted(self):self.rejects(extra=True)
 def test_storage_has_no_relocations(self):self.rejects(reloc=True)

if __name__=='__main__':unittest.main()
