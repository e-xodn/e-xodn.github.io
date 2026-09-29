# Taewoo's personal website

An editable Astro website for a research profile, projects, CV, and Markdown writing. No visual website builder, database, or paid theme is required. The design is an original, minimal academic layout inspired by the structure of the supplied references; their code and assets are not copied.

## 1. Start on Linux

Install Node.js 24 LTS using https://nodejs.org/en/download (or your existing Node version manager). This project requires Node >=22.12.0; Node 24 is recommended and used in deployment. You do not need Conda or Python for this project.

If nvm is already installed:

```bash
nvm install 24
nvm use 24
```

Extract this archive into a new folder. Then open a terminal **inside the extracted `taewoo-personal-site` folder**:

```bash
node --version
npm --version
npm ci
npm run dev
```

Open the local URL printed by Astro (normally http://localhost:4321). Keep the terminal running. Edits update your local preview; Ctrl+C stops a foreground server. If Astro starts in background mode (for example in an AI coding agent), use `npm run dev -- stop` to stop it.

Open this folder in VS Code through File → Open Folder, or `code .` if the command is installed. This site runs locally first; it has not been pushed to your GitHub account or published.

## 2. Edit your information

| What to change | File |
| --- | --- |
| Name, introduction, experience, education, interests | `src/data/profile.json` |
| Project descriptions and links | `src/data/projects.json` |
| GitHub username and domain | `site.config.mjs` |
| Posts | `src/content/posts/*.md` |
| Colors, typography, spacing, mobile layout | `src/styles/global.css` |
| Navigation and shared page structure | `src/layouts/Base.astro` |
| Homepage structure | `src/pages/index.astro` |

Your confirmed GitHub username is `e-xodn`. The project is configured for the root repository `e-xodn.github.io`.

The biography, experience, and project descriptions are starter text based on the conversation. Review them. Add institution names, dates, contact details, and other information yourself; missing values have deliberately been left blank. No publication acceptance or performance claim has been invented.

JSON requires double quotes and no trailing commas. Keep the existing structure when editing.

### Profile photo and CV PDF

Copy your own photo to `public/images/profile.jpg`, then set `photo` to `images/profile.jpg` in `profile.json`. The optional image is hidden until configured.

Copy your CV to `public/cv.pdf`, then set `cvPdf` to `cv.pdf`. The CV page then shows a download link. Set `email` if you want a public email link.

### Project links

Inside a project's `links` array, add objects such as:

```json
[{ "label": "Code", "url": "https://github.com/e-xodn/YOUR_REPOSITORY" }]
```

## 3. Write a post

```bash
npm run new:post -- my-first-insight
```

This creates `src/content/posts/my-first-insight.md` and refuses to overwrite an existing post. Edit it in VS Code. Both Korean and English are supported; set `lang: "ko"` for Korean.

```markdown
---
title: "What I learned about vision-language models"
description: "A short summary of this post."
date: 2026-09-16
category: "Study Notes"
lang: "en"
draft: true
---

## The main idea

Write your content here.
```

Categories: `AI Trends`, `AX`, `Insights`, `Study Notes`.

Drafts appear during `npm run dev` with a visible draft label. `npm run build` excludes drafts from both the article list and generated article pages. Set `draft: false` when ready. Dates are displayed and used for sorting; future dates do NOT schedule publication.

Draft exclusion does not hide Markdown source in a public GitHub repository. Keep genuinely private writing outside a public repository.

`-post.md` is a local-only editing example, not an authored article. Replace it or delete it after you have another post file.

## 4. Check before publishing

```bash
npm run build
npm run preview
```

Open the URL printed by `preview`. This is the production version: drafts should be absent. Press Ctrl+C to stop.

## 5. Publish on GitHub Pages

You own the repository and hosting settings. No GitHub repository was created by this download.

1. The GitHub username is already configured as `e-xodn` in `site.config.mjs`.
2. On GitHub create an **empty public repository** named `e-xodn.github.io`. Do not initialize it with a README, license, or .gitignore, because this folder already has files. If you already have that repository, stop and use a separate project repository instead of overwriting it.
3. Under the repository's **Settings → Pages → Build and deployment**, set **Source** to **GitHub Actions**.
4. In the local project folder, run the following. The remote command uses your confirmed username:

```bash
git init -b main
git add .
git commit -m "Create personal website"
git remote add origin https://github.com/e-xodn/e-xodn.github.io.git
git push -u origin main
```

If Git requests your identity, set your own name and email. Authenticate using your usual GitHub CLI, credential manager, or SSH configuration. GitHub account passwords cannot be used for Git HTTPS authentication; do not put a token in a remote URL or source file.

5. Open the repository's **Actions** tab. When “Deploy website” succeeds, open the URL shown in **Settings → Pages**.

The workflow uses Astro's documented GitHub Pages actions and Node 24. The pinned npm lockfile is included. GitHub Actions builds and deploys changes pushed to `main`.

### Using a project repository instead

If `<username>.github.io` already exists, create a new repository such as `personal-site`. Set `repository: 'personal-site'` in `site.config.mjs` and use that repository in `git remote add origin`. CI also derives the owner and repository from GitHub's environment. Internal links support the `/personal-site/` base path. The custom domain setting overrides that base path when configured.

### Publish future edits

```bash
npm run build
git add .
git commit -m "Update profile and writing"
git push
```

## 6. Connect your own domain later

You do not need to purchase a domain to develop or launch the site.

After choosing and registering a domain in your own account:

1. Verify domain ownership with GitHub following its current documentation.
2. Configure DNS at your registrar for GitHub Pages. The exact records depend on whether you use an apex domain or a subdomain; follow the official guide rather than copying unrelated IP addresses.
3. Set the domain in **repository Settings → Pages → Custom domain** and enable HTTPS once available.
4. Set `customDomain` in `site.config.mjs` to the full HTTPS origin, such as `https://your-domain.com`.
5. Build, commit, and push. This configuration uses `/` as the base when a custom domain is set.

The Pages settings remain authoritative for this GitHub Actions deployment. No domain has been registered or connected by this package.

Official guides:
- https://docs.astro.build/en/guides/markdown-content/
- https://docs.astro.build/en/guides/deploy/github/
- https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site

## How the pieces fit together

- `.astro` files define page structure using HTML-like syntax.
- CSS controls the visual design.
- JSON stores structured profile/project data.
- Markdown stores articles; Astro converts them into HTML during the build.
- `dist/` is generated output, so edit `src/` rather than `dist/`.
- `.github/workflows/deploy.yml` automates publication when you push to GitHub.

Start by editing one sentence in `profile.json` and watching your local browser update. Then create a draft post. You can learn the framework as you customize it.
