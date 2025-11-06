# 常见问题解决指南

## Bundle Identifier 错误

如果遇到 "Cannot index window tabs due to missing main bundle identifier" 错误：

### 在 Xcode 中设置：

1. 选择项目文件（左侧导航栏最顶部的蓝色图标）
2. 选择 Target: `PDFToLongImage`
3. 打开 `Signing & Capabilities` 标签
4. 确保 `Automatically manage signing` 已勾选
5. 在 `Bundle Identifier` 中输入：`com.example.PDFToLongImage`（或你的组织标识符）

或者在 `General` 标签中的 `Identity` 部分设置 Bundle Identifier。

## Metal/IOSurface 警告

这些警告通常不影响功能，但可以通过以下方式减少：

### 已优化的代码
- 使用 `deviceRGB` 而不是 `calibratedRGB`
- 添加了明确的 `autoreleasepool` 来管理内存
- 使用更现代的位图渲染方法

### 如果仍然出现警告：

1. **降低缩放比例**：在 `ContentView.swift` 中将 `scale: 2.0` 改为 `scale: 1.5` 或 `scale: 1.0`

2. **检查系统设置**：
   - 系统设置 → 隐私与安全性 → 关闭 "自动图形切换"（如果可用）

3. **重启应用**：这些警告通常是系统级别的缓存问题

## 其他常见问题

### 应用无法运行
- 确保在 `Signing & Capabilities` 中正确配置了签名
- 对于开发，可以使用 "Sign to Run Locally"

### PDF 转换失败
- 确保 PDF 文件没有被加密
- 检查文件路径是否正确
- 确保有足够的磁盘空间

### 图片质量不理想
- 提高 `scale` 参数（在 `ContentView.swift` 的 `convertPDF` 方法中）
- 注意：更高的 scale 值会产生更大的文件
