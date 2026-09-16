import { mkdir, writeFile } from 'node:fs/promises';
import { resolve } from 'node:path';
const slug = process.argv[2];
if (!slug || !/^[a-z0-9]+(?:-[a-z0-9]+)*$/.test(slug)) {
  console.error('Usage: npm run new:post -- my-post-title (lowercase letters, numbers, hyphens)');
  process.exit(1);
}
const title = process.argv.slice(3).join(' ') || slug.replaceAll('-', ' ');
const directory = resolve('src/content/posts');
await mkdir(directory, { recursive: true });
const path = resolve(directory, `${slug}.md`);
const lines = ['---', `title: ${JSON.stringify(title)}`, 'description: "Add a short summary."', `date: ${new Date().toISOString().slice(0,10)}`, 'category: "Study Notes"', 'lang: "en"', 'draft: true', '---', '', 'Write your post here.', ''];
try {
  await writeFile(path, lines.join('\n'), { flag: 'wx' });
  console.log(`Created ${path}`);
} catch (error) {
  if (error.code === 'EEXIST') { console.error('That post already exists; choose a different name.'); process.exit(1); }
  throw error;
}
