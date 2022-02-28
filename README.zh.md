<p align="center">
<a href="https://www.apple.com/macos/monterey/">
  <img src="https://img.shields.io/badge/macOS-Monterey_v12.2-red.svg"/> </a>
<a href="https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t480-type-20l5-20l6/downloads/ds502355">
  <img src="https://img.shields.io/badge/BIOS-1.42-blue"/> </a>
<a href="https://github.com/acidanthera/OpenCorePkg">
  <img src="https://img.shields.io/badge/OpenCore-0.7.8-12AED6"/> </a>
<a href="https://github.com/isherlockliu/Thinkpad-T480-Hackintosh/issues"> 
  <img src="https://img.shields.io/github/issues/isherlockliu/Thinkpad-T480-Hackintosh"/> </a>
<a href="https://github.com/isherlockliu/Thinkpad-T480-Hackintosh/commits/master"> 
  <img src="https://img.shields.io/github/last-commit/isherlockliu/Thinkpad-T480-Hackintosh"/> </a>
<a href="https://github.com/isherlockliu/Thinkpad-T480-Hackintosh/issues?q=is%3Aissue+label%3A%22help+wanted%22+is%3Aclosed">
  <img src="https://img.shields.io/badge/need%20help-0-blue"/> </a>
</p>


<p align="center">
<a href="https://github.com/tylernguyen/obsidian-horizon/blob/main/LICENSE">
   <img src="https://img.shields.io/badge/License-The%20Unlicense-informational.svg"> </a>
<a href="https://damnthattelevision.com/Contact">
   <img src="https://img.shields.io/badge/%40-Contact-FFF27D"> </a>
<a href="https://damnthattelevision.com/Support">
   <img src="https://img.shields.io/badge/%24-Support-ff69b4.svg"> </a>
<a href="">
   <img src="https://img.shields.io/badge/Contributions-Welcome-orange.svg"> </a>
</p>


<p align="center">
<a href="https://github.com/isherlockliu/Thinkpad-T480-Hackintosh/">
  <img src="./Other/README Resources/T480.png" alt="Thinkpad T480" width="480"> </a>
</p>


# 声明

**在开始之前请阅读完 README 和 Dortania 指南。**

**我不对因此造成的任何损坏负责。**

**当您遇到错误或想要改进此 repo 时，请考虑打开问题或拉取请求。 如果您发现本 `EFI` 引导程序对你有帮助，请给本仓库点一个 `Star` 以便让更多的人们看到。。**



# 介绍

<details>
<summary><strong>基础</strong></summary>


- 如果您是刚刚接触 Opencore，请按照 [Dortania](https://dortania.github.io/getting-started/) 的文档学习
- [CorpNewt](https://github.com/corpnewt) 和 [headkaze](https://github.com/headkaze/Hackintool) 提供的的一些有用的工具

</details> 

<details>
<summary><strong>硬件</strong></summary>
<br>


| Category  | Component              | Note                                     |
| --------- | ---------------------- | ---------------------------------------- |
| CPU       | Intel Core i7-8550U    | 20L5A01RHH                               |
| GPU       | Intel UHD 620          | 屏蔽 MX150                               |
| 固态硬盘  | LITEON T11 Plus 512    |                                          |
| 内存      | 16GB DDR4 2400Mhz      |                                          |
| Battery   | Dual battery           |                                          |
| 摄像头    | 720p 摄像头            |                                          |
| Wifi & BT | Intel Wireless-AC 8265 | 可以使用 AirportItlwm 体验到原生的 Wi-Fi |
| 输入设备  | PS2 键盘 & 新思触控板  |                                          |
| 输出      | LG 2k 2560*1440        |                                          |

</details>

<details>
<summary><strong>主要软件</strong></summary>
<br>


| Component      | Version        |
| -------------- | -------------- |
| macOS Monterey | 12.2.1 (21D62) |
| OpenCore       | 0.7.8          |

</details>

<details>
<summary><strong>内核扩展</strong></summary>
<br>


| Kext                   | Version  |
| :--------------------- | -------- |
| AirportItlwm           | 2.1.0    |
| AppleALC               | 1.6.9    |
| CPUFriend              | 1.2.4    |
| CPUFriendDataProvider  | i7-8550U |
| IntelBluetoothFirmware | 2.1.0    |
| IntelMausi             | 1.0.7    |
| Lilu                   | 1.6.0    |
| NoTouchID              | 1.0.4    |
| HibernationFixup.kext  | 1.4.5    |
| VirtualSMC             | 1.2.3    |
| VoltageShift           | 1.22     |
| VoodooPS2Controller    | 2.2.7    |
| VoodooRMI              | 1.3.4    |
| VoodooSMBus            | 3.0.0    |
| WhateverGreen          | 1.5.7    |
| YogaSMC                | 1.5.1    |

</details>

<details>
<summary><strong>UEFI 驱动</strong></summary>
<br>


|     Driver      | Version           |
| :-------------: | ----------------- |
|  AudioDxe.efi   | OpenCorePkg 0.7.8 |
|   HfsPlus.efi   | OcBinaryData      |
| OpenCanopy.efi  | OpenCorePkg 0.7.8 |
| OpenRuntime.efi | OpenCorePkg 0.7.8 |

</details>

<details>
    <summary><strong>Neofetch 截屏</strong></summary>
    <br>
    <p float="left">
        <img src="./Other/README Resources/Neofetch Monterey.png" alt="Neofetch Monterey" width="660">
    </p>
</details> 



# 安装前

<details>  
<summary><strong>UEFI 设置</strong></summary>
<br>

**Security**

- `Security Chip` **Disabled**
- `Memory Protection -> Execution Prevention` **Enabled**
- `Virtualization -> Intel Virtualization Technology` **Enabled**
- `Virtualization -> Intel VT-d Feature` **Enabled**
- `Anti-Theft -> Computrace -> Current Setting` **Disabled**
- `Secure Boot -> Secure Boot` **Disabled**
- `Intel SGX -> Intel SGX Control` **Disabled**
- `Device Guard` **Disabled**

**Startup**

- `UEFI/Legacy Boot` **UEFI Only**
- `CSM Support` **No**

**Thunderbolt**

- `Thunderbolt BIOS Assist Mode` **Disabled**
- `Wake by Thunderbolt(TM) 3` **Disabled**
- `Security Level` **User Authorization**
- `Support in Pre Boot Environment -> Thunderbolt(TM) device` **Enabled**

</details>  

<details>
<summary><strong>键盘语言</strong></summary>
<br>

添加为字符串或数据 [(ProperTree)](https://github.com/corpnewt/ProperTree) 

Format is lang-COUNTRY:keyboard

- 🇺🇸 | [0] en_US - U.S --> en-US:0 --> 656e2d55 533a30

etc.

[AppleKeyboardLayouts.txt](https://github.com/acidanthera/OpenCorePkg/blob/master/Utilities/AppleKeyboardLayouts/AppleKeyboardLayouts.txt)

</details>

# 安装后

<details>  
<summary><strong>色带问题</strong></summary>
<br>

如果您遇到一些严重的色带问题（请记住，T480 1080p 库存面板颜色精度不是很好，cca 50-60% sRGB），您唯一的解决方案是更换 GPU 属性，如下所示，或者将库存面板替换为 T490（400 nits，低功率）。

```
<key>AAPL,ig-platform-id</key>
<data>AAAWGQ==</data>
<key>device-id</key>
<data>FhkAAA==</data>
</dict>
```

不要使用这些任何额外的引导参数！ 从“其他”文件夹获取自定义的 WhatGreen 版本

您可以在 [此处](https://www.eizo.be/monitor-test/) 中通过梯度测试检查您的屏幕，或者只需查看 Launchpad 背景即可。

</details>  

<details>  
<summary><strong>生成您自己的 SMBIOS</strong></summary>
<br>

[GenSMBIOS](https://github.com/corpnewt/GenSMBIOS)

- MacBookPro15,2


</details>  

<details>  
<summary>CPU 能效管理</summary>
<br>

为您的机器生成 CPUFriendDataProvider [此处](https://github.com/fewtarius/CPUFriendFriend) 或使用其他文件夹中提供的文件，风险自负。

</details>  

<details>  
<summary><strong>VoltageShift 降压</strong></summary>
<br>

可以直接从 EFI 文件夹使用 VoltageShift，而不是禁用 SIP。 您需要使用其他文件夹中提供的特定版本。

```diff
如果要使用此功能，请在 config.plist 中启用它
```
</details>  

# 状态

<details>  
<summary><strong>正常运行 ✅</strong></summary>

- [x] 电池百分比
- [x] 蓝牙 - Intel Wireless-AC 8265 (0x0A2B) 
- [x] 开机音效
- [x] 自定义 `OpenCanopy` 
- [x] CPU 能效管理  `如果解锁了 bios 高级菜单可自行设置`
- [x] 文件保险箱 2 `No config.plist changes needed` 
- [x] GPU UHD 620
- [x] HDMI 
- [x] iMessage, FaceTime, App Store, iTunes Store. **生成您自己的 SMBIOS**
- [x] Intel I219V 有线网
- [x] 键盘 `SSDT 重定义了键位，配合 ThinkPad Assistant 使用 `
- [x] 麦克风 `SSDT 重定义了键位，配合 ThinkPad Assistant 使用`
- [x] Realtek® ALC3287 ("ALC257")  音频
- [x] SD 读卡器  
- [x] 屏幕扩展 

- [x] 睡眠唤醒
- [x] 触控板 `1-5 根手指滑动即可。使用更长、更大的触感来模拟力度触感。`
- [x] TrackPoint  `完美运行。 就像在 Windows 或 Linux 上一样.`
- [x] USB 端口 `已定制SSDT`
- [x] 摄像头
- [x] Wifi - Intel Wireless-AC 8265 
- [x] DRM `Widevine, validated on Firefox 82. WhateverGreen's DRM is broken on Big Sur`
- [x] 雷电设备

</details>  

<details>  
<summary><strong>无法运行 ⚠️</strong></summary>

- [ ] 指纹解锁  
- [ ] 随航 `如果您想使用此功能，请购买兼容的 Broadcom 卡！`

</details>  

# UEFI modding

<details>  
<summary><strong>CFG Lock | Advanced menu</strong></summary>
<br>
<img align="right" src="./Other/README Resources/CH341a.jpg" alt="CH341a.jpg" width="210">


可以解锁高级菜单，从而在高级菜单中禁用 CFG 锁定。 需要 SPI 编程器 CH341a，具体可以参考我写的[博客](https://segmentfault.com/a/1190000041408187) 

<br>

</details>  



# 感谢

- Orginal T480 OpenCore repo from [EETagent](https://github.com/EETagent/T480-OpenCore-Hackintosh) 
- Further improve OpenCore repo from [tylernguyen](https://github.com/tylernguyen/x1c6-hackintosh) 
- Lots of SSDT patches from [benbender](https://github.com/benbender)
- The guys from [Acidanthera](https://github.com/acidanthera) that make this possible
- [1Revenger1](https://github.com/1Revenger1) and [leo-labs](https://github.com/leo-labs) for [VoodooRMI](https://github.com/VoodooSMBus/VoodooRMI) and [VoodooSMBus](https://github.com/VoodooSMBus/VoodooSMBus)
- [al3xtjames](https://github.com/al3xtjames) for [NoTouchID](https://github.com/al3xtjames/NoTouchID)
- [Apple](http://apple.com) for macOS and HfsPlus.efi
- [corpnewt](https://github.com/corpnewt) for [USBMap](https://github.com/corpnewt/USBMap) and [CPUFriendDataProvider](https://github.com/corpnewt/CPUFriendFriend)
- [headkaze](https://github.com/headkaze) for [Hackintool](https://github.com/headkaze/Hackintool)
- [hieplpvip](https://github.com/hieplpvip) for [AppleBacklightSmoother](https://github.com/hieplpvip/AppleBacklightSmoother)
- [jwise](https://github.com/jwise) for [HoRNDIS](https://github.com/jwise/HoRNDIS)
- [Mieze](https://github.com/Mieze) for [IntelMausiEthernet](https://github.com/Mieze/IntelMausiEthernet)
- [MSzturc](https://github.com/MSzturc) for [ThinkPad Assistant](https://github.com/MSzturc/ThinkpadAssistant)
- [OpenIntelWireless](https://github.com/OpenIntelWireless/IntelBluetoothFirmware/releases) for [IntelBluetoothFirmware](https://github.com/OpenIntelWireless/IntelBluetoothFirmware), [itlwm](https://github.com/OpenIntelWireless/itlwm) and [HeliPort](hhttps://github.com/OpenIntelWireless/HeliPort)
- [sicreative](https://github.com/sicreative) for [VoltageShift](https://github.com/sicreative/VoltageShift)
- [zhen-zen](https://github.com/zhen-zen) for [YogaSMC](https://github.com/zhen-zen/YogaSMC)