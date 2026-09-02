/* NFS4-R-AU region-only car-render setup helper @0x80012F6C. */
struct RDAT_80012F6C_Locals {
    unsigned char rotation[40];
    int vector[3];
    int pad;
    int scale[9];
};

extern "C" int RDAT_80051804[];
extern "C" void func_800E2570(void);
extern "C" void func_800E2600(int, int, int, int);
extern "C" void func_800E669C(void *, int);
extern "C" void func_8009E854(int *, void *, void *);
extern "C" void func_800E4F30(void *, void *);
extern "C" void func_800EB820(int *, void *, void *);
extern "C" void func_800E12D0(void);
extern "C" void func_800B3854(void *);

/* The retail body starts four bytes into its object and its following sibling
 * is eight-byte aligned.  These source-level carriers preserve that TU-local
 * text padding when this one regional function is compiled in isolation. */
extern "C" const unsigned int RDAT_80012F6C_TextLead
    __attribute__((section(".text"))) = 0;

extern "C" void func_80012F6C(void *object, int screenX, int screenY,
                                int tableIndex, int tableDelta, int angle,
                                float width, float height)
{
    RDAT_80012F6C_Locals locals;
    int *tableBase;
    int *tableEntry;
    void *matrix0;
    void *matrix1;

    func_800E2570();
    screenY -= 0x88;
    func_800E2600(screenX - 0x100, screenY, 0x200, 0x100);
    tableBase = RDAT_80051804;
    tableEntry = tableBase + tableIndex;
    *tableEntry += tableDelta;
    func_800E669C(locals.rotation, angle);

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
    locals.scale[4] = 0xad80;
    func_8009E854(locals.scale, locals.rotation, matrix0);

    matrix1 = (unsigned char *)object + 0x44;
    func_800E4F30(matrix0, matrix1);
    locals.vector[0] = 0;
    locals.vector[1] = (int)(width * 65536.0f);
    locals.vector[2] = (int)(height * 65536.0f);
    func_800EB820(locals.vector, matrix0, (unsigned char *)object + 8);

    locals.vector[0] = -*(int *)((unsigned char *)object + 8);
    locals.vector[1] = -*(int *)((unsigned char *)object + 0xc);
    locals.vector[2] = -*(int *)((unsigned char *)object + 0x10);
    func_800EB820(locals.vector, matrix1, (unsigned char *)object + 0x38);
    func_800E12D0();
    *(int *)0x1f80008c = 0x404040;
    func_800B3854(object);
}

extern "C" const unsigned int RDAT_80012F6C_AlignedTail
    __attribute__((section(".text"), aligned(8))) = 0;
