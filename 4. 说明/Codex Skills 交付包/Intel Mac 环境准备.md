# Intel Mac 环境准备

这份说明面向只安装 Codex CLI 的 Intel 芯片 Mac，用于复现本题库需要的基础能力。

## 1. 安装 Node.js/npm

推荐安装 Node.js LTS。安装后会同时得到 `node` 和 `npm`。

### 方案 A：官网下载 pkg 安装包

适合不想先装 Homebrew 的机器。

1. 打开 <https://nodejs.org/>
2. 下载 macOS Installer，选择 LTS 版本。
3. 按安装器提示完成安装。
4. 打开终端验证：

```bash
node --version
npm --version
```

### 方案 B：Homebrew 安装

适合后续还要安装 `pandoc`、`tesseract` 等命令行工具的机器。

先安装 Homebrew：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Intel Mac 默认 Homebrew 路径通常是 `/usr/local`。安装完成后，如果终端提示需要配置 shell 环境，按提示执行。

然后安装 Node.js：

```bash
brew install node
node --version
npm --version
```

## 2. 安装本包的 Codex skills

进入本目录：

```bash
cd "4. 说明/Codex Skills 交付包"
./install-codex-skills.sh
```

如果目标机器已有同名 skill，脚本默认跳过。需要覆盖时：

```bash
./install-codex-skills.sh --replace
```

## 3. 安装 npm 全局工具

本包目前的 npm 全局依赖写在：

```bash
npm-global-requirements.txt
```

安装：

```bash
./install-npm-deps.sh
```

目前包含：

- `defuddle`：网页正文抽取工具，用于把网页资料清理成 Markdown。
- `docx`：Anthropic `docx` skill 推荐的 Word 文档生成库，用于从零创建 `.docx`。

手动安装等价命令：

```bash
npm install -g defuddle docx
```

## 4. PDF 和 Word 相关系统依赖

本包通过 Skill Hub 安装：

- `anthropics/skills@pdf`
- `anthropics/skills@docx`

建议额外准备这些命令行工具：

```bash
brew install poppler pandoc libreoffice
```

- `poppler`：提供 `pdftotext`、`pdftoppm`、`pdfimages`，用于 PDF 抽文字、渲染页面、抽取图片。
- `pandoc`：用于读取 `.docx` 模板内容、Markdown/LaTeX 到 Word 的转换辅助。
- `libreoffice`：用于 `.doc` 转 `.docx`、`.docx` 转 PDF 预览，以及处理部分复杂 Word 文件。

如果目标机不用 Homebrew，也可以分别从 Node.js、Pandoc、LibreOffice 官网下载 macOS pkg/dmg 安装包。Poppler 最省心的安装方式仍然是 Homebrew。

## 5. 出卷相关的 Python 依赖

PDF 和 Word 现成 skill 会按任务选择工具。为了高中数学题库入库和出卷更顺，建议安装：

```bash
python3 -m pip install pillow pypdf pymupdf pdfplumber python-docx reportlab pytesseract pdf2image
```

说明：

- `pypdf`、`pdfplumber`、`pymupdf`：PDF 文字、布局、页面处理。
- `pillow`：图片裁切与格式处理。
- `python-docx`：Python 侧读写 `.docx` 的补充方案。
- `reportlab`：需要生成 PDF 时可用。
- `pytesseract`、`pdf2image`：扫描版 PDF 的 OCR 辅助；若不用 OCR，可暂不安装。

## 6. 验证

安装完成后，建议重新打开 Codex CLI，并验证：

```bash
codex --version
node --version
npm --version
defuddle --version
which docx || true
pdftotext -v
pdftoppm -v
pandoc --version
```

如果 `defuddle --version` 不支持，也可以用：

```bash
which defuddle
```
