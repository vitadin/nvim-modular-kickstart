# Leap 基础用法

通过分步教程和练习掌握三个 Leap 命令。

## 前置要求

首先阅读 [什么是 Leap 以及为什么使用它？](./01-leap-what-and-why.md) 来理解基本概念。

---

## 三个 Leap 命令

### 命令 1: `s` - 向前跳转

**功能：** 搜索光标**前方**的位置

**使用场景：** 向下或向右移动

**示例：**
```
当前位置：
    |
    v
function setup()
  local config = {...}
  return config
end

想要跳转到 "return"？
1. 按 s
2. 输入 "re"
3. 按出现在 "return" 上的标签键
```

---

### 命令 2: `S` - 向后跳转

**功能：** 搜索光标**后方**的位置

**使用场景：** 向上或向左移动

**示例：**
```
                            当前位置：
                                    |
                                    v
function setup()
  local config = {...}
  return config
end

想要跳回到 "function"？
1. 按 S （大写 S）
2. 输入 "fu"
3. 按出现在 "function" 上的标签键
```

---

### 命令 3: `gs` - 跨窗口跳转

**功能：** 跳转到**任何可见的窗口/分屏**

**使用场景：** 当你打开了多个分屏并想在它们之间跳转

**示例：**
```
┌─────────────────┬─────────────────┐
│ 文件 1          │ 文件 2          │
│ function main() │ function test() │
│   ...           │   ...           │
│ ^ 光标在这里    │                 │
└─────────────────┴─────────────────┘

想要跳转到右侧窗口的 "test"？
1. 按 gs
2. 输入 "te"
3. 按标签（跳转到另一个窗口！）
```

---

## 分步教程

### 教程 1: 你的第一次跳转

**准备：** 打开任何包含文本的文件，或使用这个示例：
```
The quick brown fox jumps over the lazy dog.
A journey of a thousand miles begins with a single step.
To be or not to be, that is the question.
```

**练习：**
1. 将光标放在第一行的开头
2. 按 `s`（状态栏会变化 - Leap 已激活）
3. 输入 `ju`（代表 "jumps"）
4. 观察标签出现在所有 "ju" 匹配项上
5. 按出现在 "jumps" 上方的标签键
6. 🎉 你完成了第一次跳转！

---

### 教程 2: 向后跳转

**准备：** 使用上面相同的文本，将光标放在第 3 行末尾

**练习：**
1. 光标位置："To be or not to be, that is the question.|"
2. 按 `S`（大写 S - 向后跳转）
3. 输入 `qu`（代表 "quick"）
4. 按出现在第 1 行 "quick" 上的标签
5. 你跨越多行向后跳转了！

---

### 教程 3: 多个匹配项

**准备：** 包含多个相似单词的文本
```
test function test_user test_data test_validation
function test_helper function test_runner
test_integration test_unit
```

**练习：**
1. 光标在开头
2. 按 `s`
3. 输入 `te`（代表 "test"）
4. 注意标签（a, b, c, d 等）出现在**每个** "te" 匹配项上
5. 按不同的标签尝试跳转到不同的 "test" 单词
6. 按 `<Esc>` 如果不想跳转可以取消

**关键点：** 当有多个匹配项时，每个都会获得唯一的标签！

---

### 教程 4: 跨窗口跳转

**准备：** 分割你的窗口
```
:vsplit
```

现在你有两个并排的窗口。

**练习：**
1. 确保你在左侧窗口
2. 按 `gs`（从窗口跳转）
3. 输入右侧窗口中可见的任意 2 个字符
4. 按标签
5. 光标移动到右侧窗口！

---

## 将 Leap 与操作符结合使用

**强大功能：** 将 Leap 与 Vim 操作符结合！

### 删除到目标位置

```
function setup()
  local config = load_config()
  local options = parse_options()
  return merge(config, options)
end
```

**想要从光标删除到 "return"？**

1. 将光标放在 "local config"
2. 按 `d`（删除操作符）
3. 按 `s`（leap 成为动作）
4. 输入 `re`（代表 "return"）
5. 按标签
6. 从光标到 "return" 的所有内容都被删除了！

### 支持的操作：
- `d` + leap = 删除到目标
- `c` + leap = 修改到目标
- `y` + leap = 复制到目标
- `v` + leap = 可视选择到目标

---

## 练习

### 练习 1: 向前跳转

**文件内容：**
```
The quick brown fox jumps over the lazy dog.
Programming is fun when you understand the concepts.
Variables store data for later use in your program.
```

**任务：**
1. 从第 1 行开头开始
2. 跳转到 "jumps" → `s` + `ju` + 标签
3. 跳转到 "concepts" → `s` + `co` + 标签
4. 跳转到 "data" → `s` + `da` + 标签

---

### 练习 2: 向后跳转

**起始位置：** 练习 1 的第 3 行末尾

**任务：**
1. 跳回到 "Variables" → `S` + `Va` + 标签
2. 跳回到 "fun" → `S` + `fu` + 标签
3. 跳回到 "quick" → `S` + `qu` + 标签

---

### 练习 3: 多个匹配项

**文件内容：**
```
test_user test_admin test_guest
function test_helper()
  test_data = load_test()
  test_result = run_test()
end
```

**任务：**
1. 从第 1 行开始
2. 跳转到 "test_admin" → `s` + `te` +（找到正确的标签）
3. 跳转到 "test_data" → `s` + `te` +（不同的标签）
4. 跳回到 "test_helper" → `S` + `te` + 标签

---

### 练习 4: Leap + 编辑

**文件内容：**
```
local name = "old_value"
local age = 25
local city = "old_value"
```

**任务：**
1. 将第 1 行的 "old_value" 改为 "John"
   - `s` + `ol` + 标签 + `ciw` + `John` + `<Esc>`
2. 将第 3 行的 "old_value" 改为 "NYC"
   - `s` + `ol` + 标签 + `ciw` + `NYC` + `<Esc>`

---

### 练习 5: 窗口导航

**准备：**
1. 打开 Neovim
2. 垂直分割：`:vsplit`
3. 水平分割：`:split`
4. 现在你有 3 个窗口

**任务：**
1. 使用 `gs` 从当前窗口跳转到其他窗口
2. 练习：`gs` + 输入目标窗口中可见的 2 个字符 + 标签

---

## 疑难解答

### 问：我按了 's' 但没有任何反应？

**答：** 检查：
1. 确保你在**普通模式**（先按 `<Esc>`）
2. 可能有键位冲突
3. 尝试 `:verbose map s` 查看是否有其他插件映射了 `s`

---

### 问：输入 2 个字符后标签没有出现？

**答：** 可能的原因：
1. 没有找到匹配项 - 尝试不同的字符
2. 模式太常见 - 尝试更具体的字符（第 3、4 个字符）
3. Leap 对显示的匹配数量有限制

---

### 问：我总是按错标签？

**答：** 这在刚开始时很正常！技巧：
1. 练习主行键标签（`s`、`f`、`n`、`j`、`k`、`l`、`h`）
2. 跳转前先看清 - 花时间找到正确的标签
3. 随时按 `<Esc>` 取消
4. 速度来自练习

---

### 问：我可以取消正在进行的跳转吗？

**答：** 可以！
- 启动跳转后随时按 `<Esc>`
- 或者 `<C-c>` 也可以
- 光标会停留在原位

---

### 问：如何跳转到包含空格的内容？

**答：** 示例：
- "user name" → 输入 `us`（第一个词）或 `na`（第二个词）
- 你不能跳转到空格本身，跳转到附近的词

---

## 快速参考

```
╔══════════════════════════════════════════════════╗
║              LEAP 基础命令                       ║
╠══════════════════════════════════════════════════╣
║ s              向前跳转                          ║
║ S              向后跳转                          ║
║ gs             跨窗口跳转                        ║
║                                                  ║
║ 按下 s/S/gs 后                                  ║
║ [2 个字符]      输入目标                         ║
║ [标签]         按标签键跳转                      ║
║ <Esc>          取消跳转                          ║
║                                                  ║
║ 与操作符结合                                     ║
║ d + s + 字符   删除到目标                        ║
║ c + s + 字符   修改到目标                        ║
║ y + s + 字符   复制到目标                        ║
║ v + s + 字符   可视选择到目标                    ║
╚══════════════════════════════════════════════════╝
```

---

## 下一步

现在你已经掌握了基础：

- **[常用工作流程](./01-leap-common-workflows.md)** - 实际使用模式
- [高级技巧](./01-leap-advanced.md) - 高级用户技巧和窍门

---

[返回教程索引](./README.md) | [返回主 README](../../README.md)
