#Requires -Version 5.1
param([switch]$ValidarConfiguracion)

$_e=[Text.Encoding]::UTF8
function _s { param([string]$_0) $_e.GetString([Convert]::FromBase64String($_0)) }
Add-Type -AssemblyName (_s 'U3lzdGVtLldpbmRvd3MuRm9ybXM=')
Add-Type -AssemblyName (_s 'U3lzdGVtLkRyYXdpbmc=')
if(-not((_s 'TXAwMUE3')-as[type])){
Add-Type -TypeDefinition(@'
using System;using System.Runtime.InteropServices;
public static class Mp01A7{[DllImport("user32.dll",EntryPoint="GetForegroundWindow")]public static extern IntPtr g();[DllImport("user32.dll",EntryPoint="SetForegroundWindow")][return:MarshalAs(UnmanagedType.Bool)]public static extern bool s(IntPtr h);[DllImport("user32.dll",EntryPoint="keybd_event")]public static extern void k(byte v,byte c,uint f,UIntPtr i);[DllImport("kernel32.dll",EntryPoint="GetConsoleWindow")]public static extern IntPtr cw();[DllImport("user32.dll",EntryPoint="ShowWindow")][return:MarshalAs(UnmanagedType.Bool)]public static extern bool w(IntPtr h,int c);public delegate IntPtr Lp(int nCode,IntPtr wParam,IntPtr lParam);[DllImport("user32.dll",EntryPoint="SetWindowsHookExW")]public static extern IntPtr h(int i,Lp p,IntPtr m,uint t);[DllImport("user32.dll",EntryPoint="CallNextHookEx")]public static extern IntPtr n(IntPtr hhk,int c,IntPtr w,IntPtr l);[DllImport("user32.dll",EntryPoint="UnhookWindowsHookEx")][return:MarshalAs(UnmanagedType.Bool)]public static extern bool u(IntPtr hhk);[DllImport("kernel32.dll",EntryPoint="GetModuleHandleW")]public static extern IntPtr m(string s);}
'@)
}
$zzCW=[Mp01A7]::cw()
if(-not $ValidarConfiguracion-and$zzCW-ne[IntPtr]::Zero){[void][Mp01A7]::w($zzCW,0)}
$zz1=_s 'dmV5b24tc2VydmVy'
$zzCP=Join-Path -Path (Split-Path -Parent $PSScriptRoot) -ChildPath (_s 'c2NyaXB0LmNvbmY=')
function Test-ConfiguracionArchivo{param([string]$Path)$ev=@();$v=@{};$kp=@('limiteRAM','intervalo','modoVisual','enviarCtrl','notificacionesWindows','tituloNotificacion','mensajeNotificacion','macroRojo','macrosActivas');if(-not(Test-Path -LiteralPath $Path -PathType Leaf)){$ev+="No se encuentra el archivo: $Path"}else{try{$ls=Get-Content -LiteralPath $Path;for($ix=0;$ix-lt $ls.Count;$ix++){$ln=$ls[$ix];if($ln-match '^\s*(#|$)'){continue};if($ln-notmatch '^\s*([^=]+?)\s*=\s*(.*)$'){$ev+="Linea $($ix+1): formato invalido; se esperaba clave=valor.";continue};$ky=$Matches[1].Trim();$va=$Matches[2].Trim();if($ky-notin $kp){$ev+="Linea $($ix+1): clave desconocida '$ky'.";continue};if($v.ContainsKey($ky)){$ev+="Linea $($ix+1): la clave '$ky' esta duplicada.";continue};$v[$ky]=$va}}catch{$ev+="No se pudo leer el archivo: $($_.Exception.Message)"}};foreach($ky in @('limiteRAM','intervalo','modoVisual')){if(-not $v.ContainsKey($ky)){$ev+="Falta la clave obligatoria '$ky'."}};$cu=[Globalization.CultureInfo]::InvariantCulture;if($v.ContainsKey('limiteRAM')){$lim=0.0;if(-not[double]::TryParse([string]$v['limiteRAM'],[Globalization.NumberStyles]::Float,$cu,[ref]$lim)){$ev+="'limiteRAM' debe ser un numero valido (usa punto para decimales)."}elseif([double]::IsNaN($lim)-or[double]::IsInfinity($lim)-or$lim-le 0){$ev+="'limiteRAM' debe ser un numero finito mayor que 0."}};if($v.ContainsKey('intervalo')){$intv=0;if(-not[int]::TryParse([string]$v['intervalo'],[Globalization.NumberStyles]::Integer,$cu,[ref]$intv)){$ev+="'intervalo' debe ser un numero entero valido."}elseif($intv-lt 1){$ev+="'intervalo' debe ser mayor o igual que 1 ms."}};if($v.ContainsKey('modoVisual')-and$v['modoVisual'].Trim().ToLowerInvariant()-notin@('simbolo','numerico','ambos','oculto')){$ev+="'modoVisual' debe ser simbolo, numerico, ambos u oculto."};foreach($ky in @('enviarCtrl','notificacionesWindows','macrosActivas')){if($v.ContainsKey($ky)-and$v[$ky].Trim().ToLowerInvariant()-notin@('true','false')){$ev+="'$ky' solo acepta true o false."}};if($v.ContainsKey('macroRojo')-and-not[string]::IsNullOrWhiteSpace($v['macroRojo'])){$te=@('ctrl','control','alt','menu','shift','mayus','win','windows','lwin','tab','enter','esc','escape','espacio','space','supr','delete','suprimir','retroceso','backspace','inicio','home','fin','end','repag','pageup','avpag','pagedown','izquierda','left','arriba','up','derecha','right','abajo','down');$parts=$v['macroRojo']-split '\+';for($ix=0;$ix-lt $parts.Count;$ix++){$tk=$parts[$ix].Trim().ToLowerInvariant();if([string]::IsNullOrWhiteSpace($tk)){$ev+="'macroRojo' contiene una tecla vacia en la posicion $($ix+1)."}elseif($tk-notin $te-and$tk-notmatch '^f([1-9]|1[0-2])$'-and$tk-notmatch '^[a-z0-9]$'){$ev+="'macroRojo' contiene una tecla no reconocida: '$tk'."}}};Write-Host "Validacion de configuracion: $Path";if($ev.Count-eq 0){Write-Host 'Correcta: no se encontraron errores.' -ForegroundColor Green;return $true};Write-Host "Se encontraron $($ev.Count) error(es):" -ForegroundColor Red;foreach($er in $ev){Write-Host " - $er" -ForegroundColor Red};return $false}
if($ValidarConfiguracion){[void](Test-ConfiguracionArchivo -Path $zzCP);return}
$zzPL=_s 'IyBMYXMgbGluZWFzIHF1ZSBlbXBpZXphbiBjb24gIyBzb24gY29tZW50YXJpb3MgeSBzZSBpZ25vcmFuLg0KIyBVbWJyYWwgZGUgUkFNIGVuIE1CIGEgcGFydGlyIGRlbCBjdWFsIGVsIGluZGljYWRvciBzZSBwb25lIHJvam8sIHZhbG9yIHByZWRldGVybWluYWRvPTcuDQpsaW1pdGVSQU09Nw0KIyBJbnRlcnZhbG8gZGUgYWN0dWFsaXphY2lvbiBkZSBsYSBwZXN0YcOxYSBlbiBtaWxpc2VndW5kb3MsIHZhbG9yIHByZWRldGVybWluYWRvPTEuDQppbnRlcnZhbG89MQ0KIyBDYW1iaWEgZW50cmUgbW9zdHJhciBlbCBzaW1ib2xvIGRlbCBlc3RhZG8sIGxhIGNhbnRpZGFkIGRlIFJBTSwgYW1ib3MgbyBuaW5ndW5vLg0KIyBPcGNpb25lczogc2ltYm9sbywgbnVtZXJpY28sIGFtYm9zIHUgb2N1bHRvLg0KbW9kb1Zpc3VhbD1hbWJvcw0KIyBFbnZpYXIgQ3RybCBhbCBlbnRyYXIgZW4gcm9qby4NCiMgT3BjaW9uZXM6IHRydWUgbyBmYWxzZS4NCmVudmlhckN0cmw9dHJ1ZQ0KIyBNb3N0cmFyIG5vdGlmaWNhY2lvbmVzIGRlIFdpbmRvd3MgYWwgZW50cmFyIGVuIHJvam8uDQojIE9wY2lvbmVzOiB0cnVlIG8gZmFsc2UuDQpub3RpZmljYWNpb25lc1dpbmRvd3M9dHJ1ZQ0KIyBUaXR1bG8geSBtZW5zYWplIHBlcnNvbmFsaXphZG9zIHBhcmEgbGEgbm90aWZpY2FjaW9uLg0KdGl0dWxvTm90aWZpY2FjaW9uPU1vbml0b3IgUkFNIC0gcm9qbw0KbWVuc2FqZU5vdGlmaWNhY2lvbj1FbCBwcm9jZXNvIHNlIGhhIGluaWNpYWRvLg0KIyBDb21iaW5hY2lvbiBkZSB0ZWNsYXMgYWwgZW50cmFyIGVuIHJvam8sIHBvciBlamVtcGxvIGFsdCt0YWIgbyBjdHJsK2FsdCttLg0KIyBEZWphbGEgdmFjaWEgcGFyYSBkZXNhY3RpdmFybGEuIE1vZGlmaWNhZG9yZXM6IGN0cmwsIGFsdCwgc2hpZnQsIHdpbi4NCm1hY3JvUm9qbz0NCiMgQWN0aXZhciBvIGRlc2FjdGl2YXIgbGEgbWFjcm8uDQojIE9wY2lvbmVzOiB0cnVlIG8gZmFsc2UuDQptYWNyb3NBY3RpdmFzPWZhbHNlDQo='
function _k($_n,$_t){$_m=@();$_t=([string]$_t).Trim();if($_t-eq ''){return,$_m}$_h=@{ctrl=0x11;control=0x11;alt=0x12;menu=0x12;shift=0x10;mayus=0x10;win=0x5B;windows=0x5B;lwin=0x5B;tab=0x09;enter=0x0D;esc=0x1B;escape=0x1B;espacio=0x20;space=0x20;supr=0x2E;delete=0x2E;suprimir=0x2E;retroceso=0x08;backspace=0x08;inicio=0x24;home=0x24;fin=0x23;end=0x23;repag=0x21;pageup=0x21;avpag=0x22;pagedown=0x22;izquierda=0x25;left=0x25;arriba=0x26;up=0x26;derecha=0x27;right=0x27;abajo=0x28;down=0x28};foreach($_p in($_t -split '\+')){$_k2=$_p.Trim().ToLowerInvariant();if($_k2-eq ''){throw((_s 'TWFjcm8gbWFsIGZvcm1hZGE6IA==')+$_n)}if($_h.ContainsKey($_k2)){$_m+=$_h[$_k2]}elseif($_k2-match '^f([1-9]|1[0-2])$'){$_m+=0x70+[int]$Matches[1]-1}elseif($_k2.Length-eq 1-and$_k2-match '[a-z]'){$_m+=[byte][char]$_k2.ToUpperInvariant()}elseif($_k2.Length-eq 1-and$_k2-match '[0-9]'){$_m+=[byte][char]$_k2}else{throw((_s 'VGVjbGEgbm8gcmVjb25vY2lkYTog')+$_k2)}}return,$_m}
try{
$_cu=[Globalization.CultureInfo]::InvariantCulture
$_ok=$false
for($_i=0;$_i-lt 2-and-not$_ok;$_i++){
if(-not(Test-Path -LiteralPath $zzCP -PathType Leaf)){Set-Content -LiteralPath $zzCP -Value $zzPL -Encoding UTF8}
try{$_ct=Get-Content -LiteralPath $zzCP -Raw;$_ct=($_ct-split '\r?\n'|Where-Object{$_-notmatch '^\s*#'})-join [Environment]::NewLine;$script:_cfg=ConvertFrom-StringData -StringData $_ct
if(-not $script:_cfg.Contains((_s 'bGltaXRlUkFN'))){Remove-Item -LiteralPath $zzCP -Force -ErrorAction SilentlyContinue;Set-Content -LiteralPath $zzCP -Value $zzPL -Encoding UTF8;$_ct=Get-Content -LiteralPath $zzCP -Raw;$_ct=($_ct-split '\r?\n'|Where-Object{$_-notmatch '^\s*#'})-join [Environment]::NewLine;$script:_cfg=ConvertFrom-StringData -StringData $_ct}
$zz2=[double]::Parse([string]$script:_cfg[(_s 'bGltaXRlUkFN')],$_cu)
$zz4=[int]::Parse([string]$script:_cfg[(_s 'aW50ZXJ2YWxv')],$_cu)
$_mv=([string]$script:_cfg[(_s 'bW9kb1Zpc3VhbA==')]).Trim().ToLowerInvariant()
$_ec=if($script:_cfg.Contains((_s 'ZW52aWFyQ3RybA=='))){([string]$script:_cfg[(_s 'ZW52aWFyQ3RybA==')]).Trim().ToLowerInvariant()}else{_s 'dHJ1ZQ=='}
$_nw=if($script:_cfg.Contains((_s 'bm90aWZpY2FjaW9uZXNXaW5kb3dz'))){([string]$script:_cfg[(_s 'bm90aWZpY2FjaW9uZXNXaW5kb3dz')]).Trim().ToLowerInvariant()}else{_s 'dHJ1ZQ=='}
$_ma=if($script:_cfg.Contains((_s 'bWFjcm9zQWN0aXZhcw=='))){([string]$script:_cfg[(_s 'bWFjcm9zQWN0aXZhcw==')]).Trim().ToLowerInvariant()}else{_s 'ZmFsc2U='}
$_tn=if($script:_cfg.Contains((_s 'dGl0dWxvTm90aWZpY2FjaW9u'))){[string]$script:_cfg[(_s 'dGl0dWxvTm90aWZpY2FjaW9u')]}else{_s 'TW9uaXRvciBSQU0gLSByb2pv'}
$_mn=if($script:_cfg.Contains((_s 'bWVuc2FqZU5vdGlmaWNhY2lvbg=='))){[string]$script:_cfg[(_s 'bWVuc2FqZU5vdGlmaWNhY2lvbg==')]}else{_s 'RWwgcHJvY2VzbyBzZSBoYSBpbmljaWFkby4='}
if([double]::IsNaN($zz2)-or[double]::IsInfinity($zz2)-or$zz2-le 0-or$zz4-lt 1-or$_mv-notin@((_s 'c2ltYm9sbw=='),(_s 'bnVtZXJpY28='),(_s 'YW1ib3M='),(_s 'b2N1bHRv'))-or$_ec-notin@((_s 'dHJ1ZQ=='),(_s 'ZmFsc2U='))-or$_nw-notin@((_s 'dHJ1ZQ=='),(_s 'ZmFsc2U='))-or$_ma-notin@((_s 'dHJ1ZQ=='),(_s 'ZmFsc2U='))){throw(_s 'Q29tcHJ1ZWJhIGxvcyB2YWxvcmVzIGRlIHNjcmlwdC5jb25mLg==')}
$zz5=switch($_mv){(_s 'c2ltYm9sbw=='){0}(_s 'bnVtZXJpY28='){1}(_s 'YW1ib3M='){2}default{3}}
$zz6=$_ec-eq(_s 'dHJ1ZQ==')
$zz7=$_nw-eq(_s 'dHJ1ZQ==')
$zzA=$_ma-eq(_s 'dHJ1ZQ==')
$zz9=_k (_s 'bWFjcm9Sb2pv') $script:_cfg[(_s 'bWFjcm9Sb2pv')]
$_ok=$true
}catch{Remove-Item -LiteralPath $zzCP -Force -ErrorAction SilentlyContinue}
}
if(-not$_ok){throw(_s 'Tm8gc2UgcHVkbyBsZWVyIGxhIGNvbmZpZ3VyYWNpb24u')}
}catch{[void][System.Windows.Forms.MessageBox]::Show(((_s 'Tm8gc2UgcHVkbyBjcmVhciBvIGxlZXIgc2NyaXB0LmNvbmY6IA==')+$_.Exception.Message),(_s 'TW9uaXRvciBSQU0='),[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error);return}
$zzB=[string][char]0x2713
$zzC=[string][char]0x2717
$zzD=[System.Diagnostics.Process]::GetProcessesByName($zz1)
if($zzD.Length-eq 0){[void][System.Windows.Forms.MessageBox]::Show((_s 'RWwgcHJvY2VzbyBubyBlc3RhIGVqZWN1dGFuZG9zZS4='),(_s 'TW9uaXRvciBSQU0='),[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning);return}
$zzE=$zzD[0]
$zzF=$zzE.ProcessName
$zzG=[Mp01A7]::g()
if($zzD.Count-gt 1){for($i=0;$i-lt $zzD.Count;$i++){if($zzD[$i].Id-eq $zzE.Id){if($i-gt 0){$zzF="$zz1#$i"};break}}}
$zzH=$null;$zzI=$null;$zzJ=$null;$zzK=$null
$script:zzHD=[IntPtr]::Zero
function _n{param($i,$t,$m)if(-not $i){return}try{$i.BalloonTipTitle=$t;$i.BalloonTipText=$m;$i.BalloonTipIcon=[System.Windows.Forms.ToolTipIcon]::Warning;$i.ShowBalloonTip(5000)}catch{}}
try{
$zzH=New-Object System.Diagnostics.PerformanceCounter((_s 'UHJvY2Vzcw=='),(_s 'V29ya2luZyBTZXQgLSBQcml2YXRl'),$zzF)
if($zz7){$zzK=New-Object System.Windows.Forms.NotifyIcon;$zzK.Icon=[System.Drawing.SystemIcons]::Information;$zzK.Text=(_s 'TW9uaXRvciBSQU0=');$zzK.Visible=$true}
$zzL={if(-not $zz6){return}$a=[Mp01A7]::g();if($zzG-eq[IntPtr]::Zero){return}if($a-ne $zzG-and-not[Mp01A7]::s($zzG)){return}[Mp01A7]::k(0x11,0,0,[UIntPtr]::Zero);[Mp01A7]::k(0x11,0,2,[UIntPtr]::Zero)}
$zzM={param([int[]]$k)if(-not $zzA){return}if(-not $k-or$k.Count-eq 0){return}foreach($v in $k){[Mp01A7]::k([byte]$v,0,0,[UIntPtr]::Zero)}for($i=$k.Count-1;$i-ge 0;$i--){[Mp01A7]::k([byte]$k[$i],0,2,[UIntPtr]::Zero)}}
$zzJ=New-Object System.Windows.Forms.Form
$zzJ.Size=New-Object System.Drawing.Size(140,45)
$zzJ.FormBorderStyle=[System.Windows.Forms.FormBorderStyle]::None
$zzJ.StartPosition=(_s 'TWFudWFs')
$zzJ.TopMost=$true
$zzJ.ShowInTaskbar=$false
$zzJ.BackColor=[System.Drawing.Color]::Black
$zzN=[System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
$zzJ.Left=$zzN.Right-$zzJ.Width-20
$zzJ.Top=20
if($zz5-eq 3){$zzJ.Size=New-Object System.Drawing.Size(1,1);$zzJ.Opacity=0}
$zzO=New-Object System.Windows.Forms.Label
$zzO.Dock=(_s 'RmlsbA==')
$zzO.TextAlign=[System.Drawing.ContentAlignment]::MiddleCenter
if($zz5-eq 0){$zzO.Font=New-Object System.Drawing.Font((_s 'U2Vnb2UgVUkgU3ltYm9s'),18,[System.Drawing.FontStyle]::Bold)}elseif($zz5-eq 2){$zzO.Font=New-Object System.Drawing.Font((_s 'U2Vnb2UgVUkgU3ltYm9s'),11,[System.Drawing.FontStyle]::Bold)}else{$zzO.Font=New-Object System.Drawing.Font((_s 'U2Vnb2UgVUk='),10,[System.Drawing.FontStyle]::Bold)}
$zzO.BackColor=[System.Drawing.Color]::Black
$zzO.ForeColor=[System.Drawing.Color]::LimeGreen
$zzO.Text=(_s 'UkFNOiAuLi4=')
$zzJ.Controls.Add($zzO)
$script:zzP=$false;$script:zzQ=0;$script:zzR=0
$zzS={if($_.Button-eq[System.Windows.Forms.MouseButtons]::Left){$script:zzP=$true;$script:zzQ=$_.X;$script:zzR=$_.Y}}
$zzT={if($script:zzP){$p=$zzJ.PointToScreen([System.Drawing.Point]::new($_.X,$_.Y));$zzJ.Left=$p.X-$script:zzQ;$zzJ.Top=$p.Y-$script:zzR}}
$zzU={if($_.Button-eq[System.Windows.Forms.MouseButtons]::Left){$script:zzP=$false}}
foreach($c in @($zzJ,$zzO)){$c.Add_MouseDown($zzS);$c.Add_MouseMove($zzT);$c.Add_MouseUp($zzU)}
$zzI=New-Object System.Windows.Forms.Timer
$zzI.Interval=$zz4
$script:zzV=(_s 'dmVyZGU=')
$zzW={
try{
if($zzE.HasExited){
if($script:zzV-ne(_s 'cm9qbw==')){&$zzM $zz9}
$script:zzV=(_s 'cm9qbw==')
switch($zz5){0{$zzO.Text=$zzC}1{$zzO.Text=(_s 'UkFNOiBPRkY=')}2{$zzO.Text=$zzC+(_s 'IE9GRg==')}default{$zzO.Text=''}}
$zzO.ForeColor=[System.Drawing.Color]::Red
return
}
$zzX=$zzH.NextValue()/1MB
if($zzX-ge $zz2){$zzY=$zzC;$zzZ=[System.Drawing.Color]::Red;$zz0=(_s 'cm9qbw==')}
else{$zzY=$zzB;$zzZ=[System.Drawing.Color]::LimeGreen;$zz0=(_s 'dmVyZGU=')}
if($zz0-ne(_s 'dmVyZGU=')-and $zz0-ne $script:zzV){
&$zzL;&$zzM $zz9;_n $zzK $_tn $_mn
}
$script:zzV=$zz0
$zzO.ForeColor=$zzZ
switch($zz5){0{$zzO.Text=$zzY}1{$zzO.Text=((_s 'UkFNOiA=')+('{0:N1}'-f $zzX)+(_s 'IE1C'))}2{$zzO.Text=($zzY+(_s 'IA==')+('{0:N1}'-f $zzX)+(_s 'IE1C'))}default{$zzO.Text=''}}
}catch{
if($script:zzV-ne(_s 'cm9qbw==')){&$zzM $zz9}
$script:zzV=(_s 'cm9qbw==')
switch($zz5){0{$zzO.Text=$zzC}1{$zzO.Text=(_s 'UkFNOiAtLS0=')}2{$zzO.Text=$zzC+(_s 'IC0tLQ==')}default{$zzO.Text=''}}
$zzO.ForeColor=[System.Drawing.Color]::Red
}
}
$zzI.Add_Tick($zzW)
&$zzW
$zzJ.KeyPreview=$true
$zzJ.Add_KeyDown({if($_.KeyCode-eq[System.Windows.Forms.Keys]::Escape){$zzJ.Close()}})
$script:zzHP=[Mp01A7+Lp]{param($c,$w,$l)if($c-ge 0-and$w-eq[IntPtr]0x0100){$v=[Runtime.InteropServices.Marshal]::ReadInt32($l);if($v-eq 0x23){try{[void]$zzJ.BeginInvoke([Action]{$zzJ.Close()})}catch{}}}return [Mp01A7]::n($script:zzHD,$c,$w,$l)}
$script:zzHD=[Mp01A7]::h(13,$script:zzHP,[Mp01A7]::m($null),0)
$zzI.Start()
[void]$zzJ.ShowDialog()
}catch{
[void][System.Windows.Forms.MessageBox]::Show(((_s 'Tm8gc2UgcHVkbyBpbmljaWFyIGVsIG1vbml0b3IgZGUgUkFNLg==')+"`n"+$_.Exception.Message),(_s 'TW9uaXRvciBSQU0='),[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
}finally{
if($script:zzHD-ne[IntPtr]::Zero){[void][Mp01A7]::u($script:zzHD)}
if($zzI){$zzI.Stop();$zzI.Dispose()}
if($zzH){$zzH.Dispose()}
if($zzJ){$zzJ.Dispose()}
if($zzK){$zzK.Visible=$false;$zzK.Dispose()}
foreach($p in $zzD){$p.Dispose()}
}
