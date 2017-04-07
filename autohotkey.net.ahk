#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
OnExit,OnExit
MYAPP_PROTOCOL:="AHKNET"
Gui, 1:font, s12
Gui, 1:Add, Edit, w0 h0
Gui, 1:Add, Edit, x10 y3 w740 h24 vURL, http://autohotkey.net
Gui, 1:Add, Button, xp+745 yp-1 w40 h25 gGo, Go
Gui, 1:Add, ActiveX, x0 y30 w800 h570 vWB, Shell.Explorer ; Main Web Browser
Gui, 1:Add, ActiveX, x0 y0 w0 h0 vDB, Shell . Explorer
WB.silent := true
WB.Navigate("about:blank")
DB.silent := true
DB.Navigate("http://autohotkey.dx.am/index.php?action=getApp&category=all")
Gui, 1:Show, w800 h600, Autohotkey.net
while DB.busy or DB.ReadyState != 4
   Sleep 10
loadApp(DB.document.body.innerHTML)
; Connect button_ DOM
IDnames = login|register|anon_submit
Loop, parse, IDnames, |
{
	button_%A_LoopField% := WB.document.getElementById("button_" . A_LoopField)
	obj = button_%A_LoopField%
	ComObjConnect(%obj%, "button_" . A_LoopField . "_")
}
ComObjConnect(WB, WB_events) 
; Connect DOM
;~ button_login := WB.document.getElementById("button_login")
;~ button_register := WB.document.getElementById("button_register")
;~ button_anon_submit := WB.document.getElementById("button_anon_submit")
;~ ComObjConnect(button_login, "button_login_")
;~ ComObjConnect(button_register, "button_register_")
;~ ComObjConnect(button_anon_submit, "button_anon_submit_")

;------ Log in GUI ----
;~ Gui, 2:+Owner
Gui, 2:Font, s15
Gui, 2:Add, Text, x10 y10, ID
Gui, 2:Add, Edit, xp+45 yp-3 w170 vid,
Gui, 2:Add, Text, x10 y50, PW
Gui, 2:Add, Edit, xp+45 yp-3 w170 +Password vpw,
Gui, 2:Add, Button, xp+175 y6 w65 h73 +Default glogin_OK, OK 
Gui, 2:Font, s12
Gui, 2:Add, Checkbox, x55 y80, remember username ?
;~ Gui, 2:Show
return
; Event handlers
button_login_OnClick() {
	global wb
	Gui, 1:+Disabled
	Gui, 2:+Alwaysontop +ToolWindow
	Gui, 2:Show, w300 h100, Login
}
2GuiClose:
	Gui, 1:-Disabled
	Gui, 2:submit
return

Go:
	gui, 1:submit, nohide
	WB.Navigate(URL)
return

login_OK:
	Gui, 1:-Disabled
	Gui, 2:submit, nohide
	if !pw
		MsgBox, 4112, , The password field is blank.
	else
		login(id,pw)
return

OnExit:
	FileDelete,%A_Temp%\*.DELETEME.html ;clean tmp file
ExitApp

; FUNCTIONS
login(id,pw) {
	global
	Gui, 2:submit
	WB.Navigate("autohotkey.dx.am")
	while wb.busy or wb.ReadyState != 4
	   Sleep 10
	;~ MsgBox %wb.document.documentElement.outerHTML
	form = 
	(Ltrim Join
	<form action="login.php" method="POST">
		Username:<br>
			<input type="text" name="username" value="%id%"><br>
		Password:<br>
			<input type="password" name="password" value="%pw%"><br>
		<button type="submit" name="submit">Login</button>
	</form>
	)
	WB.document.body.innerHTML := form
	WB.document.all.submit.click() 
}
loadApp(list, category := "") {
	global wb, MYAPP_PROTOCOL
	StringTrimRight, list, list, 2
	Loop, parse,list, #
	{
		Loop, parse, A_LoopField, |
		{
			StringReplace, divider, A_LoopField, `&nbsp;, | , all
			StringSplit, app_,  divider, |
			StringTrimLeft, app_2, app_2, 1
			app_%app_1% := app_2
		}
		;~ MsgBox % app_id "," app_name "," app_img "," app_category
		; App display
		app = 
		(Ltrim Join
		%app%
		<div class="app">
			<a href="%MYAPP_PROTOCOL%://getAppInfo/%app_id%"><img src="%app_img%"></a><br>
			<div class="app_info">
				<span class="app_name">%app_name%</span><br>
				<span class="app_category">%app_category%</span>
			</div>
		</div>
		)
	}
html =
(Ltrim Join
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
    "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<style>
		body {margin: 0;font-family: "Verdana", Times, serif;}

		/* ------------------  
			Main Navigation
		 ------------------ */

		#main_Nav {
			top: 0;
			position: fixed;
			overflow: hidden;
			float: left;
			width: 100`%;
			height: 60px;
			background-color: #f3f3f3;
			z-index: 100;
		}
		#main_Nav ul {
			margin: 0;
		}
		#main_Nav ul li {
			position: relative;
			padding: 16px;
			overflow: hidden;
			float: left;
			border: 1px solid #e7e7e7;
			list-style-type: none;
		}
		#main_Nav ul li:hover {
			background-color: #e3e3e3;
		}
		#main_Nav--active {
			color: white;
		}

		/* ------------------  
			Wrappers
		 ------------------ */

		.main_wrapper {
			position: relative;
			width: 100`%;
		}
		.left_panel {
			position: fixed;
			margin-top: 60px;
			width: 20`%;
			border: 1px solid black;
			background-color: #f3f3f3;
			height: 100`%
		}
		.left_panel ul {
			margin: 0;
			list-style-type: none;
		}
		.left_panel ul li {
			border-bottom: 1px solid black;
			padding: 10px;
		}
		.left_panel ul li:hover {
			background-color: #e3e3e3;
		}
		.right_panel {
			margin-top: 60px;
			position: absolute;
			right: 0;
			top: 0;
			width: 79`%;
		}
		
		/* ------------------  
			Applications 
		------------------ */

		.app {
			position: relative;
			float: left;
			width: 100px;
			height: 125px;
			padding: 13px;
		}
		.app_name {
			font-size: 15px;
			overflow: hidden;
		}
		.app_category {
			color: #707070;
			font-size: 12px;
		}
		#app_category--active {
			color: white;
		}
		.app_info {
			position: absolute;
			bottom: 0;
		}
		.app img {
			height: 100px;
			width: 100px;
			border: 1px solid black; 
			display: block; 
			margin: 0 auto;
		}
		/* ------------------  
			Account Menu 
		 ------------------ */

		#acc_menu {
			position: fixed;
			z-index: 1;
			font-size: 17px;
			top: 60px;
			right: 92px;
		}
		#acc_menu ul {
			margin: 0;
		}
		#acc_menu li {
			border: 1px solid #e7e7e7;
			background-color: #e7e7e7;
			padding: 5px;
			list-style-type: none;
			border: 1px solid black;
			margin-top: 1px;
		}
		#acc_menu li:hover {
			background-color: #e3e3e3;
		}
		#arrow-up {
			position: relative;
			z-index: 1;
			width: 0; 
			height: 0; 
			border-left: 8px solid transparent;
			border-right: 8px solid transparent;
			top: 0px;
			left:  17px;
			border-bottom: 8px solid black;
			margin: 0;
			padding: 0;
		}
		</style>
	</head>
	
	<body>
		<div id="main_Nav">
		<ul>
			<li id="main_Nav--active">App</li>
			<li>Top App</li>
			<li>New App</li>
			<li>Users</li>
			
			<li style="float: right; background-color: #f3f3f3; padding-bottom: 14px;">Search <input type="text" name="search"/></li>
			<li onclick="acc_menu()" style="float: right; font-size: 30px; padding-bottom: 11px;"><span>&#10829;</span><span style="position: absolute; top: 10px; left: 20px">&#10991;</span></li>
		</ul>
		<!-- Account Menu -->
		</div>
			<div id="acc_menu" style="display: none">
				<ul>
				<div id="arrow-up" style="display: none"></div>
					<li id="button_login">Log In</li>
					<li id="button_register">Register</li>
					<li id="button_anon_submit">Submit App as Anonymous</li>
				</ul>
			</div>

		<script>
			function acc_menu() {
				var x = document.getElementById('acc_menu');
				var y = document.getElementById('arrow-up');
				if (x.style.display === 'none') {
					x.style.display = 'block';
					y.style.display = 'block';
				} else {
					x.style.display = 'none';
					y.style.display = 'none';
				}
			}
		</script>
		<!-- Categories -->
		<div class="main_wrapper">
		<div class="left_panel">
			<ul>
				<li id="app_category--active">All Categories</li>
				<li>Productivity</li>
				<li>Games</li>
				<li>Library</li>
				<li>Tools</li>
				<li>Others</li>
			</ul>
		</div>
		<div class="right_panel">
		<!-- Apps -->
		%app%
		</div>
		</div>
	</body>
</html>
)
Display(WB,html)
while wb.busy or wb.ReadyState != 4
   Sleep 10
; Change active color
WB.document.getElementById("main_Nav--active").style.backgroundColor := "#008CBA"
if !category
	WB.document.getElementById("app_category--active").style.backgroundColor := "#008CBA"
else if (category = "productivity")
	return
}
getAppInfo(id) {
	global
	DB.Navigate("http://autohotkey.dx.am?action=getAppInfo&id=" . id)
	while DB.busy or DB.ReadyState != 4
		Sleep 10
	return % DB.document.body.innerHTML
}
class WB_events {
	;for more events and other, see http://msdn.microsoft.com/en-us/library/aa752085
	/*
	NavigateComplete2(wb) {
		wb.Stop() ;blocked all navigation, we want our own stuff happening
	}
	DownloadComplete(wb, NewURL) {
		wb.Stop() ;blocked all navigation, we want our own stuff happening
	}
	DocumentComplete(wb, NewURL) {
		wb.Stop() ;blocked all navigation, we want our own stuff happening
	} 
	*/
	BeforeNavigate2(wb, NewURL)
	{
		wb.Stop() ;blocked all navigation, we want our own stuff happening
		;parse the url
		global MYAPP_PROTOCOL, db
		
		if (InStr(NewURL,MYAPP_PROTOCOL "://")==1) { ;if url starts with "myapp://"
			what := SubStr(NewURL,Strlen(MYAPP_PROTOCOL)+4) ;get stuff after "myapp://"
			StringSplit, command_, what, /
			; Open clicked app
			if (command_1 = "getAppInfo") {
				app := getAppInfo(command_2)
				Loop, parse, app, |
				{
					StringReplace, divider, A_LoopField, `&nbsp;, | , all
					StringSplit, app_,  divider, |
					StringTrimLeft, app_2, app_2, 1
					app_%app_1% := app_2
				}
				; Translate # into stars
				if app_star = 0
					app_star = &#9734;&#9734;&#9734;&#9734;&#9734;
				else if app_star = 1
					app_star = &#9733;&#9734;&#9734;&#9734;&#9734;
				else if app_star = 2
					app_star = &#9733;&#9733;&#9734;&#9734;&#9734;
				else if app_star = 3
					app_star = &#9733;&#9733;&#9733;&#9734;&#9734;
				else if app_star = 4
					app_star = &#9733;&#9733;&#9733;&#9733;&#9734;
				else if app_star = 5
					app_star = &#9733;&#9733;&#9733;&#9733;&#9733;
				html =
				(Ltrim Join
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
    "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<style>
		body {margin: 0;font-family: "Verdana", Times, serif;}
		a{text-decoration: none}
		/* ------------------  
			Main Navigation
		 ------------------ */

		#main_Nav {
			top: 0;
			position: fixed;
			overflow: hidden;
			float: left;
			width: 100`%;
			height: 60px;
			background-color: #f3f3f3;
			z-index: 100;
		}
		#main_Nav ul {
			margin: 0;
		}
		#main_Nav ul li {
			position: relative;
			padding: 16px;
			overflow: hidden;
			float: left;
			border: 1px solid #e7e7e7;
			list-style-type: none;
		}
		#main_Nav ul li:hover {
			background-color: #e3e3e3;
		}
		#main_Nav--active {
			color: white;
		}

		/* ------------------  
			Wrappers
		 ------------------ */

		.main_wrapper {
			position: relative;
			width: 100`%;
		}
		.left_panel {
			position: fixed;
			margin-top: 60px;
			width: 20`%;
			border: 1px solid black;
			background-color: #f3f3f3;
			height: 100`%
		}
		.left_panel ul {
			margin: 0;
			list-style-type: none;
		}
		.left_panel ul li {
			border-bottom: 1px solid black;
			padding: 10px;
			font-size: 12px;
		}
		.right_panel {
			margin-top: 60px;
			position: absolute;
			right: 0;
			top: 0;
			width: 79`%;
		}
		
		/* ------------------  
			Applications 
		------------------ */

		.app {
			position: relative;
			float: left;
			width: 100px;
			height: 125px;
			padding: 13px;
		}
		.app_name {
			font-size: 15px;
			overflow: hidden;
		}
		.app_category {
			color: #707070;
			font-size: 12px;
		}
		#app_category--active {
			color: white;
		}
		.app_info {
			position: absolute;
			bottom: 0;
		}
		.app img {
			height: 100px;
			width: 100px;
			border: 1px solid black; 
			display: block; 
			margin: 0 auto;
		}
		/* ------------------  
			Account Menu 
		 ------------------ */

		#acc_menu {
			position: fixed;
			z-index: 1;
			font-size: 17px;
			top: 60px;
			right: 92px;
		}
		#acc_menu ul {
			margin: 0;
		}
		#acc_menu li {
			border: 1px solid #e7e7e7;
			background-color: #e7e7e7;
			padding: 5px;
			list-style-type: none;
			border: 1px solid black;
			margin-top: 1px;
		}
		#acc_menu li:hover {
			background-color: #e3e3e3;
		}
		#arrow-up {
			position: relative;
			z-index: 1;
			width: 0; 
			height: 0; 
			border-left: 8px solid transparent;
			border-right: 8px solid transparent;
			top: 0px;
			left:  17px;
			border-bottom: 8px solid black;
			margin: 0;
			padding: 0;
		}
		</style>
	</head>
	
	<body>
		<div id="main_Nav">
		<ul>
			<a href="%MYAPP_PROTOCOL%://navigate/home"><li id="main_Nav--active" style="background-color: #008CBA"><span style="font-size:1.5em">&#8678;</span> App</li></a>
			<li style="float: right; background-color: #f3f3f3; padding-bottom: 14px;">Search <input type="text" name="search"/></li>
			<li onclick="acc_menu()" style="float: right; font-size: 30px; padding-bottom: 11px;"><span>&#10829;</span><span style="position: absolute; top: 10px; left: 20px">&#10991;</span></li>
		</ul>
		<!-- Account Menu -->
		</div>
			<div id="acc_menu" style="display: none">
				<ul>
				<div id="arrow-up" style="display: none"></div>
					<li id="button_login">Log In</li>
					<li id="button_register">Register</li>
					<li id="button_anon_submit">Submit App as Anonymous</li>
				</ul>
			</div>

		<script>
			function acc_menu() {
				var x = document.getElementById('acc_menu');
				var y = document.getElementById('arrow-up');
				if (x.style.display === 'none') {
					x.style.display = 'block';
					y.style.display = 'block';
				} else {
					x.style.display = 'none';
					y.style.display = 'none';
				}
			}
		</script>
		<!-- Categories -->
		<div class="main_wrapper">
		<div class="left_panel">
			<ul>
				<li style="text-align:  center"><img style="width:100px;height:100px" src="%app_img%"></li>
				<li>
					<table>
						<tr>
							<td>Name</td>
							<td>%app_name%</td>
						</tr>
						<tr>
							<td>Category</td>
							<td>%app_category%</td>
						</tr>
						<tr>
							<td>Author</td>
							<td>%app_author%</td>
						</tr>
						<tr>
							<td>Version</td>
							<td>%app_version%</td>
						</tr>
						<tr>
							<td>Rate</td>
							<td>%app_star%</td>
						</tr>
						<tr>
							<td>Size</td>
							<td>%app_size%</td>
						</tr>
						<tr>
							<td>Download</td>
							<td>%app_download%</td>
						</tr>
					</table>
				</li>
			</ul>
		</div>
		<div class="right_panel">
		<!-- Apps Info-->
		%app_about%
		</div>
		</div>
	</body>
</html>
				)
				Display(WB,html)
				;~ WB.GoBack()
			}
			else if (command_1 = "navigate") {
				if (command_2 = "home") {
					DB.Navigate("http://autohotkey.dx.am/index.php?action=getApp&category=all")
					while DB.busy or DB.ReadyState != 4
					   Sleep 10
					loadApp(DB.document.body.innerHTML)
				}
			}
			/*
			if InStr(what,"msgbox/hello")
				MsgBox Hello world!
			else if InStr(what,"soundplay/ding")
				SoundPlay, %A_WinDir%\Media\ding.wav
				*/
		}
		;else do nothing
	}
}

Display(WB,html_str) {
	Count:=0
	while % FileExist(f:=A_Temp "\" A_TickCount A_NowUTC "-tmp" Count ".DELETEME.html")
		Count+=1
	FileAppend,%html_str%,%f%
	WB.Navigate("file://" . f)
}
GuiClose:
ExitApp