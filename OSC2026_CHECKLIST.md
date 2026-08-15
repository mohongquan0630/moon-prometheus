# OSC2026 Acceptance Checklist

## Repository

- Public repository: https://gitlink.org.cn/mohongquan0630/moon-prometheus
- Default branch: `main`
- License: Apache-2.0
- Primary language: MoonBit
- Mooncakes package name: `mohongquan0630/moon-prometheus`
- Contributor policy: GitLink keeps the repository owner's account as the visible contributor identity.

## Engineering Artifacts

- Clear README with install, usage, development, scope, and source statements.
- Runnable example: `moon run cmd/main`
- 25 unit tests covering counters, gauges, histogram normalization, summary quantiles, label escaping, metric contracts, registry queries, PushGateway URL formatting, portable process samples, deterministic benchmarks, and text exposition.
- Generated public API file: `src/prometheus/pkg.generated.mbti`
- CI workflow: `.github/workflows/test.yml`
- Manual mooncakes.io publish workflow: `.github/workflows/publish.yml`

## Scope and compliance notes

- The repository contains about 1,350 lines of tracked MoonBit source and tests; the companion plasma repository brings the local acceptance set above 3,000 lines without counting caches or generated dependencies.
- `ProcessCollector` is deliberately portable sample storage. It does not claim to probe OS metrics automatically.
- `PushGateway` builds an escaped URL and exposition payload. It does not perform network I/O.
- The only non-core dependency is `bobzhang/crescent@0.10.0`, used for integration notes and kept under its Apache-2.0 license; see `THIRD_PARTY_NOTICES.md`.

## Local Validation

```bash
moon fmt --check
moon check --deny-warn
moon test --deny-warn
moon info --target all
moon run cmd/main
```

The local acceptance toolchain reports `moonc v0.10.3`. `moon check` and `moon test` support `--deny-warn`; `moon fmt` supports `--check`, and `moon info` supports `--target`. The current CLI rejects `--deny-warn` for `fmt` and `info`, so the strict equivalent is `moon fmt --check` plus `moon info --target all`.
