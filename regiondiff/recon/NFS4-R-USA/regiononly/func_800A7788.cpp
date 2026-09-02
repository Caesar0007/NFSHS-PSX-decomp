/* NFS4-R-USA REGION-ONLY @800A7788 */
extern "C" unsigned char RDAT_80056830[]; /* [INFERRED] identity TBD */
extern "C" int RDAT_8013E5BC; /* [INFERRED] identity TBD; regional gp + 0xD80 */
extern "C" int RDAT_8013E5C0; /* [INFERRED] identity TBD; regional gp + 0xD84 */
int RDAT_8013E5BC;
int RDAT_8013E5C0;

extern "C" int func_800E5F28(void *, int, int);

extern "C" void func_800A7788(int count)
{
    RDAT_8013E5BC = func_800E5F28(RDAT_80056830, count * 0x30, 0);
    RDAT_8013E5C0 = 0;
}
