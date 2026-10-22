# 银联支付控件 Mac 版 / 网银支付插件 (UnionPay Payment Plugin for Mac)

> 专为 macOS（支持 Apple 芯片 M1/M2/M3/M4 及 Intel）打造的银联在线支付与网银支付控件兼容工具。一键解决 Mac 上点击“确认支付”后提示“请先下载安装网银支付插件”或 `openIE` 协议无响应的问题。

[中文说明](#中文说明) | [English](#english)

---

## 中文说明

### 问题背景

在使用部分网站的**银联在线支付**或**网银支付**收银台时，页面常提示：
> *“由于部分网银仅支持IE浏览器，支付需要跳转IE浏览器进行，仅支持Windows11以下的Windows系统。如果未弹出网银支付界面，请先下载安装网银支付插件，安装完成后刷新页面重试。”*

用户下载到的通常是一个名为 `iePlugin.exe` 的 Windows 可执行文件。经过逆向工程分析：
- 该文件**并非**传统的密码加密驱动或 ActiveX 二进制插件；
- 其真实逻辑是为系统注册一个自定义协议 `openIE://`，点击“确认支付”时唤起批处理脚本，把带有 `separator` 参数的支付链接转换并强行用 Windows IE 浏览器打开。

在 macOS 上，由于系统没有注册 `openIE:` 协议，点击支付按钮时没有任何反应，导致用户无法正常付款。

### 本工具的作用

本工具是该 Windows 控件的 **Mac 原生替代实现**：
1. **接管协议**：在 macOS LaunchServices 中原生注册 `openIE://` 协议，无任何第三方依赖。
2. **解码还原**：接收支付请求，自动去除协议头并将 `separator` 转换为标准的 `&` 参数。
3. **原生调起**：直接调用 Mac 默认浏览器（Safari / Chrome / Edge）打开真实的银联收银台。

在弹出的银联官方支付页面中，用户可直接使用**云闪付 App 扫码**、**各大手机银行 App 扫码**或**快捷支付**轻松完成交易，全程无需虚拟机或 Windows 系统。

---

### 安装方法

在终端运行以下一键安装命令：

```bash
git clone https://github.com/BLACKIELF/unionpay-payment-plugin-mac.git
cd unionpay-payment-plugin-mac
chmod +x install.sh
./install.sh
```

**安装后使用**：
1. 回到支付页面，刷新网页；
2. 再次点击【确认支付】；
3. 浏览器弹窗提示“是否允许打开 OpenIE Handler？”，点击【允许】；
4. 默认浏览器将立即打开银联在线支付页面。

---

### 卸载方法

如果不再需要该工具，运行以下命令即可完全清理：

```bash
cd unionpay-payment-plugin-mac
chmod +x uninstall.sh
./uninstall.sh
```

或直接在终端删除应用包：
```bash
rm -rf ~/Applications/OpenIEHandler.app
```

---

### 免安装方案（书签脚本）

如果你不想在系统安装应用，可以直接使用项目中的 [`bookmarklet.js`](./bookmarklet.js)：
在支付页面打开浏览器开发者工具（F12 -> Console 控制台），粘贴脚本并回车，即可直接点击支付按钮正常跳转。

---

## English

### Overview

`unionpay-payment-plugin-mac` is a native macOS compatibility tool designed for UnionPay online checkout and online banking gateways that historically depend on a Windows-only `iePlugin.exe` launcher.

When checking out on certain portals, users are instructed to install an "Online Banking Payment Plugin" to launch Internet Explorer via `openIE:`. On macOS, this results in broken links or unhandled protocol errors.

This tool acts as a native drop-in replacement on macOS (supporting Apple Silicon M1-M4 and Intel) by registering the `openIE://` scheme, decoding the actual target URL, and opening it in modern macOS web browsers natively.

### Installation

```bash
git clone https://github.com/BLACKIELF/unionpay-payment-plugin-mac.git
cd unionpay-payment-plugin-mac
chmod +x install.sh
./install.sh
```

### Uninstallation

```bash
cd unionpay-payment-plugin-mac
chmod +x uninstall.sh
./uninstall.sh
```

---

## 许可证 (License)

本项目采用 [MIT License](./LICENSE) 开源协议。
