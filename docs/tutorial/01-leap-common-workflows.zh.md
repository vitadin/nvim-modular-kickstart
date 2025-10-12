# Leap 常用工作流程

在日常编码中使用 Leap.nvim 的实际使用模式和工作流程。

## 前置要求

确保你已经完成了 [Leap 基础用法](./01-leap-basic-usage.md)。

---

## 工作流程 1: 跳转到函数定义

**场景：** 你正在阅读代码，想要跳转到特定函数

```lua
-- 当前位置
local function calculate() ... end  ^
local function validate() ... end
local function process() ... end
local function transform() ... end
```

**步骤：**
1. 按 `s`
2. 输入 `pr`（"process" 的前 2 个字母）
3. 按标签 → 直接跳转到 `process()`

**为什么这样快：** 无需数行数或使用 `/process` 搜索。

---

## 工作流程 2: 跳转到变量使用位置

**场景：** 查找变量在哪里被使用

```lua
local user_name = "John"
-- ... 50 行代码 ...
print(user_name)  -- 想要跳转到这里
-- ... 更多代码 ...
print(user_name)  -- 或者这里
```

**步骤：**
1. 按 `s`
2. 输入 `us`（代表 "user"）
3. 在两处 `user_name` 上看到标签
4. 按你想要的那个标签

**专业提示：** 如果有很多匹配项，输入第三个字符（如 `use`）来缩小范围。

---

## 工作流程 3: 在特定位置编辑

**场景：** 跳转并立即开始编辑

```python
def calculate_total(items):
    total = 0  # 想要将其改为 sum
    for item in items:
        total += item.price
    return total
```

**步骤：**
1. 按 `s`
2. 输入 `to`（代表 "total"）
3. 按标签跳转到 "total = 0"
4. 立即按 `cw`（修改单词）
5. 输入 `sum`
6. 你在一个流畅的动作中完成了跳转和编辑！

**关键点：** Leap + 操作符 = 闪电般快速的编辑。

---

## 工作流程 4: 在长函数中导航

**场景：** 在长函数中跳转

```javascript
function processData(data) {
  const validated = validate(data);
  const transformed = transform(validated);
  const filtered = filter(transformed);
  const sorted = sort(filtered);
  const grouped = group(sorted);
  const aggregated = aggregate(grouped);
  return aggregated;
}
```

**步骤：**
1. 在顶部，想要跳转到 "filtered"？按 `s`，输入 `fi`，跳转
2. 想要回到 "validated"？按 `S`，输入 `va`，跳转
3. 跳转到 "return"？按 `s`，输入 `re`，跳转

**比这快得多：** `8j` 或 `/filtered<Enter>`！

---

## 工作流程 5: 从这里删除到那里

**场景：** 删除一段代码

```javascript
function setup() {
  // 当前光标位置
  const config = load_config();
  const options = parse_options();
  const merged = merge(config, options);
  // 从这里开始保留
  return merged;
}
```

**想要从光标删除到 "return"？**

**步骤：**
1. 将光标放在 "const config"
2. 按 `d`（删除操作符）
3. 按 `s`（leap 成为动作）
4. 输入 `re`（代表 "return"）
5. 按标签
6. 从光标到 "return" 的所有内容都被删除了！

**结果：**
```javascript
function setup() {
  // 当前光标位置
  return merged;
}
```

---

## 工作流程 6: 从这里复制到那里

**场景：** 复制特定部分

```lua
local function process_data()
  local input = get_input()
  local validated = validate(input)
  local transformed = transform(validated)
  local result = finalize(transformed)
  return result
end
```

**想要从 "validated" 复制到 "result"？**

**步骤：**
1. 将光标放在 "validated"
2. 按 `y`（复制操作符）
3. 按 `s`（leap 动作）
4. 输入 `re`（代表 "result"）
5. 按标签
6. 这些行现在在你的剪贴板中了！
7. 在其他地方按 `p` 粘贴

---

## 工作流程 7: 使用 Leap 进行可视选择

**场景：** 可视化选择文本以进行操作

```ruby
class UserController
  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end
end
```

**想要从 "index" 选择到 "render :index"？**

**步骤：**
1. 将光标放在 "index"
2. 按 `v`（进入可视模式）
3. 按 `s`（可视模式中的 leap）
4. 输入 `re`（代表第一个 "render"）
5. 按标签
6. 文本被可视化选中了！
7. 现在你可以 `d`（删除）、`y`（复制）或 `c`（修改）

---

## 工作流程 8: 跨多个窗口跳转

**场景：** 你打开了 3 个分屏，需要在它们之间导航

```
┌──────────────────┬──────────────────┐
│ main.lua         │ tests.lua        │
│                  │                  │
│ function main()  │ function test()  │
│   ...            │   ...            │
│ ^ 光标在这里     │                  │
├──────────────────┴──────────────────┤
│ config.lua                          │
│                                     │
│ local config = {...}                │
└─────────────────────────────────────┘
```

**想要跳转到右上角的 "test"，然后到底部的 "config"？**

**步骤：**
1. 按 `gs`（从窗口跳转）
2. 输入 `te`（代表 "test"）
3. 按标签 → 跳转到 tests.lua
4. 再次按 `gs`
5. 输入 `co`（代表 "config"）
6. 按标签 → 跳转到 config.lua

**为什么这很强大：** 无需多次使用 `<C-w>hjkl`！

---

## 工作流程 9: 重复编辑模式

**场景：** 多次进行相同的修改

```lua
function test_a() ... end
function test_b() ... end
function test_c() ... end
```

**想要删除所有三个 "test_" 前缀？**

**步骤：**
1. 按 `s`，输入 `te`，跳转到第一个 "test_"
2. 按 `dw`（删除单词）删除 "test_"
3. 按 `n`（下一个匹配 - 如果使用搜索）
   **或者** 按 `.`（点）重复上一个操作！
4. leap + 删除在下一个 "test_" 上重复！

**注意：** 这需要 vim-repeat 插件（包含在此配置中）。

---

## 工作流程 10: 导航错误消息

**场景：** 编译器在特定行显示错误

```
Error: undefined variable 'config' on line 45
Error: type mismatch on line 78
Error: missing import on line 103
```

**代替使用 `:45`、`:78`、`:103`：**

**步骤：**
1. 打开文件
2. 按 `s`，输入 `co`（代表 "config"），跳转到错误 1
3. 修复错误
4. 按 `s`，输入 `ty`（代表 "type"），跳转到错误 2
5. 修复错误
6. 按 `s`，输入 `im`（代表 "import"），跳转到错误 3
7. 修复错误

**优势：** 上下文感知导航，而不是行号。

---

## 有效工作流程的技巧

### 技巧 1: 以目标思考，而不是距离

**旧思维：** "我需要向下 10 行，向右 5 个单词"

**新思维：** "我需要到 'function' 这个词"

**操作：** `s` + `fu` + 标签 ✅

---

### 技巧 2: 选择唯一的 2 字符模式

**不好：** `s` + `aa`（在代码中太常见）

**好：** `s` + `fu`（"function" 的开头）

**更好：** `s` + `nc`（"function" 的中间 - 更唯一）

---

### 技巧 3: 频繁与操作符结合

**记住这个模式：**
```
操作符 + s/S + 2 个字符 + 标签 = 魔法！
```

**示例：**
- `d` + `s` + `re` + 标签 = 删除到 "return"
- `c` + `S` + `fu` + 标签 = 向后修改到 "function"
- `y` + `s` + `en` + 标签 = 复制到 "end"
- `v` + `s` + `if` + 标签 = 可视选择到 "if"

---

### 技巧 4: 小范围移动保持使用传统动作

**最佳实践：**
- `hjkl` 用于 1-3 个字符的移动
- `w/b/e` 用于 1-5 个单词的移动
- **Leap 用于超出这个范围的所有移动**

这种混合方法是最快的！

---

### 技巧 5: 建立肌肉记忆

**练习程序：**
1. 每天花 5 分钟只使用 leap（不用 `hjkl`，不用 `/search`）
2. 强迫自己到处使用 leap
3. 一周后，它就会成为第二天性

**从一个文件开始：** 在熟悉的文件上练习以建立信心。

---

## 常用模式速查表

```
╔════════════════════════════════════════════════════════╗
║                 常用 LEAP 模式                         ║
╠════════════════════════════════════════════════════════╣
║ 跳转到函数          s + fu + 标签                     ║
║ 跳转到变量          s + [变量名] + 标签               ║
║ 跳转到 return       s + re + 标签                     ║
║ 跳转到 import/require  s + im/re + 标签              ║
║ 跳转到 class        s + cl + 标签                     ║
║ 跳转到 error        s + er + 标签                     ║
║                                                        ║
║ 删除到目标          d + s + 字符 + 标签               ║
║ 修改到目标          c + s + 字符 + 标签               ║
║ 复制到目标          y + s + 字符 + 标签               ║
║ 选择到目标          v + s + 字符 + 标签               ║
║                                                        ║
║ 向后跳转            S + 字符 + 标签                   ║
║ 跨窗口跳转          gs + 字符 + 标签                  ║
╚════════════════════════════════════════════════════════╝
```

---

## 下一步

准备好学习高级技巧了吗？

- **[高级技巧](./01-leap-advanced.md)** - 高级用户技巧
- [文件操作](./03-oil-introduction.md) - 将 Leap 与文件管理结合使用
- [多文件导航](./04-multi-file-navigation.md) - 在文件之间跳转

---

[返回教程索引](./README.md) | [返回主 README](../../README.md)
