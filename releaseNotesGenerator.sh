#!/bin/bash

touch releaseNotes.html

cat >> releaseNotes.html <<EOL
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Release Notes</title>
        <style>
            table, th, td {
            border: 1px solid black;
            }
        </style>
    </head>
    <body>
        <h1>Release Notes</h1>
        <table style="width: 100%">
            <tr>
                <th>Firstname</th>
                <th>Lastname</th>
                <th>Age</th>
            </tr>
EOL


