FN = 'iSPCH_ConstantRuleSet'

PRELUDE = r'''
extern short          ispch_gChoice[];
extern unsigned char  ispch_gPickSamples[];
extern int  gVoxBanks[];
typedef void (*SentenceRuleSetFn)(int, int, int);
extern SentenceRuleSetFn gSentenceRuleSet;
extern int  VoxSentence_GetNumPhrases(int sentence);
extern int  iSPCH_GetOffset8(int base, int tableBase, int index);
extern unsigned int iSPCH_GetRuleID(int sentence, int index);
extern int  iSPCH_UnPackSample(int bank, int sampleIdx, int *out);
'''

_HEAD = r'''
void iSPCH_ConstantRuleSet(short *sentence, int rule)
{
    if (gSentenceRuleSet != 0) {
        int n = VoxSentence_GetNumPhrases(rule);
        int table = 0;
        if (0 < n) {
            unsigned char *pickBase = ispch_gPickSamples;
            short *choice = ispch_gChoice;
            do {
                int j;
                int ruleEntry;
                ruleEntry = iSPCH_GetOffset8(rule, rule + 4, table);
                j = 0;
                do {
                    unsigned int ruleType =
                        (unsigned int)(*(unsigned char *)(ruleEntry + j + 4) >> 4);
                    if (ruleType != 0xf) {
                        int tmp[4];
                        int r;
                        unsigned int rid;
'''

_TAIL = r'''
                    }
                    j = j + 1;
                } while (j < 4);
                table = table + 1;
                choice = choice + 6;
            } while (table < n);
        }
    }
}
'''

UNPACK = r'''                        rid = iSPCH_GetRuleID((int)sentence, (int)ruleType);
                        r = iSPCH_UnPackSample(*(int *)(*choice * 4 + gVoxBanks[0]),
                                                   (unsigned int)*(unsigned char *)
                                                       ((int)choice[4] + (int)pickBase), tmp);
'''


def V(call, extra_decl=''):
    return _HEAD + extra_decl + UNPACK + call + _TAIL


VARIANTS = {
    'base': V('''                        if (r != 0)
                            gSentenceRuleSet(
                                (int)(unsigned int)*(unsigned short *)sentence, (int)rid,
                                1 << ((unsigned char *)tmp)[0xc + j]);
'''),
    'fn_local_in_if': V('''                        if (r != 0) {
                            SentenceRuleSetFn fn = gSentenceRuleSet;
                            fn((int)(unsigned int)*(unsigned short *)sentence, (int)rid,
                               1 << ((unsigned char *)tmp)[0xc + j]);
                        }
'''),
    'fn_local_decl': V('''                        if (r != 0)
                            fn((int)(unsigned int)*(unsigned short *)sentence, (int)rid,
                               1 << ((unsigned char *)tmp)[0xc + j]);
''', '                        SentenceRuleSetFn fn = gSentenceRuleSet;\n'),
    'one_local': V('''                        if (r != 0) {
                            int one = 1;
                            gSentenceRuleSet(
                                (int)(unsigned int)*(unsigned short *)sentence, (int)rid,
                                one << ((unsigned char *)tmp)[0xc + j]);
                        }
'''),
    'byte_local': V('''                        if (r != 0) {
                            unsigned int bits = ((unsigned char *)tmp)[0xc + j];
                            gSentenceRuleSet(
                                (int)(unsigned int)*(unsigned short *)sentence, (int)rid,
                                1 << bits);
                        }
'''),
    'fn_and_one': V('''                        if (r != 0) {
                            SentenceRuleSetFn fn = gSentenceRuleSet;
                            int one = 1;
                            fn((int)(unsigned int)*(unsigned short *)sentence, (int)rid,
                               one << ((unsigned char *)tmp)[0xc + j]);
                        }
'''),
    'w0_call': V('''                        if (r != 0) {
                            do {
                                gSentenceRuleSet(
                                    (int)(unsigned int)*(unsigned short *)sentence, (int)rid,
                                    1 << ((unsigned char *)tmp)[0xc + j]);
                            } while (0);
                        }
'''),
    'arg0_local': V('''                        if (r != 0) {
                            int id = (int)(unsigned int)*(unsigned short *)sentence;
                            gSentenceRuleSet(id, (int)rid,
                                1 << ((unsigned char *)tmp)[0xc + j]);
                        }
'''),
}
