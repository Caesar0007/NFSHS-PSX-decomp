"""Original CPP selection for native-symbol measurement, never output repair.

2026-11-02: PsyQ CPP preserves real trailing source lines that modern CPP
discards. GCC uses that EOF context for synthesized destructor end records.
Only the measured AIH_BTCCOP and SCREENCONGRATS symbol TUs use this route;
normal byte builds and all other native-symbol inputs keep existing commands.
SCREENCONGRATS proof: build/tmp/v/source_round_bi_20261102/. Before-tool
backup: that directory's symbol_cpp.before.py. This is a real whole-TU input
producer selection, never a post-compile or per-function output alteration.
"""
import hashlib
import os
from pathlib import Path

CPP43_SHA256 = '7becd3512121a037d6c413e35ec4d895c968ec2a52e84a24020e9e21e81a1919'
ORIGINAL_CPP_UNITS = frozenset({
    'recon/game/common/aih_btccop.cpp',
    'recon/frontend/common/screencongrats.cpp',
})


def resolve_cpp43(cc1pl, env=None):
    env = os.environ if env is None else env
    override = env.get('NFS4_CPPPSX')
    candidate = Path(override) if override else Path(cc1pl).parent/'CPPPSX.EXE'
    if not candidate.is_file():
        raise ValueError('Selected native-symbol TUs require original PsyQ4.3 '
                         'CPPPSX.EXE beside CC1PLPSX, or NFS4_CPPPSX; '
                         'normal byte-only builds do not require this tool.')
    if hashlib.sha256(candidate.read_bytes()).hexdigest() != CPP43_SHA256:
        raise ValueError('Wrong CPPPSX identity: require GNU2.8.0 SN32 Build4.0.0007')
    return candidate


def symbol_cpp_command(command, *, source, root, default_cpp, cc1pl, env=None):
    """Return an authentic whole-TU preprocessing command before compilation.

    No .i/.s/.o/SYM is edited. Unexpected selected-input command shapes fail
    closed, rather than silently omit a define/include or certify wrong EOF.
    """
    command = list(command)
    if source is None or Path(command[0]).resolve() != Path(default_cpp).resolve():
        return command
    root, source = Path(root).resolve(), Path(source).resolve()
    if source.relative_to(root).as_posix() not in ORIGINAL_CPP_UNITS:
        return command
    words = list(map(str, command))
    if (words[1:3] != ['-x', 'c'] or words.count('-o') != 1 or
            words[-2] != '-o' or Path(words[-3]).resolve() != source):
        raise ValueError('Unexpected native-symbol CPP command for '+str(source))
    cpp = resolve_cpp43(cc1pl, env)
    return [cpp, '-lang-c++', *command[3:-2], command[-1]]
