/* NFS4-R-AU region-only shutdown/reset pass @8009A5B0. */
int RDAT_8009A5B0_State0;
int RDAT_8009A5B0_State1;
int RDAT_8009A5B0_Handle;
int RDAT_8009A5B0_Read;
int RDAT_8009A5B0_Write;
short RDAT_8009A5B0_L;
short RDAT_8009A5B0_R;
short RDAT_8009A5B0_T;
short RDAT_8009A5B0_B;
extern "C" unsigned char RDAT_801131F4[];

extern "C" void func_8009A560(void);
extern "C" void func_8009A2A0(void);
extern "C" void func_800E77DC(int);
extern "C" void func_800E8A58(int);
extern "C" void func_8009A06C(void);
extern "C" void func_8009A0D4(void *);

extern "C" void func_8009A5B0(void)
{
    if (RDAT_8009A5B0_Write != RDAT_8009A5B0_Read) {
        func_8009A560();
        while (RDAT_8009A5B0_Write != RDAT_8009A5B0_Read) {
            func_8009A2A0();
            func_800E77DC(0);
        }
    }
    if (RDAT_8009A5B0_Handle != -1)
        func_800E8A58(RDAT_8009A5B0_Handle);
    func_8009A06C();
    RDAT_8009A5B0_Handle = -1;
    func_8009A0D4(RDAT_801131F4);
    RDAT_8009A5B0_State0 = 0;
    RDAT_8009A5B0_Read = 0;
    RDAT_8009A5B0_Write = 0;
    RDAT_8009A5B0_State1 = 0;
    RDAT_8009A5B0_L = 0;
    RDAT_8009A5B0_B = 0;
    RDAT_8009A5B0_R = 0;
    RDAT_8009A5B0_T = 0x7ffc;
}
