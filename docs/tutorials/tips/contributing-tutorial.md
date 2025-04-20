---
sidebar_position: 2
title: "🤝 Contributing Tutorials"
---

:::warning
This tutorial is a community contribution and is not supported by the Open WebUI team. It serves only as a demonstration on how to customize Open WebUI for your specific use case. Want to contribute? Check out the contributing tutorial.
:::

# Contributing Tutorials

We appreciate your interest in contributing tutorials to the Open WebUI documentation. Follow the steps below to set up your environment and submit your tutorial.

## Steps

1. **Fork the `openwebui/docs` GitHub Repository**

   - Navigate to the [Open WebUI Docs Repository](https://github.com/open-webui/docs) on GitHub.
   - Click the **Fork** button at the top-right corner to create a copy under your GitHub account.

2. **Enable GitHub Actions**

   - In your forked repository, navigate to the **Actions** tab.
   - If prompted, enable GitHub Actions by following the on-screen instructions.

3. **Enable GitHub Pages**

   - Go to **Settings** > **Pages** in your forked repository.
   - Under **Source**, select the branch you want to deploy (e.g., `main`) and the folder (e.g.,`/docs`).
   - Click **Save** to enable GitHub Pages.

4. **Configure GitHub Environment Variables**

   - In your forked repository, go to **Settings** > **Secrets and variables** > **Actions** > **Variables**.
   - Add the following environment variables:
     - `BASE_URL` set to `/docs` (or your chosen base URL for the fork).
     - `SITE_URL` set to `https://<your-github-username>.github.io/`.

### 📝 Updating the GitHub Pages Workflow and Config File

If you need to adjust deployment settings to fit your custom setup, here’s what to do:

a. **Update `.github/workflows/gh-pages.yml`**

- Add environment variables for `BASE_URL` and `SITE_URL` to the build step if necessary:

     ```yaml
       - name: Build
         env:
           BASE_URL: ${{ vars.BASE_URL }}
           SITE_URL: ${{ vars.SITE_URL }}
         run: npm run build
     ```

b. **Modify `docusaurus.config.ts` to Use Environment Variables**

- Update `docusaurus.config.ts` to use these environment variables, with default values for local or direct deployment:

     ```typescript
     const config: Config = {
       title: "Open WebUI",
       tagline: "ChatGPT-Style WebUI for LLMs (Formerly Ollama WebUI)",
       favicon: "images/favicon.png",
       url: process.env.SITE_URL || "https://openwebui.com",
       baseUrl: process.env.BASE_URL || "/",
       ...
     };
     ```

- This setup ensures consistent deployment behavior for forks and custom setups.

5. **Run the `gh-pages` GitHub Workflow**

   - In the **Actions** tab, locate the `gh-pages` workflow.
   - Trigger the workflow manually if necessary, or it may run automatically based on your setup.

6. **Browse to Your Forked Copy**

   - Visit `https://<your-github-username>.github.io/<BASE_URL>` to view your forked documentation.

7. **Draft Your Changes**

   - In your forked repository, navigate to the appropriate directory (e.g., `docs/tutorial/`).
   - Create a new markdown file for your tutorial or edit existing ones.
   - Ensure that your tutorial includes the unsupported warning banner.

8. **Submit a Pull Request**

   - Once your tutorial is ready, commit your changes to your forked repository.
   - Navigate to the original `open-webui/docs` repository.
   - Click **New Pull Request** and select your fork and branch as the source.
   - Provide a descriptive title and description for your PR.
   - Submit the pull request for review.

## Important

Community-contributed tutorials must include the the following:

```
:::warning
This tutorial is a community contribution and is not supported by the Open WebUI team. It serves only as a demonstration on how to customize Open WebUI for your specific use case. Want to contribute? Check out the contributing tutorial.
:::
```

---

:::tip How to Test Docusaurus Locally  
You can test your Docusaurus site locally with the following commands:

```bash
npm install   # Install dependencies
npm run build # Build the site for production
```

This will help you catch any issues before deploying
:::

---

## 🌍 Contributing to Multilingual Documentation

Open WebUI documentation supports multiple languages, allowing users from different regions to access content in their preferred language. This section provides guidelines for contributing to multilingual documentation.

### Setting Up Multilingual Support

The project uses Docusaurus's i18n feature for multilingual support. The current supported languages are:

- English (default, `en`)
- Simplified Chinese (`zh-Hans`)

To set up or modify multilingual support:

1. **Understand the Directory Structure**:
   - Original content (English): `docs/`
   - Translated content: `i18n/[language-code]/docusaurus-plugin-content-docs/current/`

2. **Configure Language Support**:
   - Language configuration is in `docusaurus.config.ts` under the `i18n` section:
   ```typescript
   i18n: {
     defaultLocale: "en",
     locales: ["en", "zh-Hans"],
   },
   ```

### Adding a New Language

To add support for a new language:

1. **Update Configuration**:
   - Add your language code to the `locales` array in `docusaurus.config.ts`:
   ```typescript
   i18n: {
     defaultLocale: "en",
     locales: ["en", "zh-Hans", "your-language-code"],
   },
   ```

2. **Create Directory Structure**:
   - Create the following directory structure:
   ```
   i18n/[your-language-code]/docusaurus-plugin-content-docs/current/
   ```

3. **Add Translated Content**:
   - Copy the directory structure from `docs/` to your language directory
   - Translate the content while maintaining the same file structure and names
   - Preserve all frontmatter, component imports, and markdown formatting

4. **Example**:
   For adding French (`fr`) support:
   ```
   i18n/fr/docusaurus-plugin-content-docs/current/
   ```

### Revising Multilingual Pages

When revising existing multilingual content:

1. **Maintain Consistency**:
   - Ensure translations accurately reflect the original content
   - Keep the same file structure and names across all languages
   - Preserve all frontmatter, component imports, and markdown formatting

2. **Update All Language Versions**:
   - When making significant changes to the English content, update all translated versions
   - Add a note in your PR if translations need to be updated

3. **Best Practices**:
   - Keep technical terms consistent across languages
   - Maintain the same links and references in all translations
   - Ensure code blocks remain identical (don't translate code unless it's in comments)

### Testing Multilingual Setup

To test your multilingual changes:

1. **Run the Test Script**:
   ```bash
   scripts\test-i18n.bat
   ```
   This script:
   - Installs dependencies
   - Builds the documentation with translations
   - Starts the development server

2. **Access Different Language Versions**:
   - English: http://localhost:3000/
   - Simplified Chinese: http://localhost:3000/zh-Hans/
   - Your language: http://localhost:3000/[your-language-code]/

3. **Verify Your Changes**:
   - Check that all pages render correctly in each language
   - Ensure navigation works properly
   - Verify that all links and references work as expected

By following these guidelines, you'll help maintain a high-quality multilingual documentation experience for all Open WebUI users.
