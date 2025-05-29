#!/bin/bash

# Cursor 自动规则生成与敏捷工作流应用脚本 - 中文版
# 作者: bmadcode
# 描述: 将 Cursor 规则和敏捷工作流模板应用到项目中

set -e  # 遇到错误时退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # 无颜色

# 打印带颜色的消息
print_colored() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

print_header() {
    echo
    print_colored $CYAN "🚀 Cursor 自动规则生成与敏捷工作流 🚀"
    echo
}

print_success() {
    print_colored $GREEN "✅ $1"
}

print_warning() {
    print_colored $YELLOW "⚠️  $1"
}

print_error() {
    print_colored $RED "❌ $1"
}

print_info() {
    print_colored $BLUE "ℹ️  $1"
}

# 显示使用说明
show_usage() {
    print_colored $PURPLE "用法: $0 <目标项目路径>"
    echo
    print_info "此脚本将 Cursor 规则和敏捷工作流模板应用到指定的项目目录中"
    echo
    print_colored $YELLOW "示例:"
    echo "  $0 ~/projects/my-project"
    echo "  $0 /d/Projects/my-web-app"
    echo "  $0 ../existing-project"
    echo
    print_info "脚本功能："
    echo "  • 创建 .cursor/rules/ 目录结构"
    echo "  • 复制核心规则文件"
    echo "  • 设置 .gitignore 和 .cursorignore"
    echo "  • 创建工作流文档"
    echo "  • 保留现有规则"
    echo
}

# 检查参数
if [ $# -eq 0 ]; then
    print_error "错误：缺少目标项目路径参数"
    echo
    show_usage
    exit 1
fi

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    show_usage
    exit 0
fi

TARGET_DIR="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_header

print_info "目标项目路径: $TARGET_DIR"
print_info "脚本位置: $SCRIPT_DIR"

# 创建目标目录（如果不存在）
if [ ! -d "$TARGET_DIR" ]; then
    print_info "创建项目目录: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
    print_success "项目目录创建成功"
else
    print_info "项目目录已存在: $TARGET_DIR"
fi

cd "$TARGET_DIR"

# 创建 .cursor/rules 目录
print_info "设置 Cursor 规则目录结构..."
mkdir -p .cursor/rules

# 复制规则文件
print_info "复制核心规则文件..."

# 复制原版英文规则
if [ -f "$SCRIPT_DIR/.cursor/rules/000-cursor-rules.mdc" ]; then
    cp "$SCRIPT_DIR/.cursor/rules/000-cursor-rules.mdc" .cursor/rules/
    print_success "已复制: 000-cursor-rules.mdc (英文版)"
fi

# 复制中文版规则
if [ -f "$SCRIPT_DIR/.cursor/rules/000-cursor-rules-cn.mdc" ]; then
    cp "$SCRIPT_DIR/.cursor/rules/000-cursor-rules-cn.mdc" .cursor/rules/
    print_success "已复制: 000-cursor-rules-cn.mdc (中文版)"
fi

# 复制其他规则文件
if [ -f "$SCRIPT_DIR/.cursor/rules/400-md-docs.mdc" ]; then
    cp "$SCRIPT_DIR/.cursor/rules/400-md-docs.mdc" .cursor/rules/
    print_success "已复制: 400-md-docs.mdc"
fi

# 创建 .gitignore（如果不存在）
if [ ! -f ".gitignore" ]; then
    print_info "创建 .gitignore 文件..."
    cat > .gitignore << 'EOF'
# 依赖
node_modules/
vendor/
.venv/
__pycache__/

# 构建输出
dist/
build/
*.log

# 环境文件
.env
.env.local
.env.*.local

# IDE 文件
.vscode/
.idea/

# 私有 Cursor 规则
.cursor/rules/_*

# 操作系统文件
.DS_Store
Thumbs.db
EOF
    print_success "已创建 .gitignore"
else
    # 确保私有规则被忽略
    if ! grep -q ".cursor/rules/_\*" .gitignore; then
        echo "" >> .gitignore
        echo "# 私有 Cursor 规则" >> .gitignore
        echo ".cursor/rules/_*" >> .gitignore
        print_success "已更新 .gitignore 以忽略私有规则"
    fi
fi

# 创建 .cursorignore（如果不存在）
if [ ! -f ".cursorignore" ]; then
    print_info "创建 .cursorignore 文件..."
    cat > .cursorignore << 'EOF'
# 忽略这些文件不被 Cursor 索引
xnotes/
*.log
.env*
node_modules/
EOF
    print_success "已创建 .cursorignore"
fi

# 创建文档目录和工作流文档
print_info "创建文档结构..."
mkdir -p docs

# 创建工作流规则文档
if [ ! -f "docs/workflow-rules-cn.md" ]; then
    print_info "创建中文工作流文档..."
    cat > docs/workflow-rules-cn.md << 'EOF'
# Cursor 工作流规则 - 中文指南

## 概述

此项目已配置了自动 Cursor 规则生成系统。您可以通过自然语言与 AI 交互来创建和管理规则。

## 使用方法

### 创建新规则

只需告诉 AI 您想要什么行为，例如：

```
"为 JavaScript 文件创建代码格式规则，确保所有函数都有适当的注释"
```

```
"创建规则确保在 React 组件中正确使用 useState 和 useEffect"
```

```
"我注意到导入语句很混乱，请创建规则来组织导入"
```

### 规则类型

- **0XX**: 核心规则和标准
- **1XX**: 工具和 MCP 规则
- **3XX**: 测试标准
- **8XX**: 工作流规则
- **9XX**: 模板
- **1XXX**: 特定语言规则
- **2XXX**: 框架/库规则

### 私有规则

以下划线开头的规则文件（如 `_personal-style.mdc`）是私有的，不会被 git 跟踪。

## 最佳实践

1. 描述清楚您想要的行为
2. 提供好坏示例
3. 让 AI 自动处理规则创建
4. 定期审查和更新规则

## 更多信息

查看主 README 文件以获取完整文档。
EOF
    print_success "已创建中文工作流文档"
fi

# 创建基础 README（如果不存在）
if [ ! -f "README.md" ]; then
    print_info "创建基础 README.md..."
    cat > README.md << 'EOF'
# 我的项目

此项目已配置了 Cursor 自动规则生成系统。

## 快速开始

1. 打开 Cursor
2. 开始与 AI 交互
3. 告诉 AI 您希望它学习的行为模式
4. AI 将自动创建相应的规则

## 文档

- [中文工作流指南](docs/workflow-rules-cn.md)
- [英文 README](readme-cn.md) - 完整项目文档

## 规则管理

此项目使用自动规则生成。您无需手动创建规则 - 只需描述您想要的行为，AI 将处理其余部分。

---

由 Cursor 自动规则生成系统创建
EOF
    print_success "已创建基础 README.md"
fi

# 创建 xnotes 目录（用于临时笔记）
mkdir -p xnotes
if [ ! -f "xnotes/README.md" ]; then
    cat > xnotes/README.md << 'EOF'
# xnotes - 临时笔记目录

此目录被 Cursor 忽略，用于存放：

- 临时笔记
- 草稿规则
- 计划文档
- 个人备忘录

这些文件不会被 AI 索引，也不会影响项目的 AI 行为。
EOF
    print_success "已创建 xnotes 目录"
fi

echo
print_colored $GREEN "🎉 安装完成！"
echo
print_info "您的项目现在已配置了以下功能："
echo "  ✅ 自动 Cursor 规则生成"
echo "  ✅ 中文和英文规则文件"
echo "  ✅ 工作流文档"
echo "  ✅ 适当的 .gitignore 和 .cursorignore"
echo "  ✅ 文档结构"
echo
print_colored $YELLOW "下一步:"
echo "1. 在 Cursor 中打开此项目"
echo "2. 开始与 AI 对话"
echo "3. 描述您希望 AI 学习的行为"
echo "4. AI 将自动创建相应的规则！"
echo
print_info "查看 docs/workflow-rules-cn.md 获取详细使用指南"
echo
print_colored $PURPLE "享受您的 AI 辅助开发之旅！ 🚀"
echo 