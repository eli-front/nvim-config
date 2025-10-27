return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = "VeryLazy",
  config = function()
    local weather_cache = "🙈 …"

    local function fetch_weather_once()
      -- your coords
      local lat, lon = 38.636019, -90.246477
      local url = string.format(
        "https://api.open-meteo.com/v1/forecast?latitude=%s&longitude=%s&current_weather=true&temperature_unit=fahrenheit",
        tostring(lat), tostring(lon)
      )

      vim.system({ "curl", "-s", url }, { text = true }, function(res)
        local ok, data = pcall(vim.json.decode, res.stdout or "")
        if ok and data and data.current_weather and data.current_weather.temperature then
          local emoji = ""
          local weathercode = data.current_weather.weathercode

          local code_to_emoji = {
            [0] = "☀️", -- clear sky
            [1] = "🌤", -- mainly clear
            [2] = "🌤", -- partly cloudy
            [3] = "🌥", -- overcast (use cloud with sun behind large cloud)
            [45] = "🌫", -- fog
            [48] = "🌫", -- rime fog
            [51] = "🌦", -- light drizzle
            [53] = "🌦", -- moderate drizzle
            [55] = "🌧", -- dense drizzle
            [56] = "🌧", -- light freezing drizzle
            [57] = "🌧", -- dense freezing drizzle
            [61] = "🌧", -- slight rain
            [63] = "🌧", -- moderate rain
            [65] = "🌧", -- heavy rain
            [66] = "🌧", -- light freezing rain
            [67] = "🌧", -- heavy freezing rain
            [71] = "🌨", -- slight snow
            [73] = "🌨", -- moderate snow
            [75] = "🌨", -- heavy snow
            [77] = "🌨", -- snow grains
            [80] = "🌧", -- slight rain showers
            [81] = "🌧", -- moderate rain showers
            [82] = "🌧", -- violent rain showers
            [85] = "🌨", -- slight snow showers
            [86] = "🌨", -- heavy snow showers
            [95] = "⛈️", -- thunderstorm
            [96] = "⛈️", -- thunderstorm with hail
            [97] = "⛈️", -- thunderstorm with hail
          }

          emoji = code_to_emoji[weathercode] or ""

          weather_cache = string.format("%s %s°F", emoji, data.current_weather.temperature)
        else
          weather_cache = "🙉"
        end
        vim.schedule(function()
          pcall(require, "lualine")
          pcall(require("lualine").refresh, { place = { "statusline" } })
        end)
      end)
    end

    -- kick it off once deferred
    vim.defer_fn(fetch_weather_once, 200)
    -- schedule every 5 minutes
    vim.loop.new_timer():start(300000, 300000, vim.schedule_wrap(fetch_weather_once))

    local function weather_component()
      return weather_cache
    end

    require('lualine').setup {
      options = {
        theme = 'ayu_mirage',
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { weather_component, 'lsp_status', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      }
    }
  end,
}
