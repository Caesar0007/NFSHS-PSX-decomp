"""M3_land.py — write the final W85-M3 candidate (config + receipts in comments)."""
import sys
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w85')
import M3_depth as D

CFG = '001111133'
CAND = 'C:/Temp/nfs4-decomp/regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp'

s = D.src(CFG)

NOTE_TWOPLAYER = """   /* [W85-M3 2026-09-02] REGIONAL SOURCE DELTA (JPN): the Japanese build drops
      &itemTwoPlayerPinkSlips from this menu's item list -- the member is still
      constructed, only the list is shorter.  PROOF: the per-call outgoing-argument
      audit (scratchpad/w85/M3_args.py) over the 254 jal-delimited blocks gives
      base=[16,20,24,28,32,36,40,44] vs JPN=[16,20,24,28,32,36,40] for THIS call
      (call 38), and the spill-slot->member map (M3_slotmap.py) resolves base's
      slot 40 to +0x8F4 = itemTwoPlayerPinkSlips.  W84's "the source is identical"
      finding missed this: a jal-sequence / member-offset / constant audit cannot
      see a dropped stack argument. */
"""
NOTE_CTRL = """   /* [W85-M3 2026-09-02] REGIONAL SOURCE DELTA (JPN): the Japanese build drops
      &itemControllerDeadSpot1 and &itemControllerDeadSpot2 here (call 218:
      base=[16,20,24,28,32,36,40,44] vs JPN=[16,20,24,28,32,36]), leaving the same
      two items as menuControllerDualShock.  Same audit as menuTwoPlayer above. */
"""
NOTE_DEV = """   /* [W85-M3 2026-09-02] REGIONAL DEVICE RE-TUNE.  Dropping the two item
      arguments above removes chain objects at init-list line 3146, which moves
      every later cse hash-table flush boundary, so the base TU's all-nine
      depth-1 set no longer lands the %hi(FEApp) hoist.  This candidate runs the
      SAME nine sites with per-site DEPTHS (a depth-d statement expression costs
      4d+1 chain objects; depth 1 = the base's 5): weather OFF, traffic OFF,
      speech/mto_dir/mto_mir/garage depth 1, dpos depth 1, dlap depth 3,
      dsplit depth 3  (prefix 20 + suffix 31 = 48).  Measured floor over the
      whole dial -- 512-subset sweep, every achievable prefix sum 0-78, a 2-D
      (prefix,total) scan and a 125-config (A,G,S) search: gate 965, frame 632
      (retail), residual confined to stream indices 1000-1899.  The two
      remaining tie-breaks (menuSingleCarSelect fp-vs-spill needs shift >= 22;
      menuCarUpgrades ctor-a0 scheduling needs shift in [17,21]) are
      irreconcilable with an additive device -- see scratchpad/w85/M3_receipt.md. */
"""

a = ' , menuTwoPlayer(0x1004,'
i = s.index(a)
s = s[:i] + NOTE_TWOPLAYER + s[i:]
b = ' , menuControllerDualShockAnalog(0x1000,'
i = s.index(b)
s = s[:i] + NOTE_CTRL + s[i:]
c = ' , itemDisplayPosition(0x1e7,'
i = s.index(c)
s = s[:i] + NOTE_DEV + s[i:]

open(CAND, 'w', encoding='utf-8', newline='').write(s)
print('written', CAND, len(s), 'bytes')
