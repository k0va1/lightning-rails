if ENV["HISTFILE"]
  hist_dir = ENV["HISTFILE"].sub(/\/[^\/]+$/, "")
  Pry.config.history_file = File.join(hist_dir, ".pry_history")
end
