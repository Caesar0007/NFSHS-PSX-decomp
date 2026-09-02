/* NFS4-R-JPN region-only primitive-marking pass @800BB0A8. */
struct RDAT_800BB0A8_Result {
    unsigned char data[120];
    unsigned char *prim;
    unsigned char tail[12];
};
struct RDAT_800BB0A8_Vector { int x; int y; int z; };
struct RDAT_800BB0A8_Point { short x; short z; };

extern "C" RDAT_800BB0A8_Point RDAT_8011F1FC[];
extern "C" void func_8007F788(int, RDAT_800BB0A8_Result *);
extern "C" void func_800804E8(RDAT_800BB0A8_Vector *, RDAT_800BB0A8_Result *, int);

extern "C" void func_800BB0A8(int disabled)
{
    RDAT_800BB0A8_Result result;
    RDAT_800BB0A8_Vector point;
    int i;

    if (disabled == 0) {
        func_8007F788(0, &result);
        for (i = 0; (RDAT_8011F1FC[i].x != -1) || (RDAT_8011F1FC[i].z != -1); i++) {
            point.x = RDAT_8011F1FC[i].x << 16;
            point.y = 0;
            point.z = RDAT_8011F1FC[i].z << 16;
            func_800804E8(&point, &result, 1);
            if (result.prim != 0)
                *result.prim |= 0x80;
        }
    }
}
