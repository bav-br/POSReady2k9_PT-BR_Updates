'
' Windows Embedded POSReady 2009
' Last Rev: August 26, 2008
'

const HKEY_LOCAL_MACHINE = &H80000002

strComputer = "."
strWPAKeyPath = "SYSTEM\WPA\"
strWPAValueName = "Installed"
dwWPAValue = 0
strAppKeyPath = "SOFTWARE\Microsoft\"
strAppVersion = "Version"
strAppBuild = "Build"
strAppVersionValue = ""
strAppBuildValue = ""

Set objWMIRegistry = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\default:StdRegProv")
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colWPA = objWMIService.ExecQuery ("Select * from Win32_WindowsProductActivation")
Set colOperatingSystems = objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")
Set colComputerSystem = objWMIService.ExecQuery ("Select * from Win32_ComputerSystem")

'----------------------------------------------------
' Operating System
'----------------------------------------------------


objWMIRegistry.GetDWORDValue HKEY_LOCAL_MACHINE, "SYSTEM\WPA\WES", strWPAValueName, dwWPAValue
If dwWPAValue = 1 Then
	strApp = "WES"
Else
	objWMIRegistry.GetDWORDValue HKEY_LOCAL_MACHINE, "SYSTEM\WPA\POSReady", strWPAValueName, dwWPAValue
	If dwWPAValue = 1 Then
		strApp = "POSReady"
	Else 
		objWMIRegistry.GetDWORDValue HKEY_LOCAL_MACHINE, "SYSTEM\WPA\WEPOS", strWPAValueName, dwWPAValue
		If dwWPAValue = 1 Then
			strAPP = "WEPOS"
		Else 
			strApp = "Windows"
		End If	
	End If	
End If	

If strApp = "Windows" Then
	For Each objOperatingSystem in colOperatingSystems
		strInfo = strInfo & "PRODUCT:" & vbTab & objOperatingSystem.Caption & vbCrLf
		strInfo = strInfo & vbTab & vbTab & objOperatingSystem.Version & " (" & objOperatingSystem.CSDVersion & ")" & vbCrLf & vbCrLf
		strOSMajorVer = Left(objOperatingSystem.Version,1) 
	Next
Else
	If strApp = "WES" Then
		strInfo = strInfo & "PRODUCT:" & vbTAB & "Windows Embedded Standard" & vbCrLf & vbCrLf
		For Each objOperatingSystem in colOperatingSystems
			strInfo = strInfo & "BASED ON:" & vbTab & objOperatingSystem.Caption & vbCrLf
			strInfo = strInfo & vbTab & vbTab & objOperatingSystem.Version & " (" & objOperatingSystem.CSDVersion & ")" & vbCrLf & vbCrLf
			strOSMajorVer = Left(objOperatingSystem.Version,1) 
		Next
	Else
		If strApp = "POSReady" Then
			strInfo = strInfo & "PRODUCT:" & vbTab & "Windows Embedded POSReady 2009" & vbCrLf
		Else
			strInfo = strInfo & "PRODUCT:" & vbTab & "Windows Embedded for Point of Service" & vbCrLf
		End If	
		For Each objOperatingSystem in colOperatingSystems
			If objOperatingSystem.SuiteMask And 64 Then
				objWMIRegistry.GetStringValue HKEY_LOCAL_MACHINE, strAppKeyPath & strApp, strAppVersion, strAppVersionValue
				objWMIRegistry.GetStringValue HKEY_LOCAL_MACHINE, strAppKeyPath & strApp, strAppBuild, strAppBuildValue
				strInfo = strInfo & vbTab & vbTab  & "Version: " 
				If strAppVersionValue Then
					strInfo = strInfo & strAppVersionValue
				Else
					strInfo = strInfo & "1.0"
				End If
				If strAppBuildValue <> "" Then
					strInfo = strInfo & " (" & strAppBuildValue & ")"
				End If	
				strInfo = strInfo & vbCrLf & vbCrLf
			End if
			strInfo = strInfo & "BASED ON:" & vbTab & objOperatingSystem.Caption & vbCrLf
			strInfo = strInfo & vbTab & vbTab & objOperatingSystem.Version & " (" & objOperatingSystem.CSDVersion & ")" & vbCrLf & vbCrLf
			strOSMajorVer = Left(objOperatingSystem.Version,1) 
		Next
	End If
End If	
'----------------------------------------------------
'  Computer System
'----------------------------------------------------
strInfo = strInfo & "COMPUTER:"  
For Each objComputerSystem in colComputerSystem
	strInfo = strinfo & vbTab & objComputerSystem.Manufacturer & vbCrLf
	strInfo = strinfo & vbTab & vbTab & objComputerSystem.Model & vbCrLf & vbCrLf
Next
'----------------------------------------------------
'  Registration
'----------------------------------------------------
For Each objOperatingSystem in colOperatingSystems
	strInfo = strInfo & "REGISTRATION:"
    strInfo = strInfo & vbTab & objOperatingSystem.RegisteredUser & vbCrLf
    strInfo = strInfo & vbTab & vbTab & objOperatingSystem.Organization & vbCrLf & vbCrLf
Next
'----------------------------------------------------
'  Evaluation Period
'----------------------------------------------------
If strApp = "POSReady" Then
	For Each objWPA in colWPA
		strInfo = strInfo & "LICENSE:" 
		If (objWPA.RemainingEvaluationPeriod > 2000000000) Then
			strInfo = strInfo & vbTab & "Unlimited" & VBCR & VBLF
		Else
			strInfo = strInfo & vbTab & "Evaluation" & vbCrLf
			strInfo = strInfo & vbTab & vbTab & objWPA.RemainingEvaluationPeriod & " Days Remaining" & VBCR & VBLF
		End If
	Next
End If
'----------------------------------------------------
' Display results
'----------------------------------------------------
Wscript.Echo strInfo
'----------------------------------------------------
' End of script
'----------------------------------------------------