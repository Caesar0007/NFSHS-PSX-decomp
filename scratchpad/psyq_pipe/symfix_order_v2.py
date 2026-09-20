"""symfix_order_v2.py -- teach symfix_order.py three more shapes:
  * a scope may open with the `if (0) sprintf(... "SimpleMem")` literal carrier: the declaration run starts after it;
  * a declaration with a brace initialiser (`static char t[25] = { ... };`) may span lines;
  * a local retail does not have (a carrier) stays where it is relative to its predecessor: it is ranked right after the
    declaration it followed."""
R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
p = R + 'scratchpad/psyq_pipe/symfix_order.py'
s = open(p, encoding='utf-8').read()
assert 'SimpleMem' not in s
k = "        items, cur_lead, j, ic = [], [], s0, False" + NL
assert s.count(k) == 1
s = s.replace(k, k + "        while j <= end and (not lines[j].strip() or ('if (0)' in lines[j] and 'SimpleMem' in lines[j])):" + NL +
              "            j += 1          # skip the literal-carrier statement (and blank lines around it)" + NL + "        s0 = j" + NL)
k = "            while ';' not in joined and '{' not in joined and '}' not in joined and k + 1 <= end and k - j < 6:" + NL
assert s.count(k) == 1
s = s.replace(k, "            while ((';' not in joined and '{' not in joined and '}' not in joined) or" + NL +
              "                   ('=' in joined and joined.count('{') > joined.count('}')) or" + NL +
              "                   ('=' in joined and '{' in joined and ';' not in joined.rsplit('}', 1)[-1])) and k + 1 <= end and k - j < 40:" + NL)
k = "            m = DECL.match(re.sub(r'/\\*.*?\\*/', ' ', joined.replace('\\n', ' ')) if True else joined)" + NL
assert s.count(k) == 1, 'decl line'
s = s.replace(k, "            flat = re.sub(r'=\\s*\\{.*\\}', '= 0', re.sub(r'/\\*.*?\\*/', ' ', joined.replace('\\n', ' ')), flags=re.S)" + NL + "            m = DECL.match(flat)" + NL)
k = "        if len(items) < 2 or len(set(names)) != len(names) or any(x not in rank for x in names):" + NL + "            continue" + NL + "        want = sorted(items, key=lambda x: rank[x[0]])" + NL
assert s.count(k) == 1
s = s.replace(k, "        if len(items) < 2 or len(set(names)) != len(names) or not any(x in rank for x in names):" + NL + "            continue" + NL +
              "        key, last = {}, -1.0          # a carrier retail lacks keeps its place right after its predecessor" + NL +
              "        for x in names:" + NL + "            if x in rank:" + NL + "                last = float(rank[x]); key[x] = last" + NL +
              "            else:" + NL + "                last += 0.001; key[x] = last" + NL +
              "        want = sorted(items, key=lambda x: key[x[0]])" + NL)
open(p, 'w', encoding='utf-8', newline='').write(s)
print('ok')
