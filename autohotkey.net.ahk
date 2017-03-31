#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
OnExit,OnExit
Gui, font, s12
Gui, Add, Edit, w0 h0
Gui, Add, Edit, x10 y3 w740 h24 vURL, http://autohotkey.net
Gui, Add, Button, xp+745 yp-1 w40 h25 gGo, Go
Gui, Add, ActiveX, x0 y30 w800 h570 vWB, Shell.Explorer
WB.silent := true
WB.Navigate("about:blank")
Sleep 10
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
			font-size: 12px;
			overflow: hidden;
		}
		.app_category {
			color: #707070;
			font-size: 15px;
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
		</div>
			<div id="acc_menu" style="display: none">
				<ul>
				<div id="arrow-up" style="display: none"></div>
					<li>Log In</li>
					<li>Register</li>
					<li>Submit App as Anonymous</li>
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
		
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Name</span><br><span class="app_category">Category</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>
		<div class="app"><img src=""><br><div class="app_info"><span class="app_name">Code Ur List</span><br><span class="app_category">Games</span></div></div>

		</div>
		</div>
	</body>
</html>
)
;~ WB.document.write(html)
Display(WB,html)

; LOG IN
/*
WB.Navigate("autohotkey.dx.am")
while wb.busy or wb.ReadyState != 4
   Sleep 10
;~ MsgBox %wb.document.documentElement.outerHTML
form = 
(Ltrim Join
<form action="login.php" method="POST">
	Username:<br>
		<input type="text" name="username" value="%ID%"><br>
	Password:<br>
		<input type="password" name="password" value="%PW%"><br>
	<button type="submit" name="submit">Login
</form>
)
WB.document.body.innerHTML := form
WB.document.all.submit.click() 
*/
while wb.busy or wb.ReadyState != 4
   Sleep 10
WB.document.getElementById("main_Nav--active").style.backgroundColor := "#008CBA"
WB.document.getElementById("app_category--active").style.backgroundColor := "#008CBA"
Gui, Show, w800 h600, Autohotkey.net
return

Go:
gui, submit, nohide
WB.Navigate(URL)
return
OnExit:
	FileDelete,%A_Temp%\*.DELETEME.html ;clean tmp file
ExitApp
; FUNCTIONS
loadApp(category) {
	
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