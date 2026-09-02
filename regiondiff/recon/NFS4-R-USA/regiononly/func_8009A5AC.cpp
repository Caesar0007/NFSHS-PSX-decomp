/* NFS4-R-USA region-only shutdown/reset pass @8009A5AC. */
int RDAT_8009A5AC_State0;
int RDAT_8009A5AC_State1;
int RDAT_8009A5AC_Handle;
int RDAT_8009A5AC_Read;
int RDAT_8009A5AC_Write;
short RDAT_8009A5AC_L;
short RDAT_8009A5AC_R;
short RDAT_8009A5AC_T;
short RDAT_8009A5AC_B;
extern "C" unsigned char RDAT_801131C8[];

extern "C" void func_8009A55C(void);
extern "C" void func_8009A29C(void);
extern "C" void func_800E77F0(int);
extern "C" void func_800E8A6C(int);
extern "C" void func_8009A068(void);
extern "C" void func_8009A0D0(void *);

extern "C" void func_8009A5AC(void)
{
    if (RDAT_8009A5AC_Write != RDAT_8009A5AC_Read) {
        func_8009A55C();
        while (RDAT_8009A5AC_Write != RDAT_8009A5AC_Read) {
            func_8009A29C();
            func_800E77F0(0);
        }
    }
    if (RDAT_8009A5AC_Handle != -1)
        func_800E8A6C(RDAT_8009A5AC_Handle);
    func_8009A068();
    RDAT_8009A5AC_Handle = -1;
    func_8009A0D0(RDAT_801131C8);
    RDAT_8009A5AC_State0 = 0;
    RDAT_8009A5AC_Read = 0;
    RDAT_8009A5AC_Write = 0;
    RDAT_8009A5AC_State1 = 0;
    RDAT_8009A5AC_L = 0;
    RDAT_8009A5AC_B = 0;
    RDAT_8009A5AC_R = 0;
    RDAT_8009A5AC_T = 0x7ffc;
}
