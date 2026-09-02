/* NFS4-R-AU REGION-ONLY @800A778C */
extern "C" unsigned char RDAT_80056830[]; /* [INFERRED] identity TBD */
extern "C" int RDAT_8013E5E8; /* [INFERRED] identity TBD; regional gp + 0xD80 */
extern "C" int RDAT_8013E5EC; /* [INFERRED] identity TBD; regional gp + 0xD84 */
int RDAT_8013E5E8;
int RDAT_8013E5EC;

extern "C" int func_800E5F14(void *, int, int);

extern "C" void func_800A778C(int count)
{
    RDAT_8013E5E8 = func_800E5F14(RDAT_80056830, count * 0x30, 0);
    RDAT_8013E5EC = 0;
}
