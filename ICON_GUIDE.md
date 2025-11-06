# 应用图标创建指南

## 📐 所需尺寸

macOS 应用图标需要以下尺寸（所有尺寸都需要 @1x 和 @2x 版本）：

| 尺寸 | @1x | @2x |
|------|-----|-----|
| 小图标 | 16x16 | 32x32 |
| 中图标 | 32x32 | 64x64 |
| 大图标 | 128x128 | 256x256 |
| 超大图标 | 256x256 | 512x512 |
| App Store | 512x512 | 1024x1024 |

**实际需要的文件：**
- 16x16.png
- 32x32.png
- 128x128.png
- 256x256.png
- 512x512.png
- 1024x1024.png

## 🎨 设计建议

### 图标设计原则

1. **简洁明了**
   - 图标应该在小尺寸下也能清晰识别
   - 避免过多细节

2. **符合 macOS 风格**
   - 使用 macOS 设计语言
   - 圆角矩形背景（可选）
   - 适当的阴影和光泽效果

3. **主题相关**
   - 体现 PDF 和图片转换的功能
   - 可以使用文档和图片相关的图标元素

### 设计工具

- **Sketch**（推荐）
- **Figma**（免费）
- **Adobe Illustrator**
- **在线工具**：如 [IconKitchen](https://icon.kitchen/)

## 📦 在 Xcode 中添加图标

### 方法一：使用 Asset Catalog（推荐）

1. 在 Xcode 项目中，找到 `Assets.xcassets`
2. 如果已有 `AppIcon`，点击它；如果没有，右键 → `New App Icon`
3. 将对应尺寸的图片拖入相应位置
4. 确保所有尺寸都已填充

### 方法二：手动创建 AppIcon.appiconset

1. 在项目目录创建 `AppIcon.appiconset` 文件夹
2. 创建 `Contents.json` 文件（见下方模板）
3. 将图标文件放入文件夹
4. 在 Xcode 中添加资源

### Contents.json 模板

```json
{
  "images" : [
    {
      "filename" : "icon_16x16.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "16x16"
    },
    {
      "filename" : "icon_16x16@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "16x16"
    },
    {
      "filename" : "icon_32x32.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "32x32"
    },
    {
      "filename" : "icon_32x32@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "32x32"
    },
    {
      "filename" : "icon_128x128.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "128x128"
    },
    {
      "filename" : "icon_128x128@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "128x128"
    },
    {
      "filename" : "icon_256x256.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "256x256"
    },
    {
      "filename" : "icon_256x256@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "256x256"
    },
    {
      "filename" : "icon_512x512.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "512x512"
    },
    {
      "filename" : "icon_512x512@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "512x512"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
```

## 🚀 快速生成图标

如果你有一个 1024x1024 的主图标，可以使用以下方法生成其他尺寸：

### 使用 ImageMagick（命令行）

```bash
# 安装 ImageMagick（如果未安装）
brew install imagemagick

# 从 1024x1024 生成所有尺寸
convert icon_1024x1024.png -resize 16x16 icon_16x16.png
convert icon_1024x1024.png -resize 32x32 icon_32x32.png
convert icon_1024x1024.png -resize 128x128 icon_128x128.png
convert icon_1024x1024.png -resize 256x256 icon_256x256.png
convert icon_1024x1024.png -resize 512x512 icon_512x512.png

# 生成 @2x 版本（实际上就是原尺寸）
cp icon_32x32.png icon_16x16@2x.png
cp icon_64x64.png icon_32x32@2x.png
# ... 以此类推
```

### 使用在线工具

- [AppIcon.co](https://www.appicon.co/) - 上传一张图片，自动生成所有尺寸
- [IconKitchen](https://icon.kitchen/) - Google 的图标生成工具

## ✅ 验证图标

在 Xcode 中：
1. 选择项目 → Target → `General` 标签
2. 查看 `App Icons` 部分
3. 确保所有尺寸都已显示（没有警告）
4. 运行应用，检查 Dock 中的图标显示是否正确

## 💡 设计灵感

可以参考以下应用图标：
- PDF Expert
- Preview（macOS 自带）
- 其他 PDF 工具应用

记住：图标是用户对应用的第一印象，值得投入时间设计一个好的图标！
