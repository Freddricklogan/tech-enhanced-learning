# Case Study — tech-enhanced-learning

**Repository:** [tech-enhanced-learning](https://github.com/Freddricklogan/tech-enhanced-learning) · **Live demo:** [freddricklogan.github.io/tech-enhanced-learning](https://freddricklogan.github.io/tech-enhanced-learning/) · **Author:** Freddrick Logan

---

## 1. Who has this problem

Anyone who teaches with a home-made course site. The site is written in a burst before term, published once, and then edited in small, hurried commits between classes — a link here, an SEO tag there — with no build step to tell the instructor that the last edit took the home page down.

## 2. The problem, as a scenario

A student opens the link in the syllabus and gets GitHub's "Site not found" page. The instructor checks the repository: the pages are there, the commit history looks fine. What they cannot see from the repository view is that Pages is configured to publish a `docs/` folder that never existed, that the home page's front matter was pushed below fourteen lines of metadata by an SEO commit and so is no longer a page at all, and that the navigation's Modules and Resources links point at folders with nothing in them. There is a `test.md` in the root from the last time someone tried to work out what was wrong.

## 3. What it costs to leave it alone

A course site that is down is worse than none: the syllabus still points at it. A course site that is up but half-broken is worse again, because a student who hits three dead links stops trusting the fourth. And the repository advertises a course of twelve weeks and eight assignments when one week and one assignment were ever written; leaving that unlabelled is a quiet overstatement that this portfolio does not make anywhere else.

## 4. The approach, and the alternative I rejected

I rejected rebuilding the site on a different generator, and I rejected writing the eleven missing weeks. The first would have changed the URL structure for a site whose only value is that its links are stable, and the second would have been inventing course content to make a portfolio piece look finished. The repair is a Jekyll site repaired as a Jekyll site: front matter restored, metadata moved into the layout where it belongs, dead links turned into labelled notes, and a CI pipeline that builds from a locked Gemfile, validates the output and refuses to deploy a page with a broken internal link. The content is the author's; the honesty about what exists is new.

## 5. What the code does today

`_layouts/default.html` is the one layout. It builds the title, description, canonical URL and Open Graph tags from each page's front matter and site config, carries a four-item navigation (Home, Syllabus, Modules, Assignments) and a footer with the licence and repository link. `_config.yml` sets the Pages URL and base path and excludes the README, the generator script and the tooling from the build. `modules/index.html` is new: it lists Week 1 as a link and Weeks 2 to 12 by their syllabus titles as not yet published. The seven `href="#"` buttons on the assignments page and the three placeholder resource links on the one assignment are now non-interactive notes.

`package.json` defines `check`: `bundle exec jekyll build --strict_front_matter`, then `html-validate` over every built page with the recommended rules plus a ban on inline styles, then `scripts/check-links.mjs`, which resolves every relative and base-prefixed `href` and `src` in `_site` against the filesystem. The workflow runs `check` in one job with Ruby and Node, uploads `_site` as the Pages artifact, runs npm audit and Trivy, and deploys on `main`. An advisory job checks external links. The `github-pages` gem is gone: it pinned Jekyll 3.9 and a lockfile Trivy flagged nine times, and the site used none of its plugins.

## 6. Evidence

The build produces six pages and passes `html-validate` with no errors, after encoding 34 bare ampersands, escaping the Liquid output in the head, shortening one over-long title and removing the inline-styled element. The link checker reports 46 internal references and 0 broken; before the repair the navigation had two dead targets, the home page two, the Week 1 page two, and there were ten `href="#"` placeholders. A headless-Chrome pass over all six pages logged no console errors or warnings and found no horizontal overflow at 1280 or 400 pixels — the original header nav could not wrap and pushed every page to 516 pixels at a 400-pixel viewport. There are no unit tests because there is no program logic; the validation, link and build gates are the verification.

## 7. What it would take to run this in production

It is in production: the workflow is the publisher. For an instructor, the operating rule is that a page appears in the modules list when its file exists and passes the build, and a broken link is a failed pull request rather than a student's complaint. Adding a week is one file with front matter; the build tells you if the front matter is wrong.

## 8. Limits and next steps

Eleven weeks and seven assignments remain unwritten, and the site says so on the pages that would hold them. The site loads Google Fonts, the only external resource; a self-hosted font would remove it. The next step is a Week 2 page, which now takes one file and one green build.

## 9. Who should look at this

Instructors who want a course site that cannot silently break, and anyone judging whether I will repair what exists and label what does not rather than rebuild or embellish.
