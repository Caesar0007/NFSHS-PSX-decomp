/* NFS4-R-AU REGION-ONLY @800A77C4 */
extern "C" int RDAT_8013E5E8; /* [INFERRED] identity TBD; regional gp + 0xD80 */
extern "C" int RDAT_8013E5EC; /* [INFERRED] identity TBD; regional gp + 0xD84 */
int RDAT_8013E5E8;
int RDAT_8013E5EC;

extern "C" int func_800E6118(int);

extern "C" void func_800A77C4(void)
{
    func_800E6118(RDAT_8013E5E8);
    RDAT_8013E5EC = 0;
}
