# MoonBit 2026 基础软件生态开源大赛申报书
## 项目名称
`moon-prometheus`
## 项目简介
面向 MoonBit 服务端、批处理和边缘应用的 Prometheus 指标与可观测性库，提供低开销、可复用的指标模型和标准文本输出。
## 项目方向与场景
方向为基础软件生态 / 云原生可观测性，服务微服务插桩、系统样本收集、批处理任务和边缘指标导出。
## 核心功能与交付
- Counter、Gauge、Histogram、Summary 及多维标签模型，支持名称校验、转义和标签规范化。
- Registry 注册、查询、移除和确定性文本序列化，输出 HELP、TYPE、累计桶、分位数和聚合值。
- MetricDescriptor 合约校验、可移植 ProcessCollector 样本、PushGateway URL/载荷构造器。
- Crescent 原生 middleware、`/metrics` handler、28 个测试、生成的 `.mbti` API 摘要、确定性 benchmark 与可运行 CLI。
## 原创与参考
项目为原创 MoonBit 实现，未复制第三方源码；API 语义参考 Prometheus/OpenMetrics 公开规范。Crescent 集成使用 Apache-2.0 的 `bobzhang/crescent@0.11.0`，仅在 native 子包中启用。
## 仓库与许可证
GitLink：<https://gitlink.org.cn/mohongquan0630/moon-prometheus>；默认分支：`main`；模块名：`mohongquan0630/moon-prometheus`；许可证：Apache-2.0。
## 工程与验收
README 提供安装、使用和范围边界；`moon run cmd/main` 可复现实例与 benchmark；CI 覆盖 Linux、macOS、Windows，并运行格式、全目标检查、测试和接口生成；发布工作流支持 mooncakes.io 手动发布。
