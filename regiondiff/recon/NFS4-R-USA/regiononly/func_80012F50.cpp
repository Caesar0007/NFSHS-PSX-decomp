/* NFS4-R-USA region-only car-render setup helper @0x80012F50. */
struct RDAT_80012F50_Locals {
    unsigned char rotation[40];
    int vector[3];
    int pad;
    int scale[9];
};

extern "C" int RDAT_8005174C[];
extern "C" void func_800E2544(void);
extern "C" void func_800E25D4(int, int, int, int);
extern "C" void func_800E66B0(void *, int);
extern "C" void func_8009E850(int *, void *, void *);
extern "C" void func_800E4F44(void *, void *);
extern "C" void func_800EB834(int *, void *, void *);
extern "C" void func_800E12A4(void);
extern "C" void func_800B3850(void *);

extern "C" void func_80012F50(void *object, int screenX, int screenY,
                                int tableIndex, int tableDelta, int angle,
                                float width, float height)
{
    RDAT_80012F50_Locals locals;
    int *tableBase;
    int *tableEntry;
    void *matrix0;
    void *matrix1;

    func_800E2544();
    func_800E25D4(screenX - 0x100, screenY - 0x80, 0x200, 0x100);
    tableBase = RDAT_8005174C;
    tableEntry = tableBase + tableIndex;
    *tableEntry += tableDelta;
    func_800E66B0(locals.rotation, angle);

    matrix0 = (unsigned char *)object + 0x14;
    locals.scale[0] = 0x10000;
    locals.scale[1] = 0;
    locals.scale[2] = 0;
    locals.scale[3] = 0;
    locals.scale[4] = 0x10000;
    locals.scale[5] = 0;
    locals.scale[6] = 0;
    locals.scale[7] = 0;
    locals.scale[8] = 0x10000;
    locals.scale[4] = 0x8980;
    func_8009E850(locals.scale, locals.rotation, matrix0);

    matrix1 = (unsigned char *)object + 0x44;
    func_800E4F44(matrix0, matrix1);
    locals.vector[0] = 0;
    locals.vector[1] = (int)(width * 65536.0f);
    locals.vector[2] = (int)(height * 65536.0f);
    func_800EB834(locals.vector, matrix0, (unsigned char *)object + 8);

    locals.vector[0] = -*(int *)((unsigned char *)object + 8);
    locals.vector[1] = -*(int *)((unsigned char *)object + 0xc);
    locals.vector[2] = -*(int *)((unsigned char *)object + 0x10);
    func_800EB834(locals.vector, matrix1, (unsigned char *)object + 0x38);
    func_800E12A4();
    *(int *)0x1f80008c = 0x404040;
    func_800B3850(object);
}
