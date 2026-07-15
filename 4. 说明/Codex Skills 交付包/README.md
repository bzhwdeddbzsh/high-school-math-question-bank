# Codex Skills 交付包

这个目录用于记录本 vault 推荐使用的 Codex/agent skills，并在另一台只安装 Codex CLI 的 Mac 上通过 Skill Hub 一键安装。

完整准备步骤见 [Intel Mac 环境准备.md](Intel%20Mac%20环境准备.md)。

## 一键安装

在目标 Mac 上进入本目录安装 skills：

```bash
./install-codex-skills.sh
```

这个脚本会通过 Skill Hub 安装本 vault 需要的 skills。

真正安装后，skills 会进入：

```bash
${CODEX_HOME:-$HOME/.codex}/skills
```

本目录不保存第三方 skill 副本。已有上游来源的 skills 直接通过 Skill Hub 安装，保持仓库轻量。

安装 npm 全局工具：

```bash
./install-npm-deps.sh
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

## 本包通过 Skill Hub 安装的 skills

- `anthropics/skills@pdf`：PDF 读取、抽取文字/表格/图片、OCR、页面渲染、PDF 基础操作。
- `anthropics/skills@docx`：Word `.docx` 读取、创建、编辑、模板分析、XML 层编辑和排版控制。
- `kepano/obsidian-skills@defuddle`：网页正文抽取。
- `kepano/obsidian-skills@json-canvas`：Obsidian JSON Canvas。
- `kepano/obsidian-skills@obsidian-bases`：Obsidian Bases。
- `kepano/obsidian-skills@obsidian-cli`：Obsidian CLI 操作说明。
- `kepano/obsidian-skills@obsidian-markdown`：Obsidian Markdown 语法与写作规则。
- `vercel-labs/skills@find-skills`：查找和评估更多 skills。

## 当前环境里还有但不随本包迁移的 skills

- Codex 系统内置 skills：`imagegen`、`openai-docs`、`plugin-creator`、`skill-creator`、`skill-installer`。
- Codex 桌面版插件带来的 skills：浏览器控制、Chrome 控制、文档、表格、PDF、PPT、Sites、GitHub、Public Equity Investing 等。

这些通常跟 Codex 版本、桌面插件或连接器有关，不适合作为本 vault 的本地 requirements 固化。

## 额外依赖提醒

- `anthropics/skills@pdf` 和 `anthropics/skills@docx` 通过 `npx skills add ...` 安装，因此目标 Mac 需要 Node.js/npm。
- 使用 `defuddle` 前，目标 Mac 需要能运行 `defuddle` CLI；本包提供 `install-npm-deps.sh` 安装。
- 使用 `docx` skill 创建新 Word 文档时，建议安装 npm 全局包 `docx`；本包提供 `install-npm-deps.sh` 安装。
- 使用 `obsidian-cli` 前，目标 Mac 需要配置 Obsidian CLI，并且 Obsidian 应处于运行状态。
## 推荐安装顺序

```bash
# 1. 安装 Codex CLI
# 2. 安装 Node.js/npm，见 Intel Mac 环境准备.md

cd "4. 说明/Codex Skills 交付包"
./install-codex-skills.sh
./install-npm-deps.sh

# 3. 重启 Codex CLI
```
