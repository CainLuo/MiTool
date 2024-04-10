[![Platforms](https://img.shields.io/badge/Platforms-macOS_iOS_iPadOS_watchOS_visionOS-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-macOS_iOS_tvOS_iPadOS_watchOS_visionOS-Green?style=flat-square)

## Sample Table with Multiple Screenshots

<div style="overflow-x: auto;">
  <table>
    <thead>
      <tr>
        <th>Image 1</th>
        <th>Image 2</th>
        <th>Image 3</th>
        <th>Image 4</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><img src="https://github.com/CainLuo/MiTool/blob/main/ScreenShot/img1.png" alt="Screenshot 1" style="max-width: 300px;"></td>
        <td><img src="https://github.com/CainLuo/MiTool/blob/main/ScreenShot/img2.png" alt="Screenshot 2" style="max-width: 300px;"></td>
        <td><img src="https://github.com/CainLuo/MiTool/blob/main/ScreenShot/img3.png" alt="Screenshot 3" style="max-width: 300px;"></td>
        <td><img src="https://github.com/CainLuo/MiTool/blob/main/ScreenShot/img4.png" alt="Screenshot 4" style="max-width: 300px;"></td>
      </tr>
    </tbody>
  </table>
</div>


# 目前遇到的问题

- ❌❌❌ iOS, iPadOS, visionOS, watchOS 暂时也没有空去适配 ❌❌❌

# 功能列表

### 适配

- [x] macOS
- [ ] iOS
- [ ] iPadOS
- [ ] visionOS
- [ ] watchOS

### 通用功能
- [x] 星穹铁道和原神的实时便签
- [x] 添加米游社 Cookie
- [x] 获取sToken
- [x] 获取deviceFP

### 崩坏: 星穹铁道
- [ ] 角色培养详情
- [x] 获取Widget详情
- [ ] 本期/上期混沌回忆详情
- [ ] 抽卡分析

### 原神
- [x] 获取Widget详情
- [ ] 角色培养详情
- [x] 已抽取角色列表
- [x] 获取角色天赋列表
- [ ] 本期/上期深渊记录
- [ ] 抽卡分析

### 开源库
本项目用的是以下的第三方开源库, 排名不分先后, 感谢各位大佬的共享~

- [SwiftUIX](https://github.com/SwiftUIX/SwiftUIX)
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [SQLite.swift](https://github.com/stephencelis/SQLite.swift)
- [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift)

## 参考库
本项目参考了以下第三方项目的 DS 加密方式(目前还没有请求成功), 排名不分先后, 感谢各位大佬的共享~

- [gsiod_core](https://github.com/Genshin-bots/gsuid_core)
- [KimigaiiWuyi/GenshinUID](https://github.com/KimigaiiWuyi/GenshinUID)
- [baiqwerdvd/StarRailUID](https://github.com/baiqwerdvd/StarRailUID)

## 代码一致性
为了让项目的代码一致性, 使用了 [SwiftLint](https://github.com/realm/SwiftLint), 具体规则使用了 [kodecocodes](https://github.com/kodecocodes/swift-style-guide/tree/main?tab=readme-ov-file#classes-and-structures) 所提供的代码风格.

⚠️⚠️⚠️注意⚠️⚠️⚠️
如果你的电脑装的 `Homebrew` 路径与本项目的不一致, 可以在 `MiTool -> Targets -> MiTool -> Build Pahses -> SwiftLint` 将 `export PATH="/opt/homebrew/bin:$PATH"` 改成你电脑本地的路径即可.

# 建议
如果有什么功能或者改进的方便, 可以在 issues 提一下, 比如现在的 UI 界面都是比较随意, 个人不懂 UI/UX, 请大家多多包涵😭

# License
本项目采用的是GNU GENERAL PUBLIC LICENSE, 希望可以将项目一直开源下去~
