extern int CD_cbsync[];
extern int CD_syncsync[];
int CdSync(int mode, unsigned char *result)
{
    if (mode == 0) { CD_cbsync[0] = 0; }
    return CD_syncsync[0];
}
