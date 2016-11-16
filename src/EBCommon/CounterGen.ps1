# A Code generator, parse counters information from an xml file
# and generate counter definition in C++

$xmlFile = "Counters.xml"
$hppFile = "Counters.hpp"
$cppFile = "Counters.cpp"


[xml]$MonitorSetting = Get-Content $xmlFile

# Generating hpp file

"// DO NOT MODIFIY!!! This file is automatically generated from $xmlFile by powershell CounterGen.ps1" | Out-File $hppFile
"" | Out-File $hppFile -Append
"#pragma once" | Out-File $hppFile -Append
""
"#include `"stdafx.h`"" | Out-File $hppFile -Append
"#include `"stdint.h`"" | Out-File $hppFile -Append
"" | Out-File $hppFile -Append
"namespace Tracer{" | Out-File $hppFile -Append
"" | Out-File $hppFile -Append
"    enum class EBCounter : uint32_t{" | Out-File $hppFile -Append
"        NonCounter = 0," | Out-File $hppFile -Append
"" | Out-File $hppFile -Append

$MonitorSetting.ExaVengerCounters.Actions.Action | % {"        "+$_ + ","} | Out-File $hppFile -Append

"        MaxActions," | Out-File $hppFile -Append
"" | Out-File $hppFile -Append

$MonitorSetting.ExaVengerCounters.Meters.Meter | % {"        "+$_ + ","} | Out-File $hppFile -Append
"        MaxCounters" | Out-File $hppFile -Append
"    };" | Out-File $hppFile -Append
"" | Out-File $hppFile -Append
"    extern wchar_t* g_EBCounterNames[];" | Out-File $hppFile -Append
"    extern char* g_EBCounterStrings[];" | Out-File $hppFile -Append
"" | Out-File $hppFile -Append
"}" | Out-File $hppFile -Append


#Generating cpp file

"// DO NOT MODIFIY!!! This file is automatically generated from $xmlFile by powershell CounterGen.ps1" | Out-File $cppFile
""
"#include `"stdafx.h`""  | Out-File $cppFile -Append
""  | Out-File $cppFile -Append
"namespace Tracer{"  | Out-File $cppFile -Append
""  | Out-File $cppFile -Append
"    wchar_t* g_EBCounterNames[] = {"  | Out-File $cppFile -Append
"        L`"NonCounter`","  | Out-File $cppFile -Append
""  | Out-File $cppFile -Append
$MonitorSetting.ExaVengerCounters.Actions.Action | % {"        L`""+$_ + "`","}  | Out-File $cppFile -Append

"        L`"MaxActions`","  | Out-File $cppFile -Append
""  | Out-File $cppFile -Append

$MonitorSetting.ExaVengerCounters.Meters.Meter | % {"        L`""+$_ + "`","}  | Out-File $cppFile -Append
"        L`"MaxCounters`""  | Out-File $cppFile -Append
"    };"  | Out-File $cppFile -Append
""  | Out-File $cppFile -Append


"    char* g_EBCounterStrings[] = {"  | Out-File $cppFile -Append
"        `"NonCounter`","  | Out-File $cppFile -Append
""  | Out-File $cppFile -Append
$MonitorSetting.ExaVengerCounters.Actions.Action | % {"        `""+$_ + "`","}  | Out-File $cppFile -Append

"        `"MaxActions`","  | Out-File $cppFile -Append
""  | Out-File $cppFile -Append

$MonitorSetting.ExaVengerCounters.Meters.Meter | % {"        `""+$_ + "`","}  | Out-File $cppFile -Append
"        `"MaxCounters`""  | Out-File $cppFile -Append
"    };"  | Out-File $cppFile -Append


"}"  | Out-File $cppFile -Append
