# 👋 Open WebUI Documentation

Welcome to the official documentation for **Open WebUI** — a self-hosted, privacy-focused, and extensible AI interface for LLMs like Ollama and OpenAI-compatible APIs.

This site is built with [Docusaurus](https://docusaurus.io/) and includes:

- 🔧 Installation & setup guides (Docker, local, manual)
- 🧩 Plugin & extension documentation
- 📚 API reference & pipeline usage
- 🗂 File uploads & RAG integration
- 🤖 Developer contribution guide
- 🌍 Multilingual support (English, Simplified Chinese)

## 🌍 Multilingual Support

This documentation supports multiple languages:

- English (default)
- Simplified Chinese (zh-Hans)

### Adding a New Language

To add support for a new language:

1. Update the `i18n` configuration in `docusaurus.config.ts` to include your language code
2. Create a directory structure under `i18n/[language-code]/docusaurus-plugin-content-docs/current/`
3. Add translated content following the same structure as the English version

Example for adding French support:
```typescript
// In docusaurus.config.ts
i18n: {
  defaultLocale: "en",
  locales: ["en", "zh-Hans", "fr"],
},
```

Then create the directory structure:
```
i18n/fr/docusaurus-plugin-content-docs/current/
```

## 📝 Contributing

Contributions are welcome! Please read the [contributing guide](docs/tutorials/tips/contributing-tutorial.md) for details.

## 🌐 Live Docs

👉 Visit the docs: [docs.openwebui.com](https://docs.openwebui.com/)
