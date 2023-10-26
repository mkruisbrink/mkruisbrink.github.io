---
title: "Are You Ready to Dice?"
permalink: /dice/
date: 2022-08-01T03:02:20+00:00
excerpt: "A page dedicated to all the relevant courses I've taken and completed over the past few years."
header:
  overlay_image: /assets/images/pages/certifcations-showcase-optimised.jpg
---


<html>
<head>
    <title>Dice Rolling Game</title>
</head>
<body>
    <h1>Dice Rolling Game</h1>
    <label for="diceType">Select the Dice Type:</label>
    <select id="diceType">
        <option value="4">4-sided</option>
        <option value="6">6-sided</option>
        <option value="8">8-sided</option>
        <option value="10">10-sided</option>
        <option value="12">12-sided</option>
        <option value="20">20-sided</option>
    </select>
    <button id="rollButton">Roll the Dice</button>
    <div id="result"></div>

<script>
    const rollButton = document.getElementById("rollButton");
    const resultDiv = document.getElementById("result");

    rollButton.addEventListener("click", async () => {
        resultDiv.innerHTML = "Rolling the dice...";

        // Get the selected value from the dropdown
        const selectedDiceType = document.getElementById("diceType").value;

        // Make a request to the Integromat webhook with the selected dice type
        try {
            const response = await fetch('https://hook.eu1.make.com/2k9eqnwapnv3c52ry4uf5gf9ykerpyo4', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    numberOfSides: selectedDiceType,
                }),
            });

            if (response.ok) {
                const data = await response.json();
                resultDiv.innerHTML = `Result: ${data}`;
            } else {
                resultDiv.innerHTML = "Error occurred while rolling the dice.";
            }
        } catch (error) {
            resultDiv.innerHTML = "An error occurred: " + error.message;
        }
    });
</script>
</body>
</html>