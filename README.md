# PDF 转长图 macOS 应用

一个简单易用的 macOS 应用程序，可以将 PDF 文件的所有页面转换为单张垂直拼接的长图。

## 功能特性

- 🎨 简洁美观的用户界面
- 📄 支持选择 PDF 文件
- 🖼️ 自动将 PDF 所有页面拼接成长图
- 💾 保存为 PNG 格式
- ⚡ 高质量输出（2x 缩放，确保清晰度）
- 🔄 实时处理进度显示

## 系统要求

- macOS 12.0 或更高版本
- Xcode 14.0 或更高版本（用于开发）
- Swift 5.9+（用于命令行构建）

## 使用方法

### 方法一：使用 Xcode（推荐）

1. **打开 Xcode**，创建新项目：
   - 选择 "macOS" > "App"
   - 项目名称: `PDFToLongImage`
   - Bundle Identifier: `com.example.PDFToLongImage`
   - 语言: Swift
   - 界面: SwiftUI
   - 最低系统版本: macOS 12.0

2. **替换默认文件**：
   - 将 `PDFToLongImage/` 目录下的所有 `.swift` 文件添加到项目中
   - 将 `Info.plist` 的内容合并到项目的 Info.plist 中

3. **运行项目**：按 `Cmd + R` 运行应用

### 方法二：使用 Swift Package Manager

```bash
cd PDFToLongImage
swift build
swift run PDFToLongImage
```

或者使用构建脚本：

```bash
./build.sh
```

## 操作步骤

1. 启动应用后，点击 **"选择 PDF 文件"** 按钮
2. 在文件选择器中选择要转换的 PDF 文件
3. 点击 **"转换为长图"** 按钮
4. 选择保存位置和文件名
5. 等待处理完成（会显示进度条）
6. 转换完成后会显示成功提示

## 项目结构

```
PDFToLongImage/
├── PDFToLongImageApp.swift   # 应用入口
├── ContentView.swift         # 主界面 UI
├── PDFProcessor.swift        # PDF 处理核心逻辑
├── Info.plist               # 应用配置信息
└── Package.swift            # Swift Package Manager 配置
```

## 技术实现

### 核心功能

1. **PDF 转图片** (`PDFProcessor.convertPDFToImages`)
   - 使用 `PDFKit` 读取 PDF 文档
   - 将每一页渲染为 `NSImage`
   - 支持自定义缩放比例（默认 2x）

2. **图片拼接** (`PDFProcessor.combineImagesVertically)
   - 将所有页面图片垂直拼接
   - 自动居中对齐不同宽度的页面
   - 生成单张长图

3. **保存图片** (`PDFProcessor.saveImage`)
   - 将 `NSImage` 转换为 PNG 格式
   - 保存到用户指定的位置

### 使用的框架

- **SwiftUI**: 现代 UI 框架
- **PDFKit**: Apple 提供的 PDF 处理框架
- **AppKit**: macOS 应用程序框架

## 注意事项

- 大型 PDF 文件（多页或高分辨率）可能需要较长的处理时间
- 输出图片的大小取决于 PDF 页面的数量和尺寸
- 建议在处理大文件时保持应用窗口打开

## 许可证

MIT License
