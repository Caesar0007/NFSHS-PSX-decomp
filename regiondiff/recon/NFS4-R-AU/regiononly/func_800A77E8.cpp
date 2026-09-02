/* NFS4-R-AU REGION-ONLY @800A77E8 */
extern "C" int RDAT_8013E5E8; /* [INFERRED] identity TBD; regional gp + 0xD80 */
extern "C" int RDAT_8013E5EC; /* [INFERRED] identity TBD; regional gp + 0xD84 */
int RDAT_8013E5E8;
int RDAT_8013E5EC;

extern "C" int func_800A77E8(void)
{
    int index;

    index = RDAT_8013E5EC;
    RDAT_8013E5EC = index + 1;
    return RDAT_8013E5E8 + index * 0x30;
}
