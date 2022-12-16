<!--
    Project      : PROG2001 - A-04 : Hi-Lo In Asp on the server
    Author       : BUM SU YI - 8110678
				   HOANG Phuc Tran - 8789102
    Date  		 : 10/20/2022
    Description  :  An application as part of an HTML file that will play a typical Hi-Lo game, where
the player guesses values in a specific range until the correct number is found. This will be implemented by using 
ASP backend.
-->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hi-lo Game</title>
    <script type="text/javascript">

	  // This variable is used to check the numbers only
      var num = /^-?[0-9]\d*(\d+)?$/;
      // This variable is used to check the alphabet only
      var alpha = /^[a-z A-Z]+$/;
	  
			/*
       		 * Function: validateInput(typeOfInput)
       		 * Description : This function will display the user's name
       		 * Parameters : one parameter - (variable).
       		 * Returns : NONE
       		 */
			function validateInput(typeOfInput) 
			{ 
				document.getElementById("error").innerHTML ="";
				var value; 
				value = document.getElementById("inputOfUser").value;
				
				// Check if the value is empty
				if (value == "" || value === null)
				{
					document.getElementById("error").innerHTML = "Your input cannot be BLANK";
					return false;
				}
				else 
				{
					// check if the type of the input is for name
					if(typeOfInput == 2) 
					{
						document.Form.submit();
					}
					// Check if the value is larger than the maximum number of the integer
					else if (parseInt(value) > Number.MAX_SAFE_INTEGER)
					{
						document.getElementById("error").innerHTML = "Error!! Your input is too large!";
						return false;
					}
					// the value is not a number
					else if (!value.match(num))
					{
						document.getElementById("error").innerHTML =  "Error!! Your input must contain only a number!";
						return false;
					}
					// check if the max number is valid or not
					// check if the type of the input is for a maximum number
					else if (typeOfInput == 1)
					{
						document.getElementById("max").value = value;
						document.Form.submit();
					}
					else if (typeOfInput == 0)
					{
						document.Form.submit();
					}
					
				}
				
			}
		</script>
		<style type="text/css">

			.inputField
			{
				font-family:"Times New Roman", Times, serif;
				align-content: center;	
				background-color: #1a1a1a;
				border-color: green;
				border: 1ch;
				width: 64%;		
				color: white;
				font-size: 30px;
				font-weight: 650;	
				align-self: center;
			}
		
			.submitBtn
			{
				font-family:"Times New Roman", Times, serif;
				color: CornflowerBlue;
				border:solid;
				align-content: center;	
				background-color: #1a1a1a;
				border-width: 3px;
				width: 31%;
				font-size: 30px;
				font-weight: 580;	
				align-self: center;
			}
		
		.wonFormat
		{
			font-family:"Times New Roman", Times, serif;
			font-weight: 700;	
			text-align: center;
			background-color: #1a1a1a;				
			width: 100%;
			color: CornflowerBlue;
			font-size: 70px;
		}

			.errorFormat
			{
				font-family:"Times New Roman", Times, serif;
				color: red;
				text-align: center;
				background-color: #1a1a1a;				
				width: 100%;
				font-size: 40px;
				font-weight: 600;	
			}
			.underline
			{
				font-family:"Times New Roman", Times, serif;
				color: ghostwhite;
				font-size: 30px;
				align-self: center;
				border: 1px;						
				border-color: coral;
				border-bottom-style: solid;
				align-content: center;	
				background-color: #1a1a1a;
			}
			.baseFormat
			{
				font-family:"Times New Roman", Times, serif;
				color: orchid;
				margin: auto;
				width: 70%;
				height: 30%;
				margin-top: 200px;
				text-align: center;						
				font-size: 32px;
				align-self: center;
				align-content: center;	
				background-color: #1a1a1a;	
				font-weight: 600;	
			}
		</style>
  </head>
  <body class="baseFormat">
	<%
	' Declare variables
	dim max
	dim min
	dim name
	dim answer
	dim error
	dim guess
	dim maxGuess

	' Get the post hidden values of the forms
	name = Request.form("name")
	min = Request.form("min")
	guess = Request.form("guess")
	maxGuess = Request.form("maxGuess")
	max = Request.form("max")
	answer = Request.form("answer")
	%>

	<% 'Check if the name of the user is entered or not
	 if (name = "") then %>
		<form name="Form" class="baseFormat" action="hiloStart.asp" method="post" onsubmit="return validateInput(2)"> 
			Hello! Please enter your name below <br/><br/>
			<div class="underline">			
				<input type="text" class="inputField" id="inputOfUser" autofocus name="name" placeholder="Your Name!"  />
				<input type="button" value="Submit" class="submitBtn" onclick="validateInput(2)"/>	
			</div>
			<div id="error" class="errorFormat"></div>
	  </form>

	 <%  ' Check if the maxGuess is less than or euqal 1
	elseif (CInt(maxGuess) <= 1) then
		if (maxGuess="") then
		elseif (CInt(maxGuess) <= 1) then 
		 error = "Error!! your guess must be larger than 1!"
		 end if
	%>

		<form name="Form" class="baseFormat" action="hiloStart.asp" method="post" onsubmit="return validateInput(1)" >
			Hello <%=name%>! Please enter the maximum number for the game<br/><br/>
			<div class="underline">					
				<input type="text" id="inputOfUser" autofocus name="maxGuess" class="inputField"  />
				<input type="button" value="Submit" class="submitBtn" onclick="validateInput(1)"/>				
			</div>
				<div class="errorFormat" id="error"><%=error%></i></div>
				<!-- The hidden input  -->
			<input type="hidden" name="name" value="<%=name%>" />
			<input type="hidden" name="answer" id="answer"/>
			<input type="hidden" name="max" id="max"/>
			<input type="hidden" name="min" value=1 />
	  </form>

	<% ' if the answer of the user is correct or not
	  else
		' Generate  a random number
		if(answer = "") then
            Randomize
			answer = Int(Rnd * max) + 1
		end if

		if(guess <> answer or guess = "") then
			' if the guess is higher than answer
			if (CInt(guess) <= CInt(maxGuess) and CInt(guess) > CInt(answer)) then
					max = guess - 1
			' if the guess is lower than answer
			elseif (CInt(guess) >= CInt(min) and CInt(guess) < CInt(answer)) then
					min = guess + 1
			' If the guess is empty
			elseif (not guess = "") then
					error = "Error!! your guess is out of range!"
			end if %>

		<form name="Form" class="baseFormat" action="hiloStart.asp" method="post" onsubmit="return validateInput(0)">
			<%=name%>! Please make a guess between <br/> <%=min%> and <%=max%><br/><br/>
			<div class="underline">
			  <input type="text" id="inputOfUser" autofocus name="guess" class="inputField" placeholder="> <%=min%> - <%=max%>" />
			  <input type="button" class="submitBtn" value="Submit" onclick="validateInput(0)"/>
			</div>
			<div class="errorFormat" id="error"><%=error%></i></div>
			<!-- The hidden input elements -->
			<input type="hidden" name="max" value="<%=max%>" />
			<input type="hidden" name="min" value="<%=min%>" />	
			<input type="hidden" name="maxGuess" value="<%=maxGuess%>" />					
			<input type="hidden" name="answer" value="<%=answer%>" />
			<input type="hidden" name="name" value="<%=name%>" />
		</form>

	<% else %>
	<form action="hiloStart.asp" method="post">
			<div class="wonFormat">Congratulations <%=name%>,<br/> Your answer <%=answer%> is correct!<br/><br/>
			<div class="underline">
			  <input class="submitBtn"  autofocus type="submit" value="Play Again"/>
			  <!-- The hidden input element -->
			</div>
			<input type="hidden" name="name" value="<%=name%>" />
	</form>	
	<% end if
	end if %>
  </body>
</html>