@echo off
setlocal enabledelayedexpansion

REM Cursor 自动规则生成与敏捷工作流应用脚本 - 中文版 Windows
REM 作者: bmadcode
REM 描述: 将 Cursor 规则和敏捷工作流模板应用到项目中

REM 检查参数
if "%~1"=="" (
    echo ❌ 错误：缺少目标项目路径参数
    echo.
    echo 用法: %~nx0 ^<目标项目路径^>
    echo.
    echo 示例:
    echo   %~nx0 C:\Projects\my-project
    echo   %~nx0 D:\WebDev\my-app
    echo   %~nx0 ..\existing-project
    echo.
    echo 脚本功能：
    echo   • 创建 .cursor/rules/ 目录结构
    echo   • 复制核心规则文件
    echo   • 设置 .gitignore 和 .cursorignore
    echo   • 创建工作流文档
    echo   • 保留现有规则
    exit /b 1
)

if "%~1"=="--help" goto show_help
if "%~1"=="-h" goto show_help

set "TARGET_DIR=%~1"
set "SCRIPT_DIR=%~dp0"

echo.
echo 🚀 Cursor 自动规则生成与敏捷工作流 🚀
echo.

echo ℹ️  目标项目路径: %TARGET_DIR%
echo ℹ️  脚本位置: %SCRIPT_DIR%

REM 创建目标目录（如果不存在）
if not exist "%TARGET_DIR%" (
    echo ℹ️  创建项目目录: %TARGET_DIR%
    mkdir "%TARGET_DIR%"
    echo ✅ 项目目录创建成功
) else (
    echo ℹ️  项目目录已存在: %TARGET_DIR%
)

cd /d "%TARGET_DIR%"

REM 创建 .cursor/rules 目录
echo ℹ️  设置 Cursor 规则目录结构...
if not exist ".cursor\rules" mkdir ".cursor\rules"

REM 复制规则文件
echo ℹ️  复制核心规则文件...

REM 复制原版英文规则
if exist "%SCRIPT_DIR%.cursor\rules\000-cursor-rules.mdc" (
    copy "%SCRIPT_DIR%.cursor\rules\000-cursor-rules.mdc" ".cursor\rules\" >nul
    echo ✅ 已复制: 000-cursor-rules.mdc ^(英文版^)
)

REM 复制中文版规则
if exist "%SCRIPT_DIR%.cursor\rules\000-cursor-rules-cn.mdc" (
    copy "%SCRIPT_DIR%.cursor\rules\000-cursor-rules-cn.mdc" ".cursor\rules\" >nul
    echo ✅ 已复制: 000-cursor-rules-cn.mdc ^(中文版^)
)

REM 复制其他规则文件
if exist "%SCRIPT_DIR%.cursor\rules\400-md-docs.mdc" (
    copy "%SCRIPT_DIR%.cursor\rules\400-md-docs.mdc" ".cursor\rules\" >nul
    echo ✅ 已复制: 400-md-docs.mdc
)

REM 创建 .gitignore（如果不存在）
if not exist ".gitignore" (
    echo ℹ️  创建 .gitignore 文件...
    (
        echo # 依赖
        echo node_modules/
        echo vendor/
        echo .venv/
        echo __pycache__/
        echo.
        echo # 构建输出
        echo dist/
        echo build/
        echo *.log
        echo.
        echo # 环境文件
        echo .env
        echo .env.local
        echo .env.*.local
        echo.
        echo # IDE 文件
        echo .vscode/
        echo .idea/
        echo.
        echo # 私有 Cursor 规则
        echo .cursor/rules/_*
        echo.
        echo # 操作系统文件
        echo .DS_Store
        echo Thumbs.db
    ) > .gitignore
    echo ✅ 已创建 .gitignore
) else (
    REM 检查是否需要添加私有规则忽略
    findstr /C:".cursor/rules/_*" .gitignore >nul 2>&1
    if errorlevel 1 (
        echo. >> .gitignore
        echo # 私有 Cursor 规则 >> .gitignore
        echo .cursor/rules/_* >> .gitignore
        echo ✅ 已更新 .gitignore 以忽略私有规则
    )
)

REM 创建 .cursorignore（如果不存在）
if not exist ".cursorignore" (
    echo ℹ️  创建 .cursorignore 文件...
    (
        echo # 忽略这些文件不被 Cursor 索引
        echo xnotes/
        echo *.log
        echo .env*
        echo node_modules/
    ) > .cursorignore
    echo ✅ 已创建 .cursorignore
)

REM 创建文档目录
echo ℹ️  创建文档结构...
if not exist "docs" mkdir "docs"

REM 创建工作流规则文档
if not exist "docs\workflow-rules-cn.md" (
    echo ℹ️  创建中文工作流文档...
    (
        echo # Cursor 工作流规则 - 中文指南
        echo.
        echo ## 概述
        echo.
        echo 此项目已配置了自动 Cursor 规则生成系统。您可以通过自然语言与 AI 交互来创建和管理规则。
        echo.
        echo ## 使用方法
        echo.
        echo ### 创建新规则
        echo.
        echo 只需告诉 AI 您想要什么行为，例如：
        echo.
        echo ```
        echo "为 JavaScript 文件创建代码格式规则，确保所有函数都有适当的注释"
        echo ```
        echo.
        echo ```
        echo "创建规则确保在 React 组件中正确使用 useState 和 useEffect"
        echo ```
        echo.
        echo ```
        echo "我注意到导入语句很混乱，请创建规则来组织导入"
        echo ```
        echo.
        echo ### 规则类型
        echo.
        echo - **0XX**: 核心规则和标准
        echo - **1XX**: 工具和 MCP 规则
        echo - **3XX**: 测试标准
        echo - **8XX**: 工作流规则
        echo - **9XX**: 模板
        echo - **1XXX**: 特定语言规则
        echo - **2XXX**: 框架/库规则
        echo.
        echo ### 私有规则
        echo.
        echo 以下划线开头的规则文件（如 `_personal-style.mdc`）是私有的，不会被 git 跟踪。
        echo.
        echo ## 最佳实践
        echo.
        echo 1. 描述清楚您想要的行为
        echo 2. 提供好坏示例
        echo 3. 让 AI 自动处理规则创建
        echo 4. 定期审查和更新规则
        echo.
        echo ## 更多信息
        echo.
        echo 查看主 README 文件以获取完整文档。
    ) > "docs\workflow-rules-cn.md"
    echo ✅ 已创建中文工作流文档
)

REM 创建基础 README（如果不存在）
if not exist "README.md" (
    echo ℹ️  创建基础 README.md...
    (
        echo # 我的项目
        echo.
        echo 此项目已配置了 Cursor 自动规则生成系统。
        echo.
        echo ## 快速开始
        echo.
        echo 1. 打开 Cursor
        echo 2. 开始与 AI 交互
        echo 3. 告诉 AI 您希望它学习的行为模式
        echo 4. AI 将自动创建相应的规则
        echo.
        echo ## 文档
        echo.
        echo - [中文工作流指南]^(docs/workflow-rules-cn.md^)
        echo - [英文 README]^(readme-cn.md^) - 完整项目文档
        echo.
        echo ## 规则管理
        echo.
        echo 此项目使用自动规则生成。您无需手动创建规则 - 只需描述您想要的行为，AI 将处理其余部分。
        echo.
        echo ---
        echo.
        echo 由 Cursor 自动规则生成系统创建
    ) > README.md
    echo ✅ 已创建基础 README.md
)

REM 创建 xnotes 目录
if not exist "xnotes" mkdir "xnotes"
if not exist "xnotes\README.md" (
    (
        echo # xnotes - 临时笔记目录
        echo.
        echo 此目录被 Cursor 忽略，用于存放：
        echo.
        echo - 临时笔记
        echo - 草稿规则
        echo - 计划文档
        echo - 个人备忘录
        echo.
        echo 这些文件不会被 AI 索引，也不会影响项目的 AI 行为。
    ) > "xnotes\README.md"
    echo ✅ 已创建 xnotes 目录
)

echo.
echo 🎉 安装完成！
echo.
echo ℹ️  您的项目现在已配置了以下功能：
echo   ✅ 自动 Cursor 规则生成
echo   ✅ 中文和英文规则文件
echo   ✅ 工作流文档
echo   ✅ 适当的 .gitignore 和 .cursorignore
echo   ✅ 文档结构
echo.
echo ⚠️  下一步:
echo 1. 在 Cursor 中打开此项目
echo 2. 开始与 AI 对话
echo 3. 描述您希望 AI 学习的行为
echo 4. AI 将自动创建相应的规则！
echo.
echo ℹ️  查看 docs\workflow-rules-cn.md 获取详细使用指南
echo.
echo 🚀 享受您的 AI 辅助开发之旅！
echo.

goto :eof

:show_help
echo.
echo 🚀 Cursor 自动规则生成与敏捷工作流 🚀
echo.
echo 用法: %~nx0 ^<目标项目路径^>
echo.
echo 此脚本将 Cursor 规则和敏捷工作流模板应用到指定的项目目录中
echo.
echo 示例:
echo   %~nx0 C:\Projects\my-project
echo   %~nx0 D:\WebDev\my-app
echo   %~nx0 ..\existing-project
echo.
echo 脚本功能：
echo   • 创建 .cursor/rules/ 目录结构
echo   • 复制核心规则文件
echo   • 设置 .gitignore 和 .cursorignore
echo   • 创建工作流文档
echo   • 保留现有规则
echo.
exit /b 0 