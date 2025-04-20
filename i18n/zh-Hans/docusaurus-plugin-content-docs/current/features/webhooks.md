---
sidebar_position: 17
title: "🪝 Webhook 集成"
---

概述
--------

Open WebUI 提供了一个 webhook 功能，允许您在新用户注册到您的实例时自动接收通知。这是通过向 Open WebUI 提供一个 webhook URL 来实现的，当创建新用户账户时，Open WebUI 将向该 URL 发送通知。

在 Open WebUI 中配置 Webhooks
---------------------------------

您需要从支持 webhooks 的外部服务（如 Discord 频道或 Slack 工作区）获取一个 webhook URL。这个 URL 将用于接收来自 Open WebUI 的通知。

要在 Open WebUI 中配置 webhooks，您有两个选项：

### 选项 1：通过管理界面配置

1. 以管理员身份登录到您的 Open WebUI 实例。
2. 导航到`管理面板`。
3. 点击位于顶部的`设置`标签。
4. 从那里，导航到管理面板中设置的`常规`部分。
5. 找到`Webhook URL`字段并输入 webhook URL。
6. 保存更改。

### 选项 2：通过环境变量配置

或者，您可以通过设置`WEBHOOK_URL`环境变量来配置 webhook URL。有关 Open WebUI 中环境变量的更多信息，请参阅[环境变量配置](https://docs.openwebui.com/getting-started/env-configuration/#webhook_url)。

### 步骤 3：验证 Webhook

要验证 webhook 是否正常工作，请在 Open WebUI 中创建一个新用户账户。如果 webhook 配置正确，您应该会在指定的 webhook URL 收到通知。

Webhook 负载格式
----------------------

Open WebUI 发送的 webhook 负载是纯文本格式，包含关于新用户账户的简单通知消息。负载格式如下：

```
New user signed up: <username>
```

例如，如果一个名为"Tim"的用户注册，发送的负载将是：

```
New user signed up: Tim
```

故障排除
--------------

* 确保 webhook URL 正确且格式正确。
* 验证 webhook 服务已启用并正确配置。
* 检查 Open WebUI 日志中是否有与 webhook 相关的错误。
* 验证连接没有被防火墙或代理中断或阻止。
* webhook 服务器可能暂时不可用或经历高延迟。
* 如果通过 webhook 服务提供，验证 Webhook API 密钥是否无效、过期或被撤销。

注意：Open WebUI 中的 webhook 功能仍在不断发展，我们计划在未来添加更多功能和事件类型。