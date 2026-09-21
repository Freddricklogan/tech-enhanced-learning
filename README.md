# tech-enhanced-learning: a twelve-week course site on technology-enhanced learning and remote work — syllabus, modules and assignments, built and validated in CI

[![CI/CD](https://github.com/Freddricklogan/tech-enhanced-learning/actions/workflows/deploy.yml/badge.svg)](https://github.com/Freddricklogan/tech-enhanced-learning/actions/workflows/deploy.yml)
[![License CC BY-NC-SA 4.0](https://img.shields.io/badge/license-CC%20BY--NC--SA%204.0-blue)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
[![Live Site](https://img.shields.io/badge/live%20site-online-brightgreen)](https://freddricklogan.github.io/tech-enhanced-learning/)

## 1. Executive Summary & Business Impact

**Problem statement.** A course site is the first thing a student
opens and the last thing an instructor has time to maintain. This
one — a Jekyll site for a twelve-week course on technology-enhanced
learning and remote work — had been offline for months: GitHub Pages
was pointed at a folder that did not exist, the home page had lost
its layout to a misplaced SEO block, and the navigation linked to
pages that were never written.

**What this delivers.** The site back online through a CI pipeline
that builds it from a locked Gemfile (plain Jekyll 4), validates every
page, checks every internal link and only then deploys. The content
is unchanged: a syllabus, the Week 1 module and the Personal
Productivity assignment. Where the syllabus promises material that is
not yet written, the site now says so instead of linking to nothing.

**Who it is for.** Students on the course, and instructors who want
to fork a small, honest course site whose build fails before a broken
page reaches them.

**[→ Read the full case study](docs/CASE_STUDY.md)**

## 2. Demonstrated Competencies & Technical Skills

| Area | What the repository shows |
| --- | --- |
| Course design | A twelve-week syllabus balancing learning theory with remote-work practice; module and assignment structure with weighted assessment groups |
| Static-site repair | Diagnosing a Pages misconfiguration and a front-matter regression; restoring Liquid layout and SEO metadata driven by page data |
| Quality gates for content | `html-validate` on every built page, an internal link checker, strict front matter — so an unpublished page is a note, not a 404 |
| CI/CD | Ruby + Node toolchain in one job, Pages artifact deploy, advisory external link check, npm audit + Trivy |

## 3. System Architecture & Data Flow

```
index.html, syllabus/, modules/, assignments/   (Liquid pages, front matter)
_layouts/default.html + assets/css/main.css     (one layout, one stylesheet)
        │
        ▼  bundle exec jekyll build --strict_front_matter   (jekyll 4.4.1, locked)
      _site/
        │  html-validate (recommended + no-inline-style)
        │  scripts/check-links.mjs (46 internal refs, 0 broken)
        ▼
  actions/upload-pages-artifact ──► actions/deploy-pages
```

No JavaScript runs on the site. External fonts (Google Fonts) are
the only third-party resource.

## 4. Technical Highlights & Engineering Decisions

- **Build from the lockfile, not the legacy builder.** The workflow
  installs the exact gems the lockfile names, so the page that passed
  validation is the page that deploys, and a gem upgrade is a visible
  diff. The `github-pages` gem was dropped: it pinned Jekyll 3.9 and a
  set of transitive gems Trivy flagged, and the site uses none of the
  plugins it exists to provide.
- **Unpublished is a state, not a broken link.** Weeks 2–12 and seven
  assignments exist in the syllabus but not as pages; they are listed
  with their titles and marked as not yet published. The link checker
  makes this the only option — a dead link fails the build.
- **Metadata belongs to the layout.** Title, description, canonical
  URL and Open Graph tags are generated from each page's front matter,
  which is how the SEO block should have been added in the first
  place.
- **Strict front matter.** A page whose front matter Jekyll cannot
  parse is a build failure, not a silently unstyled page.
- **Nothing invented.** No module or assignment content was written
  to fill gaps; the course stands as its author left it, with its
  gaps labelled.

## 5. Getting Started & Verification

**Prerequisites.** Ruby 3.3+ with Bundler, Node 22.

```bash
git clone https://github.com/Freddricklogan/tech-enhanced-learning.git
cd tech-enhanced-learning
bundle install && npm ci
npm run check                     # jekyll build --strict_front_matter, html-validate, internal links
bundle exec jekyll serve          # http://127.0.0.1:4000/tech-enhanced-learning/
```

**Verification — the numbers this repository actually produced:**

| Check | Result |
| --- | --- |
| Jekyll build (strict front matter) | 6 pages (Jekyll 4.4.1, plain — see below) |
| html-validate | **0 errors** over 6 built pages (after encoding 34 bare ampersands and removing the inline-styled element) |
| Internal links | **46 references, 0 broken** (was: 2 nav targets, 2 home cards, 2 week-1 buttons, 10 `href="#"` placeholders) |
| Browser smoke (headless Chrome) | all 6 pages: **0 console errors / 0 warnings**; no horizontal scroll at 1280 or 400 px (nav previously overflowed to 516 px at 400) |
| Trivy (Gemfile.lock + package-lock.json) | **0 findings** — the previous `github-pages` lockfile carried 9 HIGH/CRITICAL findings in transitive gems (nokogiri, concurrent-ruby, rubyzip, faraday, addressable, activesupport) |
| Tests | none — the repository contains no program logic; the gates above are the verification |

## 6. Live Demo & Production Showcase

**<https://freddricklogan.github.io/tech-enhanced-learning/>** — home,
syllabus, modules (Week 1 published), assignments (Personal
Productivity System published).

![Course site home page](docs/screenshot.png)

---

## License

Course materials are licensed
[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/),
as the original README stated.
