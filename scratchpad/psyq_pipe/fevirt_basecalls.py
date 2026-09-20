"""fevirt_basecalls.py [--dry] -- with real virtuals `((Base *)this)->Method(...)` is a DYNAMIC call; retail calls the
base implementation directly.  Rewrite it to the qualified, non-virtual form `this->Base::Method(...)` for the menu
family's virtual method names, in every front-end source."""
import glob
import re
import sys

R = 'C:/Temp/nfs4-decomp/'
DRY = '--dry' in sys.argv
VIRT = ('DebounceKeys|ProcessInput|Draw|TransitionOff|TransitionOn|TransitionIsFinished|UpdateTransition|Initialize|IsSubMenu|'
        'DrawItem|UpdatefOpenHeight|DrawOneSong|GetShapeInfo|DrawBackground|DrawForeground|PreLoad|Cleanup|CalculateDimensions|'
        'CalculatePrizes|DrawCongratsMessage|GetCar|DrawVideoWall|InitializeVideoWall|UpdateVideoWall|AllocateAsyncBuffer|FreeAsyncBuffer|'
        'TurnOffVideoWall|SetDialog|DrawOpponentVideoWall')
pat = re.compile(r'\(\((t\w*(?:Menu|InsideBox|Screen|Dialog)\w*) \*\)this\)->(' + VIRT + r')\(')
tot = 0
for f in glob.glob(R + 'recon/frontend/**/*.cpp', recursive=True):
    s = open(f, encoding='utf-8').read()
    s2, n = pat.subn(r'this->\1::\2(', s)
    if n:
        tot += n
        print('%3d  %s' % (n, f.replace(R, '')))
        if not DRY:
            open(f, 'w', encoding='utf-8', newline='').write(s2)
print('total', tot)
