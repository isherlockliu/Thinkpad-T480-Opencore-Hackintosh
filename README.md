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



# DISCLAIMER

**Read the entire README and Dortania guides before you start.**

**I am not responsible for any damage.**

**When you encounter bug or want to improve this repo, consider opening issue or pull request. If you find this bootloader configuration useful, consider giving it a star to make it more visible.**



# Introduction

<details>
<summary><strong>General knowledge & credits</strong></summary>


- To install macOS follow the guides provided by [Dortania](https://dortania.github.io/getting-started/)
- Useful tools by [CorpNewt](https://github.com/corpnewt) and [headkaze](https://github.com/headkaze/Hackintool)

</details> 

<details>
<summary><strong>Hardware</strong></summary>
<br>


| Category   | Component                         | Note                                                         |
| ---------- | --------------------------------- | ------------------------------------------------------------ |
| CPU        | Intel Core i7-8550U               | 20L5A01RHH                                                   |
| GPU        | Intel UHD 620                     | Disable MX150                                                |
| SSD        | LITEON T11 Plus 512               |                                                              |
| Memory     | 16GB DDR4 2400Mhz                 |                                                              |
| Battery    | Dual battery                      |                                                              |
| Camera     | 720p Camera                       |                                                              |
| Wifi & BT  | Intel Wireless-AC 8265            | Use AirportItlwm for your macOS version and enjoy native Wi-Fi control |
| Input      | PS2 Keyboard & Synaptics TrackPad | [YogaSMC](https://github.com/zhen-zen/YogaSMC) for media keys like microphone switch, etc. PrtSc is mapped as F13. |
| </details> |                                   |                                                              |

<details>
<summary><strong>Main software</strong></summary>
<br>


| Component      | Version        |
| -------------- | -------------- |
| macOS Monterey | 12.2.1 (21D62) |
| OpenCore       | 0.7.8          |
| </details>     |                |

<details>
<summary><strong>Kernel extensions</strong></summary>
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
<summary><strong>UEFI drivers</strong></summary>
<br>


|     Driver      | Version           |
| :-------------: | ----------------- |
|  AudioDxe.efi   | OpenCorePkg 0.7.8 |
|   HfsPlus.efi   | OcBinaryData      |
| OpenCanopy.efi  | OpenCorePkg 0.7.8 |
| OpenRuntime.efi | OpenCorePkg 0.7.8 |
|   </details>    |                   |


<details>
    <summary><strong>Neofetch screenshots</strong></summary>
    <br>
    <p float="left">
        <img src="./Other/README Resources/Neofetch Monterey.png" alt="Neofetch Monterey" width="660">
    </p>
</details> 



# Before installation

<details>  


<summary><strong>UEFI settings</strong></summary>
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


<summary><strong>Own prev-lang-kbd</strong></summary>
<br>

Either add as a string or as a data ( HEX data [(ProperTree)](https://github.com/corpnewt/ProperTree) )

Format is lang-COUNTRY:keyboard

- 🇺🇸 | [0] en_US - U.S --> en-US:0 --> 656e2d55 533a30

etc.

[AppleKeyboardLayouts.txt](https://github.com/acidanthera/OpenCorePkg/blob/master/Utilities/AppleKeyboardLayouts/AppleKeyboardLayouts.txt)

</details>

# Post-Install

<details>  


<summary><strong>Colour banding</strong></summary>
<br>

If you encounter some serious colour banding issues ( Keep in mind that T480 1080p stock panel colour accuracy is not really good, cca 50-60% sRGB), your only solution is to replace GPU properties as bellow or replace the stock panel with one from T490 (400 nits, Low power).

```
<key>AAPL,ig-platform-id</key>
<data>AAAWGQ==</data>
<key>device-id</key>
<data>FhkAAA==</data>
</dict>
```

Do not use these any additional boot arguments! Get custom WhateverGreen version instead from Other folder

You can check your screen in gradient test [here](https://www.eizo.be/monitor-test/) or just by simple look at Launchpad background.

</details>  

<details>  


<summary><strong>Generate your own SMBIOS</strong></summary>
<br>

[GenSMBIOS](https://github.com/corpnewt/GenSMBIOS)

- MacBookPro15,2

</details>  

<details>  


<summary><strong>CPUFriend power management</strong></summary>
<br>

Generate CPUFriendDataProvider for your machine [here](https://github.com/fewtarius/CPUFriendFriend) or use at your own risk files provided in the Other folder.

</details>  

<details>  


<summary><strong>VoltageShift undervolt</strong></summary>
<br>

It is possible to use VoltageShift directly from the EFI folder instead of disabling SIP. You need to use specific version provided in the Other folder.

```diff
! If you want to use this feature, enable it in config.plist
```

</details>  

# Status

<details>  


<summary><strong>What's working ✅</strong></summary>

- [x] Battery percentage

- [x] Bluetooth - Intel Wireless-AC 8265 (0x0A2B) 

- [x] Boot chime

- [x] Boot menu `OpenCanopy` 

- [x] CPU power management / performance `Now on par with Windows without XTU undervolt.`

- [x] FireVault 2 `No config.plist changes needed` 

- [x] GPU UHD 620 hardware acceleration / performance 

- [x] HDMI `Closed and opened lid. With audio.`

- [x] iMessage, FaceTime, App Store, iTunes Store. **Generate your own SMBIOS**

- [x] Intel I219V Ethernet port

- [x] Keyboard `Volume and brightness hotkeys. Another media keys with YogaSMC.`

- [x] Microphone `With keyboard switch using ThinkPad Assistant.`

- [x] Realtek® ALC3287 ("ALC257") Audio

- [x] SD card reader `Fortunately, USB connected.`

- [x] Sidecar wired `Works with 15,2 SMBIOS.`

- [x] Sleep/Wake 

- [x] TouchPad `1-5 fingers swipe works. Emulate force touch using longer and more voluminous touch.`

- [x] TrackPoint  `Works perfectly. Just like on Windows or Linux.`

- [x] USB Ports `USB Map is different for devices with Windows Hello camera.`

- [x] Web camera

- [x] Wifi - Intel Wireless-AC 8265 `Use HeliPort app for Wi-Fi control`

- [x] DRM `Widevine, validated on Firefox 82. WhateverGreen's DRM is broken on Big Sur`

- [x] Thunderbolt  

</details>  

<details>  


<summary><strong>What's not working ⚠️</strong></summary>

- [ ] Fingerprint reader  `There is finally after many years working driver for Linux (python-validity), don't expect macOS driver any time soon.`
- [ ] Sidecar wireless `If you want to use this feature, buy a compatible Broadcom card!`

</details>  

# UEFI modding

<details>  
<summary><strong>CFG Lock | Advanced menu</strong></summary>
<br>


<img align="left" src="./Other/README Resources/CH341a.jpg" alt="CH341a.jpg" width="220">

It's possible to unlock Advanced menu thus disable CFG Lock natively in UEFI + Other Advanced menu benefits. SPI Programmer CH341a is required

<br>
https://www.reddit.com/r/thinkpad/comments/ffqqx5/currently_testing_skyra1n/

[T480 consuming 60w (~85w total) - unlimited TDP : thinkpad](https://www.reddit.com/r/thinkpad/comments/g8fk51/t480_consuming_60w_85w_total_unlimited_tdp/)

[ThinkPad discord](discord.gg/Ybdz7AS)

</details>  



# CREDITS

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
- [zhen-zen](https://github.com/zhen-zen) for [YogaSMC](
