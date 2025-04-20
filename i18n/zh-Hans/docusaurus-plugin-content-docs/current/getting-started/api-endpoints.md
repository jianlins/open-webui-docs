---
sidebar_position: 400
title: "🔗 API 端点"
---

本指南提供了有关如何有效地与 API 端点交互以使用我们的模型实现无缝集成和自动化的基本信息。请注意，这是一个实验性设置，可能会在未来进行更新以增强功能。

## 身份验证

为确保对 API 的安全访问，需要进行身份验证 🛡️。您可以使用 Bearer Token 机制对 API 请求进行身份验证。从 Open WebUI 的 **设置 > 账户** 获取您的 API 密钥，或者使用 JWT（JSON Web Token）进行身份验证。

## 重要 API 端点

### 📜 检索所有模型

- **端点**: `GET /api/models`
- **描述**: 获取通过 Open WebUI 创建或添加的所有模型。
- **示例**:

  ```bash
  curl -H "Authorization: Bearer YOUR_API_KEY" http://localhost:3000/api/models
  ```

### 💬 聊天完成

- **端点**: `POST /api/chat/completions`
- **描述**: 作为 OpenAI API 兼容的聊天完成端点，适用于 Open WebUI 上的模型，包括 Ollama 模型、OpenAI 模型和 Open WebUI 函数模型。

- **Curl 示例**:

  ```bash
  curl -X POST http://localhost:3000/api/chat/completions \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
        "model": "llama3.1",
        "messages": [
          {
            "role": "user",
            "content": "为什么天空是蓝色的？"
          }
        ]
      }'
  ```
  
- **Python 示例**:
  ```python
  import requests
  
  def chat_with_model(token):
      url = 'http://localhost:3000/api/chat/completions'
      headers = {
          'Authorization': f'Bearer {token}',
          'Content-Type': 'application/json'
      }
      data = {
        "model": "granite3.1-dense:8b",
        "messages": [
          {
            "role": "user",
            "content": "为什么天空是蓝色的？"
          }
        ]
      }
      response = requests.post(url, headers=headers, json=data)
      return response.json()
  ```

### 🦙 Ollama API 代理支持

如果您想直接与 Ollama 模型交互——包括生成嵌入或原始提示流式传输——Open WebUI 通过代理路由提供了对原生 Ollama API 的透明传递。

- **基础 URL**: `/ollama/<api>`
- **参考**: [Ollama API 文档](https://github.com/ollama/ollama/blob/main/docs/api.md)

#### 🔁 生成完成（流式传输）

```bash
curl http://localhost:3000/ollama/api/generate -d '{
  "model": "llama3.2",
  "prompt": "为什么天空是蓝色的？"
}'
```

#### 📦 列出可用模型

```bash
curl http://localhost:3000/ollama/api/tags
```

#### 🧠 生成嵌入

```bash
curl -X POST http://localhost:3000/ollama/api/embed -d '{
  "model": "llama3.2",
  "input": ["Open WebUI 很棒！", "让我们生成嵌入。"]
}'
```

这对于使用 Open WebUI 背后的 Ollama 模型构建搜索索引、检索系统或自定义管道是理想的。

### 🧩 检索增强生成 (RAG)

检索增强生成 (RAG) 功能允许您通过整合来自外部源的数据来增强响应。下面，您将找到通过 API 管理文件和知识集合的方法，以及如何在聊天完成中有效使用它们。

#### 上传文件

要在 RAG 响应中利用外部数据，您首先需要上传文件。上传文件的内容会自动提取并存储在向量数据库中。

- **端点**: `POST /api/v1/files/`
- **Curl 示例**:

  ```bash
  curl -X POST -H "Authorization: Bearer YOUR_API_KEY" -H "Accept: application/json" \
  -F "file=@/path/to/your/file" http://localhost:3000/api/v1/files/
  ```

- **Python 示例**:

  ```python
  import requests
  
  def upload_file(token, file_path):
      url = 'http://localhost:3000/api/v1/files/'
      headers = {
          'Authorization': f'Bearer {token}',
          'Accept': 'application/json'
      }
      files = {'file': open(file_path, 'rb')}
      response = requests.post(url, headers=headers, files=files)
      return response.json()
  ```

#### 将文件添加到知识集合

上传后，您可以将文件分组到知识集合中或在聊天中单独引用它们。

- **端点**: `POST /api/v1/knowledge/{id}/file/add`
- **Curl 示例**:

  ```bash
  curl -X POST http://localhost:3000/api/v1/knowledge/{knowledge_id}/file/add \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"file_id": "your-file-id-here"}'
  ```

- **Python 示例**:

  ```python
  import requests

  def add_file_to_knowledge(token, knowledge_id, file_id):
      url = f'http://localhost:3000/api/v1/knowledge/{knowledge_id}/file/add'
      headers = {
          'Authorization': f'Bearer {token}',
          'Content-Type': 'application/json'
      }
      data = {'file_id': file_id}
      response = requests.post(url, headers=headers, json=data)
      return response.json()
  ```

#### 在聊天完成中使用文件和集合

您可以在 RAG 查询中引用单个文件或整个集合，以获得丰富的响应。

##### 在聊天完成中使用单个文件

当您希望聊天模型的响应集中在特定文件的内容上时，这种方法很有益。

- **端点**: `POST /api/chat/completions`
- **Curl 示例**:

  ```bash
  curl -X POST http://localhost:3000/api/chat/completions \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
        "model": "gpt-4-turbo",
        "messages": [
          {"role": "user", "content": "解释这个文档中的概念。"}
        ],
        "files": [
          {"type": "file", "id": "your-file-id-here"}
        ]
      }'
  ```

- **Python 示例**:

  ```python
  import requests

  def chat_with_file(token, model, query, file_id):
      url = 'http://localhost:3000/api/chat/completions'
      headers = {
          'Authorization': f'Bearer {token}',
          'Content-Type': 'application/json'
      }
      payload = {
          'model': model,
          'messages': [{'role': 'user', 'content': query}],
          'files': [{'type': 'file', 'id': file_id}]
      }
      response = requests.post(url, headers=headers, json=payload)
      return response.json()
  ```

##### 在聊天完成中使用知识集合

当查询可能受益于更广泛的上下文或多个文档时，利用知识集合来增强响应。

- **端点**: `POST /api/chat/completions`
- **Curl 示例**:

  ```bash
  curl -X POST http://localhost:3000/api/chat/completions \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
        "model": "gpt-4-turbo",
        "messages": [
          {"role": "user", "content": "提供关于集合中涵盖的历史观点的见解。"}
        ],
        "files": [
          {"type": "collection", "id": "your-collection-id-here"}
        ]
      }'
  ```

- **Python 示例**:

  ```python
  import requests
  
  def chat_with_collection(token, model, query, collection_id):
      url = 'http://localhost:3000/api/chat/completions'
      headers = {
          'Authorization': f'Bearer {token}',
          'Content-Type': 'application/json'
      }
      payload = {
          'model': model,
          'messages': [{'role': 'user', 'content': query}],
          'files': [{'type': 'collection', 'id': collection_id}]
      }
      response = requests.post(url, headers=headers, json=payload)
      return response.json()
  ```

这些方法通过上传的文件和精心策划的知识集合，有效地利用外部知识，增强使用 Open WebUI API 的聊天应用程序的能力。无论是单独使用文件还是在集合中使用，您都可以根据特定需求自定义集成。

## 使用 Open WebUI 作为统一 LLM 提供商的优势

Open WebUI 提供了众多好处，使其成为开发者和企业的重要工具：

- **统一界面**：通过单一集成平台简化与不同 LLM 的交互。
- **易于实施**：通过全面的文档和社区支持快速开始集成。

## Swagger 文档链接

::::important
确保设置 `ENV` 环境变量为 `dev`，以便访问这些服务的 Swagger 文档。没有此配置，文档将不可用。
::::

访问 Open WebUI 提供的不同服务的详细 API 文档：

| 应用 | 文档路径 |
|-------------|-------------------------|
| 主要 | `/docs` |


通过遵循这些指南，您可以迅速集成并开始使用 Open WebUI API。如果您遇到任何问题或有疑问，请随时通过我们的 Discord 社区联系或查阅常见问题解答。编码愉快！🌟