// Native ACPI-setup for the USB2/3-controller on x80-series Thinkpads
//
// This enables all ports to be as native as possible on OSX and only disables those devices which
// have definetly no drivers on OSX. It should be compatible with almost all thinkpad-configs.
//
// The opinion that things like cardreader, which might not be used, are adding to a significant
// power-draw is false - if one has a working USB-setup. Even if it does not hurt.
//
// This SSDT is developed with compatibility in mind and therefor all devices are enabled by default.
//
// I'm driving both of my thinkpads with ~0.7W pkg-power draw on idle with all devices enabled.
//
// Reference: https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/extensible-host-controler-interface-usb-xhci.pdf

DefinitionBlock ("", "SSDT", 2, "T480", "XHC", 0x00001000)
{
    // Common utils from SSDT-Utils
    External (OSDW, MethodObj) // 0 Arguments
    External (DTGP, MethodObj) // 5 Arguments

    External (_SB.PCI0.XHC_, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.HS01, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.HS02, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.HS03, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.HS04, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.HS05, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.HS06, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.HS07, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.HS08, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.HS09, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.HS10, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.SS01, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.SS02, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.SS03, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.SS04, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.SS05, DeviceObj)
    External (_SB.PCI0.XHC_.RHUB.SS06, DeviceObj)

    External (_SB.PCI0.RP09.PXSX.DSB2.XHC2, DeviceObj)
    External (_SB.PCI0.RP09.PXSX.DSB2.XHC2.MODU, MethodObj)    // 0 Arguments

    Scope (\_SB)
    {
        /*
         * AppleUsbPower compatibility table for Skylake+.
         *
         * Be warned that power supply values can be different
         * for different systems. Depending on the configuration
         * these values must match injected IOKitPersonalities
         * for com.apple.driver.AppleUSBMergeNub. iPad remains
         * being the most reliable device for testing USB port
         * charging support.
         *
         * Try NOT to rename EC0, H_EC, etc. to EC.
         * These devices are incompatible with macOS and may break
         * at any time. AppleACPIEC kext must NOT load.
         * See the disable code below.
         *
         * Reference: https://dortania.github.io/OpenCore-Post-Install/usb/misc/power.html
         */
        Device (USBX)
        {
            Name (_ADR, Zero)  // _ADR: Address

            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                Local0 = Package ()
                    {
                        "kUSBSleepPortCurrentLimit", 2100, 
                        "kUSBWakePortCurrentLimit", 2100,
                        "kUSBSleepPowerSupply", 5100, 
                        "kUSBWakePowerSupply", 5100, 
                    }
                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                Return (Local0)
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (OSDW ())
                {
                    Return (0x0F)
                }

                Return (Zero)
            }
        }
 
        Scope (PCI0.XHC_)
        {
            If (OSDW ())
            {
                Name (_GPE, 0x6D)  // _GPE: General Purpose Events
            }
            
            // kUSBTypeCCableDetectACPIMethodSupported
            Method (RTPC, 1, Serialized)
            {
                Debug = Concatenate ("XHC:RTPC called with args: ", Arg0)

                Return (Zero)
            }

            /**
             * kUSBTypeCCableDetectACPIMethod
             *
             * Return:
             *    kUSBTypeCCableTypeNone              = 0,
             *    kUSBTypeCCableTypeUSB               = 1,
             */
            Method (MODU, 0, Serialized)
            {
                Local0 = One

                If (CondRefOf (\_SB.PCI0.RP09.PXSX.DSB2.XHC2.MODU))
                {
                    Local0 = (\_SB.PCI0.RP09.PXSX.DSB2.XHC2.MODU ())
                }

                Debug = Concatenate ("XHC:MODU - Result: ", Local0)

                Return (Local0)
            }

            Scope (RHUB)
            {
                Scope (HS01) // Lower USB-2-Port, 480 Mbit/s
                {
                    Method (_UPC, 0, Serialized)
                    {
                        Return (Package (0x04)  // _UPC: USB Port Capabilities  
                        {
                            0xFF, 
                            Zero, 
                            Zero, 
                            Zero
                        })
                    }
                }

                Scope (HS02) // Upper USB-2-Port, 480 Mbit/s
                {
                    Method (_UPC, 0, Serialized)
                    {
                        Return (Package (0x04)  // _UPC: USB Port Capabilities  
                        {
                            0xFF, 
                            Zero, 
                            Zero, 
                            Zero
                        })
                    }                    
                }

                Scope (HS03) // Smartcard-reader, internal, deactivated
                {
                    Method (_UPC, 0, Serialized)
                    {
                        If (OSDW ())
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities 
                            {
                                Zero,
                                Zero,
                                Zero,
                                Zero
                            })
                        }
                        Else
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF,
                                0xFF,
                                Zero,
                                Zero
                            })
                        }
                    }
                }

                Scope (HS04) // Lower speed Type-C, 480 Mbit/s, needs investigation
                {
                    Method (_UPC, 0, Serialized)
                    {
                        Return (Package (0x04)  // _UPC: USB Port Capabilities 
                        {
                            0xFF,
                            0x08,
                            Zero,
                            Zero
                        })
                    }
                }

                Scope (HS05) // Ir-webcam, internal, deactivated
                {
                    Method (_UPC, 0, Serialized)
                    {
                        If (OSDW ())
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities  
                            {
                                Zero,
                                Zero,
                                Zero,
                                Zero
                            })
                        }
                        Else
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF,
                                0xFF,
                                Zero,
                                Zero
                            })
                        }
                    }
                }

                Scope (HS06) // Unused, internal
                {
                    Method (_UPC, 0, Serialized)
                    {
                        If (OSDW ())
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                Zero,
                                Zero,
                                Zero,
                                Zero
                            })
                        }
                        Else
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF,
                                0xFF,
                                Zero,
                                Zero
                            })
                        }
                    }
                }

                Scope (HS07) // Bluetooth, internal
                {
                    Method (_UPC, 0, Serialized)  
                    {
                        Return (Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            0xFF,
                            0xFF,
                            Zero,
                            Zero
                        })
                    }
                }

                Scope (HS08) // Webcam, internal
                {
                    Method (_UPC, 0, Serialized)  
                    {
                        Return (Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            0xFF,
                            0xFF,
                            Zero,
                            Zero
                        })
                    }
                }

                Scope (HS09) // Fingerprint reader, internal, deactivated
                {
                    Method (_UPC, 0, Serialized) 
                    {
                        If (OSDW ())
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                Zero,
                                Zero,
                                Zero,
                                Zero
                            })
                        }
                        Else
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF,
                                0xFF,
                                Zero,
                                Zero
                            })
                        }
                    }
                }

                Scope (HS10) // Touchscreen, internal
                {
                    Method (_UPC, 0, Serialized)  
                    {
                        If (OSDW ())
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                Zero,
                                Zero,
                                Zero,
                                Zero
                            })
                        }
                        Else
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF,
                                0xFF,
                                Zero,
                                Zero
                            })
                        }
                    }
                }

                Scope (SS01) // Lower USB-3-Port, 5 Gbit/s
                {
                    Method (_UPC, 0, Serialized) 
                    {
                        Return (Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            0xFF,
                            0x03,
                            Zero,
                            Zero
                        })
                    }
                }

                Scope (SS02) // Upper USB-3-Port, 5 Gbit/s
                {
                    Method (_UPC, 0, Serialized) 
                    {
                        Return (Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            0xFF,
                            0x03,
                            Zero,
                            Zero
                        })
                    }
                }

                Scope (SS03) // Cardreader, internal
                {
                    Method (_UPC, 0, Serialized) 
                    {
                        If (OSDW ())
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                Zero,
                                Zero,
                                Zero,
                                Zero
                            })
                        }
                        Else
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF,
                                0xFF,
                                Zero,
                                Zero
                            })
                        }
                    }
                }

                Scope (SS04) // Higher speed Type-C, 5 Gbit/s, needs investigation
                {
                    Method (_UPC, 0, Serialized)
                    {
                        Return (Package (0x04)  // _UPC: USB Port Capabilities 
                        {
                            0xFF,
                            0x09,
                            Zero,
                            Zero
                        })
                    }
                }

                Scope (SS05) // Unused, internal
                {
                    Method (_UPC, 0, Serialized)  
                    {
                        If (OSDW ())
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                Zero,
                                Zero,
                                Zero,
                                Zero
                            })
                        }
                        Else
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF,
                                0xFF,
                                Zero,
                                Zero
                            })
                        }
                    }
                }

                Scope (SS06) // Unused, internal
                {
                    Method (_UPC, 0, Serialized)  
                    {
                        If (OSDW ())
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                Zero,
                                Zero,
                                Zero,
                                Zero
                            })
                        }
                        Else
                        {
                            Return (Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF,
                                0xFF,
                                Zero,
                                Zero
                            })
                        }
                    }
                }
            }
        }
    }
}