# Codex Skills 交付包

这个目录用于把当前机器上的个人 skills 迁移到另一台只安装 Codex CLI 的 Mac。

## 一键安装

在目标 Mac 上进入本目录，执行：

```bash
./install-codex-skills.sh
```

默认安装位置：

```bash
${CODEX_HOME:-$HOME/.codex}/skills
```

如果目标机器上已经存在同名 skill，脚本会跳过。需要用本包覆盖时执行：

```bash
./install-codex-skills.sh --replace
```

`--replace` 会先把原目录改名为 `.backup-时间戳`，再安装本包副本。

## 本包包含的个人 skills

- `hatch-pet`
- `defuddle`
- `find-skills`
- `json-canvas`
- `obsidian-bases`
- `obsidian-cli`
- `obsidian-markdown`

## 当前环境里还有但不随本包迁移的 skills

- Codex 系统内置 skills：`imagegen`、`openai-docs`、`plugin-creator`、`skill-creator`、`skill-installer`。
- Codex 桌面版插件带来的 skills：浏览器控制、Chrome 控制、文档、表格、PDF、PPT、Sites、GitHub、Public Equity Investing 等。

这些通常跟 Codex 版本、桌面插件或连接器有关，不适合作为本 vault 的本地 requirements 固化。

## 额外依赖提醒

- 使用 `defuddle` 前，目标 Mac 需要能运行 `defuddle` CLI：`npm install -g defuddle`。
- 使用 `obsidian-cli` 前，目标 Mac 需要配置 Obsidian CLI，并且 Obsidian 应处于运行状态。
- `hatch-pet` 正常生成图片时依赖 Codex 的系统 `imagegen` skill。
