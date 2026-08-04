ANCHOR = """    volatile int *saved = &_cdr.w28;
    CdSyncCallback(*saved);      /* restore saved sync callback */
    _cdr.w24 = 0;                /* reading = 0 */"""

VARIANTS = [
 ("A plain member",
  """    CdSyncCallback(_cdr.w28);
    _cdr.w24 = 0;"""),
 ("B ptr-local (current)",
  """    volatile int *saved = &_cdr.w28;
    CdSyncCallback(*saved);
    _cdr.w24 = 0;"""),
 ("C ptr-local split load",
  """    volatile int *saved = &_cdr.w28;
    int cb = *saved;
    CdSyncCallback(cb);
    _cdr.w24 = 0;"""),
 ("D struct-ptr anchored at w28",
  """    volatile CdrEnv *g = (volatile CdrEnv *)((char *)&_cdr + 0x28);
    CdSyncCallback(g->w00);
    _cdr.w24 = 0;"""),
 ("E non-volatile ptr-local",
  """    int *saved = (int *)&_cdr.w28;
    CdSyncCallback(*saved);
    _cdr.w24 = 0;"""),
 ("F ptr-local + ptr reused for store",
  """    volatile int *saved = &_cdr.w28;
    CdSyncCallback(*saved);
    ((volatile CdrEnv *)(saved - 10))->w24 = 0;"""),
 ("G ptr-local, store via _cdr, extra deref",
  """    volatile int *saved = &_cdr.w28;
    int cb;
    cb = *saved;
    CdSyncCallback(cb);
    _cdr.w24 = 0;
    (void)saved;"""),
 ("H two ptr locals",
  """    volatile int *saved = &_cdr.w28;
    volatile CdrEnv *g = &_cdr;
    CdSyncCallback(*saved);
    g->w24 = 0;"""),
 ("I ptr-local decl'd volatile ptr",
  """    volatile int *volatile saved = &_cdr.w28;
    CdSyncCallback(*saved);
    _cdr.w24 = 0;"""),
 ("J array-view of w28",
  """    CdSyncCallback((&_cdr.w28)[0]);
    _cdr.w24 = 0;"""),
]
