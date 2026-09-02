/* NFS4-R-USA REGION-ONLY @800A77C0 */
extern "C" int RDAT_8013E5BC; /* [INFERRED] identity TBD; regional gp + 0xD80 */
extern "C" int RDAT_8013E5C0; /* [INFERRED] identity TBD; regional gp + 0xD84 */
int RDAT_8013E5BC;
int RDAT_8013E5C0;

extern "C" int func_800E612C(int);

extern "C" void func_800A77C0(void)
{
    func_800E612C(RDAT_8013E5BC);
    RDAT_8013E5C0 = 0;
}
