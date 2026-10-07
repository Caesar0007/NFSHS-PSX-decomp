/* Retail-console replacement for SN development-host file I/O.
 *
 * EAC's unchanged fileroot keeps the ABI references, but psxdevelopmentsystem() disables this
 * backend on a retail kernel.  Returning ordinary failure values makes an accidental attempt fail
 * closed instead of executing SN devkit break services.
 */

int PCinit(void) { return 0; }
int PCopen(const char *name, int mode, int perms)
{
    (void)name; (void)mode; (void)perms;
    return -1;
}
int PCcreat(const char *name, int perms)
{
    (void)name; (void)perms;
    return -1;
}
int PClseek(int fd, int offset, int mode)
{
    (void)fd; (void)offset; (void)mode;
    return -1;
}
int PCclose(int fd) { (void)fd; return 0; }
int PCread(int fd, int buffer, unsigned int length)
{
    (void)fd; (void)buffer; (void)length;
    return -1;
}
int PCwrite(int fd, int buffer, unsigned int length)
{
    (void)fd; (void)buffer; (void)length;
    return -1;
}

