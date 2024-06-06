# Project name
$projectName = "roblox-trading-platform"

# Directory structure
$dirs = @(
    "$projectName/public/css",
    "$projectName/public/js",
    "$projectName/views/pages",
    "$projectName/views/partials"
)

# Files content
$filesContent = @{
    "$projectName/app.js" = @"
const express = require('express');
const app = express();
const port = 3000;

// Set the view engine to EJS
app.set('view engine', 'ejs');

// Serve static files
app.use(express.static('public'));

// Routes
app.get('/', (req, res) => {
    res.render('pages/index');
});

app.get('/trade', (req, res) => {
    res.render('pages/trade');
});

app.get('/about', (req, res) => {
    res.render('pages/about');
});

app.get('/contact', (req, res) => {
    res.render('pages/contact');
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
"@

    "$projectName/views/pages/index.ejs" = @"
<%- include('../partials/header') %>
<main>
    <section id="welcome">
        <h2>Welcome to the Roblox Trading Platform</h2>
        <p>Trade rare and special items safely and securely.</p>
        <a href="/trade" class="button">Start Trading</a>
    </section>
</main>
<%- include('../partials/footer') %>
"@

    "$projectName/views/pages/trade.ejs" = @"
<%- include('../partials/header') %>
<main>
    <section id="trade">
        <h2>Trade Items</h2>
        <p>Here you can list your items for trade and find items you're interested in.</p>
        <!-- Add trade listing and search functionality here -->
    </section>
</main>
<%- include('../partials/footer') %>
"@

    "$projectName/views/pages/about.ejs" = @"
<%- include('../partials/header') %>
<main>
    <section id="about">
        <h2>About Us</h2>
        <p>Learn more about our platform and our mission to provide a safe and secure trading environment for Roblox users.</p>
    </section>
</main>
<%- include('../partials/footer') %>
"@

    "$projectName/views/pages/contact.ejs" = @"
<%- include('../partials/header') %>
<main>
    <section id="contact">
        <h2>Contact Us</h2>
        <p>If you have any questions or need support, please reach out to us.</p>
        <form action='/submit_contact_form' method='post'>
            <label for='name'>Name:</label>
            <input type='text' id='name' name='name' required>
            <br>
            <label for='email'>Email:</label>
            <input type='email' id='email' name='email' required>
            <br>
            <label for='message'>Message:</label>
            <textarea id='message' name='message' required></textarea>
            <br>
            <input type='submit' value='Submit'>
        </form>
    </section>
</main>
<%- include('../partials/footer') %>
"@

    "$projectName/views/partials/header.ejs" = @"
<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>Roblox Trading Platform</title>
    <link rel='stylesheet' href='/css/styles.css'>
</head>
<body>
    <header>
        <h1>Roblox Trading Platform</h1>
        <nav>
            <ul>
                <li><a href='/'>Home</a></li>
                <li><a href='/trade'>Trade</a></li>
                <li><a href='/about'>About</a></li>
                <li><a href='/contact'>Contact</a></li>
            </ul>
        </nav>
    </header>
"@

    "$projectName/views/partials/footer.ejs" = @"
    <footer>
        <p>&copy; 2024 Roblox Trading Platform. All rights reserved.</p>
    </footer>
</body>
</html>
"@

    "$projectName/public/css/styles.css" = @"
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
}

header {
    background-color: #333;
    color: #fff;
    padding: 10px 0;
    text-align: center;
}

header h1 {
    margin: 0;
}

nav ul {
    list-style: none;
    padding: 0;
}

nav ul li {
    display: inline;
    margin: 0 10px;
}

nav ul li a {
    color: #fff;
    text-decoration: none;
}

main {
    padding: 20px;
}

#welcome {
    text-align: center;
    margin: 20px 0;
}

.button {
    display: inline-block;
    padding: 10px 20px;
    color: #fff;
    background-color: #007bff;
    text-decoration: none;
    border-radius: 5px;
}

.button:hover {
    background-color: #0056b3;
}

footer {
    background-color: #333;
    color: #fff;
    text-align: center;
    padding: 10px 0;
    position: fixed;
    width: 100%;
    bottom: 0;
}
"
}

# Create directories
foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Force -Path $dir
}

# Create files
foreach ($filePath in $filesContent.Keys) {
    $content = $filesContent[$filePath]
    $content | Out-File -FilePath $filePath -Encoding utf8
}

# Zip the project directory
Compress-Archive -Path "$projectName\*" -DestinationPath "$projectName.zip"

# Cleanup created files and directories
Remove-Item -Recurse -Force $projectName

Write-Output "Project directory structure created and zipped as ${projectName}.zip"
