/* NFS4-R-AU initial memory-card check. */
extern "C" int RDAT_800279A0_StateA[];
extern "C" int RDAT_800279A0_StateB[];
extern "C" int RDAT_800279A0_StateC[];
extern "C" int RDAT_800279A0_CardReady[];
extern "C" int RDAT_800279A0_Enabled[];
extern "C" unsigned char RDAT_800279A0_Language[];
extern "C" unsigned char RDAT_800279A0_Records[];

extern "C" void func_800A5130(void);
extern "C" void func_8004B17C(void *, int);
extern "C" void func_800276A0(void);
extern "C" void func_8003484C(int, int);
extern "C" short func_80034F84(int, int, int);
extern "C" void func_800349B4(void);

void Front_InitialMemCardCheck(void)
{
    RDAT_800279A0_StateA[0] = 0;
    RDAT_800279A0_StateB[0] = 0;
    RDAT_800279A0_StateC[0] = 0;
    RDAT_800279A0_CardReady[0] = 0;
    func_800A5130();
    RDAT_800279A0_Enabled[0] = 1;
    func_8004B17C(RDAT_800279A0_Records, 0);
    func_800276A0();
    func_8003484C(0, 0);
    RDAT_800279A0_CardReady[0] = func_80034F84(0, 0, 0) == 0;
    func_800349B4();
    if (RDAT_800279A0_CardReady[0] == 0)
        RDAT_800279A0_Language[0] = 0xff;
}
