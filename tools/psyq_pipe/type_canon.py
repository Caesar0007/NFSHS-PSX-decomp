"""type_canon.py -- canonical form of a struct/class/union body, for deciding whether two spellings define the same type.

Canonicalisation (semantics-preserving for member layout, member types and debug records):
  * comments and whitespace dropped, tokens rejoined with single spaces;
  * the unsigned shorthands u_char/u_short/u_int/u_long/ushort expanded to their SYS/TYPES.H meaning;
  * elaborated `struct X` / `union X` / `enum X` inside member types reduced to `X` (C++ sees the same type);
  * every data-member declaration split to one declarator per declaration (`int a, *b[2];` -> `int a; int *b[2];`).
Members containing parentheses or braces (functions, nested definitions) are kept as token strings.
"""
import re

ALIAS = {'u_char': ['unsigned', 'char'], 'u_short': ['unsigned', 'short'], 'u_int': ['unsigned', 'int'],
         'u_long': ['unsigned', 'long'], 'ushort': ['unsigned', 'short']}
TOK = re.compile(r'[A-Za-z_]\w*|0[xX][0-9a-fA-F]+|\d+|::|->|<<|>>|[^\s\w]')


def _mask(t):
    return re.sub(r'/\*.*?\*/|//[^\n]*', ' ', t, flags=re.S)


def _split_depth0(toks, sep):
    out, cur, d = [], [], 0
    for tk in toks:
        if tk in '([{':
            d += 1
        elif tk in ')]}':
            d -= 1
        if tk == sep and d == 0:
            out.append(cur)
            cur = []
        else:
            cur.append(tk)
    if cur:
        out.append(cur)
    return out


def _declarator(group):
    """Split a declarator group into (prefix, stars, name, suffix): name = last identifier followed only by [..]."""
    i = len(group) - 1
    suffix = []
    while i >= 0 and group[i] == ']':
        # walk back over a [...] group
        j = i
        d = 0
        while j >= 0:
            if group[j] == ']':
                d += 1
            elif group[j] == '[':
                d -= 1
                if d == 0:
                    break
            j -= 1
        suffix = group[j:i + 1] + suffix
        i = j - 1
    if i < 0 or not re.match(r'[A-Za-z_]\w*$', group[i]):
        return None
    name = group[i]
    k = i - 1
    stars = []
    while k >= 0 and group[k] in ('*', '&'):
        stars.insert(0, group[k])
        k -= 1
    return group[:k + 1], stars, name, suffix


def canon(body):
    toks = TOK.findall(_mask(body))
    # expand aliases
    ex = []
    for tk in toks:
        ex.extend(ALIAS.get(tk, [tk]))
    toks = ex
    # head: everything up to the first '{'
    h = toks.index('{')
    head, inner = toks[:h], toks[h + 1:]
    # drop the final '}' ';'
    while inner and inner[-1] in (';', '}'):
        last = inner.pop()
        if last == '}':
            break
    members = _split_depth0(inner, ';')
    out = []
    for m in members:
        if not m:
            continue
        if any(t in m for t in ('(', '{')) or m[0] in ('public', 'private', 'protected') or ':' in m:
            out.append(' '.join(m))
            continue
        # drop elaborated keywords inside member types
        m = [t for idx, t in enumerate(m) if not (t in ('struct', 'union', 'enum', 'class') and idx + 1 < len(m) and re.match(r'[A-Za-z_]', m[idx + 1]))]
        groups = _split_depth0(m, ',')
        first = _declarator(groups[0])
        if first is None:
            out.append(' '.join(m))
            continue
        base = first[0]
        decls = [first] + [_declarator(g) for g in groups[1:]]
        if any(d is None for d in decls):
            out.append(' '.join(m))
            continue
        for d in decls:
            out.append(' '.join(base + d[1] + [d[2]] + d[3]))
    return ' '.join(head) + ' { ' + ' ; '.join(out) + ' ; } ;'


if __name__ == '__main__':
    a = 'struct K { u_short previouscode, code;\n char kernvalue;\n char pad[3]; };'
    b = 'struct K {\n    unsigned short previouscode,code; char kernvalue, pad[3];\n};'
    print(canon(a))
    print(canon(b))
    print(canon(a) == canon(b))
