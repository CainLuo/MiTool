每个 OpenAPI 文档都需要使用 openapi 密钥声明其格式版本。本文档使用 3.1.0 版本。

```yaml
openapi: '3.1.0'
```

信息部分包含服务名称 GreetingService，并声明了 API 版本。

```yaml
info:
  title: MiToolAPIService
  version: 1.0.0
```

服务器部分声明了现有服务 URL 列表。

```yaml
servers:
  - url: https://api-takumi-record.mihoyo.com
    description: Mihoyo service deployment.
  - url: https://example-takumi.mihoyo.com
    description: Example service deployment.
```

路径部分包含构成 API 的路径和 HTTP 操作列表。
服务器将在一个路径 /greet 上处理 HTTP GET 请求。提供操作 ID 可为代码生成器提供有用的提示，让其知道生成的方法应如何调用。

```yaml
paths:
  /game_record/card/api/getGameRecordCard:
    get:
      operationId: getGreeting
```

在参数部分记录可选的查询参数，提供要问候的人的姓名。

```yaml
      parameters:
        - name: name
          required: false
          in: query
          description: The name used in the returned greeting.
          schema:
            type: string
```

不同的响应也有记录。在这种情况下，服务器将始终返回 HTTP 状态代码 200。

```yaml
      responses:
        '200':
          description: A success response with a greeting.
```

在响应中，使用 JSON 模式描述 JSON 主体的结构。
在 #/components/schemas 部分中定义可重复使用的类型，将其命名为 "问候"，并在 JSON 响应体的响应定义中对其进行引用。

```yaml
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Greeting'
components:
  schemas:
    Greeting:
      type: object
      properties:
        message:
          type: string
      required:
        - message
```yaml
