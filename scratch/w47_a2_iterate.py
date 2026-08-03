FN = 'iSPCH_IterateChoice'

PRELUDE = r'''
extern short ispch_gChoice[];
extern int VoxSentence_GetNumPhrases(int sentence);
'''

_HEAD = r'''
int iSPCH_IterateChoice(int sentence)
{
    int exhausted = 0;
    int n = VoxSentence_GetNumPhrases(sentence) - 1;
    int count, pbase, limit, loopDone, cur;
'''

_TAIL = r'''
    count = choice[2];
    pbase = choice[3];
    limit = pbase + count;
    loopDone = exhausted;
top:
    cur = (unsigned short)choice[4] + 1;
    choice[4] = cur;
    if ((short)cur < limit) {
        loopDone = 1;
    } else {
        choice[4] = choice[3];
        n = n - 1;
        choice = choice - 6;
        if (n < 0) {
            loopDone  = 1;
            exhausted = loopDone;
        }
        count = choice[2];
        pbase = choice[3];
        limit = pbase + count;
    }
    if (!loopDone) goto top;
    return exhausted;
}
'''


def V(mid):
    return _HEAD + mid + _TAIL


VARIANTS = {
    'base_2Drow':      V('    short *choice = ((short (*)[6])ispch_gChoice)[n];'),
    'base_plus':       V('    short *choice = ispch_gChoice + n * 6;'),
    'named_ptr':       V('    short *chBase = ispch_gChoice;\n'
                         '    short *choice = chBase + n * 6;'),
    'named_int':       V('    int chBase = (int)ispch_gChoice;\n'
                         '    short *choice = (short *)(chBase + n * 12);'),
    'mutate':          V('    short *choice = ispch_gChoice;\n'
                         '    choice = choice + n * 6;'),
    'named_idx':       V('    short *chBase = ispch_gChoice;\n'
                         '    int idx = n * 6;\n'
                         '    short *choice = chBase + idx;'),
    'idx_first':       V('    int idx = n * 6;\n'
                         '    short *choice = ispch_gChoice + idx;'),
    'named_charp':     V('    char *chBase = (char *)ispch_gChoice;\n'
                         '    short *choice = (short *)(chBase + n * 12);'),
    'named_ptr_rev':   V('    short *chBase = ispch_gChoice;\n'
                         '    short *choice = n * 6 + chBase;'),
    'named_row':       V('    short (*chRow)[6] = (short (*)[6])ispch_gChoice;\n'
                         '    short *choice = chRow[n];'),
    'named_deref':     V('    short *chBase = ispch_gChoice;\n'
                         '    short *choice = &chBase[n * 6];'),
}

VARIANTS.update({
    'choice_carries_mult': V('    short *chBase = ispch_gChoice;\n'
                             '    short *choice = (short *)(n * 12);\n'
                             '    choice = (short *)((char *)chBase + (int)choice);'),
    'choice_mult_then_add': V('    short *chBase = ispch_gChoice;\n'
                              '    short *choice = (short *)0 + n * 6;\n'
                              '    choice = chBase + (choice - (short *)0);'),
    'base_after_lh':       V('    short *choice;\n'
                             '    short *chBase = ispch_gChoice;\n'
                             '    choice = chBase + n * 6;'),
    'base_decl_first':     V('    short *chBase = ispch_gChoice;\n'
                             '    short *choice;\n'
                             '    choice = chBase + n * 6;'),
})
