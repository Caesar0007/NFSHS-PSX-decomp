typedef unsigned short u_short;
struct S { int c[3]; char n[3], f[3], r[3]; };
extern S *g;
extern int gi;
u_short a1, a2, a3, a4;
void t1(void) { a1 = (u_short)((signed char)g[gi].f[0] >> 1); }
void t2(void) { signed char c = g[gi].f[0]; a2 = (u_short)(c >> 1); }
void t3(void) { short v = (signed char)g[gi].f[0]; a3 = (u_short)(v >> 1); }
void t4(void) { int v = (signed char)g[gi].f[0]; a4 = (u_short)(v >> 1); }
