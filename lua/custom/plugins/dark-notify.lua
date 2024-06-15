return {
  'cormacrelf/dark-notify',
  config = function()
    require('dark_notify').run {
      schemes = {
        dark = 'catppuccin-macchiato',
        light = 'catppuccin-latte',
      },
    }
  end,
}
