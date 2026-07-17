struct S3 { int c[3]; char n[3], f[3], r[3]; };
extern S3 *g3;
extern int gi;
short q1, q2, q3;
void d1(void) { int t = (signed char)g3[gi].f[0]; t++; t--; q1 = t >> 1; }
void d2(void) { int t = (signed char)g3[gi].f[0]; q2 = t >> 1; q3 = (short)t; }
