// Internal link check over the built site: every relative or base-prefixed href/src must resolve
// to a file in _site. External links are the advisory lychee job's business.
import { readFileSync, existsSync, statSync } from 'node:fs';
import { join, dirname, normalize } from 'node:path';
import { globSync } from 'node:fs';

const base = '/tech-enhanced-learning';
const files = globSync('_site/**/*.html');
let refs = 0;
const broken = [];
for (const f of files) {
  const html = readFileSync(f, 'utf8');
  for (const m of html.matchAll(/(?:href|src)="([^"]+)"/g)) {
    const h = m[1];
    if (/^(https?:|mailto:|data:|#)/.test(h)) continue;
    refs += 1;
    const path = h.split('#')[0];
    let p;
    if (path.startsWith(base + '/') || path === base) p = join('_site', path.slice(base.length));
    else if (path.startsWith('/')) { broken.push(`${f}: ${h} (absolute path outside the base)`); continue; }
    else p = normalize(join(dirname(f), path));
    if (p.endsWith('/') || (existsSync(p) && statSync(p).isDirectory())) p = join(p, 'index.html');
    if (!existsSync(p)) broken.push(`${f}: ${h}`);
  }
}
console.log(`${files.length} pages, ${refs} internal references, ${broken.length} broken`);
if (broken.length) { console.error(broken.join('\n')); process.exit(1); }
