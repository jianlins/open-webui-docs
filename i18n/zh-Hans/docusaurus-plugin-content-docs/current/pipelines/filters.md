---
sidebar_position: 1
title: "🚰 过滤器"
---

# 过滤器

过滤器用于对传入的用户消息和传出的助手（LLM）消息执行操作。过滤器中可以采取的潜在操作包括向监控平台（如 Langfuse 或 DataDog）发送消息、修改消息内容、阻止有害消息、将消息翻译成另一种语言，或限制来自特定用户的消息频率。[Pipelines 仓库](https://github.com/open-webui/pipelines/tree/main/examples/filters)中维护了一系列示例。过滤器可以作为函数执行，也可以在 Pipelines 服务器上执行。下图展示了一般工作流程。

<p align="center">
  <a href="#">
    <img src="/images/pipelines/filters.png" alt="过滤器工作流程" />
  </a>
</p>

当在模型或管道上启用过滤器管道时，来自用户的传入消息（或"入口"）会传递给过滤器进行处理。过滤器在请求 LLM 模型的聊天完成之前对消息执行所需的操作。最后，过滤器在将传出的 LLM 消息（或"出口"）发送给用户之前对其进行后处理。