"""psylink_gmode.py -- give psylink_lane.py a FULL-DEBUG mode without touching the measurement lane's files:
  NFS4_LANE_G=1        ASPSX gets -g for every TU that has a build/gdebug/<rel>.s (made by gdebug_compile.py); that .s is
                       used instead of build/<rel>.s
  NFS4_LANE_OUT=dir    object / link directory (default build/psyq); in G mode the lane's scratch OUTPUTS (nfs4_sym.txt,
                       compare_rows.json, ...) go there too, so scratchpad/psyq_pipe keeps the plain lane's results."""
R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
p = R + 'scratchpad/psyq_pipe/psylink_lane.py'
s = open(p, encoding='utf-8').read()
assert 'NFS4_LANE_G' not in s
k = "OUT = ROOT / 'build' / 'psyq'; OUT.mkdir(parents=True, exist_ok=True)" + NL
assert s.count(k) == 1
s = s.replace(k, "GMODE = os.environ.get('NFS4_LANE_G') == '1'   # full-debug lane (see psylink_gmode.py / gdebug_compile.py)" + NL +
              "OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq'); OUT.mkdir(parents=True, exist_ok=True)" + NL)
k = "W = ROOT / 'scratchpad' / 'psyq_pipe'" + NL
assert s.count(k) == 1
s = s.replace(k, k + "WOUT = OUT if GMODE else W      # scratch OUTPUTS; inputs (sym_obj_order.json) always come from W" + NL)
for name in ('pad8.json', 'assemble_fails.json', 'gap_windows.json', 'psylink.log', 'slots.json', 'equ_symbols.json', 'nfs4_sym.txt', 'compare_rows.json'):
    a = "(W / '%s')" % name
    assert s.count(a) >= 1, name
    s = s.replace(a, "(WOUT / '%s')" % name)
k = "        sfile = ROOT / 'build' / (s.relative_to(ROOT).as_posix() + '.s')" + NL
assert s.count(k) == 1
s = s.replace(k, k + "        gfile = ROOT / 'build' / 'gdebug' / (s.relative_to(ROOT).as_posix() + '.s')" + NL +
              "        dbg = GMODE and gfile.is_file()" + NL + "        if dbg:" + NL + "            sfile = gfile" + NL)
k = "        cmd = [ASPSX, '-q', f'-G{g}', str(tmp), '-o', str(obj)]" + NL
assert s.count(k) == 1
s = s.replace(k, "        cmd = [ASPSX, '-q', *(['-g'] if dbg else []), f'-G{g}', str(tmp), '-o', str(obj)]" + NL)
if 'import os' not in s.split('OUT = ROOT')[0]:
    s = s.replace('import ', 'import os' + NL + 'import ', 1)
open(p, 'w', encoding='utf-8', newline='').write(s)
print('ok')
