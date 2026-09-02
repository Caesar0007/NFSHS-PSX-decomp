OLD = """  {
  int one = 1;
  __asm__ ("" : "=r" (one) : "0" (one));
  if (nNumber != one) {
  for (i = 1; i < nNumber; i++) {"""

VARIANTS = [
 ("A drop fence", OLD, """  {
  if (nNumber != 1) {
  for (i = 1; i < nNumber; i++) {"""),
 ("B guard !=1, i=1 separate stmt", OLD, """  {
  if (nNumber != 1) {
  i = 1;
  for (; i < nNumber; i++) {"""),
 ("C guard 1!=nNumber", OLD, """  {
  if (1 != nNumber) {
  for (i = 1; i < nNumber; i++) {"""),
 ("D guard nNumber^1", OLD, """  {
  if ((nNumber ^ 1) != 0) {
  for (i = 1; i < nNumber; i++) {"""),
 ("E while loop", OLD, """  {
  if (nNumber != 1) {
  i = 1;
  while (i < nNumber) {"""),
 ("F guard on i after i=1", OLD, """  {
  i = 1;
  if (nNumber != i) {
  for (; i < nNumber; i++) {"""),
]
