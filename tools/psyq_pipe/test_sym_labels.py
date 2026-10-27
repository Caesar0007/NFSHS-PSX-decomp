"""Regression controls for independently owned raw LABEL records."""
import contextlib,hashlib,io,json,tempfile,unittest
from pathlib import Path
import sym_labels as labels

def fixture(name='f',start=0x80010000,extra='',label='again',at=8):
 rows=[f'0000: ${start:08x} 8c Function start','    line = 10','    file = C:\\nfs4\\GAME\\COMMON\\X.CPP','    name = '+name,
       f'0001: ${start:08x} 90 Block start line = 1']
 if label is not None:rows.append(f'0002: ${start+at:08x} 94 Def class LABEL type NULL size 0 name '+label)
 rows += [extra] if extra else []
 rows += [f'0003: ${start+16:08x} 92 Block end line = 3',f'0004: ${start+20:08x} 8e Function end line 14']
 return '\n'.join(rows)+'\n'

class LabelAuditTests(unittest.TestCase):
 def setUp(self):
  self.temp=tempfile.TemporaryDirectory();self.addCleanup(self.temp.cleanup);self.d=Path(self.temp.name)
 def pair(self,n,r):
  a=self.d/'native.txt';b=self.d/'retail.txt';a.write_text(n);b.write_text(r);return labels.report(a,b)
 def test_relative_addresses_and_owner_are_compared(self):
  p=self.pair(fixture(),fixture(start=0x80050000))
  self.assertEqual(p['functions'][0]['status'],'MATCH')
  self.assertEqual(p['functions'][0]['native'][0]['owner'],dict(path=[0],start=0,end=16))
  self.assertEqual(self.pair(fixture(at=12),fixture())['counts']['different'],1)
 def test_unprovided_and_missing_labels_remain_visible(self):
  p=self.pair(fixture(label='LAB_80012345'),fixture(label=None));self.assertEqual(len(p['functions'][0]['native_only_records']),1)
  p=self.pair(fixture(label=None),fixture());self.assertEqual(len(p['functions'][0]['retail_only_records']),1)
 def test_duplicates_are_retained_and_function_copies_declined(self):
  extra='0002: $80010008 94 Def class LABEL type NULL size 0 name again'
  p=self.pair(fixture(extra=extra),fixture());self.assertEqual(p['counts']['native_records'],2)
  self.assertEqual(len(p['functions'][0]['native_only_records']),1)
  p=self.pair(fixture()+fixture(start=0x80011000),fixture());self.assertEqual(p['counts']['compared'],0)
  self.assertEqual(len(p['ambiguous_function_names_NOT_compared']),1)
 def test_sibling_owner_identity_not_just_depth(self):
  text=fixture(extra='0002: $8001000c 90 Block start line = 2\n0002: $8001000c 92 Block end line = 2')
  p=self.pair(text,fixture());self.assertEqual(p['functions'][0]['status'],'MATCH')
  moved=text.replace('0002: $80010008 94 Def class LABEL type NULL size 0 name again\n','').replace('0002: $8001000c 92','0002: $8001000c 94 Def class LABEL type NULL size 0 name again\n0002: $8001000c 92')
  p=self.pair(moved,text);self.assertEqual(p['counts']['different'],1)
 def test_same_depth_same_address_different_sibling_path(self):
  begin='0002: $80010004 90 Block start line = 2\n'
  end='0002: $8001000c 92 Block end line = 2\n'
  label='0002: $80010008 94 Def class LABEL type NULL size 0 name again\n'
  n=fixture(label=None,extra=begin+label+end+begin+end)
  r=fixture(label=None,extra=begin+end+begin+label+end)
  p=self.pair(n,r);self.assertEqual(p['functions'][0]['status'],'DIFF')
  a=p['functions'][0]['native'][0]['owner'];b=p['functions'][0]['retail'][0]['owner']
  self.assertEqual((a['start'],a['end']),(b['start'],b['end']))
  self.assertEqual(len(a['path']),len(b['path']));self.assertNotEqual(a['path'],b['path'])
 def test_malformed_and_unowned_records_are_not_green(self):
  p=self.pair(fixture(at=40),fixture());self.assertEqual(p['functions'][0]['status'],'INCOMPLETE_ADDRESS')
  self.assertEqual(p['counts']['unresolved_address_functions'],1)
  p=self.pair(fixture().replace('0003: $80010010 92 Block end line = 3\n',''),fixture())
  self.assertEqual(len(p['invalid_function_records_NOT_compared']),1)
  p=self.pair(fixture().replace('size 0 name again','size unknown name again'),fixture())
  self.assertEqual(p['counts']['compared'],0)
  self.assertEqual(len(p['unparsed_LABEL_records_NOT_compared']['native']),1)
  p=self.pair('0000: $80010000 94 Def class LABEL type NULL size 0 name orphan\n'+fixture(),fixture())
  self.assertEqual(len(p['unowned_LABEL_records']['native']),1)
  with self.assertRaises(ValueError):self.pair('nothing recognized',fixture())
 def test_only_prefix_destructor_alias_is_normalized(self):
  p=self.pair(fixture(name='___3Foo'),fixture(name='_._3Foo'));self.assertEqual(p['counts']['compared'],1)
  p=self.pair(fixture(name='f___3Foo'),fixture(name='f_._3Foo'));self.assertEqual(p['counts']['compared'],0)
 def test_cli_hashes_read_only_and_overwrite_rejection(self):
  a=self.d/'a.txt';b=self.d/'b.txt';out=self.d/'report.json';a.write_text(fixture());b.write_text(fixture())
  before=a.read_bytes(),b.read_bytes()
  with contextlib.redirect_stdout(io.StringIO()):result=labels.main(['--native',str(a),'--retail',str(b),'--report',str(out)])
  self.assertEqual(result['inputs']['native']['sha256'],hashlib.sha256(before[0]).hexdigest())
  self.assertEqual(json.loads(out.read_text()),result)
  self.assertEqual(before,(a.read_bytes(),b.read_bytes()))
  with contextlib.redirect_stderr(io.StringIO()),self.assertRaises(SystemExit):labels.main(['--native',str(a),'--retail',str(b),'--report',str(a)])
 def test_small_retail_LABEL_value_remains_unresolved_not_invalid(self):
  small=fixture().replace('$80010008 94','$00001160 94')
  p=self.pair(fixture(),small);self.assertEqual(p['counts']['unresolved_address_functions'],1)
  self.assertEqual(p['invalid_function_records_NOT_compared'],[])
  row=p['functions'][0]['retail'][0]
  self.assertEqual(row['address'],0x1160);self.assertIsNone(row['relative_address'])
  self.assertEqual(p['functions'][0]['status'],'INCOMPLETE_ADDRESS')
  p=self.pair(fixture(label='different'),small);self.assertEqual(p['functions'][0]['status'],'DIFF_INCOMPLETE_ADDRESS')

if __name__=='__main__':unittest.main()
