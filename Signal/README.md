<html>
<body>
<h1>Signal Event</h1>
<h>
    A lightweight Lua implementation of the signal/slot (event) pattern, inspired by the Roblox Studio BindableEvent. This library allows you to create custom signals, connect your own functions to them and fire events with arguments. Features include: <br><br>
    <code>Await</code> This function contains all the signal connections and also ldfgbtretyrtgtgntaertrbe exmaple: <br>
    ```lua
        local signal = require('signal.lua')
        -- Creating a new 'signal' instance
        local connection = signal.new()
        -- 
        connection:Await(function)
    ```
</h>

<pre><code class="language-lua">
local signal = require('signal.lua')
-- Creating a new 'signal' instance
local connection = signal.new()

--
connection:Await(function)
</pre></code>

<br>
<a href="signal.lua">View Script</a>
</body>
</html>