DefinitionBlock ("", "SSDT", 2, "T480", "VAR", 0x00001000)
{
    // Common utils from SSDT-Utils
    External (OSDW, MethodObj) // 0 Arguments

    External (_SB.PCI0, DeviceObj)

    // System
    External (OSYS, FieldUnitObj) 
    External (HPTE, FieldUnitObj) 
    External (WNTF, FieldUnitObj) 
    External (DPTF, FieldUnitObj) 
//    External (ZINI, MethodObj)

//    // Thunderbolt
//    External (_SB.PCI0.RP09.INIT, MethodObj)


    Scope (\_SB.PCI0)
    {
        Method (OINI, 0, NotSerialized)
        {
            If (OSDW())
            {
                Debug = "Set System Variables..."

                // Patch OSYS to native value of darwin
                OSYS = 0x07DF
                
                // Disable HPET. It shouldn't be needed on modern systems anyway and is also disabled in genuine OSX
                HPTE = Zero

                // Disable DPTF, we use DYTC!
//                DPTF = Zero
                
                // Enable DYTC, Lenovos thermal solution. Can be controlled by YogaSMC
//                WNTF = One

                
//                Debug = "ZINI ()..."
//                ZINI ()
                
//                if (CondRefOf (\_SB.PCI0.RP09.INIT))
//                {
//                    Debug = "Thunderbolt Setup..."
//                    \_SB.PCI0.RP09.INIT ()
//                }
            }           
        }
    }
}
//EOF