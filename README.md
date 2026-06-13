# My Blog

Personal blog by Sulthan A. Karimov — built with [Quarto](https://quarto.org/) and [babelquarto](https://github.com/ropensci-review-tools/babelquarto) for bilingual (English / Bahasa Indonesia) support.

**Live site**: [sulthankarimov.my.id](https://sulthankarimov.my.id)

---

## Tech Stack

| Concern | Tool |
|---|---|
| Static Site Generator | [Quarto](https://quarto.org/) CLI |
| Multilingual (EN/ID) | [babelquarto](https://github.com/ropensci-review-tools/babelquarto) (R package) |
| Python packages | [uv](https://docs.astral.sh/uv/) (`pyproject.toml` + `uv.lock`) |
| R packages | [renv](https://rstudio.github.io/renv/) (`renv.lock`) |
| Environment activation | [direnv](https://direnv.net/) (`.envrc`) |
| Hosting | GitHub Pages (auto-deployed via GitHub Actions) |

---

## Project Structure

```
myblog-main/
├── .envrc                  # direnv: chains parent env + activates .venv
├── .Rprofile               # auto-activates renv on R startup
├── .gitignore
├── .github/
│   └── workflows/
│       └── babelquarto.yml # CI: render + deploy on push to main
├── Makefile                # shortcut commands (make preview, make deploy, ...)
├── pyproject.toml          # Python deps (source of truth for uv)
├── uv.lock                 # Python lockfile (auto-generated, reproducible)
├── renv.lock               # R lockfile (source of truth for renv)
├── renv/
│   └── activate.R          # renv bootstrap script
├── CNAME                   # Custom domain: sulthankarimov.my.id
├── myblog/                 # Quarto project root
│   ├── _quarto.yml         # Site config (theme, navbar, babelquarto)
│   ├── _freeze/            # Cached computational output (COMMITTED)
│   ├── _site/              # Rendered HTML output (gitignored)
│   ├── about.qmd           # About page (EN)
│   ├── about.id.qmd        # About page (ID)
│   ├── index.qmd           # Home listing (EN)
│   ├── index.id.qmd        # Home listing (ID)
│   ├── assets/             # CSS, images, logos
│   └── posts/
│       ├── _metadata.yml   # Shared post config (freeze: true)
│       ├── Algorithms/
│       ├── Data Science/
│       ├── Exercises/
│       ├── livekit/
│       └── opinions/
└── LICENSE
```

---

## Prerequisites

Install these system-wide:

- [Quarto CLI](https://quarto.org/docs/get-started/) >= 1.4
- [R](https://www.r-project.org/) >= 4.0
- [uv](https://docs.astral.sh/uv/getting-started/installation/)
- [direnv](https://direnv.net/docs/installation/)

---

## Setup (First Time)

```bash
git clone git@github.com:sakarimov/myblog.git
cd myblog

# One command installs everything:
make setup
```

This runs:
1. `uv sync` — creates `.venv/`, installs Python packages from `uv.lock`
2. `renv::restore()` — installs R packages from `renv.lock`

To enable automatic environment activation, allow direnv:
```bash
direnv allow
```

After this, entering the directory automatically activates the Python venv.
R's `.Rprofile` does the same for renv.

---

## Content Workflow

### 1. Draft

Create a new `.qmd` file under the appropriate category:

```bash
touch myblog/posts/<category>/NN_descriptive_name.qmd
```

Minimal frontmatter:
```yaml
---
title: "Your Title"
author: "Sulthan A. Karimov"
date: 2024-07-15
categories: [data science, python]
---
```

### 2. Code Validation

Preview locally — Quarto executes Python and shows live output:

```bash
make preview    # opens http://localhost:3333
```

Verify:
- All code cells execute without errors
- Outputs (tables, numbers) display correctly
- No missing imports or broken references

### 3. Freeze

The `freeze: true` setting in `posts/_metadata.yml` captures executed output
into `_freeze/`. This means CI does NOT need to re-run your code (which may
fail due to missing deps, GPU, network, etc.).

After previewing and confirming output looks right, the `_freeze/` directory
is already updated. **Always commit `_freeze/` alongside your post.**

To force re-execution of all posts (e.g. after updating a package):
```bash
make freeze     # quarto render --execute (re-runs all code, updates _freeze/)
```

### 4. Visual Validation

With preview open in browser, check:
- Plots render correctly (matplotlib / plotly / seaborn)
- Images load and are sized properly
- Code-fold and TOC work as expected
- Mobile responsiveness (resize browser or use dev tools)
- Tables display properly (`df-print: paged`)

### 5. Bilingual (if needed)

For Indonesian translation, create the `.id.qmd` variant:
```bash
cp myblog/posts/<category>/NN_name.qmd myblog/posts/<category>/NN_name.id.qmd
# Translate content to Bahasa Indonesia
```

babelquarto auto-generates the language switcher from `_quarto.yml`.

### 6. Commit & Push

```bash
make deploy     # renders full multilingual site + commits + pushes
```

Or manually:
```bash
make render         # full multilingual render (babelquarto)
git add -A
git commit -m "feat: add <post title>"
git push
```

### 7. CI Auto-Deploys

Push to `main` triggers `.github/workflows/babelquarto.yml`:

1. Sets up R + Quarto + Python
2. Installs deps (`requirements.txt` for Python, `babelquarto` for R)
3. Runs `babelquarto::render_website()`
4. Publishes to `gh-pages` branch
5. Live at `sulthankarimov.my.id` in ~2-3 minutes

---

## Managing Dependencies

### Python (via uv)

```bash
# Add a new package
uv add <package-name>

# Remove a package
uv remove <package-name>

# Reinstall from lockfile (after git pull)
uv sync
```

`pyproject.toml` is the source of truth. `uv.lock` ensures reproducible installs.

### R (via renv)

```bash
# Add a new R package
Rscript -e 'source("renv/activate.R"); renv::install("package-name")'

# Snapshot current state into lockfile
Rscript -e 'source("renv/activate.R"); renv::snapshot()'

# Restore from lockfile (after git pull)
Rscript -e 'source("renv/activate.R"); renv::restore()'
```

`renv.lock` is the source of truth. The `renv/library/` directory is gitignored
(packages are restored from the lockfile).

### Environment Activation (direnv)

The `.envrc` chains environments:
```bash
source_up                       # inherits parent .envrc (if any)
source .venv/bin/activate       # activates uv-managed Python venv
```

R activation is handled by `.Rprofile` which sources `renv/activate.R`.

---

## Available Commands

| Command | Description |
|---|---|
| `make setup` | First-time setup: install Python (uv) + R (renv) deps |
| `make sync` | Reinstall Python deps from `uv.lock` |
| `make preview` | Live preview at localhost:3333 (English) |
| `make render` | Full multilingual render to `_site/` (EN + ID) |
| `make freeze` | Re-execute all posts and update `_freeze/` cache |
| `make clean` | Remove `_site/` and `.quarto/` build artifacts |
| `make deploy` | Render multilingual + commit + push |

---

## License

See [LICENSE](LICENSE).
