FN = 'iSPCH_OrderSentences'

PRELUDE = r'''
extern int iSPCH_GetOffset16(int base, int tableBase, int index);
extern int iSPCH_Rand(int n);
'''

_HEAD = r'''
void iSPCH_OrderSentences(int event, int outOrder)
{
    unsigned char  weights[104];
    unsigned int   n = (unsigned int)*(unsigned char *)(event + 6);
    int            total = 0;
    int            j = 0;
    int            i;
'''

_MID = r'''
    i = 0;
    if (0 < total) {
        do {
            int r = iSPCH_Rand(total);
            j = 0;
            if (n != 0) {
                while (1) {
                    r = r - (int)(unsigned int)weights[j];
                    if (r < 0)
                        break;
                    j = j + 1;
                    if (!(j < (int)n))
                        break;
                }
            }
            *(char *)(outOrder + i) = (char)j;
            i = i + 1;
            total = total - (int)(unsigned int)weights[j];
            weights[j] = 0;
        } while (0 < total);
    }
    j = 0;
'''

_P3 = r'''
    if (n != 0) {
        do {
            char *p3;
            p3 = (char *)iSPCH_GetOffset16(event, event + 0xc, j);
            if (*p3 == '\0') {
                *(char *)(outOrder + i) = (char)j;
                i = i + 1;
            }
            j = j + 1;
        } while (j < (int)n);
    }
}
'''


def V(phase1, p3=None, decl=''):
    return (_HEAD + decl + '    if (n != 0) {\n        do {\n' + phase1
            + '        } while (j < (int)n);\n    }\n' + _MID + (p3 or _P3))


P1_BASE = r'''            unsigned char *p;
            p = (unsigned char *)iSPCH_GetOffset16(event, event + 0xc, j);
            weights[j] = *p;
            j = j + 1;
            total = total + (int)(unsigned int)*p;
'''

P1_SHARED = r'''            p = (unsigned char *)iSPCH_GetOffset16(event, event + 0xc, j);
            weights[j] = *p;
            j = j + 1;
            total = total + (int)(unsigned int)*p;
'''

P3_SHARED = r'''
    if (n != 0) {
        do {
            p = (unsigned char *)iSPCH_GetOffset16(event, event + 0xc, j);
            if (*p == '\0') {
                *(char *)(outOrder + i) = (char)j;
                i = i + 1;
            }
            j = j + 1;
        } while (j < (int)n);
    }
}
'''

VARIANTS = {
    'base': V(P1_BASE),
    'shared_p_fnscope': V(P1_SHARED, P3_SHARED, decl='    unsigned char *p;\n'),
    'p_int_shared': V(
        r'''            p = (unsigned char *)iSPCH_GetOffset16(event, event + 0xc, j);
            weights[j] = *p;
            j = j + 1;
            total = total + (int)(unsigned int)*p;
''', P3_SHARED, decl='    unsigned char *p;\n'),
    'byte_temp': V(r'''            unsigned char *p;
            unsigned int b;
            p = (unsigned char *)iSPCH_GetOffset16(event, event + 0xc, j);
            b = *p;
            weights[j] = (unsigned char)b;
            j = j + 1;
            total = total + (int)(unsigned int)*p;
'''),
    'store_after_total': V(r'''            unsigned char *p;
            p = (unsigned char *)iSPCH_GetOffset16(event, event + 0xc, j);
            total = total + (int)(unsigned int)*p;
            weights[j] = *p;
            j = j + 1;
'''),
    'idx_after': V(r'''            unsigned char *p;
            p = (unsigned char *)iSPCH_GetOffset16(event, event + 0xc, j);
            weights[j] = *p;
            total = total + (int)(unsigned int)*p;
            j = j + 1;
'''),
    'refdial_w0': V(r'''            unsigned char *p;
            p = (unsigned char *)iSPCH_GetOffset16(event, event + 0xc, j);
            do { weights[j] = *p; } while (0);
            j = j + 1;
            total = total + (int)(unsigned int)*p;
'''),
    'refdial_w0_both': V(r'''            unsigned char *p;
            p = (unsigned char *)iSPCH_GetOffset16(event, event + 0xc, j);
            do { weights[j] = *p; j = j + 1; total = total + (int)(unsigned int)*p; } while (0);
'''),
    'refdial_w0_total': V(r'''            unsigned char *p;
            p = (unsigned char *)iSPCH_GetOffset16(event, event + 0xc, j);
            weights[j] = *p;
            j = j + 1;
            do { total = total + (int)(unsigned int)*p; } while (0);
'''),
    'goto_loop': (_HEAD + '    if (n != 0) {\n'
                  '        top1:\n        {\n' + P1_BASE + '        }\n'
                  '        if (j < (int)n) goto top1;\n    }\n' + _MID + _P3),
}
