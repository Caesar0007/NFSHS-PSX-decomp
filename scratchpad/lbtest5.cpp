struct S2 { int c[3]; signed char n[3], f[3], r[3]; };
struct S3 { int c[3]; char n[3], f[3], r[3]; };
extern S2 *g2; extern S3 *g3;
extern int gi;
int p1(void) { return g2[gi].f[0]; }
int p2(void) { return (signed char)g3[gi].f[0]; }
int p3(void) { return g2[gi].f[0] >> 1; }
short q1;
void p4(void) { q1 = g2[gi].f[0] >> 1; }
int p5(void) { int t = g2[gi].f[0]; return t >> 1; }
