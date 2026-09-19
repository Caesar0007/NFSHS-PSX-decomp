"""Read-only access to the project-owned DuckStation's exported 2 MiB RAM.

DuckStation bus.cpp: RAM_OFFSET=0; memmap.cpp: name=duckstation_<pid>.
OpenFileMapping deliberately never creates a missing mapping. The caller must
hold the emulator stopped through GDB for a coherent audit snapshot.
"""
import ctypes
from ctypes import wintypes as w
import json
from pathlib import Path

RAM_SIZE = 0x200000


def ram_offset(address, size):
    if size < 0:
        raise ValueError('Negative memory size')
    for base in (0, 0x80000000, 0xA0000000):
        if base <= address < base + RAM_SIZE and address + size <= base + RAM_SIZE:
            return address - base
    return None


class SharedRAM:
    def __init__(self, host, port):
        self.view = self.handle = self.process = None
        root = Path(__file__).resolve().parents[2]
        record = json.loads((root/'status/runtime/duckstation-process.json').read_text(encoding='utf-8-sig'))
        if host != '127.0.0.1' or port != record['port']:
            raise OSError('Shared RAM is limited to the project GDB endpoint')
        self.pid = int(record['pid'])
        self.name = f'duckstation_{self.pid}'
        self.k = k = ctypes.WinDLL('kernel32', use_last_error=True)
        for name, args, result in (
            ('OpenFileMappingW', [w.DWORD,w.BOOL,w.LPCWSTR], w.HANDLE),
            ('MapViewOfFile', [w.HANDLE,w.DWORD,w.DWORD,w.DWORD,ctypes.c_size_t], ctypes.c_void_p),
            ('UnmapViewOfFile', [ctypes.c_void_p], w.BOOL),
            ('CloseHandle', [w.HANDLE], w.BOOL),
            ('OpenProcess', [w.DWORD,w.BOOL,w.DWORD], w.HANDLE),
            ('QueryFullProcessImageNameW', [w.HANDLE,w.DWORD,w.LPWSTR,ctypes.POINTER(w.DWORD)], w.BOOL),
            ('WaitForSingleObject', [w.HANDLE,w.DWORD], w.DWORD)):
            fn = getattr(k,name); fn.argtypes=args; fn.restype=result
        try:
            self.process = k.OpenProcess(0x100000 | 0x1000, False, self.pid)
            if not self.process:
                raise ctypes.WinError(ctypes.get_last_error())
            path = ctypes.create_unicode_buffer(32768); length = w.DWORD(len(path))
            if not k.QueryFullProcessImageNameW(self.process, 0, path, ctypes.byref(length)):
                raise ctypes.WinError(ctypes.get_last_error())
            allowed = {
                (root/'tools/duckstation'/runtime/'duckstation-qt-x64-ReleaseLTCG.exe').resolve()
                for runtime in ('runtime', 'api-runtime')
            }
            expected = Path(record['executable']).resolve()
            if expected not in allowed or Path(path.value).resolve() != expected:
                raise OSError('Project DuckStation PID was reused')
            # Validate the live listener, not just the launcher record.
            ip = ctypes.WinDLL('iphlpapi').GetExtendedTcpTable
            ip.argtypes = [ctypes.c_void_p,ctypes.POINTER(w.DWORD),w.BOOL,w.ULONG,w.ULONG,w.ULONG]
            ip.restype = w.DWORD
            length = w.DWORD(0)
            ip(None,ctypes.byref(length),False,2,3,0)  # AF_INET, OWNER_PID_LISTENER
            table = ctypes.create_string_buffer(length.value)
            if ip(table,ctypes.byref(length),False,2,3,0):
                raise OSError('Cannot verify GDB listener owner')
            import struct, socket
            rows = [struct.unpack_from('<6I',table,4+i*24) for i in range(struct.unpack_from('<I',table)[0])]
            if not any(row[1] == 0x0100007f and socket.ntohs(row[2]&65535) == port and row[5] == self.pid for row in rows):
                raise OSError('GDB listener owner mismatch')
            self.handle = k.OpenFileMappingW(4,False,self.name)  # FILE_MAP_READ
            if not self.handle:
                raise ctypes.WinError(ctypes.get_last_error())
            self.view = k.MapViewOfFile(self.handle,4,0,0,RAM_SIZE)
            if not self.view:
                raise ctypes.WinError(ctypes.get_last_error())
        except Exception:
            self.close()
            raise

    def read(self, address, size):
        offset = ram_offset(address,size)
        if offset is None:
            raise ValueError('Outside the first 2 MiB of PSX RAM')
        if not self.view or self.k.WaitForSingleObject(self.process,0) != 258:
            raise OSError('DuckStation mapping owner is no longer running')
        return ctypes.string_at(self.view+offset,size)

    def close(self):
        if self.view:
            self.k.UnmapViewOfFile(self.view); self.view=None
        for attr in ('handle','process'):
            if getattr(self,attr):
                self.k.CloseHandle(getattr(self,attr)); setattr(self,attr,None)
