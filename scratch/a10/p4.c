int gsmall;
int gbig[64];
static int ssmall;
extern int esmall;
int f(int a){ gsmall = a; ssmall = a; return gsmall + gbig[0] + ssmall + esmall; }
