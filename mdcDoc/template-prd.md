# 产品需求文档模板

## 要求

- 遵循标准化的 PRD 结构
- 包含所有必需部分
- 维护适当的文档层次结构

## 结构

### 必需部分

#### 1. 标题

- 标题："{项目名称}的产品需求文档 (PRD)"

#### 2. 状态

- 草稿
- 已批准

#### 3. 介绍

- {项目名称}的清晰描述
- 项目范围概述
- 业务背景和驱动因素
- 目标用户/利益相关者

#### 4. 目标

- 明确的项目目标
- 可衡量的结果
- 成功标准
- 关键绩效指标 (KPI)

#### 5. 功能和需求

- 功能需求
- 非功能需求
- 用户体验需求
- 集成需求
- 合规需求

#### 6. 史诗结构

- 必须定义至少一个史诗
- 格式：史诗-{N}：{标题} ({状态})
  - 状态可以是：当前、未来、完成
- 一次只能有一个史诗为"当前"状态
- 每个史诗代表一个主要功能或功能性
- 史诗必须按顺序实施

#### 7. 故事列表

- 故事在史诗下组织
- 格式：故事-{N}：{故事/任务描述}
  <note>故事的详细信息将稍后在故事文件中起草</note>

#### 8. 技术栈

- 编程语言
- 框架
- 注：这将在架构文档中进一步详细定义

#### 9. 未来增强

- 未来考虑的潜在史诗
- 史诗进展期间收集的想法
- 优先级指导原则
- 影响评估

## 示例

<example type="valid">
# 帝国防御平台 v2 的产品需求文档 (PRD)

## 状态：草稿

## 介绍

帝国防御平台 v2 (IDP2) 是一个最先进的战斗站，旨在维护整个银河系的和平与秩序。该项目包括开发一个具有前所未有防御能力的完全可操作的空间站。该平台将既作为军事设施，也作为帝国力量的象征。

## 目标

- 相比 v1 实现行星防御覆盖率提高 200%
- 将对叛军入侵的响应时间缩短 75%
- 实施精度为 99.99% 的自动防御系统
- 建立容纳 120 万帝国人员的能力
- 通过先进的反应堆技术实现能源自给自足

## 功能和需求

### 功能需求

- 具有预测性瞄准的自动防御网格
- 量子加密通信系统
- 为 120 万人员提供的先进生命支持系统
- 用于快速维修的模块化建设系统
- AI 驱动的威胁检测和响应

### 非功能需求

- 99.999% 系统正常运行时间
- 亚毫秒级武器响应时间
- 零延迟内部通信
- 所有可居住区域的辐射屏蔽
- 95% 的能源效率等级

## 史诗结构

史诗-1：核心基础设施开发 (完成)
史诗-2：防御系统集成 (当前)
史诗-3：生命支持和人员系统 (未来)
史诗-4：指挥控制实施 (未来)

## 故事列表

### 史诗-2：防御系统集成

故事-1：实施主要武器瞄准系统
故事-2：开发护盾发生器网络
故事-3：创建自动防御网格控制界面
故事-4：威胁检测 AI 的集成
故事-5：为武器部署备用电力分配

## 技术栈

- 编程语言：银河基础 C++23，量子脚本
- 框架：ImperialCore，DefenseGrid Pro
- 基础设施：HyperScale 云，QuantumNet
- 安全性：帝国级加密 (IGE) v4

## 未来增强

- 行星级牵引光束能力
- 先进隐形技术集成
- 为 TIE 防御者中队扩展机库设施
- 冗余护盾发生器系统
- 深空超空间跟踪系统
  </example>

<example type="invalid">
国际象棋游戏
- 添加基本游戏
- 以后可能添加 AI
- 我们可能需要的其他功能
</example> 