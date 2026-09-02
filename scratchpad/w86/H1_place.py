"""H1_place -- where to spend the +1 chain object.

`H1_fine.copy1` proved P=21 satisfies BOTH tie-breaks (score 25, insns 3197,
frame 632).  Its residual is a 27-insn hunk around the garage carrier itself,
i.e. the cost of spelling the +1 INSIDE that site.  This script prices the same
+1 at every other prefix site.

A depth-1 `({ EXPR; })` costs 4 notes + 1 cse-deleted result copy = 5 objects.
Giving it a NAMED LOCAL -- `({ T *p = EXPR; p; })` -- adds one more copy and
nothing else, so it is a +1 device that opens no new block.
"""
import sys
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w86')
import H1_score as S
import H1_fine as F

V = {
 # +1 by giving an existing depth-1 site a named local
 'speech':  ('({ &iteratorLocalSpeech; })',
             '({ tListIterator *localSpeechIterator = &iteratorLocalSpeech; localSpeechIterator; })'),
 'mto_dir': ('({ &itemTrackDirection; })',
             '({ tMenuItem *trackDirectionItem = &itemTrackDirection; trackDirectionItem; })'),
 'mto_mir': ('({ &itemTrackMirrored; })',
             '({ tMenuItem *trackMirroredItem = &itemTrackMirrored; trackMirroredItem; })'),
 'dpos':    ('({ &iteratorDisplayPosition; })',
             '({ tListIterator *displayPositionIterator = &iteratorDisplayPosition; displayPositionIterator; })'),
 # garage variants (the H1_fine winner + orderings)
 'gar_copy':  (F.GAR, F.CANDS['copy1']),
 'gar_copy_b': (F.GAR,
   'tMenuItem *garageCarItem = &itemGarageCar; (void)garageCarItem; tMenuItem *garageCarItem2 = garageCarItem; (void)garageCarItem2; 0x1a00'),
 'gar_use':   (F.GAR,
   'tMenuItem *garageCarItem = &itemGarageCar; tMenuItem *garageCarItem2 = &itemGarageCar; (void)garageCarItem; (void)garageCarItem2; 0x1a00'),
}


if __name__ == '__main__':
    names = sys.argv[1:] or list(V)
    for nm in names:
        old, new = V[nm]
        try:
            st = S.build_cfg('001111133', edits=[(old, new, 1)], tag='H1_place')
        except SystemExit as e:
            print('%-12s SKIP %s' % (nm, e)); continue
        n, ln, err, bad = S.score_stream(st)
        print('%-12s insns=%-5d frame=%-4s R2delta=%-4s R1=%-10s score=%s %s' %
              (nm, ln, S.frame(st), S.probe1747(st), S.probeR1(st), n, err), flush=True)
