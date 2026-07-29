# MoonBit 2026 基础软件生态开源大赛申报书

## 1. 项目名称
**moon-prometheus**

## 2. 项目简介
**moon-prometheus** 是 MoonBit 生态下首个云原生指标监控（Metrics）与可观测性（Observability）库，旨在为运行在服务端的 MoonBit 应用提供高标准、低开销的 Prometheus 指标插桩与采集能力，输出标准的 OpenMetrics 文本格式数据。

## 3. 项目方向与适用场景
**方向**：基础软件生态 / 云原生可观测性
**适用场景**：
- **微服务监控**：为 MoonBit 编写的微服务（例如基于 Crescent 框架）提供核心业务指标暴露能力。
- **系统监控**：在各种底层系统工具中收集性能参数（如内存占用、响应延迟）。
- **边缘计算**：在资源受限的环境中轻量化地统计调用次数与耗时，通过 Pull 或 Push 的方式上传给监控端。

## 4. 拟实现的核心功能（已完成）
1. **统一注册中心 (Registry)**：提供全局的指标（Metrics）注册与管理，聚合所有的监控数据。
2. **多维标签支持 (Labels)**：核心数据模型支持基于键值对（Key-Value）的多维度过滤。
3. **Counter (计数器)**：一种只能递增的指标，适用于统计如请求总数、错误总数等。
4. **Gauge (仪表盘)**：一种可以任意增减的指标，适用于统计如当前内存使用量、并发连接数等。
5. **Histogram (直方图)**：将观测值放入配置的桶（Buckets）中，提供数据的分布概况，极度适合统计请求延迟（P99, P95等）。
6. **标准文本输出引擎 (Text Exposition Format)**：严格遵循 Prometheus 指标暴露标准，确保生成的文本可以直接被 Prometheus Server 抓取。

## 5. 是否为原创项目、移植项目或参考已有开源项目
- **原创项目**。本项目在底层实现、数据结构设计与内存模型均完全由团队使用 MoonBit 从零开发，未直接移植任何代码，以保证最佳的 MoonBit 原生体验。
- **参考标准**：API 设计与文本协议完全参考 CNCF Prometheus 官方设定的 OpenMetrics 规范。

## 6. 公开仓库与提交状态
- GitLink 仓库：<https://gitlink.org.cn/mohongquan0630/moon-prometheus>
- 默认分支：`main`
- 仓库避免无意义的重复提交和空提交，提交历史覆盖架构搭建、核心指标类型、文本序列化、PushGateway、Crescent 集成说明、测试和验收修正。
- GitLink 侧仅保留账号创建者本人作为贡献者身份，不为了对齐 GitHub 用户制造虚拟贡献者。

## 7. 验收补充
- README 已补充安装、示例、开发命令、范围边界和来源声明。
- CI 已补充 `.github/workflows/test.yml`，覆盖 Linux、macOS、Windows。
- 发布工作流已补充 `.github/workflows/publish.yml`，用于配置 mooncakes.io 凭证后手动发布。
- 当前本地验证命令：`moon fmt --check`、`moon check --deny-warn`、`moon test --deny-warn`、`moon info`、`moon run cmd/main`。
