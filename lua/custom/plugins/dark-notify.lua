return {
  'cormacrelf/dark-notify',
  config = function()
    require('dark_notify').run {
      schemes = {
        dark = 'tokyonight',
        light = 'tokyonight-day',
      },
    }
  end,
}
