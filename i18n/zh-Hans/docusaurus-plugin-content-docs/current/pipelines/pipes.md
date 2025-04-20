---
sidebar_position: 2
title: "🔧 管道"
---

# 管道
管道是可用于在将 LLM 消息返回给用户之前执行操作的函数。您可以使用管道执行的潜在操作示例包括检索增强生成 (RAG)、向非 OpenAI LLM 提供商（如 Anthropic、Azure OpenAI 或 Google）发送请求，或直接在您的 Web UI 中执行函数。管道可以作为函数托管，也可以在 Pipelines 服务器上托管。[Pipelines 仓库](https://github.com/open-webui/pipelines/tree/main/examples/pipelines)中维护了一系列示例。下图展示了一般工作流程。

<p align="center">
  <a href="#">
    <img src="/images/pipelines/pipes.png" alt="管道工作流程" />
  </a>
</p>

在您的 WebUI 中定义的管道会显示为带有"External"标识的新模型。下面可以看到两个管道模型，`Database RAG Pipeline` 和 `DOOM`，它们与两个自托管模型并排显示：

<p align="center">
  <a href="#">
    <img src="/images/pipelines/pipe-model-example.png" alt="WebUI 中的管道模型" />
  </a>
</p>