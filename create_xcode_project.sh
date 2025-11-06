#!/bin/bash

# 创建 Xcode 项目的脚本
# 使用方法: ./create_xcode_project.sh

PROJECT_NAME="PDFToLongImage"
BUNDLE_ID="com.example.PDFToLongImage"

echo "创建 Xcode 项目: $PROJECT_NAME"

# 创建项目目录
mkdir -p "$PROJECT_NAME.xcodeproj"

cat > "$PROJECT_NAME.xcodeproj/project.pbxproj" << 'EOF'
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 56;
	objects = {
		/* 项目配置 */
		/* 注意: 这是一个简化的项目文件模板 */
		/* 建议使用 Xcode 创建新项目后替换这些文件 */
	};
	rootObject = /* Project object */;
}
EOF

echo "项目结构已创建！"
echo ""
echo "要在 Xcode 中打开项目："
echo "1. 打开 Xcode"
echo "2. 选择 File > New > Project"
echo "3. 选择 macOS > App"
echo "4. 项目名称: $PROJECT_NAME"
echo "5. Bundle Identifier: $BUNDLE_ID"
echo "6. 语言: Swift"
echo "7. 界面: SwiftUI"
echo "8. 创建项目后，将源代码文件添加到项目中"
echo ""
echo "或者直接使用 Swift Package Manager:"
echo "  swift build"
echo "  swift run PDFToLongImage"
