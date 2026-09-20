"""symloop_setup.py -- NFS4_LANE_ONLY=<fragment[,fragment]> for psylink_lane.py: the --assemble step touches only the TUs
whose path contains a fragment (all other objects stay as the last full run left them).  For the per-file SYM loop."""
R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
p = R + 'scratchpad/psyq_pipe/psylink_lane.py'
s = open(p, encoding='utf-8').read()
assert 'NFS4_LANE_ONLY' not in s
k = "        rel = s.relative_to(ROOT).as_posix()" + NL
assert s.count(k) == 1
s = s.replace(k, k + "        if ONLY and not any(f in rel for f in ONLY):" + NL + "            if (OUT / objname(rel)).is_file():" + NL + "                ok += 1" + NL + "            continue" + NL)
k = "WOUT = OUT if GMODE else W"
assert s.count(k) == 1
s = s.replace(k, "ONLY = [f for f in os.environ.get('NFS4_LANE_ONLY', '').split(',') if f]   # per-file loop: assemble just these TUs" + NL + k)
open(p, 'w', encoding='utf-8', newline='').write(s)
print('ok')
