#!/bin/bash

# PDF 转长图 macOS 应用构建脚本

cd "$(dirname "$0")/PDFToLongImage"

echo "正在构建 PDF 转长图应用..."
echo ""

# 检查 Swift 是否安装
if ! command -v swift &> /dev/null; then
    echo "错误: 未找到 Swift。请先安装 Xcode Command Line Tools:"
    echo "  xcode-select --install"
    exit 1
fi

# 构建项目
echo "步骤 1/2: 编译项目..."
swift build

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 构建成功！"
    echo ""
    echo "运行应用:"
    echo "  swift run PDFToLongImage"
    echo ""
    echo "或在 Xcode 中打开项目进行开发"
else
    echo ""
    echo "❌ 构建失败"
    exit 1
fi
