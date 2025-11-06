# PDF 转长图 - 快速启动指南

## 📦 使用 Xcode 运行（最简单）

1. **打开 Xcode**（如果没有，从 App Store 安装）

2. **创建新项目**：
   - 菜单: `File` → `New` → `Project`
   - 选择: `macOS` → `App`
   - 点击 `Next`

3. **配置项目**：
   - Product Name: `PDFToLongImage`
   - Team: 选择你的 Apple ID（如果没有，点击 "Add Account"）
   - Organization Identifier: `com.example`（或你的域名）
   - Bundle Identifier: 会自动生成
   - Interface: `SwiftUI`
   - Language: `Swift`
   - 取消勾选 "Use Core Data"
   - 点击 `Next`

4. **选择保存位置**：
   - 选择项目保存位置（不要保存在 PDFToLongImage 文件夹内）
   - 点击 `Create`

5. **替换文件**：
   - 删除 Xcode 自动生成的 `ContentView.swift` 和 `PDFToLongImageApp.swift`
   - 将 `PDFToLongImage/` 目录下的所有 `.swift` 文件拖入 Xcode 项目
   - 确保勾选 "Copy items if needed" 和你的 Target

6. **更新 Info.plist**（可选）：
   - 打开项目设置 → `Info` 标签
   - 将 `PDFToLongImage/Info.plist` 中的内容合并进去

7. **运行**：
   - 点击左上角的运行按钮（▶️）或按 `Cmd + R`
   - 应用窗口会打开

## 🚀 使用方法

1. 点击 **"选择 PDF 文件"** 按钮
2. 选择一个 PDF 文件
3. 点击 **"转换为长图"** 按钮
4. 选择保存位置
5. 等待处理完成

## ⚙️ 自定义设置

在 `PDFProcessor.swift` 中可以调整：

- **缩放比例**：修改 `scale` 参数（默认 2.0）
  - 更高的值 = 更清晰的图片，但文件更大
  - 更低的值 = 更小的文件，但可能不够清晰

## 🐛 常见问题

**Q: 编译错误？**
- 确保最低系统版本设置为 macOS 12.0
- 清除构建缓存：`Product` → `Clean Build Folder` (Shift+Cmd+K)

**Q: 应用无法打开？**
- 首次运行可能需要: `系统设置` → `隐私与安全性` → 允许运行

**Q: 转换失败？**
- 确保 PDF 文件没有被加密或损坏
- 检查是否有足够的磁盘空间

**Q: 图片太大？**
- 降低 `scale` 参数（在 `ContentView.swift` 的 `convertPDF` 方法中）

## 📝 技术说明

- 使用 `PDFKit` 框架渲染 PDF 页面
- 使用 `NSImage` 和 `NSBitmapImageRep` 处理图片
- 所有页面垂直拼接，不同宽度的页面会居中对齐
- 输出为 PNG 格式，支持透明背景
