extern int Cdinfo[];
extern int g_currentthread[];
extern void other(int);
int f(int a)
{
    if (Cdinfo[0] & 0x10) {
        if (g_currentthread[0] == 2) { other(a); return 1; }
    }
    return 0;
}
