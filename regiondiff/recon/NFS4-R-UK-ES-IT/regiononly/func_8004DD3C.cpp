/* NFS4-R-UK-ES-IT region-only frontend draw helper @0x8004DD3C. */
struct RDAT_8004DD3C_Point {
    short x;
    short y;
};

extern "C" int RDAT_8013EAC8[];
extern "C" RDAT_8004DD3C_Point RDAT_800532F4[];
extern "C" void func_800EECDC(unsigned int *, RDAT_8004DD3C_Point *);

extern "C" void func_8004DD3C(short x, int y)
{
    unsigned int **packetTail = (unsigned int **)0x1f800004;
    RDAT_8004DD3C_Point *point = RDAT_800532F4;
    unsigned int addressMask = 0x00ffffff;
    unsigned int highMask = ~addressMask;
    unsigned int *packet;
    unsigned int *ordering;
    unsigned int address;
    unsigned int packetTag;
    unsigned int orderingTag;

    point->x = x;
    point->y = y + RDAT_8013EAC8[0] * 0x100;
    packet = *packetTail;
    ordering = *(unsigned int **)0x1f800000;
    packetTag = (*packet & highMask) | (*ordering & addressMask);
    *packet = packetTag;
    orderingTag = *ordering;
    *packetTail = packet + 3;
    address = (unsigned int)packet & addressMask;
    *ordering = (orderingTag & highMask) | (address & addressMask);
    func_800EECDC(packet, point);
}

