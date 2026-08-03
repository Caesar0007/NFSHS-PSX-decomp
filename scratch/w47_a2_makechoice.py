FN = 'iSPCH_SentenceMakeChoice'

PRELUDE = r'''
extern short ispch_gChoice[];
extern int VoxSentence_GetNumPhrases(int sentence);
extern int iSPCH_Rand(int n);
extern void iSPCH_RandomizeSentencePicks(int sentence);
extern int iSPCH_ChooseShortSentence(int sentence);
'''

_HEAD = r'''
int iSPCH_SentenceMakeChoice(int sentence, int mode)
{
    int ok = 0;
    if (mode == 1) {
        iSPCH_RandomizeSentencePicks(sentence);
        ok = iSPCH_ChooseShortSentence(sentence);
    } else {
        int n = VoxSentence_GetNumPhrases(sentence);
        int i = 0;
        if (ok < n) {
            ok = 1;
            sentence = (int)ispch_gChoice + i * 0xc;
'''

_TAIL = r'''
        }
    }
    return ok;
}
'''

BODY = r'''
                int r = iSPCH_Rand((int)*(short *)(sentence + 4));
                i = i + 1;
                *(short *)(sentence + 8) = *(unsigned short *)(sentence + 6) + (short)r;
                sentence = sentence + 0xc;
'''


def V(mid):
    return _HEAD + mid + _TAIL


VARIANTS = {
    'dowhile':   V('            do {\n' + BODY + '            } while (i < n);'),
    'goto':      V('top:\n            {\n' + BODY + '            }\n'
                   '            if (i < n) goto top;'),
    'goto_w0':   V('top:\n            {\n' + BODY + '            }\n'
                   '            do { if (i < n) goto top; } while (0);'),
    'goto_w0b':  V('top:\n            {\n' + BODY + '            }\n'
                   '            do { if (n > i) goto top; } while (0);'),
    'goto_w0d2': V('top:\n            {\n' + BODY + '            }\n'
                   '            do { do { if (i < n) goto top; } while (0); } while (0);'),
    'goto_guard_w0':
                 V('            do { if (ok < n) ok = 1; } while (0);\n'
                   'top:\n            {\n' + BODY + '            }\n'
                   '            if (i < n) goto top;'),
}
