/* NFS4-R-USA region-only allocator @800702E4. */
struct RDAT_800702E4_State {
    unsigned char data[0xA0];
};

extern "C" RDAT_800702E4_State RDAT_8010EA70[];
extern "C" int RDAT_8010F0B0[];

extern "C" void *func_800702E4(void)
{
    int i;

    for (i = 0; i < 10; i++) {
        if (RDAT_8010F0B0[i] == 0) {
            RDAT_8010F0B0[i] = 1;
            return &RDAT_8010EA70[i];
        }
    }
    return 0;
}
