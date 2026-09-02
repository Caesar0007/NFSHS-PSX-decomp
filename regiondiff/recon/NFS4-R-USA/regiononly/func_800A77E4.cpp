/* NFS4-R-USA REGION-ONLY @800A77E4 */
extern "C" int RDAT_8013E5BC; /* [INFERRED] identity TBD; regional gp + 0xD80 */
extern "C" int RDAT_8013E5C0; /* [INFERRED] identity TBD; regional gp + 0xD84 */
int RDAT_8013E5BC;
int RDAT_8013E5C0;

extern "C" int func_800A77E4(void)
{
    int index;

    index = RDAT_8013E5C0;
    RDAT_8013E5C0 = index + 1;
    return RDAT_8013E5BC + index * 0x30;
}
