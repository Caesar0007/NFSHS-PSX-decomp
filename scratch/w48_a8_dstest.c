typedef void (*DslCB)(unsigned char intr, unsigned char *result);
#define ST_BSS __attribute__((section(".bss")))

/* V1: plain scalar */
static DslCB cb1 ST_BSS;
DslCB V1(DslCB f) { DslCB o = cb1; cb1 = f; return o; }

/* V2: unsized array view */
static DslCB cb2_d ST_BSS;
extern DslCB cb2_v[] asm("cb2_d");
DslCB V2(DslCB f) { DslCB o = cb2_v[0]; cb2_v[0] = f; return o; }

/* V3: unsized array view + pointer local */
static DslCB cb3_d ST_BSS;
extern DslCB cb3_v[] asm("cb3_d");
DslCB V3(DslCB f) { DslCB *p = cb3_v; DslCB o = *p; *p = f; return o; }

/* V4: sized [1] view */
static DslCB cb4_d ST_BSS;
extern DslCB cb4_v[1] asm("cb4_d");
DslCB V4(DslCB f) { DslCB o = cb4_v[0]; cb4_v[0] = f; return o; }

/* V5: pointer local, scalar addr */
static DslCB cb5 ST_BSS;
DslCB V5(DslCB f) { DslCB *p = &cb5; DslCB o = *p; *p = f; return o; }

/* V6: volatile scalar */
static volatile DslCB cb6 ST_BSS;
DslCB V6(DslCB f) { DslCB o = cb6; cb6 = f; return o; }

/* V7: unsized array view, volatile elements */
static DslCB cb7_d ST_BSS;
extern volatile DslCB cb7_v[] asm("cb7_d");
DslCB V7(DslCB f) { DslCB o = cb7_v[0]; cb7_v[0] = f; return o; }
