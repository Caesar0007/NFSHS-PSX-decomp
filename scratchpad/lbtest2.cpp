typedef unsigned short u_short;
struct S2 { int c[3]; signed char n[3], f[3], r[3]; };
extern S2 *g2;
extern int gi2;
u_short b1, b2;
short b3;
void u1(void) { b1 = (u_short)(g2[gi2].f[0] >> 1); }
void u2(void) { b2 = (u_short)((int)g2[gi2].f[0] >> 1); }
void u3(void) { b3 = (short)(g2[gi2].f[0] >> 1); }
