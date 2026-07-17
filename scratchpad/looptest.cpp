struct C3 { int x,y,z; };
extern int gRes;
void relD(C3 *n, C3 *rp, int xD, int yD, int zD, int *bd) {
  int rd;
  rd = (n->x/256)*(rp->x/256) + (n->y/256)*(rp->y/256) + (n->z/256)*(rp->z/256);
  rd = rd + (xD*bd[0] + yD*bd[1] + zD*bd[2]);
  gRes = rd;
}
void relE(C3 *n, C3 *rp, int xD, int yD, int zD, int *bd) {
  int rd, rd2;
  rd = (n->x/256)*(rp->x/256) + (n->y/256)*(rp->y/256) + (n->z/256)*(rp->z/256);
  rd2 = (xD*bd[0] + yD*bd[1] + zD*bd[2]) + rd;
  gRes = rd2;
}
