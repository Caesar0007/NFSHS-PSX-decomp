extern int G[];
int gsum;
int f(int a, int b, int *p)
{
  int i, s = 0, t = G[0], u = a * b;
  for (i = 0; i < 10; i++) { s += p[i] * t; p[i] = s + u; }
  gsum = s;
  return s + t + u;
}
