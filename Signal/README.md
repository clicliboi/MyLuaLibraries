<h1>Signal Event</h1>

<a href="Signal.lua">Signal.lua</a> is a lightweight Lua implementation of the signal/slot (event) pattern, inspired by the Roblox Studio BindableEvent. This library allows you to create custom signals, connect your own functions to them and fire events with arguments. Features include: 
<li style="list-style:none">
<ul><code>Await</code> Connects a listener to the signal. The listener will be called every time the signal is fired. Returns a connection object that can be disconnected.</ul>
<ul><code>Once</code> Connects a listener to the signal, but gets disconnected after the signal has been fired.</ul>
<ul><code>Fire</code> Invokes all connected listeners, passing any provided arguments to them.</ul>
<ul><code>Destroy</code> Cleans up the signal by disconnecting all listeners and making the signal unusable.</ul>
</li>

## Code exmaple:
### <code>Await</code>
<h4>

```lua
-- Requiring the 'Signal.lua' library
local Signal = require("Signal")

-- Creating a new 'Signal' instance
local newSignal = Signal.new()

-- Create a listener
local connection;
connection = newSignal:Await(function(msg)
    print(msg)
    connection:Disconnect()
end)
```
</h4>

### <code>Fire</code>
<h4>

```lua
-- Firing the 'newSignal' instance
newSignal:Fire("Hello World!") -- printing Hello World!

-- 'connection' has been disconnected
```
</h4>

### <code>Once</code>
<h4>

```lua
-- Create a listener using 'Once'
newSignal:Once(function(msg)
    print(msg)
end)

newSignal:Fire("Hello World!") -- printing Hello World!
```
</h4>

### <code>Destroy</code>
<h4>

```lua
newSignal:Destroy() -- 'newSignal' has been destoryed
```
</h4>
