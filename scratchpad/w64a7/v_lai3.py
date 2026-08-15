DECL_A = """static unsigned char *_actcur __attribute__((section(".bss")));"""
DECL_ARR = """static unsigned char *_actcur[1] __attribute__((section(".bss")));"""
ST_A = """            _actcur = cur;"""
ST_ARR = """            _actcur[0] = cur;"""
ANC_A = """            ac = &_actcur;"""
ANC_ARR = """            ac = _actcur;"""
ANC_ARR0 = """            ac = &_actcur[0];"""
ANC_CAST = """            ac = (unsigned char **)&_actcur;"""

ARRSET = [(DECL_A, DECL_ARR), (ST_A, ST_ARR)]

VARIANTS = [
    ("A control", []),
    ("V1 sized [1] + decay anchor", ARRSET + [(ANC_A, ANC_ARR)]),
    ("V2 sized [1] + &arr[0] anchor", ARRSET + [(ANC_A, ANC_ARR0)]),
    ("V3 scalar + cast anchor", [(ANC_A, ANC_CAST)]),
]
