$Advapi32 = @"
using System;
using System.Runtime.InteropServices;

public class Advapi32 {
    [DllImport("advapi32.dll", SetLastError = true)]
    public static extern bool GetUserName(System.Text.StringBuilder sb, ref Int32 length);
}
"@

Add-Type $Advapi32

$User32 = @"
using System;
using System.Runtime.InteropServices;

public class User32 {
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int MessageBox(IntPtr hWnd, String text, 
        String caption, int options);
}
"@

Add-Type $User32

$buffer = New-Object System.Text.StringBuilder
$strlen = 64

$tmp = [Advapi32]::GetUserName($buffer,[ref]$strlen)
$tmp = [User32]::MessageBox(0, $buffer, "Username", 0)