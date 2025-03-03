function LookupFunc {

	Param ($moduleName, $functionName)

	$assem = ([AppDomain]::CurrentDomain.GetAssemblies() | 
    Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].
      Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
    $tmp=@()
    $assem.GetMethods() | ForEach-Object {If($_.Name -eq "GetProcAddress") {$tmp+=$_}}
    $test = @(($assem.GetMethod('GetModuleHandle')).Invoke($null, @($moduleName)), $functionName)
	return $tmp[1].Invoke($null, $test)
}

LookupFunc "user32.dll" "MessageBoxA"