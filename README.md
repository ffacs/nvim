# Neovim 配置（macOS / Linux）

## 迁移到新机器

1. 安装 Neovim 0.10 或更新版本，并确保 `nvim` 在 PATH 中。
2. 将整个目录复制到 `~/.config/nvim`（使用 XDG 时为 `$XDG_CONFIG_HOME/nvim`），**包含 `lazy-lock.json`**。
3. 在终端运行一次：

```sh
bash ~/.config/nvim/bootstrap.sh
```

脚本会检查系统依赖、安装缺失的依赖，再下载锁定版本的插件和配置中全部语言服务。完成后打开 Neovim 即可。重复运行会补齐缺失项，不主动升级已安装插件或语言服务。

- macOS 使用已安装的 Homebrew；Linux 支持 apt、dnf、pacman。系统安装可能需要 sudo。
- 依赖：Git、curl、tar、gzip、unzip、ripgrep、Node.js >= 20（含 npm）、Python >= 3.10（含 venv/ensurepip）。旧发行版的 Node/Python 可能需要先升级。
- Python 只用于 Python/CMake 语言服务安装，不作为 Neovim provider，不需要 pynvim。
- 网络需能访问 GitHub、npm 和 PyPI。没有安装权限时，可先自行准备依赖，再运行 `bash bootstrap.sh --no-system`。
- 只检查依赖、不安装：`bash bootstrap.sh --check`。
- 自定义 Neovim 路径：`NVIM_BIN=/path/to/nvim bash bootstrap.sh`。
- 不要复制旧机器的插件目录、Mason 可执行文件或 Python 虚拟环境；它们可能与目标架构不兼容。

仅复制配置并启动 Neovim，也会自动下载插件及缺失的语言服务，但不会偷偷调用 sudo 安装系统软件；新机器建议先运行上述脚本。首次安装完成前，相应语言服务尚不可用。

## 版本与故障处理

`lazy-lock.json` 应随配置一起提交和复制，避免新机器下载到不兼容的最新版。lazy.nvim 自身也按锁定提交引导安装。升级插件后应重新验证配置并提交锁文件。

安装失败时检查 `:Lazy`、`:Mason` 和 `:MasonLog`，解决网络或系统依赖问题后重新运行初始化脚本。语言服务下载由 Mason 的当前注册表决定，并非与插件一样锁定版本。Rust 的 cargo/rustc、C/C++ 编译器及项目依赖仍由项目开发环境提供。

## 常用快捷键

Leader 键为空格。

| 快捷键 | 功能 |
| --- | --- |
| Ctrl-p / 空格 ff | 查找当前工作目录下的文件 |
| 空格 fg | 搜索当前工作目录中的文本（rg） |
| 空格 fb / fr / fh | buffer / 最近文件 / 帮助 |
| 空格 f | 当前文件函数（LSP） |
| 空格 o / ft | 当前文件符号（LSP） |
| F2 | 打开/关闭内置文件浏览器（netrw） |
| s | Flash：输入目标文字，再按标签跳转 |
| K / gd / gr / gi | 文档 / 定义 / 引用 / 实现 |
| 空格 rn / ca | 重命名 / 代码操作 |
| 空格 e / [d / ]d | 诊断详情 / 上一个 / 下一个诊断 |
| 空格 k / q | 参数签名 / 诊断列表 |
| 空格 = | 格式化；v/V 模式格式化选区（需 LSP 支持） |
