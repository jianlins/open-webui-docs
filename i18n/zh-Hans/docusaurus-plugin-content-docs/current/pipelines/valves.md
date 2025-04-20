---
sidebar_position: 3
title: "⚙️ 阀门"
---

# 阀门

阀门是按管道设置的输入变量。阀门被设置为 `Pipeline` 类的子类，并作为 `Pipeline` 类的 `__init__` 方法的一部分进行初始化。

在向管道添加阀门时，请包含一种方法，确保管理员可以在 Web UI 中重新配置阀门。有几个选项：

- 使用 `os.getenv()` 设置用于管道的环境变量，以及在未设置环境变量时使用的默认值。下面是一个示例：

```
self.valves = self.Valves(
    **{
        "LLAMAINDEX_OLLAMA_BASE_URL": os.getenv("LLAMAINDEX_OLLAMA_BASE_URL", "http://localhost:11434"),
        "LLAMAINDEX_MODEL_NAME": os.getenv("LLAMAINDEX_MODEL_NAME", "llama3"),
        "LLAMAINDEX_EMBEDDING_MODEL_NAME": os.getenv("LLAMAINDEX_EMBEDDING_MODEL_NAME", "nomic-embed-text"),
    }
)
```

- 将阀门设置为 `Optional` 类型，这将允许管道加载，即使没有为阀门设置值。

```
class Pipeline:
    class Valves(BaseModel):
        target_user_roles: List[str] = ["user"]
        max_turns: Optional[int] = None
```

如果您没有留下一种方法让阀门在 Web UI 中更新，在尝试将管道添加到 Web UI 后，您将在 Pipelines 服务器日志中看到以下错误：
`WARNING:root:No Pipeline class found in <pipeline name>`