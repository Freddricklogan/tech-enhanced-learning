# AUDIT — tech-enhanced-learning (pre-refactor)

Audit of the previous build: a Jekyll course site (one layout, five
content pages, one stylesheet, a 1,482-line generator script), a
README that linked to a live site, and GitHub Pages configured to
publish `main:/docs`.

---

## A. What no longer worked

### A1 — The live site was a 404
Pages was set to serve the `/docs` folder of `main`. There is no
`docs/` folder, so `https://freddricklogan.github.io/tech-enhanced-learning/`
returned GitHub's "Site not found" page. A `test.md` left over from
diagnosing this was still in the repository. **Fix:** a workflow
builds the site from a locked Gemfile, validates every
page and deploys the artifact; Pages switched to workflow builds.
`test.md` removed.

### A2 — The home page had lost its layout
The SEO commit (9eee2f1) placed fourteen `<meta>` and `<link>` lines
*above* the YAML front matter of `index.html`. Front matter must be
the first thing in the file, so Jekyll stopped treating the page as a
Liquid page: no layout, no header, no stylesheet — a bare fragment.
The tags themselves described the page as a "SoftwareApplication"
named "Freddrick Logan" with an Unsplash stock photo. **Fix:** front
matter restored to the top; title, description, canonical and Open
Graph tags moved into the layout's `<head>` and driven by page data
(course banner as the image); the JSON-LD dropped.

### A3 — A fixed "View Source" pill with inline styles
Appended after `</body>` with a 300-character `style` attribute.
**Fix:** a footer line with the licence and the repository link;
`html-validate` now rejects inline styles.

## B. Dead links

| Where | Link | Fix |
| --- | --- | --- |
| nav (every page) | `/modules/` | `modules/index.html` created: Week 1 linked, Weeks 2–12 listed from the syllabus and marked not yet published |
| nav (every page) | `/resources/` | removed — no such content exists |
| home cards | `assignments/case-study/`, `assignments/remote-team/` | point at the matching sections of the assignments page |
| week 1 | `assignments/ple-setup/`, `assignments/remote-reflection/` | point at the assignments page, labelled as not yet published |
| assignments page | seven `href="#"` buttons | replaced by a non-interactive "not yet published" note |
| personal-productivity | three `href="#"` resource links | plain text, marked to be published |

A built-site link checker (`scripts/check-links.mjs`) now runs in CI:
46 internal references, 0 broken.

## C. Markup and layout

- 34 bare `&` characters in page text encoded; Liquid output in the
  head escaped; one page title over 70 characters shortened. Every
  built page passes `html-validate` (recommended rules + no inline
  styles).
- The header nav could not wrap, so every page scrolled horizontally
  at 400 px (nav width 411 px). It now wraps and the header stacks
  below 768 px.
- `_config.yml` pointed `url` at `localhost:4000` with an empty
  `baseurl`; set to the Pages URL and `/tech-enhanced-learning`. The
  unused Cayman theme and `jekyll-feed` (no posts) removed; README,
  generator script, tooling files excluded from the build.
- The `github-pages` gem pinned Jekyll 3.9.5 and a lockfile in which
  Trivy found 9 HIGH/CRITICAL findings (nokogiri 1.13.10,
  concurrent-ruby 1.3.5, rubyzip 2.4.1, faraday 2.8.1, addressable
  2.8.7, activesupport 6.1.7.10). The site uses none of that gem's
  plugins, so the Gemfile is now plain `jekyll ~> 4.3`; the new
  lockfile scans clean.

## D. Content left as it was

The course is one published module (Week 1) and one published
assignment of twelve weeks and eight assignments described in the
syllabus. Nothing was written to fill the gaps; the site now says so
instead of linking to pages that do not exist. `setup-tel-course.sh`,
the script that generated the original scaffold, is kept as a record
and excluded from the build. The licence (CC BY-NC-SA 4.0) is the
README's original statement and now appears in the footer.
