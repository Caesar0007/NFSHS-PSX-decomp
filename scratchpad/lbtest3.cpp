typedef unsigned short u_short;
struct S3 { int c[3]; char n[3], f[3], r[3]; };
extern S3 *g3;
extern int gi3;
extern int fm(int,int);
u_short c1;
short c2;
void w1(void) {
  u_short fx; short v0x;
  fx = (u_short)((signed char)g3[gi3].f[0] >> 1);
  fm(1,2); fm(3,4);
  v0x = 100 - fx;
  c2 = v0x;
  c1 = fx + 3;
}
