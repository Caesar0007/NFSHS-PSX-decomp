extern int g[2];
extern int ch;
extern int (*fp)(unsigned char *);
int f(unsigned char *info)
{
    if (g[ch] > 0) { do { fp(0); } while (g[ch] > 0); }
    return 1;
}
