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
- Unit tests for counters, gauges, histograms, summaries, registry queries, PushGateway URL formatting, process collector registration, and text exposition.
- Generated public API file: `src/prometheus/pkg.generated.mbti`
- CI workflow: `.github/workflows/test.yml`
- Manual mooncakes.io publish workflow: `.github/workflows/publish.yml`

## Local Validation

```bash
moon fmt --check
moon check --deny-warn
moon test --deny-warn
moon info
moon run cmd/main
```

Current MoonBit CLI supports `--deny-warn` for `check` and `test`. `moon fmt` supports `--check`/`--warn`, and `moon info` supports `--target`; neither currently accepts `--deny-warn` in `moon 0.1.20260713`.
