import { defineConfig } from 'astro/config';
import { siteConfig } from './site.config.mjs';
const owner = process.env.GITHUB_REPOSITORY_OWNER || siteConfig.githubUsername;
const repository = process.env.GITHUB_REPOSITORY?.split('/')[1] || siteConfig.repository;
const rootRepo = !repository || repository.toLowerCase() === `${owner}.github.io`.toLowerCase();
export default defineConfig({
  site: siteConfig.customDomain || `https://${owner}.github.io`,
  base: siteConfig.customDomain || rootRepo ? '/' : `/${repository}`,
  trailingSlash: 'always',
  output: 'static',
});
