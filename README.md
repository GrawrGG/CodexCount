# CodexCount
 
Counts the number of `Cataloged Research` currently in your bag, so you know how much reputation you will gain with `The Archivists' Codex` faction.

![image](https://user-images.githubusercontent.com/81110548/124400147-5e1c7480-dcd5-11eb-9a8f-b52af47d3230.png)

## Development
### Environment
Recommended development environment is [VS Code](https://code.visualstudio.com/) with the following extensions:
- [fsdeploy](https://marketplace.visualstudio.com/items?itemName=mightycoco.fsdeploy) - auto-deploy addon locally on file change (configured for a standard Windows `C:\\Program Files (x86)\\World of Warcraft` install location)
- [WoW API](https://marketplace.visualstudio.com/items?itemName=ketho.wow-api) - intellisense for WoW APIs
- [Lua language server](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) - included with WoW API above
- [vscode-lua](https://marketplace.visualstudio.com/items?itemName=trixnz.vscode-lua) - for linting + formatting

The [Luacheck](https://github.com/mpeterv/luacheck) static analyzer should be installed locally and configured as `lua.luacheckPath` in the `vscode-lua` settings.

### Style
This project uses **2-space** indentation and the **vscode-lua formatter**. The workspace settings have been configured to use this by default; if you have the above extensions installed your code will be autoformatted on save or when the editor loses focus. Otherwise we use the following conventions:

```lua
-- variables first
local CONSTANTS_ALL_CAPS_SNAKE_CASE = true
local lowerCamelCaseFileLocal = 1
GlobalUpperCamelCase = {}

-- functions last
local function LocalFunctionUpperCamelCase() 
  if (useBracketsPlease) then end
end

function SomeVar:GlobalFunctionUpperCamelCase()
  local lowerCamelCaseFunctionLocal = nil
end
```
