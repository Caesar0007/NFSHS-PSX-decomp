extern int CD_cbsync[];
extern void other(int);
int CdFlush(int mode)
{
    other(mode);
    if (mode) CD_cbsync[0] = mode;
    return CD_cbsync[0];
}
