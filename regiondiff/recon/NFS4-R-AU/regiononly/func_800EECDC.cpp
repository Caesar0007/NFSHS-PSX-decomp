/* NFS4-R-AU REGION-ONLY @800EECDC */
struct RDAT_800EECDC_Result {
    unsigned char pad0[3];
    unsigned char state;
    int value;
    int tail;
};

struct RDAT_800EECDC_Coord {
    short x;
    short y;
};

extern "C" int func_800EF350(short, short);

extern "C" void func_800EECDC(RDAT_800EECDC_Result *result,
                                RDAT_800EECDC_Coord *coord)
{
    result->state = 2;
    result->value = func_800EF350(coord->x, coord->y);
    result->tail = 0;
}
